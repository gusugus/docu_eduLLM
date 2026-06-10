# Flujos de Comunicación entre Repositorios - eduLLM

> Generado con Codegraph y lectura directa de código fuente.
> Última actualización: 2026-06-10

## Topología de Red

```
                    ┌──────────────────────────────────────────────────────────────┐
                    │                       Gateway                               │
                    │              (Spring Cloud Gateway)                         │
                    │                   puerto 8089                               │
                    │              Docker: gateway-ms:8080                         │
                    └──────┬──────────────┬──────────────┬────────────────────────┘
                           │              │              │
              ┌────────────┴───┐   ┌──────┴──────┐   ┌──┴─────────────────┐
              │  /api/auth/**  │   │ /api/rag/** │   │ /api/admin/**      │
              │  /login        │   │              │   │                    │
              │  /dashboard    │   │              │   │                    │
              └──────┬────────┘   └──────┬───────┘   └────┬────────────────┘
                     │                   │                 │
              ┌──────┴────────┐   ┌──────┴───────┐   ┌────┴────────────────┐
              │  auth-ms      │   │  ms-rag      │   │  ms-admin          │
              │  (Spring Boot)│   │  (FastAPI)   │   │  (Node.js/Express) │
              │  puerto 8082  │   │  puerto 8002 │   │  puerto 8083       │
              └──────┬────────┘   └──────┬───────┘   └────┬────────────────┘
                     │                   │                 │
                     ▼                   ▼                 ▼
              ┌─────────────────────────────────────────────────┐
              │               PostgreSQL (edu_llm)              │
              │               puerto 5432                       │
              │               admin:admin@localhost:5432        │
              └─────────────────────────────────────────────────┘
```

## 1. Gateway (Spring Cloud Gateway)

### Configuración
- **Puerto local**: 8089
- **Docker**: gateway-ms:8080
- **Frontends que sirve**:
  - Admin: `http://localhost:8001`
  - Profesor: `http://localhost:8002`
  - Estudiante: `http://localhost:8003`

### Rutas en Gateway (`Gateway/src/main/resources/application.yml`)

| Ruta | Destino | ID Ruta |
|------|---------|---------|
| `/api/auth/**`, `/login`, `/forgot-password`, `/reset-password`, `/dashboard` | `http://localhost:8082` (auth-ms) | `auth-ms` |
| `/api/rag/**` | `http://localhost:8002` (ms-rag) | `ms-rag` |
| `/api/admin/**` | `http://localhost:8083` (ms-admin) | `ms-admin` |

### Endpoints especiales manejados por el Gateway

| Endpoint | Método | Handler | Descripción |
|----------|--------|---------|-------------|
| `/login-success` | GET | `handleLoginSuccessAndRedirect()` | Valida cookie JWT, determina rol, redirige 302 al frontend correspondiente |
| `/api/auth/verify` | GET | `handleVerify()` | Verifica validez del token JWT (cookie o Bearer) |
| `/api/auth/logout` | GET | `handleLogout()` | Limpia cookie jwtToken |

### Filtro JWT (`JwtAuthenticationFilter.java`)

```
filter() → path == /login-success? → handleLoginSuccessAndRedirect()
         → path == /api/auth/verify? → handleVerify()
         → path == /api/auth/logout? → handleLogout()
         → path in PUBLIC_PATHS? → chain.filter() (pasa directo)
         → else → handleProtectedRoute() (requiere token)
```

**Rutas públicas** (sin autenticación): `/api/auth/login`, `/api/auth/forgot-password`, `/api/auth/reset-password`, `/login`, `/forgot-password`, `/reset-password`, `/socket.io`

### Headers que inyecta en rutas protegidas
- `X-User-Id` — ID del usuario extraído del JWT
- `X-User-Role` — Rol del usuario
- `X-Username` — Username

---

## 2. autenticacionWeb / auth-ms (Spring Boot)

### Configuración
- **Puerto**: 8080 (Docker: auth-ms:8080)
- **DB**: PostgreSQL (`jdbc:postgresql://127.0.0.1:5432/edu_llm`)
- **Gateway URL**: `http://gateway-ms`
- **OpenTelemetry**: Alloy (localhost:4318)

### Endpoints

| Método | Ruta | Controlador | Función |
|--------|------|-------------|---------|
| GET | `/login` | `ViewController.loginPage()` | Sirve login.html |
| GET | `/forgot-password` | `ViewController.showForgotPasswordForm()` | Sirve forgot-password.html |
| GET | `/reset-password` | `ViewController.showResetPasswordForm()` | Sirve reset-password.html |
| POST | `/api/auth/login` | `AuthController.createAuthenticationToken()` | Login, retorna JWT + redirect URL |
| POST | `/api/auth/forgot-password` | `AuthController.forgotPassword()` | Envía email con token de reseteo |
| POST | `/api/auth/reset-password` | `AuthController.resetPassword()` | Resetea contraseña |
| GET | `/api/auth/verify` | `AuthController.verify()` | Verifica autenticación |

### Dependencias externas
- **PostgreSQL** — función `comun.fn_login(username)` para autenticar
- **Gateway** — redirige a `gatewayUrl + /login-success` post-login
- **OpenTelemetry** — envía trazas a `localhost:4318`

---

## 3. proxy / LLM-MIDD (Flask)

### Configuración
- **Puerto**: 5000
- **LLM Backends**: llama.cpp (`http://localhost:8080`), llama-agent (`http://127.0.0.1:8081`)
- **RAG local**: ChromaDB en `rag/chroma_db/`
- **DB**: PostgreSQL (`DATABASE_URL`)

### Endpoints

| Método | Ruta | Blueprint | Función |
|--------|------|-----------|---------|
| POST | `/chat/<session_id>` | chat | Enruta mensaje al LLM backend, retorna SSE stream |
| POST | `/session` | session | Crea nueva sesión en llama-agent |
| POST | `/permission` | permission | Aprueba/rechaza acción (auto-approve) |
| POST | `/generate-quiz` | quiz | Genera quiz vía LLM y persiste en DB |

### Flujo del chat

```
POST /chat/<session_id>
  → get_backend_response(session_id, message, backend, options)
    → backend == "llamacpp"?
      → get_completion_response(message)    → POST {LLAMACPP_URL}/completion
      → get_chat_completion_response(msg)   → POST {LLAMACPP_URL}/v1/chat/completions
    → backend == "llama-agent"?
      → get_chat_response(session_id, msg)  → POST {LLAMA_AGENT_URL}/v1/agent/session/{id}/chat
  → get_stream_generator() → Response SSE stream
```

### Dependencias externas
- **llama.cpp** — `{LLAMACPP_URL}/completion` y `/v1/chat/completions`
- **llama-agent** — `{LLAMA_AGENT_URL}/v1/agent/session/{id}/chat`
- **ChromaDB** — RAG local (embeddings all-mpnet-base-v2)
- **PostgreSQL** — guardar quizzes generados

---

## 4. rag / ms-rag (FastAPI)

### Configuración
- **Puerto**: 8002
- **Vector DB**: Qdrant
- **DB**: PostgreSQL (solo lectura de configuración)
- **OpenTelemetry**: Alloy (alloy:4317 gRPC)

### Endpoints

| Método | Ruta | Función |
|--------|------|---------|
| POST | `/query` | `query_rag()` — búsqueda semántica sobre Qdrant |
| GET | `/health` | `health()` — estado del servicio |
| GET | `/temas` | `listar_temas()` — lista temas disponibles con subtemas |
| POST | `/query-by-tema-and-subtema` | `query_by_tema_and_subtema()` — filtrado por currículum |
| GET | `/admin/info` | `admin_info()` — info de administración |

### Dependencias externas
- **Qdrant** — vectores de conocimiento educativo
- **PostgreSQL** — lectura de configuración (`DB_HOST`, `DB_PORT`, etc.)
- **OpenTelemetry** — trazas a Alloy (gRPC)

---

## 5. MindBuzz (Express + Socket.IO)

### Configuración
- **Socket server**: puerto 8004 (`WS_PORT`)
- **Web app**: puerto 3000
- **DB**: PostgreSQL (sesiones + datos de juego)
- **JWT Secret**: `mindbuzz-jwt-secret-key-2026`

### Endpoints REST

| Método | Ruta | Función |
|--------|------|---------|
| POST | `/auth/login` | Login local con Passport (estrategia local) |
| GET | `/auth/status` | Verifica autenticación JWT |
| POST | `/auth/dev-login` | Login de desarrollo (sin credenciales) |
| POST | `/auth/gateway-session` | Crea sesión JWT desde datos del Gateway |
| GET | `/auth/oidc/status` | Estado OIDC |
| GET | `/auth/oidc/login` | Inicia flujo OIDC |

### Eventos Socket.IO

| Evento | Dirección | Descripción |
|--------|-----------|-------------|
| `tutor:chunk` | Server → Client | Fragmento de respuesta del tutor LLM |
| `tutor:completed` | Server → Client | Respuesta del tutor completada |
| `tutor:error` | Server → Client | Error del tutor |

### Dependencias externas
- **proxy** — `TutorService.askTutor()` llama a `POST http://localhost:5000/chat/{sessionId}`
- **PostgreSQL** — sesiones de juego, datos de jugadores, quizzes
- **Gateway** — `LOGIN_URL = VITE_GATEWAY_URL || http://localhost:8085`

---

## 6. administrador (Node.js/Express + React)

### Configuración
- **BACK**: puerto 8002
- **FRONT**: puerto 8001 (Vite dev server)
- **Gateway URL**: `http://localhost:8085` (VITE_GATEWAY_URL)
- **DB**: PostgreSQL (Prisma ORM, DB-first)

### Endpoints del BACK (`/api/admin/...`)

| Método | Ruta | Controlador |
|--------|------|-------------|
| GET/POST | `/professors` | `professor.controller` |
| GET/PUT/DELETE | `/professors/:id` | `professor.controller` |
| GET/POST | `/students` | `student.controller` |
| GET/PUT/DELETE | `/students/:id` | `student.controller` |
| GET/POST | `/subjects` | `subject.controller` |
| GET/PUT/DELETE | `/subjects/:id` | `subject.controller` |
| GET/POST | `/grados` | `grado.controller` |
| GET/PUT/DELETE | `/grados/:id` | `grado.controller` |
| GET | `/users` | `user.controller` |
| GET | `/users/:id` | `user.controller` |
| POST | `/users/check-username` | `user.controller` |
| POST | `/users/suggest-username` | `user.controller` |
| POST | `/assignments/professor-subject` | `assignment.controller` |
| GET | `/assignments/professor-subject` | `assignment.controller` |
| DELETE | `/assignments/professor-subject/:id` | `assignment.controller` |
| POST | `/assignments/student-subject` | `assignment.controller` |
| GET | `/assignments/student-subject` | `assignment.controller` |
| DELETE | `/assignments/student-subject/:id` | `assignment.controller` |
| POST | `/upload/profile-photo` | `upload.controller` |

### Flujo de autenticación del admin

```
FRONT (React) → fetch(`${GATEWAY}/api/auth/verify`) — verifica token
              → axios(`${GATEWAY}/api/admin/**`) — API calls con cookie/Authorization
                → Gateway inyecta X-User-Id, X-User-Role, X-Username headers
                  → BACK (Node.js) lee headers → auth.middleware() → req.user
```

### Dependencias externas
- **Gateway** — todos los requests pasan por `http://localhost:8085`
- **Tutor** — `TutorPage.jsx` redirige a `{GATEWAY}/tutor`
- **Quizz** — `QuizzPage.jsx` redirige a `{GATEWAY}/quiz`
- **PostgreSQL** — Prisma ORM

---

## 7. prompting (Python)

### Configuración
- **Contiene**: quizz-web (Express), tutor-web (Express)
- **RAG API URL**: `http://localhost:8085`
- **Gateway URL**: `http://localhost:8085`

### Componentes
- `quizz-web/server.js` — servidor web para generación de quizzes
- `tutor-web/server.js` — servidor web para tutor virtual

### Dependencias externas
- **Gateway** — `RAG_API_URL = http://localhost:8085`

---

## Mapa Completo de Comunicación Inter-Servicios

```
                         ┌─────────────────────────────┐
                         │      Frontend Admin         │
                         │      localhost:8001          │
                         └────────────┬────────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────────┐
                         │    Frontend Profesor        │
                         │    localhost:8002            │
                         └────────────┬────────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────────┐
                         │   Frontend Estudiante       │
                         │   localhost:8003            │
                         └────────────┬────────────────┘
                                      │
                    ┌─────────────────┼──────────────────────┐
                    │                 │                      │
                    ▼                 ▼                      ▼
          ┌─────────────────┐  ┌──────────────┐   ┌────────────────────┐
          │ MindBuzz Web    │  │   Gateway    │   │   MindBuzz Socket  │
          │ localhost:3000  │  │  localhost:  │   │   localhost:8004   │
          └──────┬──────────┘  │  8089/8085   │   └────────┬───────────┘
                 │             └──────┬───────┘            │
                 │                    │                    │
                 │         ┌──────────┼──────────┐         │
                 │         │          │          │         │
                 ▼         ▼          ▼          ▼         │
          ┌───────────────────────────────────────────┐    │
          │      auth-ms  │  ms-rag  │  ms-admin      │    │
          │       :8082    │  :8002   │  :8083        │    │
          └───────────────────────────────────────────┘    │
                         │                                 │
                         ▼                                 │
          ┌───────────────────────────────────────────┐    │
          │             PostgreSQL :5432              │◄───┘
          │           (edu_llm database)              │
          └───────────────────────────────────────────┘
                         ▲
                         │
          ┌───────────────┴───────────────────┐
          │         proxy / LLM-MIDD          │
          │         localhost:5000            │
          └───────┬──────────────────┬────────┘
                  │                  │
                  ▼                  ▼
          ┌──────────────┐   ┌──────────────┐
          │  llama.cpp   │   │ llama-agent  │
          │  localhost:  │   │ localhost:   │
          │  8080        │   │ 8081         │
          └──────────────┘   └──────────────┘
                  │
                  ▼
          ┌────────────────┐
          │   ChromaDB     │
          │  (RAG local)   │
          └────────────────┘

          ┌────────────────┐
          │    Qdrant      │◄──── ms-rag
          │  (Vector DB)   │
          └────────────────┘
```

## Puertos Resumen

| Servicio | Puerto Local | Puerto Docker | Tecnología |
|----------|-------------|---------------|------------|
| Gateway | 8089 | 8080 | Spring Cloud Gateway |
| auth-ms | 8082 | 8080 | Spring Boot |
| ms-admin (BACK) | 8083 | 8002 | Node.js/Express |
| ms-admin (FRONT) | 8001 | 8001 | React + Vite |
| ms-rag | 8002 | 8000 | FastAPI (Python) |
| proxy (LLM-MIDD) | 5000 | 5000 | Flask (Python) |
| MindBuzz Socket | 8004 | 8004 | Express + Socket.IO |
| MindBuzz Web | 3000 | 3000 | Next.js |
| PostgreSQL | 5432 | 5432 | PostgreSQL 17 |
| llama.cpp | 8080 | — | C/C++ |
| llama-agent | 8081 | — | Python |
| Qdrant | — | — | Vector DB |
| Alloy (OTel) | 4317/4318 | 4317/4318 | OpenTelemetry Collector |
| ChromaDB | — | — | Vector DB (local proxy) |

## Servicios que usan PostgreSQL

| Servicio | Tablas/Funciones |
|----------|-----------------|
| auth-ms | `comun.fn_login()`, `comun.usuario`, `comun.rol` |
| proxy | quizzes, preguntas |
| MindBuzz | sesiones, managers, quizzes, players |
| ms-admin (BACK) | todas las tablas vía Prisma ORM |
| ms-rag | Configuración (solo lectura) |

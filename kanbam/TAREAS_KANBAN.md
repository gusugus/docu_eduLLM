# Tareas para Kanban - eduLLM (v2 - Desglose Técnico)
**Proyecto:** eduLLM
**Formato:** Usar etiquetas entre corchetes `[Categoría]` y tags (#) para filtrar.

---

## 1. SETUP E INFRAESTRUCTURA
- **Título:** [Setup] Levantar Base de Datos Vectorial (Qdrant) y cargar embeddings del libro.
  **Descripción:** Crear contenedor Docker de Qdrant. y cargar los capitulos 1 y 2 del libro de Ciencias Naturales.
  **Tags:** `infraestructura`, `rag`
  **Color:** green
  **Duración:** 2d

- **Título:** [Setup] Levantar Base de Datos (Postgres), tablas y relaciones.
  **Descripción:** Crear la base de datos, con sus esquemas, tablas y relaciones entre tablas (MER).
  **Tags:** `infraestructura`
  **Color:** green
  **Duración:** 2d

- **Título:** [Setup] Investigacion y busqueda de herramientas.
  **Descripción:** Revision e instalación de herramientas necesarias para levantar el ecosistema eduLLM (microservicios, API, docker, postgres, qdrant, llama.cpp, frameworks, estructura de repositorios).
  **Tags:** `infraestructura`
  **Color:** green
  **Duración:** 3d

---

## 2. FRONTEND - PANTALLAS Y VISTAS

### 2.1 Frontend Administrador
- **Título:** [Admin Front] Pantalla de Login
  **Descripción:** Diseñar formulario de login (username/password). Conectar con el endpoint `/api/auth/login` del ms Autenticación. Autenticar el token JWT recibido y redirigir al Dashboard según el rol (profesor/administrador/estudiante).
  **Tags:** `frontend`, `admin`, `login`
  **Color:** blue
  **Duración:** 1d

- **Título:** [Admin Front] Pantalla CRUD de Profesores
  **Descripción:** Formulario para listar, crear, editar y eliminar profesores. Consumir APIs del MS Administrador (a través del Gateway). Incluir validaciones y feedback visual.
  **Tags:** `frontend`, `admin`, `crud`, `profesores`
  **Color:** blue
  **Duración:** 2d

- **Título:** [Admin Front] Pantalla CRUD de Estudiantes
  **Descripción:** Formulario para listar, crear, editar y eliminar estudiantes. Consumir APIs del MS Administrador.
  **Tags:** `frontend`, `admin`, `crud`, `estudiantes`
  **Color:** blue
  **Duración:** 1d

- **Título:** [Admin Front] Pantalla CRUD de Materias
  **Descripción:** Formulario para listar, crear, editar y eliminar materias. Consumir APIs del MS Administrador.
  **Tags:** `frontend`, `admin`, `crud`, `materias`
  **Color:** blue
  **Duración:** 1d

- **Título:** [Admin Front] Pantalla CRUD de Cursos
  **Descripción:** Formulario para listar, crear, editar y eliminar cursos. Consumir APIs del MS Administrador.
  **Tags:** `frontend`, `admin`, `crud`, `cursos`
  **Color:** blue
  **Duración:** 1d

- **Título:** [Admin Front] Pantalla de Asignaciones (Profesores/Estudiantes a Cursos)
  **Descripción:** Interfaz para asignar/desasignar profesores y estudiantes a cursos. Puede ser una tabla con checkboxes o un selector múltiple. Consumir APIs correspondientes.
  **Tags:** `frontend`, `admin`, `asignaciones`
  **Color:** blue
  **Duración:** 2d

- **Título:** [Admin Front] Dashboard de Administrador
  **Descripción:** Crear vista principal con menú de navegación a las secciones: Profesores, Estudiantes, Materias, Cursos y Asignaciones. Mostrar resumen de estadísticas (cantidad de profesores, estudiantes, etc.).
  **Tags:** `frontend`, `admin`, `dashboard`
  **Color:** blue
  **Duración:** 2d

### 2.2 Frontend Profesor
- **Título:** [Profesor Front] Dashboard de Profesor
  **Descripción:** Vista principal del profesor que muestre sus cursos asignados y los quizzes existentes. Botones para "Crear Quiz", "Editar Quiz" y "Crear Sala de Juego".
  **Tags:** `frontend`, `profesor`, `dashboard`
  **Color:** yellow
  **Duración:** 2d

- **Título:** [Profesor Front] Pantalla de Creación de Quizzes (Manual)
  **Descripción:** Formulario paso a paso para crear quiz: título, descripción, y agregar preguntas (texto, opciones múltiples, marcar respuesta correcta). Consumir APIs del MS Profesor (a través del Gateway).
  **Tags:** `frontend`, `profesor`, `quizzes`
  **Color:** yellow
  **Duración:** 3d

- **Título:** [Profesor Front] Pantalla de Edición de Quizzes
  **Descripción:** Listar quizzes existentes del profesor. Permitir modificar título, descripción, y editar/eliminar preguntas. Consumir APIs del MS Profesor.
  **Tags:** `frontend`, `profesor`, `quizzes`
  **Color:** yellow
  **Duración:** 2d

- **Título:** [Profesor Front] Pantalla de Creación de Sala de Juego
  **Descripción:** Interfaz para que el profesor seleccione un quiz de su lista, establezca parámetros (tiempo por pregunta, puntuación, etc.) y genere un código de sala. Conectar con el MS Game (WebSocket) para crear la sala y obtener el código.
  **Tags:** `frontend`, `profesor`, `sala`
  **Color:** yellow
  **Duración:** 2d

### 2.3 Frontend Estudiante
- **Título:** [Estudiante Front] Pantalla de Unirse a Sala (Lobby)
  **Descripción:** Formulario simple donde el estudiante ingresa el código de la sala proporcionado por el profesor. Conectar con el MS Game (WebSocket) para validar el código y unirse a la sala. Mostrar "Esperando inicio del juego".
  **Tags:** `frontend`, `estudiante`, `lobby`
  **Color:** purple
  **Duración:** 1d

- **Título:** [Estudiante Front] Pantalla de Juego (Preguntas y Respuestas)
  **Descripción:** Vista que muestra la pregunta actual, las opciones de respuesta y un temporizador. Enviar la respuesta seleccionada al MS Game a través del WebSocket. Mostrar retroalimentación inmediata (correcto/incorrecto) y puntuación parcial.
  **Tags:** `frontend`, `estudiante`, `juego`
  **Color:** purple
  **Duración:** 3d

- **Título:** [Estudiante Front] Pantalla de Resultados del Quiz
  **Descripción:** Al finalizar el quiz, mostrar puntuación total, clasificación (si aplica) y un resumen de respuestas correctas/incorrectas. Botón para "Hablar con Tutor IA".
  **Tags:** `frontend`, `estudiante`, `resultados`
  **Color:** purple
  **Duración:** 1d

- **Título:** [Estudiante Front] Pantalla de Chat con Tutor IA (Post-Juego)
  **Descripción:** Interfaz de chat donde el estudiante puede escribir preguntas sobre sus errores. Envio de preguntas errónea, respuesta del estudiante, respuesta correcta al MS prompting y mostrar la explicación generada.
  **Tags:** `frontend`, `estudiante`, `ia`, `chat`
  **Color:** purple
  **Duración:** 2d

---

## 3. BACKEND - ENDPOINTS Y LÓGICA INTERNA

### 3.1 Microservicio de Administrador (MS Admin)
- **Título:** [Admin MS] Endpoint CRUD de Profesores
  **Descripción:** Implementar endpoints REST (GET, POST, PUT, DELETE) para gestionar profesores. Validar roles (solo administrador). Conectar con base de datos.
  **Tags:** `backend`, `admin`, `api`, `crud`
  **Color:** red
  **Duración:** 2d

- **Título:** [Admin MS] Endpoint CRUD de Estudiantes
  **Descripción:** Implementar endpoints REST para gestionar estudiantes. Validar roles. Conectar con base de datos.
  **Tags:** `backend`, `admin`, `api`, `crud`
  **Color:** red
  **Duración:** 1d

- **Título:** [Admin MS] Endpoint CRUD de Materias
  **Descripción:** Implementar endpoints REST para gestionar materias. Conectar con base de datos.
  **Tags:** `backend`, `admin`, `api`, `crud`
  **Color:** red
  **Duración:** 1d

- **Título:** [Admin MS] Endpoint CRUD de Cursos
  **Descripción:** Implementar endpoints REST para gestionar cursos. Conectar con base de datos.
  **Tags:** `backend`, `admin`, `api`, `crud`
  **Color:** red
  **Duración:** 1d

- **Título:** [Admin MS] Endpoint de Asignaciones (Profesor/Estudiante a Curso)
  **Descripción:** Implementar endpoints para asignar/desasignar profesores y estudiantes a cursos. Guardar relaciones en la base de datos.
  **Tags:** `backend`, `admin`, `api`, `asignaciones`
  **Color:** red
  **Duración:** 2d

### 3.2 Microservicio de Profesor (MS Profesor)
- **Título:** [Profesor MS] Endpoint para Guardar Quizzes
  **Descripción:** Implementar endpoint POST `/api/quizzes` que reciba el objeto quiz (título, preguntas, opciones, respuesta correcta). Validar que el profesor autenticado sea el propietario. Guardar en base de datos.
  **Tags:** `backend`, `profesor`, `api`, `quizzes`
  **Color:** orange
  **Duración:** 3d

- **Título:** [Profesor MS] Endpoint para Obtener Quizzes del Profesor
  **Descripción:** Implementar endpoint GET `/api/quizzes` que devuelva la lista de quizzes creados por el profesor autenticado.
  **Tags:** `backend`, `profesor`, `api`, `quizzes`
  **Color:** orange
  **Duración:** 1d

- **Título:** [Profesor MS] Endpoint para Editar Quiz
  **Descripción:** Implementar endpoint PUT `/api/quizzes/{id}` para actualizar título, preguntas, etc. Validar propiedad del quiz.
  **Tags:** `backend`, `profesor`, `api`, `quizzes`
  **Color:** orange
  **Duración:** 1d

- **Título:** [Profesor MS] Endpoint para Eliminar Quiz
  **Descripción:** Implementar endpoint soft-DELETE `/api/quizzes/{id}` para eliminar un quiz. Validar propiedad.
  **Tags:** `backend`, `profesor`, `api`, `quizzes`
  **Color:** orange
  **Duración:** 1d

### 3.3 Microservicio de Juego (Game)
- **Título:** [Game MS] Lógica de Creación de Sala y Gestión de Jugadores
  **Descripción:** En el servidor WebSocket, implementar evento `create_room` que recibe `quiz_id` y genera un código único de sala. Mantener en memoria la lista de jugadores conectados (estudiantes) y sus datos (nombre, puntuación).
  **Tags:** `backend`, `game`, `salas`
  **Color:** teal
  **Duración:** 2d

- **Título:** [Game MS] Lógica de Inicio de Juego y Envío de Preguntas
  **Descripción:** Cuando el profesor inicie el juego (evento `start_game`), el servidor recupera las preguntas del quiz (consultando al MS Profesor) y las envía uno a uno a todos los estudiantes conectados a la sala (evento `next_question`).
  **Tags:** `backend`, `game`, `logica`
  **Color:** teal
  **Duración:** 2d

- **Título:** [Game MS] Lógica de Recepción de Respuestas y Cálculo de Puntaje
  **Descripción:** Al recibir una respuesta del estudiante (evento `submit_answer`), comparar con la respuesta correcta. Calcular puntaje según tiempo de respuesta y enviar retroalimentación individual. Actualizar la puntuación total del estudiante en la sala.
  **Tags:** `backend`, `game`, `puntaje`
  **Color:** teal
  **Duración:** 2d

- **Título:** [Game MS] Lógica de Fin de Juego y Envío de Resultados
  **Descripción:** Al finalizar todas las preguntas, enviar a cada estudiante su puntuación final y un resumen de sus respuestas. Enviar al profesor la clasificación general.
  **Tags:** `backend`, `game`, `resultados`
  **Color:** teal
  **Duración:** 1d

### 3.4 Microservicio RAG y Middleware LLM
- **Título:** [RAG MS] Endpoint `/query` para Recuperar Contexto Educativo
  **Descripción:** El microservicio debe exponer un endpoint POST `/query` que recibe una pregunta en texto plano, genera su embedding (usando fastembed BAAI/bge-small-en-v1.5), busca en Qdrant (colección `rag_biologia`) y devuelve los top-K fragmentos más relevantes con su puntuación de similitud.
  **Tags:** `backend`, `rag`, `api`, 
  **Color:** lime
  **Duración:** 2d

- **Título:** [RAG MS] Integración con Middleware LLM (Proxy)
  **Descripción:** El middleware LLM (proxyLLM) debe consumir el endpoint `/query` del RAG MS para obtener contexto relevante. Luego, armar un prompt enriquecido y enviarlo a LLAMA.cpp. Finalmente, devolver la respuesta generada al estudiante.
  **Tags:** `backend`, `rag`, `llm`, `middleware`, `integracion`
  **Color:** lime
  **Duración:** 2d

---

## 4. DESPLIEGUE DE MICROSERVICIOS
- **Título:** [Despliegue] Configurar Microservicio de Gateway (Rutas y Filtros JWT)
  **Descripción:** Definir rutas de enrutamiento en `application.yml` para todos los MS (auth, rag, game, admin, profe). Implementar validación de tokens JWT y seguridad por propagación de headers(ej: `X-User-Id`, `X-Role`) a los MS internos.
  **Tags:** `despliegue`, `gateway`, `seguridad`
  **Color:** green
  **Duración:** 2d

- **Título:** [Despliegue] Desplegar Microservicio de Profesor (Backend)
  **Descripción:** Implementar controladores CRUD para quizzes y preguntas. Exponer endpoints internos para otros MS.
  **Tags:** `despliegue`, `backend`, `profesor`
  **Color:** green
  **Duración:** 2d

- **Título:** [Despliegue] Desplegar Microservicio de Administrador (Backend)
  **Descripción:** Crear estructura base del MS. Implementar CRUD de profesores, estudiantes, materias, cursos y asignaciones. Exponer endpoints internos para otros MS.
  **Tags:** `despliegue`, `backend`, `admin`
  **Color:** green
  **Duración:** 2d

- **Título:** [Despliegue] Desplegar Microservicio de Juego (Backend)
  **Descripción:** Configurar el servidor WebSocket (Socket.io o similar) para manejar salas de juego en tiempo real. Definir eventos de conexión, creación de sala, respuesta de estudiantes y cálculo de puntajes.
  **Tags:** `despliegue`, `backend`, `game`
  **Color:** green
  **Duración:** 2d

- **Título:** [Despliegue] Desplegar Microservicio RAG y Middleware LLM
  **Descripción:** Verificar que el microservicio RAG esté corriendo en el puerto `:8002` y el proxy LLM funcione correctamente. Probar conexión con Qdrant y con LLAMA.cpp.
  **Tags:** `despliegue`, `rag`, `llm`, `middleware`
  **Color:** green
  **Duración:** 2d

---

## 5. COMUNICACIÓN E INTEGRACIÓN ENTRE MICROSERVICIOS

- **Título:** [Integración] Gateway como Proxy Inverso
  **Descripción:** Configurar el Gateway para enrutar las peticiones del frontend al microservicio correspondiente según la URL base (ej: `/api/admin/*` -> MS Admin, `/api/profesor/*` -> MS Profesor, `/api/auth/*` -> MS Auth, etc.).
  **Tags:** `integracion`, `gateway`, `proxy`
  **Color:** cyan
  **Duración:** 1d

- **Título:** [Integración] Propagación de Token JWT entre Microservicios
  **Descripción:** Asegurar que cuando el Gateway recibe una petición con token JWT, lo valide, extraiga el usuario y rol, y luego agregue headers (ej: `X-User-Id`, `X-Role`) a la petición que reenvía al microservicio destino. Los microservicios deben confiar en estos headers para autorización.
  **Tags:** `integracion`, `seguridad`, `jwt`, `gateway`
  **Color:** cyan
  **Duración:** 2d

- **Título:** [Integración] Logout de Usuarios (Gateway)
  **Descripción:** Implementar endpoint `/api/auth/logout` en el Gateway. Al recibir la petición, el Gateway debe invalidar el token JWT, y el frontend redirigirá al login.
  **Tags:** `integracion`, `seguridad`, `jwt`, `gateway`, `logout`
  **Color:** cyan
  **Duración:** 1d

- **Título:** [Integración] Comunicación MS Game con MS Profesor para Obtener Quizzes
  **Descripción:** Cuando el profesor inicie un juego, el MS Game debe consultar al MS Profesor (a través del Gateway) el quiz completo (preguntas y respuestas) para poder enviarlas a los estudiantes.
  **Tags:** `integracion`, `game`, `profesor`, `api`
  **Color:** cyan
  **Duración:** 1d

- **Título:** [Integración] Comunicación Frontend Estudiante con MS Game (WebSocket)
  **Descripción:** Implementar en el frontend del estudiante la conexión WebSocket al MS Game. Manejar eventos: conexión, unión a sala, recepción de preguntas, envío de respuestas, recepción de resultados.
  **Tags:** `integracion`, `frontend`, `game`
  **Color:** cyan
  **Duración:** 2d

- **Título:** [Integración] Comunicación Frontend Estudiante con Middleware LLM (Chat IA)
  **Descripción:** Cuando el estudiante esté en el chat post-partida, el frontend debe enviar el mensaje del estudiante junto con el contexto de errores (pregunta, respuesta del estudiante, respuesta correcta) al middleware LLM (a través del Gateway). El middleware LLM consultará al RAG y a LLAMA.cpp para generar la explicación.
  **Tags:** `integracion`, `frontend`, `ia`, `chat`, `middleware`
  **Color:** cyan
  **Duración:** 2d
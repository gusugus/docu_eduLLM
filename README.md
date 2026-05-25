# eduLLM - Índice de Diagramas de Secuencia (Flujos de Tiempo)

Este repositorio contiene la documentación de los flujos de interacción y diagramas de secuencia del sistema **eduLLM**, organizados por actor y caso de uso. Los diagramas están escritos en formato **PlantUML** dentro de archivos Markdown (`.md`).

Para navegar rápidamente entre los archivos, también puedes usar el archivo **[INDEX.md](INDEX.md)**.

---

## 🗺️ Mapa de Componentes y Actores

Los flujos descritos en los diagramas involucran a los siguientes actores y componentes del sistema:

*   **Actores**:
    *   `Usuario` / `Profesor` / `Estudiante`: Usuarios finales del sistema.
*   **Componentes / Microservicios**:
    *   `Gateway`: Punto de entrada único que valida tokens JWT y redirige peticiones.
    *   `MS AUTENTICACION`: Encargado del inicio de sesión, validación de credenciales y generación de JWTs.
    *   `MS PROFESOR`: Backend/Frontend para la gestión y sincronización manual de preguntas.
    *   `MS LLM-MIDD`: Middleware encargado de orquestar las peticiones a los modelos de lenguaje (LLM).
    *   `MS RAG`: Microservicio de generación aumentada por recuperación (Retrieval-Augmented Generation) para proveer contexto educativo.
    *   `LLAMA.cpp`: Motor de inferencia local para el LLM.
    *   `Juego Legacy (API)`: Sistema de juego con el cual se sincronizan las preguntas del profesor.

---

## 🗂️ Índice de Diagramas

A continuación se detallan los diagramas de secuencia disponibles en la carpeta [tiempo](tiempo/):

| # | Diagrama / Flujo | Actor Principal | Descripción | Estado / Detalle |
| :-: | :--- | :--- | :--- | :--- |
| **1** | [1. Diagrama de secuencia: Login (profesor o estudiante)](<tiempo/1. Diagrama de secuencia: Login (profesor o estudiante).md>) | Común | Proceso de autenticación y obtención de token JWT a través del Gateway y el MS de Autenticación. | Completado |
| **2** | [2. Profesor: Guardar preguntas de forma manual](<tiempo/2. Profesor: Guardar preguntas forma manual.md>) | Profesor | Registro manual de preguntas por parte del profesor, persistencia en BD y sincronización opcional con la API del juego. | Completado |
| **3A** | [3A. Profesor: Generar preguntas con IA - 403 Forbidden](<tiempo/3A. Profesor: Generar preguntas con IA - 403 Forbidden.md>) | Profesor | Flujo alternativo/error de control de acceso cuando un usuario con token inválido o rol incorrecto intenta acceder al panel o la API de IA. | Completado |
| **3B** | [3B. Profesor: genera preguntas auto](<tiempo/3B. Profesor: genera preguntas auto.md>) | Profesor | Flujo principal de generación automática de preguntas usando IA: integración de RAG para recuperar contexto y llamada al LLM (Llama.cpp). | Completado |
| **4** | [4. Estudiante: juega una partida](<tiempo/4. Estudiante: juega una partida.md>) | Estudiante | Diagrama de secuencia del juego y resolución de preguntas por parte del estudiante. | *Pendiente de documentar* (Archivo vacío) |
| **5** | [5. Estudiante: solicita retroalimentación al LLM (post-partida)](<tiempo/5. Estudiante: solicita retroalimentación al LLM (post-partida).md>) | Estudiante | Solicitud de retroalimentación inteligente sobre las respuestas dadas, con recuperación de contexto mediante RAG y memoria de conversación. | Completado |

---

## 🚀 Cómo Visualizar los Diagramas

Dado que los archivos están escritos en **PlantUML**, puedes visualizarlos de las siguientes maneras:

1.  **Extensión de VS Code**: Instala la extensión oficial de **PlantUML** y presiona `Alt + D` para previsualizar el diagrama activo.
2.  **Servidor PlantUML**: Copia el código de cualquier archivo y pégalo en el [Servidor Oficial de PlantUML](http://www.plantuml.com/plantuml) para generar la imagen en PNG/SVG.
3.  **Línea de comandos (CLI)**: Si tienes Java y `plantuml.jar` instalados, puedes renderizar todos los diagramas ejecutando:
    ```bash
    plantuml tiempo/*.md
    ```

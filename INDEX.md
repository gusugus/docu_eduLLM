# INDEX - Navegación de Documentación (eduLLM)

Bienvenido al índice de navegación de la documentación de **eduLLM**. Utiliza este menú para navegar directamente a los archivos markdown (`.md`) de cada diagrama de secuencia.

---

## 🗂️ Diagramas y Flujos del Sistema

*   **🔑 Autenticación y Acceso**
    *   [1. Diagrama de secuencia: Login (profesor o estudiante)](<tiempo/1. Diagrama de secuencia: Login (profesor o estudiante).md>)
        *   *Flujo de autenticación general, generación y validación de tokens JWT en el Gateway.*

*   **👨‍🏫 Sección del Profesor**
    *   [2. Profesor: Guardar preguntas de forma manual](<tiempo/2. Profesor: Guardar preguntas forma manual.md>)
        *   *Creación y sincronización de preguntas con la base de datos y la API legacy del juego.*
    *   [3A. Profesor: Generación de preguntas con IA - Acceso Denegado (403)](<tiempo/3A. Profesor: Generar preguntas con IA - 403 Forbidden.md>)
        *   *Manejo de seguridad y validación de roles cuando se intenta acceder sin permisos.*
    *   [3B. Profesor: Generación automática de preguntas con IA](<tiempo/3B. Profesor: genera preguntas auto.md>)
        *   *Flujo completo de generación asistida por IA usando RAG (recuperación de contexto) y LLAMA.cpp.*

*   **🎮 Sección del Estudiante**
    *   [4. Estudiante: juega una partida](<tiempo/4. Estudiante: juega una partida.md>)
        *   *Flujo de partida y envío de respuestas (pendiente de documentar).*
    *   [5. Estudiante: Retroalimentación de la partida mediante LLM](<tiempo/5. Estudiante: solicita retroalimentación al LLM (post-partida).md>)
        *   *Generación de comentarios pedagógicos adaptativos basados en el historial y contexto RAG.*

---

## 🧭 Instrucciones de Navegación

*   **Para volver aquí**: Cada uno de los archivos markdown anteriores tiene enlaces de retorno o puedes pulsar "Atrás" en tu lector de Markdown.
*   **Para ver el detalle técnico**: Si deseas ver una explicación de la arquitectura y la relación entre microservicios, consulta el archivo principal [README.md](README.md).

@startuml eduLLM_Database
!theme plain
title eduLLM - Modelo de Base de Datos (Esquema comun)

skinparam linetype ortho
skinparam class {
    BackgroundColor #FEF9E6
    BorderColor #333333
    ArrowColor #333333
}

' ============================================
' TABLAS PRINCIPALES DE USUARIOS
' ============================================
class usuario {
    + id_usuario : INTEGER [PK]
    --
    cedula : VARCHAR(20) [NN]
    username : VARCHAR(100) [NN, UK]
    correo : TEXT
    primer_nombre : VARCHAR(100) [NN]
    segundo_nombre : VARCHAR(100)
    apellido_paterno : VARCHAR(100) [NN]
    apellido_materno : VARCHAR(100)
    password_hash : VARCHAR(255) [NN]
    reset_token : VARCHAR(255)
    reset_token_expiry : TIMESTAMP
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_rol : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class rol {
    + id_rol : INTEGER [PK]
    --
    nombre : VARCHAR(50) [NN, UK]
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_estado : INTEGER [FK]
}

class estado {
    + id_estado : INTEGER [PK]
    --
    codigo : VARCHAR(3) [NN, UK]
    nombre : VARCHAR(50) [NN]
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
}

' ============================================
' ROLES ESPECÍFICOS (HERENCIA LÓGICA)
' ============================================
class administrador {
    + id_administrador : INTEGER [PK]
    --
    nivel_acceso : INTEGER
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_usuario : INTEGER [FK, UK]
    id_estado : INTEGER [FK]
}

class profesor {
    + id_profesor : INTEGER [PK]
    --
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_usuario : INTEGER [FK, UK]
    id_estado : INTEGER [FK]
}

class estudiante {
    + id_estudiante : INTEGER [PK]
    --
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_usuario : INTEGER [FK, UK]
    id_estado : INTEGER [FK]
    id_grado : INTEGER [FK]
}

' ============================================
' ACADÉMICO
' ============================================
class grado {
    + id_grado : INTEGER [PK]
    --
    grado : INTEGER
    paralelo : VARCHAR(1)
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    id_estado : INTEGER [FK]
}

class periodo_lectivo {
    + id_periodo_lectivo : INTEGER [PK]
    --
    nombre : VARCHAR(100) [NN]
    fecha_inicio : DATE [NN]
    fecha_fin : DATE [NN]
    es_activo : BOOLEAN
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_estado : INTEGER [FK]
}

class materia {
    + id_materia : INTEGER [PK]
    --
    nombre : VARCHAR(100) [NN]
    nombre_normalizado : TEXT
    descripcion : TEXT
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_estado : INTEGER [FK]
    id_grado : INTEGER [FK]
}

' ============================================
' RELACIONES ACADÉMICAS
' ============================================
class profesor_materia {
    + id_profesor_materia : INTEGER [PK]
    --
    fecha_asignacion : TIMESTAMP
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_profesor : INTEGER [FK]
    id_materia : INTEGER [FK]
    id_periodo_lectivo : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class estudiante_materia {
    + id_estudiante_materia : INTEGER [PK]
    --
    fecha_inscripcion : TIMESTAMP
    fecha_retiro : TIMESTAMP
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_estudiante : INTEGER [FK]
    id_materia : INTEGER [FK]
    id_periodo_lectivo : INTEGER [FK]
    id_estado : INTEGER [FK]
}

' ============================================
' PRUEBAS Y GAMIFICACIÓN
' ============================================
class prueba {
    + id_prueba : INTEGER [PK]
    --
    titulo : VARCHAR(255) [NN]
    descripcion : TEXT
    configuracion : JSONB
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_profesor : INTEGER [FK]
    id_materia : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class partida {
    + id_partida : INTEGER [PK]
    --
    codigo_acceso : VARCHAR(6) [NN, UK]
    estado_partida : VARCHAR(20)
    iniciado_en : TIMESTAMP
    finalizado_en : TIMESTAMP
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_prueba : INTEGER [FK]
    id_profesor : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class partida_estudiante {
    + id_partida_estudiante : INTEGER [PK]
    --
    nickname_opcional : VARCHAR(100)
    puntaje_total : INTEGER
    respuestas_correctas : INTEGER
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_partida : INTEGER [FK]
    id_estudiante : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class pregunta {
    + id_pregunta : INTEGER [PK]
    --
    texto : TEXT [NN]
    tipo : VARCHAR(20)
    cooldown : INTEGER
    tiempo_limite : INTEGER
    image_url : TEXT
    audio_url : TEXT
    video_url : TEXT
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_prueba : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class opcion {
    + id_opcion : INTEGER [PK]
    --
    texto : TEXT [NN]
    orden : INTEGER [NN]
    es_correcta : BOOLEAN
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    -- FK --
    id_pregunta : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class respuesta {
    + id_respuesta : INTEGER [PK]
    --
    respuesta_dada : INTEGER
    tiempo_ms : INTEGER
    puntaje_obtenido : INTEGER
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_partida_estudiante : INTEGER [FK]
    id_pregunta : INTEGER [FK]
    id_opcion_seleccionada : INTEGER [FK]
}

class retroalimentacion_llm {
    + id_retroalimentacion : INTEGER [PK]
    --
    preguntas_falladas : JSONB
    prompt_enviado : TEXT
    respuesta_llm : TEXT
    modelo_usado : VARCHAR(100)
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_partida_estudiante : INTEGER [FK]
}

' ============================================
' PARÁMETROS Y DOCUMENTOS
' ============================================
class admi_parametro {
    + id_parametro : INTEGER [PK]
    --
    clave : VARCHAR(100) [NN, UK]
    valor : TEXT [NN]
    tipo : VARCHAR(20)
    descripcion : TEXT
    fecha_creacion : TIMESTAMP
    usuario_creacion : INTEGER
    fecha_modificacion : TIMESTAMP
    usuario_modificacion : INTEGER
    -- FK --
    id_estado : INTEGER [FK]
}

class documento {
    + id_documento : INTEGER [PK]
    --
    ruta : TEXT [NN]
    -- FK --
    id_usuario : INTEGER [FK]
    id_estado : INTEGER [FK]
}

class sessions {
    + sid : VARCHAR [PK]
    --
    sess : JSON [NN]
    expire : TIMESTAMP [NN]
}

' ============================================
' RELACIONES
' ============================================
usuario ||--|| rol : "tiene"
usuario ||--|| estado : "tiene"
rol ||--|| estado : "tiene"

usuario ||--|| administrador : "puede ser"
usuario ||--|| profesor : "puede ser"
usuario ||--|| estudiante : "puede ser"

administrador ||--|| estado : "tiene"
profesor ||--|| estado : "tiene"
estudiante ||--|| estado : "tiene"

estudiante }o--|| grado : "pertenece"

profesor_materia }o--|| profesor : "asigna"
profesor_materia }o--|| materia : "asigna"
profesor_materia }o--|| periodo_lectivo : "en"
profesor_materia ||--|| estado : "tiene"

estudiante_materia }o--|| estudiante : "inscribe"
estudiante_materia }o--|| materia : "inscribe"
estudiante_materia }o--|| periodo_lectivo : "en"
estudiante_materia ||--|| estado : "tiene"

materia }o--|| grado : "pertenece"
materia ||--|| estado : "tiene"
periodo_lectivo ||--|| estado : "tiene"
grado ||--|| estado : "tiene"

prueba }o--|| profesor : "crea"
prueba }o--|| materia : "de"
prueba ||--|| estado : "tiene"

partida }o--|| prueba : "ejecuta"
partida }o--|| profesor : "gestiona"
partida ||--|| estado : "tiene"

partida_estudiante }o--|| partida : "participa"
partida_estudiante }o--|| estudiante : "participa"
partida_estudiante ||--|| estado : "tiene"

pregunta }o--|| prueba : "contiene"
pregunta ||--|| estado : "tiene"

opcion }o--|| pregunta : "responde"
opcion ||--|| estado : "tiene"

respuesta }o--|| partida_estudiante : "registra"
respuesta }o--|| pregunta : "responde"
respuesta }o--|| opcion : "selecciona"

retroalimentacion_llm }o--|| partida_estudiante : "genera"

admi_parametro ||--|| estado : "tiene"
documento }o--|| usuario : "pertenece"
documento ||--|| estado : "tiene"

@enduml
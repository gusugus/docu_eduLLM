@startuml
!define table(x) class x << (T,#FFAAAA) >>
!define fk(x) <color:blue>x</color>
!define pk(x) <color:green>_x_</color>

table(usuario) {
    pk(id_usuario): int
    username: varchar(100) UK
    password_hash: varchar(255)
    fk(id_rol): int
    fk(id_estado): int
    primer_nombre: varchar(100)
    apellido_paterno: varchar(100)
    apellido_materno: varchar(100)
    correo: text
    reset_token: varchar(255)
    reset_token_expiry: timestamp
}

table(rol) {
    pk(id_rol): int
    nombre: varchar(50) UK
    fk(id_estado): int
}

table(estado) {
    pk(id_estado): int
    codigo: varchar(3) UK
    nombre: varchar(50)
}

table(administrador) {
    pk(id_administrador): int
    fk(id_usuario): int
    nivel_acceso: int
    fk(id_estado): int
}

table(profesor) {
    pk(id_profesor): int
    fk(id_usuario): int
    especialidad: varchar(100)
    fk(id_estado): int
}

table(estudiante) {
    pk(id_estudiante): int
    fk(id_usuario): int
    fk(id_grado): int
    fk(id_estado): int
}

table(grado) {
    pk(id_grado): int
    grado: int
    paralelo: varchar(1)
    fk(id_estado): int
}

table(materia) {
    pk(id_materia): int
    nombre: varchar(100)
    descripcion: text
    fk(id_grado): int
    fk(id_estado): int
    nombre_normalizado: text
}

table(periodo_lectivo) {
    pk(id_periodo_lectivo): int
    nombre: varchar(100)
    fecha_inicio: date
    fecha_fin: date
    es_activo: boolean
    fk(id_estado): int
}

table(profesor_materia) {
    pk(id_profesor_materia): int
    fk(id_profesor): int
    fk(id_materia): int
    fk(id_periodo_lectivo): int
    fk(id_estado): int
}

table(estudiante_materia) {
    pk(id_estudiante_materia): int
    fk(id_estudiante): int
    fk(id_materia): int
    fk(id_periodo_lectivo): int
    fk(id_estado): int
    fecha_inscripcion: timestamp
    fecha_retiro: timestamp
}

table(prueba) {
    pk(id_prueba): int
    titulo: varchar(255)
    descripcion: text
    fk(id_profesor): int
    fk(id_materia): int
    configuracion: jsonb
    fk(id_estado): int
}

table(partida) {
    pk(id_partida): int
    fk(id_prueba): int
    fk(id_profesor): int
    codigo_acceso: varchar(6) UK
    estado_partida: varchar(20)
    iniciado_en: timestamp
    finalizado_en: timestamp
    fk(id_estado): int
}

table(partida_estudiante) {
    pk(id_partida_estudiante): int
    fk(id_partida): int
    fk(id_estudiante): int
    nickname_opcional: varchar(100)
    puntaje_total: int
    respuestas_correctas: int
    fk(id_estado): int
}

table(pregunta) {
    pk(id_pregunta): int
    fk(id_prueba): int
    texto: text
    tipo: varchar(20)
    cooldown: int
    tiempo_limite: int
    fk(id_estado): int
    image_url: text
    audio_url: text
    video_url: text
}

table(opcion) {
    pk(id_opcion): int
    fk(id_pregunta): int
    texto: text
    orden: int
    es_correcta: boolean
    fk(id_estado): int
}

table(respuesta) {
    pk(id_respuesta): int
    fk(id_partida_estudiante): int
    fk(id_pregunta): int
    fk(id_opcion_seleccionada): int
    tiempo_ms: int
    puntaje_obtenido: int
}

table(retroalimentacion_llm) {
    pk(id_retroalimentacion): int
    fk(id_partida_estudiante): int
    preguntas_falladas: jsonb
    prompt_enviado: text
    respuesta_llm: text
    modelo_usado: varchar(100)
}

table(admi_parametro) {
    pk(id_parametro): int
    clave: varchar(100) UK
    valor: text
    tipo: varchar(20)
    descripcion: text
    fk(id_estado): int
}

table(documento) {
    pk(id_documento): int
    ruta: text
    fk(id_usuario): int
    fk(id_estado): int
}

usuario ||--o{ administrador : ""
usuario ||--o{ profesor : ""
usuario ||--o{ estudiante : ""
usuario ||--o{ documento : ""
usuario }o--|| rol : ""
usuario }o--|| estado : ""

estado ||--o{ admi_parametro : ""
estado ||--o{ materia : ""
estado ||--o{ prueba : ""
estado ||--o{ partida : ""
estado ||--o{ partida_estudiante : ""
estado ||--o{ pregunta : ""
estado ||--o{ opcion : ""
estado ||--o{ periodo_lectivo : ""
estado ||--o{ profesor_materia : ""
estado ||--o{ estudiante_materia : ""
estado ||--o{ administrador : ""
estado ||--o{ profesor : ""
estado ||--o{ estudiante : ""

profesor ||--o{ prueba : ""
profesor ||--o{ partida : ""
profesor ||--o{ profesor_materia : ""

materia ||--o{ profesor_materia : ""
materia ||--o{ estudiante_materia : ""
materia ||--o{ prueba : ""
materia }o--|| grado : ""

grado ||--o{ estudiante : ""
grado ||--o{ materia : ""

periodo_lectivo ||--o{ profesor_materia : ""
periodo_lectivo ||--o{ estudiante_materia : ""

prueba ||--o{ partida : ""
prueba ||--o{ pregunta : ""

pregunta ||--o{ opcion : ""
pregunta ||--o{ respuesta : ""

partida ||--o{ partida_estudiante : ""
partida_estudiante ||--o{ respuesta : ""
partida_estudiante ||--|| retroalimentacion_llm : ""

@enduml
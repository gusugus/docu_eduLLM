erDiagram
    usuario {
        integer id_usuario PK
        varchar username UK
        varchar password_hash
        integer id_rol FK
        integer id_estado FK
        varchar primer_nombre
        varchar apellido_paterno
        varchar apellido_materno
        varchar correo
        varchar reset_token
        timestamp reset_token_expiry
    }

    rol {
        integer id_rol PK
        varchar nombre UK
        integer id_estado FK
    }

    estado {
        integer id_estado PK
        varchar codigo UK
        varchar nombre
    }

    administrador {
        integer id_administrador PK
        integer id_usuario FK
        integer nivel_acceso
        integer id_estado FK
    }

    profesor {
        integer id_profesor PK
        integer id_usuario FK
        varchar especialidad
        integer id_estado FK
    }

    estudiante {
        integer id_estudiante PK
        integer id_usuario FK
        integer id_grado FK
        integer id_estado FK
    }

    grado {
        integer id_grado PK
        integer grado
        varchar paralelo
        integer id_estado FK
    }

    materia {
        integer id_materia PK
        varchar nombre
        text descripcion
        integer id_grado FK
        integer id_estado FK
        text nombre_normalizado
    }

    periodo_lectivo {
        integer id_periodo_lectivo PK
        varchar nombre
        date fecha_inicio
        date fecha_fin
        boolean es_activo
        integer id_estado FK
    }

    profesor_materia {
        integer id_profesor_materia PK
        integer id_profesor FK
        integer id_materia FK
        integer id_periodo_lectivo FK
        integer id_estado FK
    }

    estudiante_materia {
        integer id_estudiante_materia PK
        integer id_estudiante FK
        integer id_materia FK
        integer id_periodo_lectivo FK
        integer id_estado FK
        timestamp fecha_inscripcion
        timestamp fecha_retiro
    }

    prueba {
        integer id_prueba PK
        varchar titulo
        text descripcion
        integer id_profesor FK
        integer id_materia FK
        jsonb configuracion
        integer id_estado FK
    }

    partida {
        integer id_partida PK
        integer id_prueba FK
        integer id_profesor FK
        varchar codigo_acceso UK
        varchar estado_partida
        timestamp iniciado_en
        timestamp finalizado_en
        integer id_estado FK
    }

    partida_estudiante {
        integer id_partida_estudiante PK
        integer id_partida FK
        integer id_estudiante FK
        varchar nickname_opcional
        integer puntaje_total
        integer respuestas_correctas
        integer id_estado FK
    }

    pregunta {
        integer id_pregunta PK
        integer id_prueba FK
        text texto
        varchar tipo
        integer cooldown
        integer tiempo_limite
        integer id_estado FK
        text image_url
        text audio_url
        text video_url
    }

    opcion {
        integer id_opcion PK
        integer id_pregunta FK
        text texto
        integer orden
        boolean es_correcta
        integer id_estado FK
    }

    respuesta {
        integer id_respuesta PK
        integer id_partida_estudiante FK
        integer id_pregunta FK
        integer id_opcion_seleccionada FK
        integer tiempo_ms
        integer puntaje_obtenido
    }

    retroalimentacion_llm {
        integer id_retroalimentacion PK
        integer id_partida_estudiante FK
        jsonb preguntas_falladas
        text prompt_enviado
        text respuesta_llm
        varchar modelo_usado
    }

    admi_parametro {
        integer id_parametro PK
        varchar clave UK
        text valor
        varchar tipo
        text descripcion
        integer id_estado FK
    }

    documento {
        integer id_documento PK
        text ruta
        integer id_usuario FK
        integer id_estado FK
    }


    usuario ||--o{ administrador : "es"
    usuario ||--o{ profesor : "es"
    usuario ||--o{ estudiante : "es"
    usuario ||--o{ documento : "posee"
    usuario }o--|| rol : "tiene"
    usuario }o--|| estado : "estado"

    estado ||--o{ admi_parametro : "estado"
    estado ||--o{ materia : "estado"
    estado ||--o{ prueba : "estado"
    estado ||--o{ partida : "estado"
    estado ||--o{ partida_estudiante : "estado"
    estado ||--o{ pregunta : "estado"
    estado ||--o{ opcion : "estado"
    estado ||--o{ periodo_lectivo : "estado"
    estado ||--o{ profesor_materia : "estado"
    estado ||--o{ estudiante_materia : "estado"
    estado ||--o{ administrador : "estado"
    estado ||--o{ profesor : "estado"
    estado ||--o{ estudiante : "estado"

    profesor ||--o{ prueba : "crea"
    profesor ||--o{ partida : "genera"
    profesor ||--o{ profesor_materia : "asigna"

    materia ||--o{ profesor_materia : "tiene"
    materia ||--o{ estudiante_materia : "inscribe"
    materia ||--o{ prueba : "asociada"
    materia }o--|| grado : "pertenece"

    grado ||--o{ estudiante : "tiene"
    grado ||--o{ materia : "ofrece"

    periodo_lectivo ||--o{ profesor_materia : "vigencia"
    periodo_lectivo ||--o{ estudiante_materia : "vigencia"

    prueba ||--o{ partida : "se juega"
    prueba ||--o{ pregunta : "contiene"

    pregunta ||--o{ opcion : "tiene"
    pregunta ||--o{ respuesta : "recibe"

    partida ||--o{ partida_estudiante : "participantes"
    partida_estudiante ||--o{ respuesta : "envía"
    partida_estudiante ||--|| retroalimentacion_llm : "recibe"
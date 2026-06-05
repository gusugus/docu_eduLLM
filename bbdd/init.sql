
CREATE SCHEMA comun;


ALTER SCHEMA comun OWNER TO admin;


CREATE TABLE comun.admi_parametro (
    id_parametro integer NOT NULL,
    clave character varying(100) NOT NULL,
    valor text NOT NULL,
    tipo character varying(20) DEFAULT 'string'::character varying,
    descripcion text,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    CONSTRAINT check_tipo_valido CHECK (((tipo)::text = ANY ((ARRAY['TEXT'::character varying, 'NUMERIC'::character varying, 'BOOLEAN'::character varying, 'JSON'::character varying])::text[])))
);


ALTER TABLE comun.admi_parametro OWNER TO admin;

--
-- Name: administrador; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.administrador (
    id_administrador integer NOT NULL,
    id_usuario integer NOT NULL,
    nivel_acceso integer DEFAULT 1,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL
);


ALTER TABLE comun.administrador OWNER TO admin;

--
-- Name: admin_administrador_id_administrador_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_administrador_id_administrador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_administrador_id_administrador_seq OWNER TO admin;

--
-- Name: admin_administrador_id_administrador_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_administrador_id_administrador_seq OWNED BY comun.administrador.id_administrador;


--
-- Name: estado; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.estado (
    id_estado integer NOT NULL,
    codigo character varying(3) NOT NULL,
    nombre character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer
);


ALTER TABLE comun.estado OWNER TO admin;

--
-- Name: admin_estado_id_estado_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_estado_id_estado_seq OWNER TO admin;

--
-- Name: admin_estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_estado_id_estado_seq OWNED BY comun.estado.id_estado;


--
-- Name: estudiante; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.estudiante (
    id_estudiante integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    id_grado integer
);


ALTER TABLE comun.estudiante OWNER TO admin;

--
-- Name: admin_estudiante_id_estudiante_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_estudiante_id_estudiante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_estudiante_id_estudiante_seq OWNER TO admin;

--
-- Name: admin_estudiante_id_estudiante_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_estudiante_id_estudiante_seq OWNED BY comun.estudiante.id_estudiante;


--
-- Name: admin_parametro_id_parametro_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_parametro_id_parametro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_parametro_id_parametro_seq OWNER TO admin;

--
-- Name: admin_parametro_id_parametro_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_parametro_id_parametro_seq OWNED BY comun.admi_parametro.id_parametro;


--
-- Name: periodo_lectivo; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.periodo_lectivo (
    id_periodo_lectivo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    es_activo boolean DEFAULT false,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL
);


ALTER TABLE comun.periodo_lectivo OWNER TO admin;

--
-- Name: admin_periodo_lectivo_id_periodo_lectivo_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_periodo_lectivo_id_periodo_lectivo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_periodo_lectivo_id_periodo_lectivo_seq OWNER TO admin;

--
-- Name: admin_periodo_lectivo_id_periodo_lectivo_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_periodo_lectivo_id_periodo_lectivo_seq OWNED BY comun.periodo_lectivo.id_periodo_lectivo;


--
-- Name: profesor; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.profesor (
    id_profesor integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    especialidad character varying(100)
);


ALTER TABLE comun.profesor OWNER TO admin;

--
-- Name: admin_profesor_id_profesor_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_profesor_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_profesor_id_profesor_seq OWNER TO admin;

--
-- Name: admin_profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_profesor_id_profesor_seq OWNED BY comun.profesor.id_profesor;


--
-- Name: rol; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.rol (
    id_rol integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL
);


ALTER TABLE comun.rol OWNER TO admin;

--
-- Name: admin_rol_id_rol_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_rol_id_rol_seq OWNER TO admin;

--
-- Name: admin_rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_rol_id_rol_seq OWNED BY comun.rol.id_rol;


--
-- Name: usuario; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.usuario (
    id_usuario integer NOT NULL,
    cedula character varying(20) NOT NULL,
    username character varying(100) NOT NULL,
    primer_nombre character varying(100) NOT NULL,
    apellido_paterno character varying(100) NOT NULL,
    apellido_materno character varying(100),
    password_hash character varying(255) NOT NULL,
    id_rol integer NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    reset_token character varying(255),
    reset_token_expiry timestamp with time zone,
    correo text,
    segundo_nombre character varying(100)
);


ALTER TABLE comun.usuario OWNER TO admin;

--
-- Name: admin_usuario_id_usuario_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.admin_usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.admin_usuario_id_usuario_seq OWNER TO admin;

--
-- Name: admin_usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.admin_usuario_id_usuario_seq OWNED BY comun.usuario.id_usuario;


--
-- Name: documento; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.documento (
    id_documento integer NOT NULL,
    ruta text NOT NULL,
    id_usuario integer,
    id_estado integer
);


ALTER TABLE comun.documento OWNER TO admin;

--
-- Name: documento_id_documento_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.documento_id_documento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.documento_id_documento_seq OWNER TO admin;

--
-- Name: documento_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.documento_id_documento_seq OWNED BY comun.documento.id_documento;


--
-- Name: estudiante_materia; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.estudiante_materia (
    id_estudiante_materia integer NOT NULL,
    id_estudiante integer NOT NULL,
    id_materia integer NOT NULL,
    id_periodo_lectivo integer NOT NULL,
    fecha_inscripcion timestamp with time zone DEFAULT now(),
    fecha_retiro timestamp with time zone,
    id_estado integer NOT NULL,
    usuario_creacion integer,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_modificacion integer,
    fecha_modificacion timestamp with time zone
);


ALTER TABLE comun.estudiante_materia OWNER TO admin;

--
-- Name: estudiante_materia_id_estudiante_materia_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.estudiante_materia_id_estudiante_materia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.estudiante_materia_id_estudiante_materia_seq OWNER TO admin;

--
-- Name: estudiante_materia_id_estudiante_materia_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.estudiante_materia_id_estudiante_materia_seq OWNED BY comun.estudiante_materia.id_estudiante_materia;


--
-- Name: grado; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.grado (
    grado integer,
    paralelo character varying(1),
    id_grado integer NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer DEFAULT 1
);


ALTER TABLE comun.grado OWNER TO admin;

--
-- Name: materia; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.materia (
    id_materia integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    nombre_normalizado text,
    id_grado integer
);


ALTER TABLE comun.materia OWNER TO admin;

--
-- Name: info_materia_id_materia_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_materia_id_materia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_materia_id_materia_seq OWNER TO admin;

--
-- Name: info_materia_id_materia_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_materia_id_materia_seq OWNED BY comun.materia.id_materia;


--
-- Name: opcion; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.opcion (
    id_opcion integer NOT NULL,
    id_pregunta integer NOT NULL,
    texto text NOT NULL,
    orden integer NOT NULL,
    es_correcta boolean DEFAULT false,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    id_estado integer NOT NULL
);


ALTER TABLE comun.opcion OWNER TO admin;

--
-- Name: info_opcion_id_opcion_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_opcion_id_opcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_opcion_id_opcion_seq OWNER TO admin;

--
-- Name: info_opcion_id_opcion_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_opcion_id_opcion_seq OWNED BY comun.opcion.id_opcion;


--
-- Name: partida_estudiante; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.partida_estudiante (
    id_partida_estudiante integer NOT NULL,
    id_partida integer NOT NULL,
    id_estudiante integer NOT NULL,
    nickname_opcional character varying(100),
    puntaje_total integer DEFAULT 0,
    respuestas_correctas integer DEFAULT 0,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL
);


ALTER TABLE comun.partida_estudiante OWNER TO admin;

--
-- Name: info_partida_estudiante_id_partida_estudiante_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_partida_estudiante_id_partida_estudiante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_partida_estudiante_id_partida_estudiante_seq OWNER TO admin;

--
-- Name: info_partida_estudiante_id_partida_estudiante_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_partida_estudiante_id_partida_estudiante_seq OWNED BY comun.partida_estudiante.id_partida_estudiante;


--
-- Name: partida; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.partida (
    id_partida integer NOT NULL,
    id_prueba integer NOT NULL,
    codigo_acceso character varying(6) NOT NULL,
    id_profesor integer NOT NULL,
    estado_partida character varying(20) DEFAULT 'esperando'::character varying,
    iniciado_en timestamp with time zone,
    finalizado_en timestamp with time zone,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL
);


ALTER TABLE comun.partida OWNER TO admin;

--
-- Name: info_partida_id_partida_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_partida_id_partida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_partida_id_partida_seq OWNER TO admin;

--
-- Name: info_partida_id_partida_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_partida_id_partida_seq OWNED BY comun.partida.id_partida;


--
-- Name: pregunta; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.pregunta (
    id_pregunta integer NOT NULL,
    id_prueba integer NOT NULL,
    texto text NOT NULL,
    tipo character varying(20) DEFAULT 'single_choice'::character varying,
    cooldown integer DEFAULT 5,
    tiempo_limite integer DEFAULT 30,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    image_url text,
    audio_url text,
    video_url text
);
ALTER TABLE ONLY comun.pregunta ALTER COLUMN image_url SET STORAGE PLAIN;


ALTER TABLE comun.pregunta OWNER TO admin;

--
-- Name: info_pregunta_id_pregunta_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_pregunta_id_pregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_pregunta_id_pregunta_seq OWNER TO admin;

--
-- Name: info_pregunta_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_pregunta_id_pregunta_seq OWNED BY comun.pregunta.id_pregunta;


--
-- Name: prueba; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.prueba (
    id_prueba integer NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    id_profesor integer NOT NULL,
    configuracion jsonb,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    id_materia integer
);


ALTER TABLE comun.prueba OWNER TO admin;

--
-- Name: info_prueba_id_prueba_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_prueba_id_prueba_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_prueba_id_prueba_seq OWNER TO admin;

--
-- Name: info_prueba_id_prueba_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_prueba_id_prueba_seq OWNED BY comun.prueba.id_prueba;


--
-- Name: respuesta; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.respuesta (
    id_respuesta integer NOT NULL,
    id_partida_estudiante integer NOT NULL,
    id_pregunta integer NOT NULL,
    respuesta_dada integer,
    tiempo_ms integer,
    puntaje_obtenido integer DEFAULT 0,
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_opcion_seleccionada integer
);


ALTER TABLE comun.respuesta OWNER TO admin;

--
-- Name: info_respuesta_id_respuesta_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_respuesta_id_respuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_respuesta_id_respuesta_seq OWNER TO admin;

--
-- Name: info_respuesta_id_respuesta_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_respuesta_id_respuesta_seq OWNED BY comun.respuesta.id_respuesta;


--
-- Name: retroalimentacion_llm; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.retroalimentacion_llm (
    id_retroalimentacion integer NOT NULL,
    id_partida_estudiante integer NOT NULL,
    preguntas_falladas jsonb,
    prompt_enviado text,
    respuesta_llm text,
    modelo_usado character varying(100),
    fecha_creacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer
);


ALTER TABLE comun.retroalimentacion_llm OWNER TO admin;

--
-- Name: info_retroalimentacion_llm_id_retroalimentacion_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.info_retroalimentacion_llm_id_retroalimentacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.info_retroalimentacion_llm_id_retroalimentacion_seq OWNER TO admin;

--
-- Name: info_retroalimentacion_llm_id_retroalimentacion_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.info_retroalimentacion_llm_id_retroalimentacion_seq OWNED BY comun.retroalimentacion_llm.id_retroalimentacion;


--
-- Name: profesor_materia; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.profesor_materia (
    id_profesor_materia integer NOT NULL,
    id_profesor integer NOT NULL,
    id_materia integer NOT NULL,
    fecha_asignacion timestamp with time zone DEFAULT now(),
    usuario_creacion integer,
    fecha_modificacion timestamp with time zone,
    usuario_modificacion integer,
    id_estado integer NOT NULL,
    id_periodo_lectivo integer NOT NULL
);


ALTER TABLE comun.profesor_materia OWNER TO admin;

--
-- Name: profesor_materia_id_profesor_materia_seq; Type: SEQUENCE; Schema: comun; Owner: admin
--

CREATE SEQUENCE comun.profesor_materia_id_profesor_materia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE comun.profesor_materia_id_profesor_materia_seq OWNER TO admin;

--
-- Name: profesor_materia_id_profesor_materia_seq; Type: SEQUENCE OWNED BY; Schema: comun; Owner: admin
--

ALTER SEQUENCE comun.profesor_materia_id_profesor_materia_seq OWNED BY comun.profesor_materia.id_profesor_materia;


--
-- Name: sessions; Type: TABLE; Schema: comun; Owner: admin
--

CREATE TABLE comun.sessions (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE comun.sessions OWNER TO admin;

--
-- Name: admi_parametro id_parametro; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.admi_parametro ALTER COLUMN id_parametro SET DEFAULT nextval('comun.admin_parametro_id_parametro_seq'::regclass);


--
-- Name: administrador id_administrador; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.administrador ALTER COLUMN id_administrador SET DEFAULT nextval('comun.admin_administrador_id_administrador_seq'::regclass);


--
-- Name: documento id_documento; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.documento ALTER COLUMN id_documento SET DEFAULT nextval('comun.documento_id_documento_seq'::regclass);


--
-- Name: estado id_estado; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estado ALTER COLUMN id_estado SET DEFAULT nextval('comun.admin_estado_id_estado_seq'::regclass);


--
-- Name: estudiante id_estudiante; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante ALTER COLUMN id_estudiante SET DEFAULT nextval('comun.admin_estudiante_id_estudiante_seq'::regclass);


--
-- Name: estudiante_materia id_estudiante_materia; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia ALTER COLUMN id_estudiante_materia SET DEFAULT nextval('comun.estudiante_materia_id_estudiante_materia_seq'::regclass);


--
-- Name: materia id_materia; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.materia ALTER COLUMN id_materia SET DEFAULT nextval('comun.info_materia_id_materia_seq'::regclass);


--
-- Name: opcion id_opcion; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.opcion ALTER COLUMN id_opcion SET DEFAULT nextval('comun.info_opcion_id_opcion_seq'::regclass);


--
-- Name: partida id_partida; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida ALTER COLUMN id_partida SET DEFAULT nextval('comun.info_partida_id_partida_seq'::regclass);


--
-- Name: partida_estudiante id_partida_estudiante; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida_estudiante ALTER COLUMN id_partida_estudiante SET DEFAULT nextval('comun.info_partida_estudiante_id_partida_estudiante_seq'::regclass);


--
-- Name: periodo_lectivo id_periodo_lectivo; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.periodo_lectivo ALTER COLUMN id_periodo_lectivo SET DEFAULT nextval('comun.admin_periodo_lectivo_id_periodo_lectivo_seq'::regclass);


--
-- Name: pregunta id_pregunta; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.pregunta ALTER COLUMN id_pregunta SET DEFAULT nextval('comun.info_pregunta_id_pregunta_seq'::regclass);


--
-- Name: profesor id_profesor; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor ALTER COLUMN id_profesor SET DEFAULT nextval('comun.admin_profesor_id_profesor_seq'::regclass);


--
-- Name: profesor_materia id_profesor_materia; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia ALTER COLUMN id_profesor_materia SET DEFAULT nextval('comun.profesor_materia_id_profesor_materia_seq'::regclass);


--
-- Name: prueba id_prueba; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.prueba ALTER COLUMN id_prueba SET DEFAULT nextval('comun.info_prueba_id_prueba_seq'::regclass);


--
-- Name: respuesta id_respuesta; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.respuesta ALTER COLUMN id_respuesta SET DEFAULT nextval('comun.info_respuesta_id_respuesta_seq'::regclass);


--
-- Name: retroalimentacion_llm id_retroalimentacion; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.retroalimentacion_llm ALTER COLUMN id_retroalimentacion SET DEFAULT nextval('comun.info_retroalimentacion_llm_id_retroalimentacion_seq'::regclass);


--
-- Name: rol id_rol; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.rol ALTER COLUMN id_rol SET DEFAULT nextval('comun.admin_rol_id_rol_seq'::regclass);


--
-- Name: usuario id_usuario; Type: DEFAULT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('comun.admin_usuario_id_usuario_seq'::regclass);


--
-- Name: administrador admin_administrador_id_usuario_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.administrador
    ADD CONSTRAINT admin_administrador_id_usuario_key UNIQUE (id_usuario);


--
-- Name: administrador admin_administrador_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.administrador
    ADD CONSTRAINT admin_administrador_pkey PRIMARY KEY (id_administrador);


--
-- Name: estado admin_estado_codigo_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estado
    ADD CONSTRAINT admin_estado_codigo_key UNIQUE (codigo);


--
-- Name: estado admin_estado_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estado
    ADD CONSTRAINT admin_estado_pkey PRIMARY KEY (id_estado);


--
-- Name: estudiante admin_estudiante_id_usuario_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante
    ADD CONSTRAINT admin_estudiante_id_usuario_key UNIQUE (id_usuario);


--
-- Name: estudiante admin_estudiante_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante
    ADD CONSTRAINT admin_estudiante_pkey PRIMARY KEY (id_estudiante);


--
-- Name: admi_parametro admin_parametro_clave_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.admi_parametro
    ADD CONSTRAINT admin_parametro_clave_key UNIQUE (clave);


--
-- Name: admi_parametro admin_parametro_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.admi_parametro
    ADD CONSTRAINT admin_parametro_pkey PRIMARY KEY (id_parametro);


--
-- Name: periodo_lectivo admin_periodo_lectivo_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.periodo_lectivo
    ADD CONSTRAINT admin_periodo_lectivo_pkey PRIMARY KEY (id_periodo_lectivo);


--
-- Name: profesor admin_profesor_id_usuario_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor
    ADD CONSTRAINT admin_profesor_id_usuario_key UNIQUE (id_usuario);


--
-- Name: profesor admin_profesor_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor
    ADD CONSTRAINT admin_profesor_pkey PRIMARY KEY (id_profesor);


--
-- Name: rol admin_rol_nombre_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.rol
    ADD CONSTRAINT admin_rol_nombre_key UNIQUE (nombre);


--
-- Name: rol admin_rol_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.rol
    ADD CONSTRAINT admin_rol_pkey PRIMARY KEY (id_rol);


--
-- Name: usuario admin_usuario_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.usuario
    ADD CONSTRAINT admin_usuario_pkey PRIMARY KEY (id_usuario);


--
-- Name: usuario admin_usuario_username_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.usuario
    ADD CONSTRAINT admin_usuario_username_key UNIQUE (username);


--
-- Name: documento documento_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.documento
    ADD CONSTRAINT documento_pkey PRIMARY KEY (id_documento);


--
-- Name: estudiante_materia estudiante_materia_id_estudiante_id_materia_id_periodo_lect_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia
    ADD CONSTRAINT estudiante_materia_id_estudiante_id_materia_id_periodo_lect_key UNIQUE (id_estudiante, id_materia, id_periodo_lectivo, id_estado);


--
-- Name: estudiante_materia estudiante_materia_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia
    ADD CONSTRAINT estudiante_materia_pkey PRIMARY KEY (id_estudiante_materia);


--
-- Name: grado grado_pk; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.grado
    ADD CONSTRAINT grado_pk PRIMARY KEY (id_grado);


--
-- Name: materia info_materia_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.materia
    ADD CONSTRAINT info_materia_pkey PRIMARY KEY (id_materia);


--
-- Name: opcion info_opcion_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.opcion
    ADD CONSTRAINT info_opcion_pkey PRIMARY KEY (id_opcion);


--
-- Name: partida info_partida_codigo_acceso_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida
    ADD CONSTRAINT info_partida_codigo_acceso_key UNIQUE (codigo_acceso);


--
-- Name: partida_estudiante info_partida_estudiante_id_partida_id_estudiante_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida_estudiante
    ADD CONSTRAINT info_partida_estudiante_id_partida_id_estudiante_key UNIQUE (id_partida, id_estudiante);


--
-- Name: partida_estudiante info_partida_estudiante_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida_estudiante
    ADD CONSTRAINT info_partida_estudiante_pkey PRIMARY KEY (id_partida_estudiante);


--
-- Name: partida info_partida_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida
    ADD CONSTRAINT info_partida_pkey PRIMARY KEY (id_partida);


--
-- Name: pregunta info_pregunta_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.pregunta
    ADD CONSTRAINT info_pregunta_pkey PRIMARY KEY (id_pregunta);


--
-- Name: prueba info_prueba_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.prueba
    ADD CONSTRAINT info_prueba_pkey PRIMARY KEY (id_prueba);


--
-- Name: respuesta info_respuesta_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.respuesta
    ADD CONSTRAINT info_respuesta_pkey PRIMARY KEY (id_respuesta);


--
-- Name: retroalimentacion_llm info_retroalimentacion_llm_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.retroalimentacion_llm
    ADD CONSTRAINT info_retroalimentacion_llm_pkey PRIMARY KEY (id_retroalimentacion);


--
-- Name: profesor_materia profesor_materia_id_profesor_id_materia_key; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_id_profesor_id_materia_key UNIQUE (id_profesor, id_materia);


--
-- Name: profesor_materia profesor_materia_periodo_unique; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_periodo_unique UNIQUE (id_profesor, id_materia, id_periodo_lectivo);


--
-- Name: profesor_materia profesor_materia_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_pkey PRIMARY KEY (id_profesor_materia);


--
-- Name: sessions session_pkey; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.sessions
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: partida uk_partida_codigo_acceso; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida
    ADD CONSTRAINT uk_partida_codigo_acceso UNIQUE (codigo_acceso);


--
-- Name: partida_estudiante uk_partida_estudiante; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida_estudiante
    ADD CONSTRAINT uk_partida_estudiante UNIQUE (id_partida, id_estudiante);


--
-- Name: materia uq_materia_nombre_grado; Type: CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.materia
    ADD CONSTRAINT uq_materia_nombre_grado UNIQUE (nombre_normalizado, id_grado);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: comun; Owner: admin
--

CREATE INDEX "IDX_session_expire" ON comun.sessions USING btree (expire);


--
-- Name: idx_opcion_pregunta_orden; Type: INDEX; Schema: comun; Owner: admin
--

CREATE UNIQUE INDEX idx_opcion_pregunta_orden ON comun.opcion USING btree (id_pregunta, orden) WHERE (id_estado = comun.obtener_id_estado_activo());


--
-- Name: estado trg_proteger_estado_activo; Type: TRIGGER; Schema: comun; Owner: admin
--

CREATE TRIGGER trg_proteger_estado_activo BEFORE UPDATE ON comun.estado FOR EACH ROW EXECUTE FUNCTION comun.trg_proteger_estado_activo();


--
-- Name: admi_parametro admin_parametro_id_estado_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.admi_parametro
    ADD CONSTRAINT admin_parametro_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: periodo_lectivo admin_periodo_lectivo_id_estado_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.periodo_lectivo
    ADD CONSTRAINT admin_periodo_lectivo_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: estudiante_materia estudiante_materia_id_estado_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia
    ADD CONSTRAINT estudiante_materia_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: estudiante_materia estudiante_materia_id_estudiante_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia
    ADD CONSTRAINT estudiante_materia_id_estudiante_fkey FOREIGN KEY (id_estudiante) REFERENCES comun.estudiante(id_estudiante);


--
-- Name: estudiante_materia estudiante_materia_id_materia_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia
    ADD CONSTRAINT estudiante_materia_id_materia_fkey FOREIGN KEY (id_materia) REFERENCES comun.materia(id_materia);


--
-- Name: estudiante_materia estudiante_materia_id_periodo_lectivo_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante_materia
    ADD CONSTRAINT estudiante_materia_id_periodo_lectivo_fkey FOREIGN KEY (id_periodo_lectivo) REFERENCES comun.periodo_lectivo(id_periodo_lectivo);


--
-- Name: administrador fk_administrador_usuario; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.administrador
    ADD CONSTRAINT fk_administrador_usuario FOREIGN KEY (id_usuario) REFERENCES comun.usuario(id_usuario);


--
-- Name: documento fk_documento_estado; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.documento
    ADD CONSTRAINT fk_documento_estado FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: documento fk_documento_usuario; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.documento
    ADD CONSTRAINT fk_documento_usuario FOREIGN KEY (id_usuario) REFERENCES comun.usuario(id_usuario);


--
-- Name: estudiante fk_estudiante_usuario; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.estudiante
    ADD CONSTRAINT fk_estudiante_usuario FOREIGN KEY (id_usuario) REFERENCES comun.usuario(id_usuario);


--
-- Name: materia fk_materia_grado; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.materia
    ADD CONSTRAINT fk_materia_grado FOREIGN KEY (id_grado) REFERENCES comun.grado(id_grado);


--
-- Name: partida_estudiante fk_parte_estudiante; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida_estudiante
    ADD CONSTRAINT fk_parte_estudiante FOREIGN KEY (id_estudiante) REFERENCES comun.estudiante(id_estudiante);


--
-- Name: partida_estudiante fk_parte_partida; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida_estudiante
    ADD CONSTRAINT fk_parte_partida FOREIGN KEY (id_partida) REFERENCES comun.partida(id_partida);


--
-- Name: partida fk_partida_profesor; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida
    ADD CONSTRAINT fk_partida_profesor FOREIGN KEY (id_profesor) REFERENCES comun.profesor(id_profesor);


--
-- Name: partida fk_partida_prueba; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.partida
    ADD CONSTRAINT fk_partida_prueba FOREIGN KEY (id_prueba) REFERENCES comun.prueba(id_prueba);


--
-- Name: pregunta fk_pregunta_prueba; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.pregunta
    ADD CONSTRAINT fk_pregunta_prueba FOREIGN KEY (id_prueba) REFERENCES comun.prueba(id_prueba);


--
-- Name: profesor fk_profesor_usuario; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor
    ADD CONSTRAINT fk_profesor_usuario FOREIGN KEY (id_usuario) REFERENCES comun.usuario(id_usuario);


--
-- Name: prueba fk_prueba_materia; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.prueba
    ADD CONSTRAINT fk_prueba_materia FOREIGN KEY (id_materia) REFERENCES comun.materia(id_materia);


--
-- Name: respuesta fk_respuesta_opcion; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.respuesta
    ADD CONSTRAINT fk_respuesta_opcion FOREIGN KEY (id_opcion_seleccionada) REFERENCES comun.opcion(id_opcion);


--
-- Name: respuesta fk_respuesta_partida_estudiante; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.respuesta
    ADD CONSTRAINT fk_respuesta_partida_estudiante FOREIGN KEY (id_partida_estudiante) REFERENCES comun.partida_estudiante(id_partida_estudiante);


--
-- Name: respuesta fk_respuesta_pregunta; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.respuesta
    ADD CONSTRAINT fk_respuesta_pregunta FOREIGN KEY (id_pregunta) REFERENCES comun.pregunta(id_pregunta);


--
-- Name: materia info_materia_id_estado_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.materia
    ADD CONSTRAINT info_materia_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: opcion info_opcion_id_estado_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.opcion
    ADD CONSTRAINT info_opcion_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: opcion info_opcion_id_pregunta_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.opcion
    ADD CONSTRAINT info_opcion_id_pregunta_fkey FOREIGN KEY (id_pregunta) REFERENCES comun.pregunta(id_pregunta);


--
-- Name: prueba info_prueba_id_materia_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.prueba
    ADD CONSTRAINT info_prueba_id_materia_fkey FOREIGN KEY (id_materia) REFERENCES comun.materia(id_materia);


--
-- Name: profesor_materia profesor_materia_id_estado_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES comun.estado(id_estado);


--
-- Name: profesor_materia profesor_materia_id_materia_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_id_materia_fkey FOREIGN KEY (id_materia) REFERENCES comun.materia(id_materia);


--
-- Name: profesor_materia profesor_materia_id_periodo_lectivo_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_id_periodo_lectivo_fkey FOREIGN KEY (id_periodo_lectivo) REFERENCES comun.periodo_lectivo(id_periodo_lectivo);


--
-- Name: profesor_materia profesor_materia_id_profesor_fkey; Type: FK CONSTRAINT; Schema: comun; Owner: admin
--

ALTER TABLE ONLY comun.profesor_materia
    ADD CONSTRAINT profesor_materia_id_profesor_fkey FOREIGN KEY (id_profesor) REFERENCES comun.profesor(id_profesor);


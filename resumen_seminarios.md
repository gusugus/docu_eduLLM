# Banco de Preguntas y Conceptos – Ingeniería de Sistemas (Unificado)

## 1. Programación Orientada a Objetos (POO)

| Concepto | Respuesta / Definición |
|----------|------------------------|
| ¿Qué es POO? | Paradigma basado en objetos con atributos y métodos. |
| Clase | Plantilla para crear objetos. |
| Objeto | Instancia de una clase. |
| Encapsulamiento | Ocultar datos internos y controlar acceso. |
| Herencia | Una clase hereda atributos y métodos de otra. |
| Polimorfismo | Un mismo método puede tener diferentes comportamientos según el objeto. |
| Abstracción | Mostrar solo lo esencial, ocultando detalles internos. |
| private | Acceso solo dentro de la misma clase. |
| protected | Acceso dentro de la clase y sus subclases. |
| Interfaz | Contrato que define métodos obligatorios. |
| Clase abstracta | Clase que no puede instanciarse directamente (sirve como base). |

### Principios SOLID (siglas y breve descripción)

- **SRP** (Single Responsibility Principle): Una clase debe tener una sola razón para cambiar (una sola responsabilidad).
- **OCP** (Open/Closed Principle): Abierto para extensión, cerrado para modificación.
- **LSP** (Liskov Substitution Principle): Las clases hijas deben poder sustituir a la clase padre sin alterar el comportamiento esperado.
- **ISP** (Interface Segregation Principle): Las interfaces deben ser específicas; no obligar a implementar métodos innecesarios.
- **DIP** (Dependency Inversion Principle): Depender de abstracciones, no de implementaciones concretas.

## 2. Bases de Datos y Administración

### DDL vs DML
- **DDL** (Data Definition Language): Define estructura (CREATE, ALTER, DROP).
- **DML** (Data Manipulation Language): Manipula datos (SELECT, INSERT, UPDATE, DELETE).

### Creación de tablas (T-SQL)
Ejemplo de sintaxis (sin bloques de código):
CREATE TABLE Usuarios ( Id INT PRIMARY KEY, Nombre NVARCHAR(50) NOT NULL, Email NVARCHAR(100) UNIQUE );

### Claves y restricciones
- **PRIMARY KEY (PK)**: Identifica cada fila de forma única.
- **FOREIGN KEY (FK)**: Relaciona tablas y mantiene integridad referencial.
- **NOT NULL**: Evita valores nulos.
- **UNIQUE**: Garantiza valores únicos en una columna.
- **CHECK**: Valida condición (ej: Edad >= 18).

### Índices
Estructura que acelera las búsquedas (SELECT) pero puede ralentizar inserciones/actualizaciones.

### Triggers (disparadores)
Procedimientos que se ejecutan automáticamente ante eventos INSERT, UPDATE, DELETE.

### Logs de base de datos y recuperación
- **Transaction Log**: Registro de todas las transacciones para poder recuperar la BD ante fallos (ROLLBACK, RESTORE).
- **Recuperación**: Proceso de restaurar la BD a un estado consistente usando backups y logs.

### Formas normales (hasta 3FN)
- **1FN**: Eliminar grupos repetitivos, cada celda un valor atómico.
- **2FN**: Estar en 1FN y eliminar dependencias parciales (dependencia de parte de la PK).
- **3FN**: Estar en 2FN y eliminar dependencias transitivas (un atributo no clave depende de otro no clave).

### ACID (propiedades de transacciones)
- **Atomicidad**: La transacción se completa totalmente o no se realiza.
- **Consistencia**: La BD pasa de un estado válido a otro válido.
- **Aislamiento (Isolation)**: Transacciones concurrentes no interfieren entre sí.
- **Durabilidad**: Una transacción confirmada persiste incluso tras fallos.

## 3. Modelos de ciclo de vida del software (diferencias)

- **Cascada**: Secuencial, requisitos fijos al inicio. No se puede volver atrás fácilmente.
- **V (Modelo V)**: Versión con verificación y validación; cada fase de desarrollo tiene una fase de prueba asociada (pruebas unitarias, integración, sistema, aceptación).
- **Espiral**: Basado en riesgos; iterativo con evaluación de riesgos en cada vuelta. Ideal para sistemas complejos y de alto riesgo.
- **Incremental**: Se entregan partes funcionales (incrementos) en iteraciones cortas.
- **Iterativo**: Se repiten ciclos (requisitos, diseño, implementación) refinando el producto.
- **Ágil (Scrum, XP)**: Adaptativo, colaboración continua con el cliente, entregas frecuentes.
- **DevOps**: Integración de desarrollo y operaciones para despliegues continuos.

## 4. Ingeniería de requisitos y normas

- **Requisito funcional**: Lo que el sistema debe hacer (funcionalidad específica).
- **Requisito no funcional**: Atributos de calidad (rendimiento, seguridad, usabilidad).
- **ISO/IEC 12207**: Estándar de procesos del ciclo de vida del software (adquisición, suministro, desarrollo, operación, mantenimiento).
- **Verificación**: ¿Construimos bien el producto? (revisa especificación).
- **Validación**: ¿Construimos el producto correcto? (satisface necesidades del usuario).

## 5. Arquitectura de software

### Definición
Estructura fundamental del software (componentes, relaciones, principios de diseño).

### Componentes arquitectónicos
Módulos, servicios, capas, bases de datos, interfaces, etc.

### Rol del arquitecto de software
Define la estructura, toma decisiones técnicas, asegura que se cumplan atributos de calidad, guía al equipo.

### Drivers arquitectónicos
Requisitos que influyen fuertemente en la arquitectura (funcionales, calidad, restricciones técnicas/negocio).

### ISO/IEC 25010 (calidad de software)
Sustituye a ISO 9126; define atributos: adecuación funcional, rendimiento, compatibilidad, usabilidad, fiabilidad, seguridad, mantenibilidad, portabilidad.

### Principios de diseño arquitectónico
Separación de intereses, modularidad, cohesión, acoplamiento débil, reutilización.

### Cohesión y acoplamiento
- **Cohesión**: Grado en que las responsabilidades de un módulo están relacionadas (alta cohesión es buena).
- **Acoplamiento**: Grado de dependencia entre módulos (bajo acoplamiento es bueno).

### Tolerancia a fallos
Capacidad del sistema de seguir funcionando (quizás degradado) ante fallos de componentes.

### Escalabilidad
Capacidad de crecer en rendimiento o usuarios añadiendo recursos (vertical u horizontal).

### Descentralización
Distribución de control y datos sin un nodo central (ej: blockchain, microservicios sin orquestador central).

### Interoperabilidad
Capacidad de intercambiar información y usar la información intercambiada (estándares, APIs).

### Patrones de arquitectura comunes
- **Capas (Layered)**: Separación en capas (presentación, negocio, datos).
- **Cliente-Servidor**: Clientes solicitan, servidor responde.
- **Microservicios**: Servicios pequeños, autónomos, desplegables independientemente.
- **Event-Driven**: Comunicación asíncrona mediante eventos.
- **Hexagonal (Puertos y Adaptadores)**: Aísla la lógica de negocio de los detalles externos.
- **Cloud Native**: Diseñada para la nube (contenedores, orquestación, CI/CD, resiliencia).

### Arquitectura moderna
- **Microservicios**: Ventajas: independencia, escalabilidad. Desventajas: complejidad de comunicación, transacciones distribuidas.
- **Serverless**: Ejecución de funciones sin gestionar servidores.
- **Arquitectura segura**: Principios: defensa en profundidad, mínimo privilegio, seguridad por diseño.

### Evaluación arquitectónica
Métodos como ATAM (Architecture Tradeoff Analysis Method) para analizar riesgos y compensaciones.

### Scrum y arquitectura
El arquitecto colabora con el Product Owner y el equipo; las decisiones arquitectónicas se pueden hacer en sprints iniciales o en spikes.

### Documentación arquitectónica
Se usa C4 Model, diagramas UML (componentes, despliegue), ADR (Architecture Decision Records).

## 6. Desarrollo Web (HTML, CSS, JS)

### Etiquetas semánticas principales
header, nav, main, section, article, aside, footer – mejoran SEO y accesibilidad.

### Atributos globales HTML (comunes a cualquier etiqueta)
id, class, style, title, data-*, hidden, lang, tabindex, contenteditable.

### Buenas prácticas HTML5
- Usar DOCTYPE.
- Estructura semántica.
- Atributo alt en img.
- Validar formularios.
- Responsive design con viewport.

### Organización de rutas en proyecto web
Proyecto/
├── index.html
├── css/
│   └── estilos.css
├── js/
│   └── script.js
├── img/
│   └── logo.png
└── pages/ (opcional)

### Buenas prácticas de nomenclatura
- Archivos y carpetas: minúsculas, sin espacios, usar guiones (ej: mi-archivo.css).
- Clases CSS: kebab-case (btn-primary).
- IDs: camelCase o kebab-case, pero mejor clases.
- Variables JS: camelCase.

### CSS: sintaxis, evolución, estructura
- Sintaxis: selector { propiedad: valor; }
- Evolución: CSS1 (básico), CSS2 (media queries?), CSS3 (módulos: flexbox, grid, animaciones).
- Estructura: reglas, comentarios /* */, cascada, especificidad.

### Tipos de selectores CSS
- Universal (*)
- Tipo (elemento: p, div)
- Clase (.clase)
- ID (#id)
- Atributo ([type="text"])
- Pseudoclase (:hover, :nth-child)
- Pseudoelemento (::before, ::after)
- Combinadores (espacio descendiente, > hijo directo, + adyacente, ~ general)

### Flexbox (propiedades contenedor e ítems)
Contenedor: display: flex, flex-direction, justify-content, align-items, gap.
Ítems: flex-grow, flex-shrink, flex-basis, order, align-self.

### Listados, tablas, formularios
- Listas: ul, ol, li (estilos con list-style).
- Tablas: table, tr, td, th, caption, border-collapse.
- Formularios: form, input, label, select, textarea, button; atributos: required, placeholder, pattern, name.

## 7. Prácticas actuales en desarrollo de software

### Comparativa de modelos (cascada, iterativo, ágil)

| Característica | Cascada | Iterativo | Ágil (Scrum) |
|----------------|---------|-----------|---------------|
| Requisitos | Fijos al inicio | Cambiantes pero gestionados | Cambiantes, priorizados |
| Participación cliente | Baja (al inicio y al final) | Media | Alta (continua) |
| Riesgo | Alto (pruebas tardías) | Medio | Bajo (entregas frecuentes) |
| Flexibilidad | Muy baja | Media | Alta |
| Concurrencia | No | Parcial | Sí (equipos multifuncionales) |

### DevOps y CI/CD
- **DevOps**: Cultura y prácticas que unifican desarrollo (Dev) y operaciones (Ops).
- **CI** (Integración Continua): Integrar código frecuentemente, ejecutar pruebas automáticas.
- **CD** (Despliegue Continuo): Automatizar despliegue a producción después de pasar pruebas.

### Ciclo de vida del software (ISO 12207 resume)
Adquisición → Suministro → Desarrollo → Operación → Mantenimiento (más procesos de soporte: documentación, configuración, aseguramiento de calidad).

### Proceso vs Proyecto
- **Proceso**: Actividad repetitiva y permanente (ej: proceso de desarrollo, gestión de cambios).
- **Proyecto**: Esfuerzo temporal con inicio y fin, produce un resultado único (ej: construir un sistema específico).

## 8. Gestión de la configuración (adicional)

- **Identificación de ítems de configuración**: Qué artefactos se controlan (código, documentos, librerías).
- **Control de versiones**: Git (commit, branch, merge, tag).
- **Estado de configuración**: Registro de versiones y cambios.
- **Auditoría de configuración**: Verificar que lo entregado coincide con lo especificado.

## 9. Seguridad básica (ampliación)

- **Autenticación vs Autorización**: Autenticación = verificar identidad; Autorización = verificar permisos.
- **Cifrado simétrico** (AES) y **asimétrico** (RSA).
- **Hashing** (SHA, MD5) – unidireccional.
- **SQL Injection**: Prevenir con consultas parametrizadas (prepared statements).
- **XSS**: Sanitizar entradas, usar CSP.
- **HTTPS**: HTTP sobre SSL/TLS.
- **Firewall**: Filtrado de tráfico.

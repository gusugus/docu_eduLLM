# Banco de 120 preguntas – Examen Complexivo (Nivel avanzado)

## Base de Datos y Administración de BD (30 preguntas)

### Pregunta 1
**¿Qué diferencia fundamental existe entre una base de datos relacional y una NoSQL?**  
✅ Respuesta: La relacional usa esquemas fijos, tablas y SQL; NoSQL usa esquemas flexibles (documentos, clave-valor, grafos) y escalabilidad horizontal nativa.  
📌 Explicación: Las relacionales son ideales para datos estructurados y ACID; NoSQL para alta concurrencia y datos semiestructurados.

### Pregunta 2
**¿Qué es la integridad referencial y cómo se mantiene?**  
✅ Respuesta: Integridad referencial garantiza que un valor de FK corresponda a una PK existente o sea nulo. Se mantiene mediante restricciones FOREIGN KEY y acciones como CASCADE, SET NULL.  
📌 Explicación: Evita huérfanos. Ej: no se puede eliminar un cliente si tiene pedidos a menos que se use ON DELETE CASCADE.

### Pregunta 3
**¿Qué es una transacción anidada y qué SGBD la soporta?**  
✅ Respuesta: Transacción dentro de otra transacción; se pueden hacer SAVEPOINT. No todos los SGBD soportan anidamiento completo (Oracle sí, MySQL no realmente).  
📌 Explicación: En SQL Server se simulan con transacciones nombradas; PostgreSQL permite savepoints.

### Pregunta 4
**¿Qué problema resuelve el aislamiento de nivel SERIALIZABLE?**  
✅ Respuesta: Evita todos los fenómenos anómalos (lectura sucia, no repetible, fantasma), simulando ejecución secuencial.  
📌 Explicación: Es el nivel más estricto, pero reduce concurrencia. Usa bloqueos de rango o MVCC.

### Pregunta 5
**¿Qué es un deadlock (interbloqueo) en BD y cómo se resuelve?**  
✅ Respuesta: Dos o más transacciones esperan indefinidamente por recursos bloqueados entre sí. Se resuelve mediante detección y aborto de una transacción víctima.  
📌 Explicación: El SGBD elige una víctima según costo y hace ROLLBACK.

### Pregunta 6
**¿Qué es el log de operaciones (WAL – Write-Ahead Logging)?**  
✅ Respuesta: Mecanismo donde todos los cambios se registran primero en un log antes de escribirse en disco. Garantiza durabilidad y recuperación.  
📌 Explicación: Si falla el sistema, se rehacen (REDO) o deshacen (UNDO) transacciones usando el log.

### Pregunta 7
**¿Qué es la desnormalización y cuándo se usa?**  
✅ Respuesta: Introducir redundancia controlada para mejorar el rendimiento de lecturas (evitando JOIN costosos).  
📌 Explicación: Se usa en sistemas OLAP, data warehouses o cuando la velocidad de consulta es crítica.

### Pregunta 8
**¿Qué es un índice compuesto y cómo se elige el orden de columnas?**  
✅ Respuesta: Índice sobre múltiples columnas. El orden debe coincidir con las condiciones de búsqueda (primera columna la más selectiva).  
📌 Explicación: Un índice (a,b) sirve para búsquedas por a o a+b, pero no por b sola.

### Pregunta 9
**¿Qué es un procedimiento almacenado y qué ventajas ofrece?**  
✅ Respuesta: Bloque de código SQL almacenado en el servidor. Ventajas: reducción de tráfico, reutilización, seguridad y encapsulamiento.  
📌 Explicación: Se ejecuta en el servidor, evitando enviar múltiples consultas desde la aplicación.

### Pregunta 10
**¿Qué es una vista materializada?**  
✅ Respuesta: Vista cuyo resultado se almacena físicamente y se actualiza periódicamente o de forma incremental.  
📌 Explicación: Mejora drásticamente el rendimiento de consultas pesadas a costa de espacio y mantenimiento.

### Pregunta 11
**¿Qué es un plan de ejecución y cómo se analiza?**  
✅ Respuesta: Es la secuencia de pasos que sigue el optimizador para ejecutar una consulta. Se analiza con EXPLAIN (o comandos similares).  
📌 Explicación: Permite detectar cuellos de botella, como escaneos de tabla completos (table scan) o mal uso de índices.

### Pregunta 12
**¿Qué es el particionamiento de tablas (partitioning)?**  
✅ Respuesta: Dividir una tabla grande en segmentos físicos más pequeños según un criterio (rango, lista, hash).  
📌 Explicación: Mejora mantenimiento (borrar particiones rápidamente) y rendimiento de consultas con filtros sobre la clave de partición.

### Pregunta 13
**¿Qué es un disparador (trigger) INSTEAD OF?**  
✅ Respuesta: Trigger que se ejecuta en lugar de la operación INSERT, UPDATE o DELETE, normalmente sobre vistas.  
📌 Explicación: Permite actualizar vistas no actualizables directamente.

### Pregunta 14
**¿Qué es la propiedad ACID de durabilidad y cómo se implementa?**  
✅ Respuesta: Una transacción confirmada persiste ante fallos. Se implementa mediante logs (WAL) y respaldos.  
📌 Explicación: Al hacer COMMIT, el SGBD asegura que los cambios están en el log en disco.

### Pregunta 15
**¿Qué significa CHECK CONSTRAINT y cuándo se evalúa?**  
✅ Respuesta: Restricción que valida una condición booleana en cada fila al insertar o actualizar.  
📌 Explicación: Ejemplo: edad >= 18. Se evalúa por fila, no sobre el conjunto.

### Pregunta 16
**¿Qué es la normalización de BCNF (Boyce-Codd) y cómo se diferencia de 3FN?**  
✅ Respuesta: BCNF es más estricta que 3FN: toda dependencia funcional debe tener un superkey como determinante.  
📌 Explicación: Cubre casos raros que 3FN no resuelve (dependencias funcionales compuestas).

### Pregunta 17
**¿Qué es un cursor en SQL y cuándo se justifica su uso?**  
✅ Respuesta: Permite recorrer filas una a una, como en programación procedural. Se justifica en operaciones por fila (p.ej., actualizaciones complejas con lógica).  
📌 Explicación: Son lentos y evitan el set-based processing, por eso se usan solo cuando no hay alternativa.

### Pregunta 18
**¿Qué es un plan de consulta parametrizado?**  
✅ Respuesta: Plan reutilizado para consultas que solo cambian en los valores de los literales. Mejora rendimiento al evitar compilar cada vez.  
📌 Explicación: El optimizador genera un plan genérico y lo almacena en caché.

### Pregunta 19
**¿Qué es un índice tipo hash y para qué sirve?**  
✅ Respuesta: Índice que usa funciones hash para búsquedas de igualdad exacta ( = ). No sirve para búsquedas por rango.  
📌 Explicación: Extremadamente rápido para claves exactas, pero no ordena los datos.

### Pregunta 20
**¿Qué es la fragmentación horizontal en bases de datos distribuidas?**  
✅ Respuesta: Dividir una tabla en fragmentos que contienen subconjuntos de filas, distribuyéndolos en diferentes nodos.  
📌 Explicación: Cada fragmento puede estar en un sitio distinto, mejora escalabilidad y localidad.

### Pregunta 21
**¿Qué es la conciliación de datos (data reconciliation) en migraciones?**  
✅ Respuesta: Proceso de comparar y corregir diferencias entre fuentes de datos después de una migración o replicación.  
📌 Explicación: Asegura que los datos de origen y destino sean consistentes.

### Pregunta 22
**¿Qué es un modelo de datos semántico (como el Entidad-Relación extendido)?**  
✅ Respuesta: Modelo conceptual que incluye herencia, agregación y categorías (subtipos/supertipos).  
📌 Explicación: Mejora la representación de la realidad, útil para diseñar bases de datos complejas.

### Pregunta 23
**¿Qué es el almacenamiento columnar?**  
✅ Respuesta: Almacenamiento donde los datos de cada columna se guardan juntos en disco, en lugar de fila completa.  
📌 Explicación: Ideal para consultas analíticas que leen pocas columnas de muchas filas (OLAP).

### Pregunta 24
**¿Qué es la regla de oro de la administración de BD: "Backup, recovery, test"?**  
✅ Respuesta: Realizar copias de seguridad periódicas, probar su restauración y tener un plan de recuperación documentado.  
📌 Explicación: El backup sin prueba de restauración no sirve.

### Pregunta 25
**¿Qué es el monitoreo de rendimiento con DMV en SQL Server o performance_schema en MySQL?**  
✅ Respuesta: Vistas y tablas del sistema que exponen estadísticas de esperas, consultas lentas, bloqueos y uso de recursos.  
📌 Explicación: Permite identificar cuellos de botella sin herramientas externas.

### Pregunta 26
**¿Qué es un índice filtrado?**  
✅ Respuesta: Índice creado sobre un subconjunto de filas que cumplen una condición (WHERE).  
📌 Explicación: Reduce tamaño y mejora rendimiento para consultas que siempre filtran por ese predicado.

### Pregunta 27
**¿Qué es la teoría de CAP en sistemas distribuidos (base de datos)?**  
✅ Respuesta: Solo se pueden garantizar dos de tres: Consistencia, Disponibilidad y Tolerancia a Particiones.  
📌 Explicación: En BD distribuidas hay que elegir entre CP (consistente) o AP (disponible).

### Pregunta 28
**¿Qué es una transacción distribuida y el protocolo 2PC (two-phase commit)?**  
✅ Respuesta: Transacción que abarca varios nodos. 2PC coordina el commit en dos fases: preparación y confirmación.  
📌 Explicación: Garantiza atomicidad global, pero puede ser lento y tener bloqueos.

### Pregunta 29
**¿Qué es un tipo de dato espacial (geometry/geography) y un índice espacial?**  
✅ Respuesta: Tipo de dato para puntos, líneas y polígonos; índice espacial usa estructuras como R-tree.  
📌 Explicación: Permite consultas de proximidad, intersección o dentro de un área (ej: ubicaciones cercanas).

### Pregunta 30
**¿Qué es la auditoría de base de datos a nivel de fila (fine-grained auditing)?**  
✅ Respuesta: Mecanismo que registra accesos o cambios en filas específicas según condiciones (ej: solo si se consulta salario).  
📌 Explicación: Útil para cumplimiento de regulaciones (GDPR, PCI-DSS).

---

## Programación Orientada a Objetos (20 preguntas)

### Pregunta 31
**¿Qué es el principio de inversión de dependencias (DIP) y cómo se aplica?**  
✅ Respuesta: Depender de abstracciones (interfaces) y no de implementaciones concretas. Se aplica inyectando dependencias.  
📌 Explicación: Permite cambiar la implementación sin modificar el código cliente.

### Pregunta 32
**¿Qué es el acoplamiento dinámico y estático en POO?**  
✅ Respuesta: Dinámico ocurre en tiempo de ejecución (polimorfismo); estático es en tiempo de compilación (declaración de tipos).  
📌 Explicación: El acoplamiento dinámico favorece la flexibilidad.

### Pregunta 33
**¿Qué es el patrón de diseño Singleton y cuáles son sus problemas?**  
✅ Respuesta: Garantiza una única instancia de una clase. Problemas: dificulta pruebas unitarias, introduce estado global oculto.  
📌 Explicación: En entornos concurrentes se necesita doble verificación de bloqueo.

### Pregunta 34
**¿Qué es el delegado (delegate) en lenguajes como C#?**  
✅ Respuesta: Tipo que referencia métodos, permitiendo tratar métodos como objetos. Similar a punteros a función seguros.  
📌 Explicación: Soporta invocación multicasting y es base para eventos.

### Pregunta 35
**¿Qué es el método de extensión en C#?**  
✅ Respuesta: Permite agregar métodos a tipos existentes sin herencia, usando métodos estáticos con parámetro this.  
📌 Explicación: Útil para añadir funcionalidad a clases selladas o interfaces.

### Pregunta 36
**¿Qué es la sombra de variable (variable shadowing) en herencia?**  
✅ Respuesta: Declarar un campo con mismo nombre en subclase, ocultando el de la superclase. Puede causar confusión.  
📌 Explicación: Se recomienda usar new y evitar porque viola el principio de sustitución.

### Pregunta 37
**¿Qué es la covarianza y contravarianza en genéricos?**  
✅ Respuesta: Covarianza permite usar un tipo más derivado (out); contravarianza permite usar uno más genérico (in).  
📌 Explicación: En C#: IEnumerable<out T> es covariante; Action<in T> es contravariante.

### Pregunta 38
**¿Qué es el patrón Factory Method vs Abstract Factory?**  
✅ Respuesta: Factory Method define un método para crear objetos en una clase; Abstract Factory crea familias de objetos mediante interfaces.  
📌 Explicación: Abstract Factory suele implementarse con Factory Methods.

### Pregunta 39
**¿Qué es el principio de menor conocimiento (Law of Demeter)?**  
✅ Respuesta: Un objeto solo debe comunicarse con sus vecinos directos (evitar cadena de métodos como a.b.c.d()).  
📌 Explicación: Reduce acoplamiento y facilita mantenimiento.

### Pregunta 40
**¿Qué es el polimorfismo paramétrico (generics/templates)?**  
✅ Respuesta: Capacidad de escribir código que funciona con cualquier tipo, especificado en el momento de uso.  
📌 Explicación: Genera código parametrizado, diferente de subtipado (herencia).

### Pregunta 41
**¿Qué es la inyección de dependencias por constructor?**  
✅ Respuesta: Las dependencias se pasan como parámetros al constructor, almacenándose en campos privados.  
📌 Explicación: Es la forma más recomendada porque deja explícitas las dependencias y facilita pruebas.

### Pregunta 42
**¿Qué es un mixin?**  
✅ Respuesta: Patrón que agrupa comportamiento reutilizable sin herencia múltiple (usando traits o interfaces con métodos por defecto).  
📌 Explicación: En lenguajes como Ruby es nativo; en Java 8+ se simula con default methods.

### Pregunta 43
**¿Qué es una clase sellada (sealed)?**  
✅ Respuesta: Clase que no puede ser heredada. Útil para evitar alteraciones peligrosas o por razones de seguridad.  
📌 Explicación: En C#: sealed; en Java: final.

### Pregunta 44
**¿Qué es el LSP y cómo se detecta su violación?**  
✅ Respuesta: Liskov Substitution Principle. Se detecta cuando un método que espera una clase base falla si recibe una subclase (ej: lanzando excepción no esperada).  
📌 Explicación: La subclase no debe precondiciones más fuertes ni postcondiciones más débiles.

### Pregunta 45
**¿Qué es el patrón Comportamiento (Observer)?**  
✅ Respuesta: Define dependencia uno-a-muchos para que cuando un sujeto cambie, los observadores se notifiquen automáticamente.  
📌 Explicación: Muy usado en interfaces gráficas y sistemas de eventos.

### Pregunta 46
**¿Qué es el concepto de "programación orientada a aspectos" (AOP)?**  
✅ Respuesta: Separa preocupaciones transversales (logging, seguridad) del código principal mediante aspectos.  
📌 Explicación: Implementado con proxies, decoradores o herramientas como AspectJ.

### Pregunta 47
**¿Qué es una interfaz funcional?**  
✅ Respuesta: Interfaz con un solo método abstracto, permitiendo usarse con expresiones lambda.  
📌 Explicación: En Java es base para streams y APIs funcionales.

### Pregunta 48
**¿Qué es el patrón Value Object vs Entity?**  
✅ Respuesta: Value Object se identifica por sus atributos (inmutable, sin identidad); Entity tiene identidad propia (ID).  
📌 Explicación: Ejemplo: dirección postal es Value Object; Persona es Entity.

### Pregunta 49
**¿Qué es la sobrecarga de operadores (operator overloading)?**  
✅ Respuesta: Definir comportamiento de operadores (+, -, ==) para tipos definidos por el usuario.  
📌 Explicación: Útil para tipos matemáticos o colecciones; debe usarse con coherencia semántica.

### Pregunta 50
**¿Qué es el polimorfismo de inclusión (subtipo)?**  
✅ Respuesta: Capacidad de tratar un objeto de una subclase como si fuera de la superclase, usando métodos virtuales.  
📌 Explicación: Es el polimorfismo clásico de herencia.

---

## Construcción de Software y Metodologías (25 preguntas)

### Pregunta 51
**¿Qué es la deuda técnica y cómo se gestiona?**  
✅ Respuesta: Consecuencias de tomar atajos en desarrollo que se pagan después con mayor esfuerzo de mantenimiento. Se gestiona con refactorización planificada.  
📌 Explicación: Puede ser deliberada (para entregar rápido) o accidental; debe medirse con herramientas de análisis estático.

### Pregunta 52
**¿Qué es la integración continua (CI) y qué pipeline mínimo recomienda?**  
✅ Respuesta: Automatización que construye y prueba el código en cada commit. Pipeline mínimo: compilación, pruebas unitarias y análisis estático.  
📌 Explicación: Herramientas: Jenkins, GitLab CI, GitHub Actions.

### Pregunta 53
**¿Qué es el despliegue continuo (CD) y en qué se diferencia de entrega continua?**  
✅ Respuesta: Entrega continua = el artefacto está listo para desplegarse manualmente; despliegue continuo = pasa automáticamente a producción.  
📌 Explicación: El despliegue continuo requiere pruebas automáticas muy robustas.

### Pregunta 54
**¿Qué es el desarrollo dirigido por pruebas (TDD) y sus tres leyes?**  
✅ Respuesta: Escribir prueba fallida, luego código mínimo para que pase, luego refactorizar. Leyes: no escribir código sin prueba fallida, no más prueba que la necesaria, no más código que pasar la prueba.  
📌 Explicación: Ciclo Red-Green-Refactor.

### Pregunta 55
**¿Qué es el análisis de puntos de función?**  
✅ Respuesta: Método para estimar tamaño funcional del software basado en entradas, salidas, consultas, archivos internos y externos.  
📌 Explicación: Independiente de tecnología, pero requiere entrenamiento.

### Pregunta 56
**¿Qué es la refactorización y cuándo se aplica?**  
✅ Respuesta: Cambiar la estructura interna sin alterar comportamiento externo. Se aplica durante desarrollo continuo (no al final).  
📌 Explicación: Motivos: eliminar código duplicado, mejorar legibilidad, preparar para nuevas funcionalidades.

### Pregunta 57
**¿Qué es la cobertura de código y qué límites se recomiendan?**  
✅ Respuesta: Porcentaje de líneas o ramas ejecutadas por pruebas. Se recomienda al menos 80% para ramas, pero no garantiza calidad.  
📌 Explicación: Cobertura alta no equivale a pruebas buenas (faltan casos límite).

### Pregunta 58
**¿Qué es la programación en pares (pair programming) y sus roles?**  
✅ Respuesta: Dos desarrolladores trabajan en una estación: uno conduce (driver) y otro revisa (navigator). Mejora calidad y transferencia de conocimiento.  
📌 Explicación: Parte de Extreme Programming.

### Pregunta 59
**¿Qué es la metodología Scrum: eventos y artefactos principales?**  
✅ Respuesta: Eventos: Sprint Planning, Daily Scrum, Sprint Review, Retrospectiva. Artefactos: Product Backlog, Sprint Backlog, Incremento.  
📌 Explicación: Los roles son Scrum Master, Product Owner, Team.

### Pregunta 60
**¿Qué es un spike en Scrum?**  
✅ Respuesta: Tarea de investigación o prototipo para reducir incertidumbre técnica. Tiene tiempo límite (time-box).  
📌 Explicación: No produce incremento de producto, pero sí conocimiento.

### Pregunta 61
**¿Qué es el concepto de "Definition of Done" (DoD)?**  
✅ Respuesta: Lista de criterios que debe cumplir una historia de usuario para considerarse terminada (pruebas, documentación, revisión).  
📌 Explicación: Evita entregar trabajo semi-terminado.

### Pregunta 62
**¿Qué es el diagrama de Gantt y en qué metodologías se usa?**  
✅ Respuesta: Gráfico de barras que muestra líneas de tiempo de tareas. Se usa en cascada o planificación tradicional, no en ágil puro.  
📌 Explicación: Muestra dependencias y ruta crítica.

### Pregunta 63
**¿Qué es la metodología Kanban y sus métricas clave?**  
✅ Respuesta: Enfoque basado en flujo continuo, con límite de trabajo en progreso (WIP). Métricas: lead time, cycle time, throughput.  
📌 Explicación: No tiene iteraciones fijas como Scrum.

### Pregunta 64
**¿Qué es la ingeniería de requisitos basada en modelos (Model-Based Requirements Engineering)?**  
✅ Respuesta: Usar modelos (SysML, UML) para capturar, analizar y validar requisitos de forma formal.  
📌 Explicación: Permite simulación y verificación automática.

### Pregunta 65
**¿Qué es la trazabilidad de requisitos (matriz de trazabilidad)?**  
✅ Respuesta: Relaciona requisitos con casos de prueba, diseño e implementación. Permite evaluar impacto de cambios.  
📌 Explicación: Herramientas como JIRA, DOORS.

### Pregunta 66
**¿Qué es el estándar IEEE 830?**  
✅ Respuesta: Práctica recomendada para especificaciones de requisitos de software (ERS). Define estructura y atributos.  
📌 Explicación: Aunque obsoleto, sentó bases para requisitos claros, completos y verificables.

### Pregunta 67
**¿Qué es un prototipo evolutivo vs descartable?**  
✅ Respuesta: Evolutivo se refina hasta convertirse en producto final; descartable se construye para validar requisitos y se tira.  
📌 Explicación: El descartable reduce riesgos tempranos.

### Pregunta 68
**¿Qué es la gestión de configuración de software (SCM)?**  
✅ Respuesta: Disciplina para controlar cambios en artefactos (código, documentos) y mantener integridad. Actividades: identificación, control, estado, auditoría.  
📌 Explicación: Herramientas: Git, SVN.

### Pregunta 69
**¿Qué es un branching model recomendado (Git Flow, GitHub Flow)?**  
✅ Respuesta: Git Flow usa ramas main, develop, feature, release, hotfix. GitHub Flow es más simple: main y feature branches.  
📌 Explicación: Git Flow es adecuado para versiones programadas; GitHub Flow para despliegue continuo.

### Pregunta 70
**¿Qué es la prueba de regresión y cuándo se ejecuta?**  
✅ Respuesta: Re-ejecutar pruebas para asegurar que cambios nuevos no rompan funcionalidades existentes. Se ejecuta después de cada modificación.  
📌 Explicación: Debe estar automatizada.

### Pregunta 71
**¿Qué es la prueba de humo (smoke testing)?**  
✅ Respuesta: Conjunto de pruebas básicas para verificar que el sistema no colapsa y las funcionalidades principales funcionan.  
📌 Explicación: Se hace antes de pruebas más profundas.

### Pregunta 72
**¿Qué es la deuda de calidad (quality debt)?**  
✅ Respuesta: Subconjunto de deuda técnica relacionado con falta de pruebas, mal diseño o baja mantenibilidad.  
📌 Explicación: Aumenta el costo de cambios futuros.

### Pregunta 73
**¿Qué es la metodología de desarrollo basada en entregas (Release Train)?**  
✅ Respuesta: Planificación coordinada de múltiples equipos que sincronizan entregas en ciclos fijos (ej: SAFe).  
📌 Explicación: Útil para grandes organizaciones.

### Pregunta 74
**¿Qué es el análisis estático de código?**  
✅ Respuesta: Examinar el código fuente sin ejecutarlo para encontrar errores, olores de código o vulnerabilidades.  
📌 Explicación: Herramientas: SonarQube, ESLint.

### Pregunta 75
**¿Qué es el concepto de "Technical Excellence" en Extreme Programming?**  
✅ Respuesta: Prácticas como refactorización continua, integración continua, pruebas automatizadas y propiedad colectiva del código.  
📌 Explicación: Busca mantener el diseño limpio y adaptable.

---

## Seminario: HTML, CSS, Modelos de interfaces, Arquitectura web, Seguridad (25 preguntas)

### Pregunta 76
**¿Qué es el modelo de caja (box model) en CSS y cómo influye el box-sizing?**  
✅ Respuesta: Modelo que define que cada elemento tiene contenido, padding, borde y margen. box-sizing: border-box hace que el ancho total incluya padding y borde.  
📌 Explicación: Por defecto (content-box) el ancho se refiere solo al contenido.

### Pregunta 77
**¿Qué es una media query y cómo funciona?**  
✅ Respuesta: Regla CSS que aplica estilos según características del dispositivo (ancho, resolución, orientación). Ej: @media (max-width: 600px) { ... }.  
📌 Explicación: Base del diseño responsivo.

### Pregunta 78
**¿Qué es el CSS Grid y en qué se diferencia de Flexbox?**  
✅ Respuesta: Grid es bidimensional (filas y columnas); Flexbox es unidimensional (fila o columna).  
📌 Explicación: Grid es ideal para diseños completos de página; Flexbox para componentes o alineaciones simples.

### Pregunta 79
**¿Qué es la especificidad en CSS y cómo se calcula?**  
✅ Respuesta: Peso de un selector que determina qué regla se aplica. Cálculo: inline style (1000), ID (100), clase/pseudoclase (10), elemento (1).  
📌 Explicación: El selector con mayor especificidad gana; si igual, la última declaración en el orden.

### Pregunta 80
**¿Qué es el CSS preprocesador y ejemplos?**  
✅ Respuesta: Herramienta que extiende CSS con variables, anidamiento, mixins y funciones. Ejemplos: Sass, Less, Stylus.  
📌 Explicación: Se compila a CSS estándar.

### Pregunta 81
**¿Qué es el atributo data-* en HTML5?**  
✅ Respuesta: Atributo personalizado que almacena datos privados en elementos HTML (data-id, data-nombre).  
📌 Explicación: Accesible vía dataset en JavaScript; útil para asociar datos sin usar clases extras.

### Pregunta 82
**¿Qué es el shadow DOM y para qué sirve?**  
✅ Respuesta: Encapsulamiento de DOM y CSS para componentes web, aislándolos del resto del documento.  
📌 Explicación: Usado en custom elements y frameworks como Lit.

### Pregunta 83
**¿Qué es la accesibilidad web (WCAG) y cuáles son los cuatro principios?**  
✅ Respuesta: Directrices para hacer sitios usables por personas con discapacidades. Principios: Perceptible, Operable, Comprensible, Robusto.  
📌 Explicación: WCAG 2.1 nivel AA es estándar legal en muchos países.

### Pregunta 84
**¿Qué es el patrón de diseño MVC (Model-View-Controller) en aplicaciones web?**  
✅ Respuesta: Separa datos (modelo), interfaz (vista) y lógica de control (controlador). Facilita mantenimiento y pruebas.  
📌 Explicación: Implementado en frameworks como Spring MVC, ASP.NET MVC, Laravel.

### Pregunta 85
**¿Qué es un API RESTful?**  
✅ Respuesta: Estilo arquitectónico que usa HTTP y métodos (GET, POST, PUT, DELETE) para operar sobre recursos identificados por URL.  
📌 Explicación: Debe ser stateless y usar códigos de estado HTTP correctos.

### Pregunta 86
**¿Qué es GraphQL y cómo difiere de REST?**  
✅ Respuesta: Lenguaje de consulta que permite al cliente pedir exactamente los campos que necesita en una sola petición. REST suele tener múltiples endpoints fijos.  
📌 Explicación: GraphQL evita over-fetching y under-fetching.

### Pregunta 87
**¿Qué es el almacenamiento local (localStorage) vs sessionStorage?**  
✅ Respuesta: localStorage persiste indefinidamente; sessionStorage persiste mientras la pestaña esté abierta. Ambos guardan pares clave-valor.  
📌 Explicación: Capacidad limitada (5-10 MB); solo almacena cadenas.

### Pregunta 88
**¿Qué es el evento DOMContentLoaded vs load?**  
✅ Respuesta: DOMContentLoaded ocurre cuando el HTML se ha cargado y parseado (sin esperar imágenes/estilos). load espera recursos completos.  
📌 Explicación: Usar DOMContentLoaded para manipular DOM temprano.

### Pregunta 89
**¿Qué es el CORS (Cross-Origin Resource Sharing)?**  
✅ Respuesta: Mecanismo que permite o restringe peticiones HTTP desde un dominio diferente al servidor. Se configura con cabeceras como Access-Control-Allow-Origin.  
📌 Explicación: Previene ataques CSRF y protege datos.

### Pregunta 90
**¿Qué es un Service Worker?**  
✅ Respuesta: Script que corre en segundo plano, independiente de la página. Permite funcionalidades offline, push notifications, caché.  
📌 Explicación: Base de las Progressive Web Apps (PWA).

### Pregunta 91
**¿Qué es el concepto de "responsive web design" y sus técnicas?**  
✅ Respuesta: Diseño que se adapta a diferentes tamaños de pantalla usando media queries, fluid grids y imágenes flexibles.  
📌 Explicación: Evita crear sitios separados para móviles.

### Pregunta 92
**¿Qué es la optimización de rendimiento web (core web vitals)?**  
✅ Respuesta: Métricas de Google: Largest Contentful Paint (LCP), First Input Delay (FID), Cumulative Layout Shift (CLS).  
📌 Explicación: Miden carga, interactividad y estabilidad visual.

### Pregunta 93
**¿Qué es el método de diseño "mobile-first"?**  
✅ Respuesta: Desarrollar primero para pantallas pequeñas y luego añadir mejoras para grandes con media queries (min-width).  
📌 Explicación: Mejora rendimiento y experiencia en móviles.

### Pregunta 94
**¿Qué es un framework CSS como Bootstrap o Tailwind?**  
✅ Respuesta: Biblioteca de estilos y componentes predefinidos. Bootstrap da clases completas (btn); Tailwind es utility-first (bg-blue-500, p-4).  
📌 Explicación: Aceleran desarrollo, pero pueden generar código redundante.

### Pregunta 95
**¿Qué es el atributo "async" vs "defer" en scripts?**  
✅ Respuesta: async carga y ejecuta el script en paralelo sin orden; defer lo ejecuta después de parsear el HTML, respetando orden.  
📌 Explicación: Ambos no bloquean renderizado, pero defer es más seguro para scripts que dependen del DOM.

### Pregunta 96
**¿Qué es la etiqueta meta viewport?**  
✅ Respuesta: <meta name="viewport" content="width=device-width, initial-scale=1"> Controla dimensiones y escala en dispositivos móviles.  
📌 Explicación: Esencial para responsive design.

### Pregunta 97
**¿Qué es el posicionamiento sticky en CSS?**  
✅ Respuesta: El elemento se comporta como relative hasta que alcanza un umbral, luego se vuelve fixed. Útil para cabeceras que quedan pegadas.  
📌 Explicación: No funciona en todos los contenedores overflow.

### Pregunta 98
**¿Qué es la pseudoclase :nth-child()?**  
✅ Respuesta: Selecciona elementos según su posición entre hermanos, ej: :nth-child(2n) (pares).  
📌 Explicación: Puede usar fórmulas an+b.

### Pregunta 99
**¿Qué es un selector de atributo [atributo^="valor"]?**  
✅ Respuesta: Selecciona elementos cuyo atributo comienza con el valor dado. Ej: [href^="https"] para enlaces seguros.  
📌 Explicación: También existen $= (termina con), *= (contiene).

### Pregunta 100
**¿Qué es la propiedad flex-grow y cómo distribuye espacio?**  
✅ Respuesta: Factor de crecimiento de un ítem en contenedor flex. Todos parten de 0; espacio sobrante se distribuye proporcionalmente según suma de flex-grow.  
📌 Explicación: Si un ítem tiene 2 y otro 1, el primero recibe el doble de espacio extra.

---

## Tópicos de Seguridad y Arquitectura (20 preguntas)

### Pregunta 101
**¿Qué es el cifrado de extremo a extremo (E2EE)?**  
✅ Respuesta: Cifrado en el cliente y descifrado solo por el destinatario final; el servidor no tiene acceso al texto plano.  
📌 Explicación: Usado en WhatsApp, Signal; impide que el proveedor lea mensajes.

### Pregunta 102
**¿Qué es un ataque Man-in-the-Middle (MitM) y cómo prevenirlo?**  
✅ Respuesta: Atacante intercepta comunicación entre dos partes. Prevención: usar TLS certificados, evitar redes públicas sin VPN, pinning de certificados.  
📌 Explicación: HTTPS no es suficiente si el cliente acepta certificados fraudulentos.

### Pregunta 103
**¿Qué es el HSTS (HTTP Strict Transport Security)?**  
✅ Respuesta: Cabecera que fuerza al navegador a usar siempre HTTPS para el dominio, evitando downgrade attacks.  
📌 Explicación: Se configura con: Strict-Transport-Security: max-age=31536000.

### Pregunta 104
**¿Qué es un token JWT (JSON Web Token)?**  
✅ Respuesta: Token compacto y autosuficiente que contiene claims firmados digitalmente. Se usa para autenticación sin estado.  
📌 Explicación: No debe almacenar información sensible a menos que esté cifrado.

### Pregunta 105
**¿Qué es el OAuth 2.0 y en qué se diferencia de autenticación?**  
✅ Respuesta: OAuth 2.0 es autorización (delegar acceso), no autenticación. OpenID Connect añade capa de autenticación.  
📌 Explicación: Flujo común: "Login with Google" delega acceso a perfil.

### Pregunta 106
**¿Qué es un ataque XSS (Cross-Site Scripting) y cómo evitarlo?**  
✅ Respuesta: Inyección de scripts maliciosos que se ejecutan en navegadores de otros usuarios. Prevención: sanitizar salidas, usar CSP, escapar caracteres HTML.  
📌 Explicación: Hay XSS reflejado, almacenado y DOM-based.

### Pregunta 107
**¿Qué es el CSRF (Cross-Site Request Forgery)?**  
✅ Respuesta: Ataque que engaña al usuario autenticado para enviar peticiones no deseadas. Prevención: tokens anti-CSRF, SameSite cookies.  
📌 Explicación: Es diferente de XSS; no ejecuta código, sino acciones.

### Pregunta 108
**¿Qué es una arquitectura de microservicios y sus retos?**  
✅ Respuesta: Sistema compuesto por servicios pequeños desplegables independientemente. Retos: transacciones distribuidas, trazabilidad, latencia de red.  
📌 Explicación: Cada microservicio tiene su propia base de datos.

### Pregunta 109
**¿Qué es el patrón Circuit Breaker?**  
✅ Respuesta: Patrón que previene llamadas a un servicio que falla repetidamente, abriendo el circuito y redirigiendo a fallback.  
📌 Explicación: Se implementa con bibliotecas como Resilience4j, Hystrix.

### Pregunta 110
**¿Qué es la arquitectura orientada a eventos (EDA)?**  
✅ Respuesta: Los componentes se comunican mediante eventos asíncronos a través de un bus (Kafka, RabbitMQ). Desacopla emisores y receptores.  
📌 Explicación: Alta escalabilidad y resiliencia.

### Pregunta 111
**¿Qué es la arquitectura hexagonal (puertos y adaptadores)?**  
✅ Respuesta: Aísla la lógica de negocio del centro, expuesta mediante puertos (interfaces), y los adaptadores (controladores, repositorios) conectan el exterior.  
📌 Explicación: Permite probar la lógica sin infraestructura.

### Pregunta 112
**¿Qué es el principio de responsabilidad única (SRP) y cómo se relaciona con la arquitectura?**  
✅ Respuesta: Una clase o módulo debe tener una sola razón para cambiar. En arquitectura, cada servicio o capa debe tener un propósito claro.  
📌 Explicación: Facilita mantenimiento y evita cambios por múltiples causas.

### Pregunta 113
**¿Qué es el balanceo de carga (load balancing) y algoritmos comunes?**  
✅ Respuesta: Distribuir tráfico entre varios servidores. Algoritmos: round-robin, least connections, IP hash.  
📌 Explicación: Mejora disponibilidad y escalabilidad.

### Pregunta 114
**¿Qué es la tolerancia a fallos mediante replicación?**  
✅ Respuesta: Mantener copias redundantes de datos o servicios. Si uno falla, otro toma el control (failover).  
📌 Explicación: En BD: replicación maestro-esclavo; en servicios: múltiples instancias detrás de balanceador.

### Pregunta 115
**¿Qué es el principio de mínima exposición (least privilege)?**  
✅ Respuesta: Otorgar solo los permisos necesarios para realizar una tarea. Aplica a usuarios, procesos y APIs.  
📌 Explicación: Reduce superficie de ataque.

### Pregunta 116
**¿Qué es la defensa en profundidad?**  
✅ Respuesta: Estrategia de seguridad con múltiples capas (firewall, WAF, autenticación, cifrado, monitoreo) para que si una falla, las otras protejan.  
📌 Explicación: No confiar en una sola medida.

### Pregunta 117
**¿Qué es el modelado de amenazas (threat modeling) y metodología STRIDE?**  
✅ Respuesta: Proceso para identificar riesgos de seguridad. STRIDE: Suplantación, Manipulación, Repudio, Divulgación, Denegación de servicio, Elevación de privilegios.  
📌 Explicación: Se hace en diseño arquitectónico.

### Pregunta 118
**¿Qué es el concepto de "Infrastructure as Code" (IaC)?**  
✅ Respuesta: Gestionar y aprovisionar infraestructura mediante archivos de configuración (Terraform, CloudFormation).  
📌 Explicación: Permite versionamiento, replicación y reducción de errores manuales.

### Pregunta 119
**¿Qué es un contenedor (Docker) y en qué se diferencia de una máquina virtual?**  
✅ Respuesta: Contenedor comparte el kernel del host, es ligero y arranca en segundos. VM tiene su propio SO completo y es más pesada.  
📌 Explicación: Los contenedores son portables y consistentes.

### Pregunta 120
**¿Qué es Kubernetes (K8s)?**  
✅ Respuesta: Orquestador de contenedores que automatiza despliegue, escalado y gestión de aplicaciones en clústeres.  
📌 Explicación: Conceptos: pods, servicios, deployments, ingress.

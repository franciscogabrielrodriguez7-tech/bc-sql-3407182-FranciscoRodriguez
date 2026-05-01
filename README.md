# AeroTech Fleet Management DB ✈️

Este proyecto consiste en el diseño e implementación de una base de datos relacional robusta para la gestión operativa de una empresa aérea. El esquema está optimizado para garantizar la integridad de los datos, la trazabilidad de los vuelos y la gestión eficiente de activos y personal, cumpliendo con estándares internacionales de la industria.

## 1. Entidades Principales

El sistema se articula en torno a cuatro entidades clave que representan el núcleo del negocio aeronáutico:

*   **Aircraft (Aeronaves):** Control de los activos físicos, su capacidad y estado operativo.
*   **Passengers (Pasajeros):** Registro detallado de clientes, incluyendo validaciones de identidad y contacto.
*   **Crews (Tripulación):** Gestión del capital humano (pilotos y auxiliares) asignado a la operación.
*   **Flights (Vuelos):** Entidad transaccional central que coordina aeronaves, tripulaciones y rutas en horarios específicos.

---

## 2. Estructura de las Tablas

A continuación, se detalla la arquitectura técnica del esquema:

### 🛠 Aircraft (Flota)
| Columna | Tipo | Restricción | Propósito |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PK, AUTOINCREMENT | Identificador único interno. |
| `model` | TEXT | NOT NULL | Modelo comercial del fabricante. |
| `capacity` | INTEGER | CHECK (> 0) | Garantiza que la capacidad sea un valor positivo. |
| `registration` | TEXT | UNIQUE, NOT NULL | Matrícula oficial única por aeronave. |
| `is_active` | INTEGER | DEFAULT 1, CHECK (0,1) | Flag booleano para disponibilidad operativa. |

### 👤 Passengers (Clientes)
| Columna | Tipo | Restricción | Propósito |
| :--- | :--- | :--- | :--- |
| `email` | TEXT | UNIQUE, CHECK (Regex) | Validación de formato de correo electrónico. |
| `passport_id` | TEXT | UNIQUE, NOT NULL | Clave única de identificación internacional. |

### 👨‍✈️ Crews (Recurso Humano)
| Columna | Tipo | Restricción | Propósito |
| :--- | :--- | :--- | :--- |
| `attendants_count`| INTEGER | DEFAULT 2, CHECK (>=0) | Control de personal mínimo de cabina. |
| `base_airport` | TEXT | NOT NULL | Nodo o HUB principal de la tripulación. |

### 📅 Flights (Operaciones)
| Columna | Tipo | Restricción | Propósito |
| :--- | :--- | :--- | :--- |
| `flight_code` | TEXT | UNIQUE, NOT NULL | Código comercial del vuelo (Ej: AV244). |
| `origin_icao` | TEXT | NOT NULL | Código estándar internacional del aeropuerto. |
| `departure_at` | TEXT | NOT NULL (ISO8601) | Fecha y hora de salida programada. |
| `status` | TEXT | CHECK (Constraint) | Estados: Scheduled, Delayed, In-flight, etc. |
| `aircraft_id` | INTEGER | FK, ON DELETE SET NULL | Vínculo con aeronave (integridad referencial). |

---

## 3. Buenas Prácticas de Ingeniería Aplicadas ✅

El diseño sigue estándares de nivel profesional para asegurar la escalabilidad y mantenibilidad del sistema:

*   **Idempotencia y Limpieza:** Uso de cláusulas `DROP TABLE IF EXISTS` y `CREATE TABLE IF NOT EXISTS` para garantizar una creación de esquema limpia en cualquier entorno.
*   **Integridad de Datos Robusta:**
    *   **Constraints de Dominio:** Uso de `CHECK` para validar lógicamente los datos (ej. formato de email, capacidades positivas).
    *   **Unicidad:** Restricciones `UNIQUE` en campos críticos para evitar duplicidad de registros (pasaportes, matrículas, códigos de vuelo).
*   **Estándares Internacionales:** 
    *   **ISO 8601:** Almacenamiento de tiempos en formato `YYYY-MM-DD HH:MM:SS` para facilitar cálculos y compatibilidad.
    *   **Nomenclatura ICAO/IATA:** Uso de estándares aeronáuticos para el nombramiento de aeropuertos.
*   **Manejo de Relaciones y Persistencia:** Implementación de `ON DELETE SET NULL` en las llaves foráneas. Esto permite que, si un registro de avión o tripulación se elimina, el histórico de vuelos permanezca intacto para auditorías.
*   **Código Limpio y Documentado:** Nomenclatura semántica en inglés (estándar en tecnología) y comentarios detallados que explican la lógica de cada bloque.

-- ===========================================================
-- WEEK 07 NULLs y CONSTRAINTS
-- ===========================================================

-- 1. ACTIVACIÓN DE INTEGRIDAD REFERENCIAL
PRAGMA foreign_keys = ON;

-- 2. LIMPIEZA
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS passengers;
DROP TABLE IF EXISTS aircraft;
DROP TABLE IF EXISTS crews;

-- 3. CREACIÓN DE TABLAS con los NULL y CONSTRAINTS correspondientes a la lógica(DDL)

CREATE TABLE aircraft (
    id              INTEGER PRIMARY KEY,
    model           TEXT    NOT NULL,
    capacity        INTEGER NOT NULL CHECK (capacity > 0),
    -- NULLIF + TRIM: Convierte espacios en blanco a NULL, lo cual hace fallar el NOT NULL
    registration    TEXT    NOT NULL UNIQUE CHECK (NULLIF(TRIM(registration), '') IS NOT NULL),
    manufacturer    TEXT
);

CREATE TABLE crews (
    id              INTEGER PRIMARY KEY,
    captain         TEXT    NOT NULL CHECK (NULLIF(TRIM(captain), '') IS NOT NULL),
    -- LOWER: Evita que 'Luis' y 'luis' cuenten como personas distintas
    copilot         TEXT    NOT NULL CHECK (NULLIF(TRIM(copilot), '') IS NOT NULL AND LOWER(copilot) != LOWER(captain)),
    attendants      INTEGER NOT NULL CHECK (attendants >= 0),
    base_airport    TEXT
);

CREATE TABLE passengers (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    lastname    TEXT    NOT NULL,
    email       TEXT,
    phone       TEXT,
    passport    TEXT    NOT NULL UNIQUE CHECK (NULLIF(TRIM(passport), '') IS NOT NULL),
    -- COALESCE: Obliga a que el primer valor no nulo exista. Si ambos son NULL, falla la inserción.
    CHECK (COALESCE(email, phone) IS NOT NULL)
);

CREATE TABLE flights (
    id              INTEGER PRIMARY KEY,
    flight_number   TEXT    NOT NULL UNIQUE,
    origin          TEXT    NOT NULL,
    destination     TEXT    NOT NULL CHECK (LOWER(origin) != LOWER(destination)),
    departure_time  TEXT    NOT NULL,
    -- arrival_time permite NULL por defecto, arreglando el problema de "adivinar el futuro"
    arrival_time    TEXT,
    -- ON DELETE SET NULL: Protege el historial si se borra un avión o tripulación
    aircraft_id     INTEGER REFERENCES aircraft(id) ON DELETE SET NULL,
    crew_id         INTEGER REFERENCES crews(id) ON DELETE SET NULL,
    -- Valida que si hay hora de llegada, obligatoriamente sea después de la salida
    CHECK (arrival_time IS NULL OR arrival_time > departure_time)
);

-- ===========================================================
-- 4. INSERCIONES DE PRUEBA
-- ===========================================================

INSERT INTO aircraft (id, model, capacity, registration) 
VALUES (1, 'Boeing 737', 150, 'HK-1234');

INSERT INTO crews (id, captain, copilot, attendants) 
VALUES (1, 'Andrea Gomez', 'Luis Perez', 4);

-- Pasajeros demostrando la regla COALESCE (Uno usa email, otro usa teléfono)
INSERT INTO passengers (id, name, lastname, email, phone, passport) 
VALUES (1, 'Ana', 'Torres', 'ana@mail.com', NULL, 'PAS-1111');
INSERT INTO passengers (id, name, lastname, email, phone, passport) 
VALUES (2, 'David', 'Ruiz', NULL, '3105555555', 'PAS-2222');

-- Vuelos demostrando el estado NULL (Uno completado, uno en progreso)
INSERT INTO flights (id, flight_number, origin, destination, departure_time, arrival_time, aircraft_id, crew_id) 
VALUES (1, 'AT100', 'Bogota', 'Medellin', '2026-06-20 10:00', '2026-06-20 11:00', 1, 1);
INSERT INTO flights (id, flight_number, origin, destination, departure_time, arrival_time, aircraft_id, crew_id) 
VALUES (2, 'AT101', 'Cali', 'Miami', '2026-06-21 08:00', NULL, 1, 1);

-- ===========================================================
-- 5. LECTURAS SIMPLES DE COMPROBACIÓN
-- ===========================================================

-- Extraer el dato de contacto útil sin importar cuál de los dos llenó el pasajero
SELECT 
    name, 
    lastname, 
    COALESCE(email, phone) AS contact_info
FROM passengers;

-- Filtrar únicamente los vuelos que están en el aire (sin hora de llegada aún)
SELECT 
    flight_number, 
    origin, 
    destination 
FROM flights 
WHERE arrival_time IS NULL;
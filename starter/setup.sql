-- ============================================
-- PROYECTO SEMANAL: Conoce tu Dominio
-- Semana 01 — Introducción a Bases de Datos Relacionales
-- Dominio: Empresa de Transporte Aéreo
-- ============================================

-- ============================================
-- PASO 1: Crear la entidad principal (flights)
-- ============================================


CREATE TABLE flights (
    id              INTEGER PRIMARY KEY,
    flight_number   TEXT    NOT NULL,
    origin          TEXT    NOT NULL,
    destination     TEXT    NOT NULL,
    departure_time  TEXT    NOT NULL,
    arrival_time    TEXT    NOT NULL,
    aircraft_id     INTEGER,
    crew_id         INTEGER
);

-- ============================================
-- PASO 2: Crear la entidad passengers
-- ============================================

CREATE TABLE passengers (
    id          INTEGER PRIMARY KEY,
    name   TEXT    NOT NULL,
    lastname   TEXT    NOT NULL,
    email       TEXT,
    phone       TEXT,
    passport    TEXT    NOT NULL
);

-- ============================================
-- PASO 3: Crear la entidad aircraft
-- ============================================

CREATE TABLE aircraft (
    id              INTEGER PRIMARY KEY,
    model           TEXT    NOT NULL,
    capacity        INTEGER NOT NULL,
    registration    TEXT    NOT NULL,
    manufacturer    TEXT
);

-- ============================================
-- PASO 4: Crear la entidad crews
-- ============================================

CREATE TABLE crews (
    id              INTEGER PRIMARY KEY,
    captain         TEXT    NOT NULL,
    copilot         TEXT    NOT NULL,
    attendants      INTEGER NOT NULL,
    base_airport    TEXT
);

-- ============================================
-- PASO 5: Insertar datos de prueba
-- ============================================

-- Vuelos
INSERT INTO flights (id, flight_number, origin, destination, departure_time, arrival_time, aircraft_id, crew_id) VALUES
    (1, 'AV101', 'Bogotá', 'Miami', '2026-05-01 08:00', '2026-05-01 13:00', 1, 1),
    (2, 'AV102', 'Medellín', 'Madrid', '2026-05-02 16:00', '2026-05-03 08:00', 2, 2),
    (3, 'AV103', 'Cali', 'Cancún', '2026-05-04 09:30', '2026-05-04 12:00', 3, 3),
    (4, 'AV104', 'Bogotá', 'Buenos Aires', '2026-05-05 22:00', '2026-05-06 06:00', 4, 4),
    (5, 'AV105', 'Cartagena', 'Panamá', '2026-05-06 11:00', '2026-05-06 12:30', 5, 5),
    (6, 'AV106', 'Bogotá', 'Lima', '2026-05-07 07:00', '2026-05-07 10:00', 6, 6),
    (7, 'AV107', 'Medellín', 'New York', '2026-05-08 14:00', '2026-05-08 21:00', 7, 7),
    (8, 'AV108', 'Cali', 'Quito', '2026-05-09 06:00', '2026-05-09 07:30', 8, 8),
    (9, 'AV109', 'Bogotá', 'Los Ángeles', '2026-05-10 23:00', '2026-05-11 06:00', 9, 9),
    (10, 'AV110', 'Barranquilla', 'Orlando', '2026-05-11 12:00', '2026-05-11 16:00', 10, 10);

-- Pasajeros
INSERT INTO passengers (id, name, lastname, email, phone, passport) VALUES
    (1, 'Laura', 'Gómez', 'laura.gomez@email.com', '3001234567', 'P123456'),
    (2, 'Carlos', 'Pérez', 'carlos.perez@email.com', '3017654321', 'P654321'),
    (3, 'Ana', 'Torres', 'ana.torres@email.com', '3029876543', 'P789012'),
    (4, 'Juan', 'Rodríguez', 'juan.rodriguez@email.com', '3034567890', 'P345678'),
    (5, 'María', 'López', 'maria.lopez@email.com', '3041122334', 'P901234'),
    (6, 'Pedro', 'Sánchez', 'pedro.sanchez@email.com', '3052233445', 'P112233'),
    (7, 'Lucía', 'Fernández', 'lucia.fernandez@email.com', '3063344556', 'P223344'),
    (8, 'Andrés', 'Ramírez', 'andres.ramirez@email.com', '3074455667', 'P334455'),
    (9, 'Sofía', 'Herrera', 'sofia.herrera@email.com', '3085566778', 'P445566'),
    (10, 'Diego', 'Castro', 'diego.castro@email.com', '3096677889', 'P556677'),
    (11, 'Valentina', 'Ruiz', 'valentina.ruiz@email.com', '3107788990', 'P667788'),
    (12, 'Miguel', 'Ángel', 'miguel.angel@email.com', '3118899001', 'P778899'),
    (13, 'Camila', 'Vargas', 'camila.vargas@email.com', '3129900112', 'P889900'),
    (14, 'Julián', 'Morales', 'julian.morales@email.com', '3131011123', 'P990011'),
    (15, 'Paula', 'Castaño', 'paula.castano@email.com', '3142122234','P101112');

-- Aviones
INSERT INTO aircraft (id, model, capacity, registration, manufacturer) VALUES
    (1, 'Airbus A320', 180, 'HK-3201', 'Airbus'),
    (2, 'Boeing 787', 250, 'HK-7872', 'Boeing'),
    (3, 'Embraer E190', 100, 'HK-1903', 'Embraer'),
    (4, 'Boeing 737', 160, 'HK-7374', 'Boeing'),
    (5, 'Airbus A350', 300, 'HK-3505', 'Airbus'),
    (6, 'ATR 72', 70, 'HK-7276', 'ATR'),
    (7, 'Bombardier CRJ900', 90, 'HK-9097', 'Bombardier');

-- Tripulaciones
INSERT INTO crews (id, captain, copilot, attendants, base_airport) VALUES
    (1, 'Cap. Andrés Silva', 'Cop. Luis Martínez', 4, 'Bogotá'),
    (2, 'Cap. María Fernández', 'Cop. Juan Gómez', 5, 'Medellín'),
    (3, 'Cap. Carlos Ramírez', 'Cop. Ana Torres', 3, 'Cali'),
    (4, 'Cap. Laura Gómez', 'Cop. Pedro Sánchez', 6, 'Bogotá'),
    (5, 'Cap. Juan Rodríguez', 'Cop. Lucía Fernández', 4, 'Cartagena');

 


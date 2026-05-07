-- ============================================================
-- DATABASE SCHEMA: AeroTech Fleet Management
-- Standard: ISO/IEC 9075 (SQL)
-- ============================================================

-- CLEANUP: Ensure a clean state before schema creation
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS passengers;
DROP TABLE IF EXISTS aircraft;
DROP TABLE IF EXISTS crews;

-- 1. AIRCRAFT: Assets and physical fleet data
CREATE TABLE IF NOT EXISTS aircraft (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    model         TEXT NOT NULL,
    capacity      INTEGER NOT NULL CHECK (capacity > 0),
    registration  TEXT NOT NULL UNIQUE,
    manufacturer  TEXT DEFAULT 'Unknown',
    is_active     INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1))
);

-- 2. PASSENGERS: Customer and traveler information
CREATE TABLE IF NOT EXISTS passengers (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    email         TEXT UNIQUE CHECK (email LIKE '%@%.%'),
    phone_number  TEXT,
    passport_id   TEXT NOT NULL UNIQUE
);

-- 3. CREWS: Human resources assigned to flights
CREATE TABLE IF NOT EXISTS crews (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    captain_name  TEXT NOT NULL,
    copilot_name  TEXT NOT NULL,
    attendants_count INTEGER NOT NULL DEFAULT 2 CHECK (attendants_count >= 0),
    base_airport  TEXT NOT NULL
);

-- 4. FLIGHTS: Operational core linking assets and crew
CREATE TABLE IF NOT EXISTS flights (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    flight_code     TEXT NOT NULL UNIQUE,
    origin_icao     TEXT NOT NULL,      -- Using ICAO/IATA standard naming
    destination_icao TEXT NOT NULL,
    departure_at    TEXT NOT NULL,      -- ISO8601 strings (YYYY-MM-DD HH:MM:SS)
    arrival_at      TEXT NOT NULL,
    aircraft_id     INTEGER,
    crew_id         INTEGER,
    status          TEXT DEFAULT 'Scheduled' 
                    CHECK (status IN ('Scheduled', 'Delayed', 'In-flight', 'Arrived', 'Cancelled')),
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(id) ON DELETE SET NULL,
    FOREIGN KEY (crew_id)     REFERENCES crews(id) ON DELETE SET NULL
);

-- VERIFICATION
.tables
PRAGMA table_info(flights); -- verify table info
-- PRAGMA is use to query, modify, and manage the database schema and settings. It is not a standard SQL command but is specific to SQLite.

-- new data that matches the new schema 

-- AIRCRAFT 
INSERT INTO aircraft (model, capacity, registration, manufacturer, is_active) VALUES
('Airbus A320neo', 180, 'HK-5335', 'Airbus', 1),
('Boeing 787-9', 250, 'HK-5521', 'Boeing', 1),
('Boeing 737 MAX 8', 170, 'HK-5410', 'Boeing', 1),
('Airbus A330-200', 252, 'HK-5190', 'Airbus', 1),
('ATR 72-600', 72, 'HK-5041', 'ATR', 1),
('Embraer E195-E2', 132, 'HK-5288', 'Embraer', 1),
('Airbus A321LR', 206, 'HK-5399', 'Airbus', 1),
('Boeing 777-300ER', 396, 'HK-5600', 'Boeing', 1),
('Cessna 208 Caravan', 12, 'HK-4820', 'Cessna', 1),
('Airbus A319', 144, 'HK-5212', 'Airbus', 0), 
('Boeing 747-8i', 410, 'HK-5700', 'Boeing', 1),
('Bombardier CRJ-900', 90, 'HK-5122', 'Bombardier', 1),
('Airbus A350-900', 315, 'HK-5450', 'Airbus', 1),
('Boeing 767-300F', 120, 'HK-5000C', 'Boeing', 1),
('Airbus A320neo', 180, 'HK-5336', 'Airbus', 1);

-- PASSENGERS 
INSERT INTO passengers (first_name, last_name, email, phone_number, passport_id) VALUES
('Francisco', 'Rodriguez', 'f.rodriguez@email.com', '+573101234567', 'PAS-998877'),
('Laura', 'Gomez', 'laura.gomez@aero.co', '+573004567890', 'PAS-112233'),
('Carlos', 'Mendoza', 'c.mendoza@gmail.com', '+573209876543', 'PAS-445566'),
('Ana', 'Martinez', 'ana.mtz@outlook.com', '+13057891234', 'PAS-778899'),
('John', 'Smith', 'j.smith@provider.net', '+442071234567', 'PAS-001122'),
('Maria', 'Curie', 'm.curie@science.org', '+33140506070', 'PAS-334455'),
('Sofia', 'Castillo', 'sofi.cas@email.com', '+573155554433', 'PAS-667788'),
('Diego', 'Sanz', 'd.sanz@viajes.es', '+34912345678', 'PAS-889900'),
('Elena', 'Russo', 'e.russo@it.com', '+39061234567', 'PAS-223311'),
('Julian', 'Bernal', 'jbernal@empresa.com', '+573112223344', 'PAS-556644'),
('Camila', 'Vargas', 'c.vargas@estudiante.edu', '+573149998877', 'PAS-121234'),
('Robert', 'Wilson', 'r.wilson@tech.com', '+14155550101', 'PAS-787890'),
('Yuki', 'Tanaka', 'y.tanaka@jp.com', '+81312345678', 'PAS-343456'),
('Luis', 'Ortega', 'l.ortega@freelance.com', '+525512345678', 'PAS-909012'),
('Isabella', 'Conti', 'i.conti@br.com', '+551198765432', 'PAS-565678');

-- CREWS 
INSERT INTO crews (captain_name, copilot_name, attendants_count, base_airport) VALUES
('Andres Silva', 'Luis Martinez', 4, 'SKBO'), -- Bogota
('Maria Fernandez', 'Juan Gomez', 6, 'SKRG'), -- Medellin
('Carlos Ramirez', 'Ana Torres', 3, 'SKCL'), -- Cali
('Roberto Cano', 'Paula Ortiz', 5, 'SKBO'),
('Felipe Rios', 'Sonia Lopez', 4, 'SKCG'), -- Cartagena
('Ricardo Vega', 'Marta Soler', 2, 'SKBQ'), -- Barranquilla
('Ignacio Ruiz', 'Elena Gil', 8, 'KJFK'), -- New York
('Oscar Diaz', 'Lucia Paz', 4, 'SKBO'),
('Victor Hugo', 'Diana Prince', 5, 'LEMD'), -- Madrid
('Samuel Kim', 'Javier Peña', 4, 'MPTO'), -- Panama
('Beatriz Pinzon', 'Nicolas Mora', 3, 'SKBO'),
('Armando Mendoza', 'Marcela Valencia', 6, 'SKRG'),
('Hugo Lombardi', 'Patricia Fernandez', 4, 'SKCL'),
('Daniel Valencia', 'Mario Calderon', 4, 'SKBO'),
('Betty Suarez', 'Freddy Contreras', 2, 'SKPE');

-- FLIGHTS
INSERT INTO flights (flight_code, origin_icao, destination_icao, departure_at, arrival_at, aircraft_id, crew_id, status) VALUES
('AT1001', 'SKBO', 'KMIA', '2026-05-01 06:00:00', '2026-05-01 10:30:00', 1, 1, 'Scheduled'),
('AT2005', 'SKRG', 'LEMD', '2026-05-01 18:00:00', '2026-05-02 10:00:00', 2, 2, 'Scheduled'),
('AT3002', 'SKCL', 'MPTO', '2026-05-02 09:15:00', '2026-05-02 11:00:00', 3, 3, 'Scheduled'),
('AT4044', 'SKBO', 'KJFK', '2026-05-02 23:30:00', '2026-05-03 05:45:00', 4, 4, 'Scheduled'),
('AT5010', 'SKCG', 'SKBO', '2026-05-03 12:00:00', '2026-05-03 13:30:00', 5, 5, 'Scheduled'),
('AT1122', 'SKBQ', 'KMIA', '2026-05-03 07:00:00', '2026-05-03 09:50:00', 6, 6, 'Scheduled'),
('AT9901', 'SKBO', 'SPJC', '2026-05-04 14:00:00', '2026-05-04 17:15:00', 7, 8, 'Delayed'),
('AT7788', 'KJFK', 'LEMD', '2026-05-04 21:00:00', '2026-05-05 09:00:00', 8, 7, 'Scheduled'),
('AT8855', 'SKBO', 'SABE', '2026-05-05 01:00:00', '2026-05-05 07:30:00', 13, 11, 'Scheduled'),
('AT6633', 'SKRG', 'SKBO', '2026-05-05 10:00:00', '2026-05-05 11:00:00', 12, 12, 'In-flight'),
('AT2211', 'MPTO', 'SKCL', '2026-05-06 15:30:00', '2026-05-06 17:00:00', 3, 10, 'Scheduled'),
('AT4400', 'LEMD', 'SKBO', '2026-05-06 23:50:00', '2026-05-07 04:20:00', 13, 9, 'Scheduled'),
('AT5522', 'SKBO', 'SKCG', '2026-05-07 08:00:00', '2026-05-07 09:30:00', 1, 14, 'Scheduled'),
('AT3311', 'SKPE', 'SKBO', '2026-05-07 13:00:00', '2026-05-07 14:00:00', 5, 15, 'Arrived'),
('AT1100', 'SKBO', 'KLAX', '2026-05-08 22:00:00', '2026-05-09 05:00:00', 11, 4, 'Scheduled');


PRAGMA table_info(aircraft); 
ALTER TABLE aircraft
RENAME COLUMN id TO aircraft_id; -- Renaming the 'id' column to 'aircraft_id' for better clarity

PRAGMA table_info(passengers); 
ALTER TABLE passengers
RENAME COLUMN id TO pass_id; -- Renaming the 'id' column to 'pass_id' for better clarity

PRAGMA table_info(crews); 
ALTER TABLE crews
RENAME COLUMN id TO crew_id; -- Renaming the 'id' column to 'crew_id' for better clarity

PRAGMA table_info(flights); 
ALTER TABLE flights
RENAME COLUMN id TO flight_id; -- Renaming the 'id' column to 'flight_id' for better clarity
ALTER TABLE flights
RENAME COLUMN status TO flight_status;

-- ============================================================
-- 3rd week - DML:Data Manipulation Language
-- ============================================================



UPDATE passengers
SET email = 'newexamplemail@newmail.com'
WHERE passport_id = 'PAS-998877';

UPDATE flights 
SET flight_status = 'Delayed' -- Changing the status of a flight to 'Delayed'
WHERE flight_code = 'AT1001';

SELECT flight_status
FROM flights 
WHERE flight_code = 'AT1001';

UPDATE flights
SET flight_status = 'Cancelled' -- Changing the status of a flight to 'Cancelled'
WHERE flight_code = 'AT1001';

SELECT flight_status 
FROM flights 
WHERE flight_code = 'AT1001';

UPDATE flights
SET flight_status = 'In-flight' 
WHERE origin_icao = 'SKRG' AND flight_status = 'Scheduled';

SELECT flight_code, flight_status
FROM flights
WHERE origin_icao = 'SKRG';

SELECT aircraft_id, model, capacity, registration, manufacturer, is_active
FROM aircraft
WHERE is_active = 0; -- IT WILL SHOW THE INACTIVE AIRCRAFTS

DELETE FROM aircraft
WHERE is_active = 0; -- Deleting the inactive aircrafts from the database

-- =============================================================
-- week 4 SELECT statements and queries(DQL:Data Query Language)
-- =============================================================

INSERT INTO aircraft (model, capacity, registration, manufacturer, is_active) VALUES
('Boeing 737-800', 162, 'HK-5001', 'Boeing', 1), ('Airbus A320', 180, 'HK-5002', 'Airbus', 1),
('Boeing 787-8', 250, 'HK-5003', 'Boeing', 1), ('Embraer E190', 100, 'HK-5004', 'Embraer', 1),
('Airbus A330', 252, 'HK-5005', 'Airbus', 1), ('ATR 72-600', 70, 'HK-5006', 'ATR', 1),
('Boeing 777-200', 310, 'HK-5007', 'Boeing', 1), ('Airbus A321', 220, 'HK-5008', 'Airbus', 1),
('Cessna 208', 12, 'HK-5009', 'Cessna', 1), ('Bombardier CRJ700', 78, 'HK-5010', 'Bombardier', 0),
('Airbus A350', 325, 'HK-5011', 'Airbus', 1), ('Boeing 747-400', 416, 'HK-5012', 'Boeing', 1),
('Gulfstream G650', 19, 'HK-5013', 'Gulfstream', 1), ('Dash 8 Q400', 76, 'HK-5014', 'De Havilland', 1),
('Boeing 737 MAX 9', 178, 'HK-5015', 'Boeing', 1), ('Airbus A319', 144, 'HK-5016', 'Airbus', 1),
('Embraer E175', 76, 'HK-5017', 'Embraer', 1), ('Airbus A220', 135, 'HK-5018', 'Airbus', 1),
('Boeing 767-300', 210, 'HK-5019', 'Boeing', 0), ('Pilatus PC-12', 9, 'HK-5020', 'Pilatus', 1);

INSERT INTO passengers (first_name, last_name, email, phone_number, passport_id) VALUES
('Juan', 'Perez', 'j.perez@mail.com', '300111', 'PAS-101'), ('Maria', 'Lopez', 'm.lopez@mail.com', '300222', 'PAS-102'),
('Carlos', 'Ruiz', 'c.ruiz@mail.com', '300333', 'PAS-103'), ('Ana', 'Silva', 'a.silva@mail.com', '300444', 'PAS-104'),
('Luis', 'Mesa', 'l.mesa@mail.com', '300555', 'PAS-105'), ('Rosa', 'Diaz', 'r.diaz@mail.com', '300666', 'PAS-106'),
('Jorge', 'Gomez', 'j.gomez@mail.com', '300777', 'PAS-107'), ('Elena', 'Vega', 'e.vega@mail.com', '300888', 'PAS-108'),
('Pedro', 'Sanz', 'p.sanz@mail.com', '300999', 'PAS-109'), ('Lucia', 'Cruz', 'l.cruz@mail.com', '300000', 'PAS-110'),
('David', 'Mora', 'd.mora@mail.com', '300112', 'PAS-111'), ('Sofia', 'Leon', 's.leon@mail.com', '300113', 'PAS-112'),
('Hugo', 'Rios', 'h.rios@mail.com', '300114', 'PAS-113'), ('Paula', 'Luna', 'p.luna@mail.com', '300115', 'PAS-114'),
('Ivan', 'Soto', 'i.soto@mail.com', '300116', 'PAS-115'), ('Sara', 'Peña', 's.pena@mail.com', '300117', 'PAS-116'),
('Mario', 'Cano', 'm.cano@mail.com', '300118', 'PAS-117'), ('Ines', 'Vidal', 'i.vidal@mail.com', '300119', 'PAS-118'),
('Raul', 'Lara', 'r.lara@mail.com', '300120', 'PAS-119'), ('Clara', 'Toro', 'c.toro@mail.com', '300121', 'PAS-120');

INSERT INTO crews (captain_name, copilot_name, attendants_count, base_airport) VALUES
('Capt. 01', 'Cop. 01', 4, 'SKBO'), ('Capt. 02', 'Cop. 02', 5, 'SKRG'), ('Capt. 03', 'Cop. 03', 3, 'SKCL'),
('Capt. 04', 'Cop. 04', 6, 'SKBO'), ('Capt. 05', 'Cop. 05', 4, 'SKCG'), ('Capt. 06', 'Cop. 06', 2, 'SKBQ'),
('Capt. 07', 'Cop. 07', 5, 'SKBO'), ('Capt. 08', 'Cop. 08', 3, 'SKRG'), ('Capt. 09', 'Cop. 09', 4, 'SKCL'),
('Capt. 10', 'Cop. 10', 6, 'SKBO'), ('Capt. 11', 'Cop. 11', 5, 'SKCG'), ('Capt. 12', 'Cop. 12', 4, 'SKBQ'),
('Capt. 13', 'Cop. 13', 3, 'SKBO'), ('Capt. 14', 'Cop. 14', 2, 'SKRG'), ('Capt. 15', 'Cop. 15', 5, 'SKCL'),
('Capt. 16', 'Cop. 16', 4, 'SKBO'), ('Capt. 17', 'Cop. 17', 6, 'SKCG'), ('Capt. 18', 'Cop. 18', 3, 'SKBQ'),
('Capt. 19', 'Cop. 19', 4, 'SKBO'), ('Capt. 20', 'Cop. 20', 5, 'SKRG');

INSERT INTO flights (flight_code, origin_icao, destination_icao, departure_at, arrival_at, aircraft_id, crew_id, flight_status) VALUES
('FL-01', 'SKBO', 'KMIA', '2026-06-01 08:00', '2026-06-01 12:00', 1, 1, 'Scheduled'),
('FL-02', 'SKBO', 'LEMD', '2026-06-01 10:00', '2026-06-01 22:00', 2, 2, 'Scheduled'),
('FL-03', 'SKRG', 'MPTO', '2026-06-01 14:00', '2026-06-01 16:00', 3, 3, 'Delayed'),
('FL-04', 'SKCL', 'SABE', '2026-06-01 16:00', '2026-06-01 22:00', 4, 4, 'Scheduled'),
('FL-05', 'SKBO', 'KJFK', '2026-06-01 20:00', '2026-06-02 04:00', 5, 5, 'Scheduled'),
('FL-06', 'KMIA', 'SKBO', '2026-06-02 08:00', '2026-06-02 12:00', 1, 6, 'Scheduled'),
('FL-07', 'LEMD', 'SKBO', '2026-06-02 10:00', '2026-06-02 22:00', 2, 7, 'Scheduled'),
('FL-08', 'MPTO', 'SKRG', '2026-06-02 14:00', '2026-06-02 16:00', 3, 8, 'Scheduled'),
('FL-09', 'SABE', 'SKCL', '2026-06-02 16:00', '2026-06-02 22:00', 4, 9, 'Scheduled'),
('FL-10', 'KJFK', 'SKBO', '2026-06-02 20:00', '2026-06-03 04:00', 5, 10, 'Scheduled'),
('FL-11', 'SKBO', 'SKRG', '2026-06-03 07:00', '2026-06-03 08:00', 6, 11, 'Scheduled'),
('FL-12', 'SKRG', 'SKBO', '2026-06-03 09:00', '2026-06-03 10:00', 6, 12, 'Scheduled'),
('FL-13', 'SKBO', 'SKCL', '2026-06-03 11:00', '2026-06-03 12:00', 7, 13, 'Cancelled'),
('FL-14', 'SKCL', 'SKBO', '2026-06-03 13:00', '2026-06-03 14:00', 7, 14, 'Scheduled'),
('FL-15', 'SKBO', 'SKCG', '2026-06-03 15:00', '2026-06-03 16:30', 8, 15, 'Scheduled'),
('FL-16', 'SKCG', 'SKBO', '2026-06-03 17:30', '2026-06-03 19:00', 8, 16, 'Scheduled'),
('FL-17', 'SKBO', 'SKBQ', '2026-06-03 20:00', '2026-06-03 21:30', 9, 17, 'Scheduled'),
('FL-18', 'SKBQ', 'SKBO', '2026-06-03 22:30', '2026-06-04 00:00', 9, 18, 'Scheduled'),
('FL-19', 'SKBO', 'LEMD', '2026-06-04 06:00', '2026-06-04 18:00', 11, 19, 'Scheduled'),
('FL-20', 'LEMD', 'SKBO', '2026-06-05 06:00', '2026-06-05 18:00', 11, 20, 'Scheduled');

SELECT 
    flight_code AS Codigo_Vuelo,
    origin_icao AS Aeropuerto_Origen,
    destination_icao AS Aeropuerto_Destino,
    departure_at AS Fecha_Salida
FROM flights
WHERE origin_icao = 'SKBO' AND flight_status = 'Scheduled';

SELECT 
    first_name AS Nombre,
    last_name AS Apellido,
    passport_id AS Numero_Pasaporte
FROM passengers;

SELECT 
    model AS Modelo_Avion,
    capacity AS Capacidad_Pasajeros
FROM aircraft
ORDER BY capacity DESC;

SELECT flight_code, flight_status 
FROM flights 
WHERE flight_status = 'Delayed' OR flight_status = 'Cancelled';

SELECT model, capacity 
FROM aircraft 
WHERE capacity >= 200
ORDER BY capacity ASC
LIMIT 5
OFFSET 0;

SELECT model, capacity 
FROM aircraft 
WHERE capacity >= 200
ORDER BY capacity ASC
LIMIT 5
OFFSET 5;

SELECT flight_code, departure_at 
FROM flights 
WHERE departure_at >= '2026-06-01 00:00' AND departure_at < '2026-07-01 00:00'
ORDER BY departure_at ASC;

SELECT captain_name, copilot_name
FROM crews 
WHERE attendants_count >= 5
ORDER BY captain_name ASC;


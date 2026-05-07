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




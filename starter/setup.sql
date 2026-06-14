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

-- CREACIÓN DE TABLAS con los NULL y CONSTRAINTS correspondientes a la lógica(DDL)

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
-- POBLACIÓN DE DATOS REALISTAS (50 REGISTROS POR TABLA)
-- ===========================================================

-- 1. AIRCRAFT (Aeronaves)
INSERT INTO aircraft (id, model, capacity, registration, manufacturer) VALUES
(101, 'Airbus A320', 150, 'HK-5301', 'Airbus'), (102, 'Airbus A320', 150, 'HK-5302', 'Airbus'),
(103, 'Airbus A320', 150, 'HK-5303', 'Airbus'), (104, 'Airbus A320neo', 156, 'HK-5304', 'Airbus'),
(105, 'Airbus A320neo', 156, 'HK-5305', 'Airbus'), (106, 'Airbus A330', 252, 'HK-5306', 'Airbus'),
(107, 'Airbus A330', 252, 'HK-5307', 'Airbus'), (108, 'Boeing 737-800', 160, 'HK-5308', 'Boeing'),
(109, 'Boeing 737-800', 160, 'HK-5309', 'Boeing'), (110, 'Boeing 737-800', 160, 'HK-5310', 'Boeing'),
(111, 'Boeing 737 MAX', 172, 'HK-5311', 'Boeing'), (112, 'Boeing 737 MAX', 172, 'HK-5312', 'Boeing'),
(113, 'Boeing 787-8', 250, 'HK-5313', 'Boeing'), (114, 'Boeing 787-8', 250, 'HK-5314', 'Boeing'),
(115, 'ATR 72-600', 68, 'HK-5315', 'ATR'), (116, 'ATR 72-600', 68, 'HK-5316', 'ATR'),
(117, 'ATR 42-500', 48, 'HK-5317', 'ATR'), (118, 'ATR 42-500', 48, 'HK-5318', 'ATR'),
(119, 'Embraer E190', 96, 'HK-5319', 'Embraer'), (120, 'Embraer E190', 96, 'HK-5320', 'Embraer'),
(121, 'Airbus A319', 120, 'HK-5321', 'Airbus'), (122, 'Airbus A319', 120, 'HK-5322', 'Airbus'),
(123, 'Airbus A321', 190, 'HK-5323', 'Airbus'), (124, 'Airbus A321', 190, 'HK-5324', 'Airbus'),
(125, 'Boeing 777', 300, 'HK-5325', 'Boeing'), (126, 'Boeing 777', 300, 'HK-5326', 'Boeing'),
(127, 'Cessna 208', 9, 'HK-5327', 'Cessna'), (128, 'Cessna 208', 9, 'HK-5328', 'Cessna'),
(129, 'Airbus A320', 150, 'CC-AWA', 'Airbus'), (130, 'Airbus A320', 150, 'CC-AWB', 'Airbus'),
(131, 'Boeing 737-800', 160, 'XA-VAA', 'Boeing'), (132, 'Boeing 737-800', 160, 'XA-VAB', 'Boeing'),
(133, 'Embraer E195', 118, 'PR-AZA', 'Embraer'), (134, 'Embraer E195', 118, 'PR-AZB', 'Embraer'),
(135, 'ATR 72-600', 68, 'HK-5335', 'ATR'), (136, 'ATR 72-600', 68, 'HK-5336', 'ATR'),
(137, 'Airbus A330', 252, 'HK-5337', 'Airbus'), (138, 'Airbus A330', 252, 'HK-5338', 'Airbus'),
(139, 'Boeing 787-9', 290, 'HK-5339', 'Boeing'), (140, 'Boeing 787-9', 290, 'HK-5340', 'Boeing'),
(141, 'Airbus A350', 315, 'HK-5341', 'Airbus'), (142, 'Airbus A350', 315, 'HK-5342', 'Airbus'),
(143, 'Embraer E175', 76, 'HK-5343', 'Embraer'), (144, 'Embraer E175', 76, 'HK-5344', 'Embraer'),
(145, 'Airbus A320neo', 156, 'HK-5345', 'Airbus'), (146, 'Airbus A320neo', 156, 'HK-5346', 'Airbus'),
(147, 'Boeing 737 MAX', 172, 'HK-5347', 'Boeing'), (148, 'Boeing 737 MAX', 172, 'HK-5348', 'Boeing'),
(149, 'ATR 42-500', 48, 'HK-5349', 'ATR'), (150, 'ATR 42-500', 48, 'HK-5350', 'ATR');

-- 2. CREWS (Tripulaciones)
INSERT INTO crews (id, captain, copilot, attendants, base_airport) VALUES
(101, 'Carlos Ramirez', 'Andres Silva', 4, 'BOG'), (102, 'Maria Gomez', 'Juan Perez', 5, 'BOG'),
(103, 'Javier Torres', 'Luis Fernandez', 4, 'MDE'), (104, 'Ana Martinez', 'Diego Lopez', 3, 'CLO'),
(105, 'Pedro Ruiz', 'Laura Diaz', 4, 'BOG'), (106, 'Sofia Castro', 'Camila Vargas', 5, 'CTG'),
(107, 'Miguel Rojas', 'Mateo Ortiz', 4, 'BAQ'), (108, 'Daniela Rios', 'Santiago Gil', 3, 'MDE'),
(109, 'Jorge Morales', 'Sebastian Vega', 4, 'BOG'), (110, 'Valentina Cruz', 'Nicolas Peña', 4, 'CLO'),
(111, 'Ricardo Herrera', 'Felipe Cardenas', 5, 'BOG'), (112, 'Paula Medina', 'Tomas Aguilar', 3, 'SMR'),
(113, 'Alejandro Pinto', 'Daniel Escobar', 4, 'MDE'), (114, 'Carolina Moya', 'David Paredes', 4, 'BOG'),
(115, 'Andres Castro', 'Julian Quintero', 2, 'BGA'), (116, 'Natalia Leon', 'Samuel Orozco', 2, 'PEI'),
(117, 'Juan Cardenas', 'Esteban Velez', 4, 'BOG'), (118, 'Diana Pineda', 'Oscar Mejia', 4, 'MDE'),
(119, 'Hector Navas', 'Camilo Jaramillo', 5, 'BOG'), (120, 'Gabriela Soto', 'Ivan Duque', 3, 'CLO'),
(121, 'Roberto Cano', 'Victor Salas', 4, 'BOG'), (122, 'Marcela Rico', 'Hugo Londoño', 4, 'CTG'),
(123, 'Mauricio Alba', 'Leonardo Paz', 5, 'BOG'), (124, 'Juliana Rey', 'Emilio Rivas', 4, 'MDE'),
(125, 'Guillermo Mora', 'Martin Solis', 6, 'BOG'), (126, 'Teresa Blanco', 'Pablo Cuellar', 6, 'BOG'),
(127, 'Fernando Giraldo', 'Simon Gaitan', 2, 'CUC'), (128, 'Lorena Mesa', 'Alberto Parra', 2, 'EYP'),
(129, 'Hernan Cortes', 'Rafael Nieto', 4, 'BOG'), (130, 'Silvia Vargas', 'Joaquin Osorio', 4, 'MDE'),
(131, 'Rodrigo Bueno', 'Gonzalo Ibarra', 4, 'BOG'), (132, 'Angela Cifuentes', 'Alonso Vaca', 4, 'CLO'),
(133, 'Gustavo Garzon', 'Marcos Duarte', 3, 'BOG'), (134, 'Patricia Avila', 'Raul Cordoba', 3, 'CTG'),
(135, 'Esteban Lugo', 'Ignacio Fierro', 2, 'VVC'), (136, 'Monica Bello', 'Felix Montenegro', 2, 'MZL'),
(137, 'Ruben Dario', 'Cesar Augusto', 5, 'BOG'), (138, 'Luisa Fernanda', 'Maria Jose', 5, 'MDE'),
(139, 'Fabian Casas', 'Nelson Suarez', 6, 'BOG'), (140, 'Gloria Arce', 'Jairo Borda', 6, 'BOG'),
(141, 'Orlando Niño', 'Mario Bernal', 5, 'BOG'), (142, 'Victoria Roa', 'Armando Hoyos', 5, 'CLO'),
(143, 'Edwin Caro', 'Elias Noguera', 3, 'BOG'), (144, 'Sandra Tovar', 'Ismael Forero', 3, 'BOG'),
(145, 'Wilmar Cruz', 'Cristian Burgos', 4, 'BOG'), (146, 'Tatiana Rozo', 'Bryan Galindo', 4, 'MDE'),
(147, 'Diego Franco', 'Kevin Beltran', 4, 'BOG'), (148, 'Paola Segura', 'Alex Cardenas', 4, 'CLO'),
(149, 'Wilson Pava', 'Johan Carrillo', 2, 'BOG'), (150, 'Yolanda Celis', 'Ronald Arango', 2, 'MDE');

-- 3. PASSENGERS (Pasajeros)
INSERT INTO passengers (id, name, lastname, email, phone, passport) VALUES
(101, 'Jose', 'Gomez', 'jose@mail.com', '3101234567', 'P0001'), (102, 'Maria', 'Rodriguez', NULL, '3201234567', 'P0002'),
(103, 'Carlos', 'Perez', 'carlos@mail.com', NULL, 'P0003'), (104, 'Ana', 'Gonzalez', 'ana@mail.com', '3151234567', 'P0004'),
(105, 'Luis', 'Ramirez', NULL, '3001234567', 'P0005'), (106, 'Carmen', 'García', 'carmen@mail.com', NULL, 'P0006'),
(107, 'Jorge', 'Martinez', 'jorge@mail.com', '3111234567', 'P0007'), (108, 'Martha', 'Lopez', NULL, '3121234567', 'P0008'),
(109, 'Pedro', 'Hernandez', 'pedro@mail.com', NULL, 'P0009'), (110, 'Luz', 'Diaz', 'luz@mail.com', '3131234567', 'P0010'),
(111, 'Miguel', 'Torres', NULL, '3141234567', 'P0011'), (112, 'Rosa', 'Ruiz', 'rosa@mail.com', NULL, 'P0012'),
(113, 'Juan', 'Flores', 'juan@mail.com', '3161234567', 'P0013'), (114, 'Blanca', 'Alvarez', NULL, '3171234567', 'P0014'),
(115, 'Andres', 'Rojas', 'andres@mail.com', NULL, 'P0015'), (116, 'Elena', 'Acosta', 'elena@mail.com', '3181234567', 'P0016'),
(117, 'David', 'Mendoza', NULL, '3191234567', 'P0017'), (118, 'Diana', 'Medina', 'diana@mail.com', NULL, 'P0018'),
(119, 'Oscar', 'Herrera', 'oscar@mail.com', '3211234567', 'P0019'), (120, 'Patricia', 'Aguilar', NULL, '3221234567', 'P0020'),
(121, 'Diego', 'Castro', 'diego@mail.com', NULL, 'P0021'), (122, 'Sonia', 'Ortiz', 'sonia@mail.com', '3231234567', 'P0022'),
(123, 'Fernando', 'Vargas', NULL, '3241234567', 'P0023'), (124, 'Gloria', 'Rios', 'gloria@mail.com', NULL, 'P0024'),
(125, 'Javier', 'Silva', 'javier@mail.com', '3501234567', 'P0025'), (126, 'Nelly', 'Morales', NULL, '3511234567', 'P0026'),
(127, 'Ivan', 'Pena', 'ivan@mail.com', NULL, 'P0027'), (128, 'Alba', 'Cruz', 'alba@mail.com', '3021234567', 'P0028'),
(129, 'Hector', 'Reyes', NULL, '3031234567', 'P0029'), (130, 'Teresa', 'Romero', 'teresa@mail.com', NULL, 'P0030'),
(131, 'Gabriel', 'Rubio', 'gabriel@mail.com', '3041234567', 'P0031'), (132, 'Silvia', 'Quintero', NULL, '3051234567', 'P0032'),
(133, 'Mario', 'Guzman', 'mario@mail.com', NULL, 'P0033'), (134, 'Paola', 'Suarez', 'paola@mail.com', '3011234567', 'P0034'),
(135, 'Victor', 'Paredes', NULL, '3061234567', 'P0035'), (136, 'Angela', 'Moya', 'angela@mail.com', NULL, 'P0036'),
(137, 'Ricardo', 'Soto', 'ricardo@mail.com', '3071234567', 'P0037'), (138, 'Victoria', 'Velez', NULL, '3081234567', 'P0038'),
(139, 'Cesar', 'Orozco', 'cesar@mail.com', NULL, 'P0039'), (140, 'Margarita', 'Mejia', 'margarita@mail.com', '3091234567', 'P0040'),
(141, 'Eduardo', 'Pardo', NULL, '3109876543', 'P0041'), (142, 'Beatriz', 'Cortes', 'beatriz@mail.com', NULL, 'P0042'),
(143, 'Armando', 'Cabrera', 'armando@mail.com', '3119876543', 'P0043'), (144, 'Irene', 'Nieto', NULL, '3129876543', 'P0044'),
(145, 'Guillermo', 'Blanco', 'guille@mail.com', NULL, 'P0045'), (146, 'Consuelo', 'Navarro', 'consuelo@mail.com', '3139876543', 'P0046'),
(147, 'Mauricio', 'Castaño', NULL, '3149876543', 'P0047'), (148, 'Lorena', 'Osorio', 'lorena@mail.com', NULL, 'P0048'),
(149, 'Felipe', 'Bermudez', 'felipe@mail.com', '3159876543', 'P0049'), (150, 'Andrea', 'Serna', NULL, '3169876543', 'P0050');

-- 4. FLIGHTS (Vuelos)
INSERT INTO flights (id, flight_number, origin, destination, departure_time, arrival_time, aircraft_id, crew_id) VALUES
(101, 'AV001', 'BOG', 'MDE', '2026-06-15 08:00', '2026-06-15 09:00', 101, 101),
(102, 'AV002', 'MDE', 'BOG', '2026-06-15 10:00', '2026-06-15 11:00', 101, 101),
(103, 'AV003', 'BOG', 'CLO', '2026-06-15 12:00', '2026-06-15 13:00', 102, 102),
(104, 'AV004', 'CLO', 'BOG', '2026-06-15 14:00', '2026-06-15 15:00', 102, 102),
(105, 'AV005', 'BOG', 'CTG', '2026-06-15 16:00', '2026-06-15 17:30', 103, 103),
(106, 'AV006', 'CTG', 'BOG', '2026-06-15 18:30', '2026-06-15 20:00', 103, 103),
(107, 'AV007', 'BOG', 'MIA', '2026-06-16 06:00', '2026-06-16 10:00', 106, 104),
(108, 'AV008', 'MIA', 'BOG', '2026-06-16 12:00', '2026-06-16 16:00', 106, 104),
(109, 'AV009', 'BOG', 'MAD', '2026-06-16 21:00', '2026-06-17 13:00', 113, 105),
(110, 'AV010', 'MAD', 'BOG', '2026-06-17 16:00', '2026-06-17 20:30', 113, 105),
(111, 'AV011', 'BOG', 'BAQ', '2026-06-17 08:00', '2026-06-17 09:30', 104, 106),
(112, 'AV012', 'BAQ', 'BOG', '2026-06-17 10:30', '2026-06-17 12:00', 104, 106),
(113, 'AV013', 'BOG', 'SMR', '2026-06-18 09:00', '2026-06-18 10:30', 105, 107),
(114, 'AV014', 'SMR', 'BOG', '2026-06-18 11:30', '2026-06-18 13:00', 105, 107),
(115, 'AV015', 'BOG', 'PEI', '2026-06-18 14:00', '2026-06-18 15:00', 115, 108),
(116, 'AV016', 'PEI', 'BOG', '2026-06-18 16:00', '2026-06-18 17:00', 115, 108),
(117, 'AV017', 'BOG', 'BGA', '2026-06-19 07:00', '2026-06-19 08:00', 119, 109),
(118, 'AV018', 'BGA', 'BOG', '2026-06-19 09:00', '2026-06-19 10:00', 119, 109),
(119, 'AV019', 'MDE', 'CLO', '2026-06-19 11:00', '2026-06-19 12:00', 121, 110),
(120, 'AV020', 'CLO', 'MDE', '2026-06-19 13:00', '2026-06-19 14:00', 121, 110),
(121, 'AV021', 'BOG', 'LIM', '2026-06-20 05:00', '2026-06-20 08:00', 108, 111),
(122, 'AV022', 'LIM', 'BOG', '2026-06-20 09:00', '2026-06-20 12:00', 108, 111),
(123, 'AV023', 'BOG', 'GRU', '2026-06-20 15:00', '2026-06-20 23:00', 125, 112),
(124, 'AV024', 'GRU', 'BOG', '2026-06-21 01:00', '2026-06-21 05:00', 125, 112),
(125, 'AV025', 'BOG', 'CUC', '2026-06-21 08:00', '2026-06-21 09:15', 116, 113),
(126, 'AV026', 'CUC', 'BOG', '2026-06-21 10:00', '2026-06-21 11:15', 116, 113),
(127, 'AV027', 'BOG', 'VVC', '2026-06-21 13:00', '2026-06-21 13:45', 117, 114),
(128, 'AV028', 'VVC', 'BOG', '2026-06-21 14:30', '2026-06-21 15:15', 117, 114),
(129, 'AV029', 'BOG', 'EYP', '2026-06-22 09:00', '2026-06-22 10:00', 118, 115),
(130, 'AV030', 'EYP', 'BOG', '2026-06-22 11:00', '2026-06-22 12:00', 118, 115),
(131, 'AV031', 'BOG', 'NVA', '2026-06-22 14:00', '2026-06-22 15:00', 127, 116),
(132, 'AV032', 'NVA', 'BOG', '2026-06-22 16:00', '2026-06-22 17:00', 127, 116),
(133, 'AV033', 'BOG', 'ADZ', '2026-06-23 07:00', '2026-06-23 09:00', 123, 117),
(134, 'AV034', 'ADZ', 'BOG', '2026-06-23 10:00', '2026-06-23 12:00', 123, 117),
(135, 'AV035', 'BOG', 'MEX', '2026-06-23 06:00', '2026-06-23 10:30', 111, 118),
(136, 'AV036', 'MEX', 'BOG', '2026-06-23 12:00', '2026-06-23 16:30', 111, 118),
(137, 'AV037', 'BOG', 'SCL', '2026-06-24 18:00', '2026-06-24 23:45', 139, 119),
(138, 'AV038', 'SCL', 'BOG', '2026-06-25 01:00', '2026-06-25 06:45', 139, 119),
(139, 'AV039', 'MDE', 'MIA', '2026-06-25 08:00', '2026-06-25 11:30', 109, 120),
(140, 'AV040', 'MIA', 'MDE', '2026-06-25 13:00', '2026-06-25 16:30', 109, 120),
(141, 'AV041', 'CLO', 'MIA', '2026-06-26 07:00', '2026-06-26 10:45', 110, 121),
(142, 'AV042', 'MIA', 'CLO', '2026-06-26 12:00', '2026-06-26 15:45', 110, 121),
(143, 'AV043', 'BOG', 'JFK', '2026-06-26 14:00', '2026-06-26 20:00', 107, 122),
(144, 'AV044', 'JFK', 'BOG', '2026-06-26 22:00', NULL, 107, 122),
(145, 'AV045', 'BOG', 'UIO', '2026-06-27 08:00', '2026-06-27 09:30', 120, 123),
(146, 'AV046', 'UIO', 'BOG', '2026-06-27 10:30', NULL, 120, 123),
(147, 'AV047', 'BOG', 'PTY', '2026-06-27 15:00', '2026-06-27 16:30', 112, 124),
(148, 'AV048', 'PTY', 'BOG', '2026-06-27 18:00', NULL, 112, 124),
(149, 'AV049', 'MDE', 'CTG', '2026-06-28 09:00', '2026-06-28 10:15', 122, 125),
(150, 'AV050', 'CTG', 'MDE', '2026-06-28 11:00', NULL, 122, 125);
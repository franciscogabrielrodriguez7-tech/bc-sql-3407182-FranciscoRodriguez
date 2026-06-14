-- ===========================================================
-- WEEK 09 JOINs: INNER JOIN Y LEFT JOIN
-- ===========================================================

-- asociar capitán con vuelo 
SELECT 
    f.flight_number,
    c.captain,
    f.origin,
    f.destination 
FROM flights f 
JOIN crews c ON f.crew_id = c.id;  

-- vuelos sin capitán(no deberían haber)
SELECT 
    f.flight_number,
    c.captain,
    f.origin,
    f.destination 
FROM flights f 
LEFT JOIN crews c ON f.crew_id = c.id
WHERE c.captain IS NULL;  

-- mostrar todos los capitanes con sus vuelos asociados 
SELECT 
    f.flight_number,
    c.captain,
    f.origin,
    f.destination 
FROM crews c
LEFT JOIN flights f ON f.crew_id = c.id;

-- mostrar aviones sin vuelo asignado
SELECT 
    a.model AS modelo,
    f.flight_number AS vuelo_asociado
FROM aircraft a 
LEFT JOIN flights f ON a.id = f.aircraft_id
WHERE f.flight_number IS NULL;

-- vuelos sin avión asignado(no debería haber)
SELECT 
    a.model AS modelo,
    f.flight_number AS vuelo_asociado
FROM flights f 
LEFT JOIN aircraft a ON a.id = f.aircraft_id
WHERE a.id IS NULL;

-- mostrar los capitanes sin vuelo asignado
SELECT 
    c.captain AS capitan,
    f.flight_number AS vuelo_asociado
FROM crews c
LEFT JOIN flights f ON c.id = f.crew_id
WHERE f.flight_number IS NULL;

-- todos los vueos con todos los aviones
SELECT 
    a.model AS avion,
    f.flight_number AS vuelo_asociado
FROM aircraft a
FULL OUTER JOIN flights f ON a.id = f.aircraft_id;

-- Conectando Aviones (A) con Tripulaciones (C) a través de Vuelos (B)
SELECT 
    a.model AS modelo_avion,
    f.flight_number AS numero_vuelo,
    c.captain AS capitan_asignado
FROM aircraft a
JOIN flights f ON a.id = f.aircraft_id  -- A -> B
JOIN crews c ON f.crew_id = c.id;       -- B -> C

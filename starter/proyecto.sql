-- =============================================================
-- week 4 SELECT statements and queries(DQL:Data Query Language)
-- =============================================================

SELECT 
    flight_code AS Codigo_vuelo,
    origin_icao AS Aeropuerto_origen,
    destination_icao AS Aeropuerto_destino,
    departure_at AS Fecha_salida
FROM flights
WHERE origin_icao = 'SKBO' AND flight_status = 'Scheduled';

SELECT 
    first_name AS Nombre,
    last_name AS Apellido,
    passport_id AS Numero_pasaporte
FROM passengers;

SELECT 
    model AS Modelo_avion,
    capacity AS Capacidad_pasajeros
FROM aircraft
ORDER BY capacity DESC;

SELECT 
    flight_code AS codigo_vuelo, 
    flight_status AS estado_vuelo
FROM flights 
WHERE flight_status = 'Delayed' OR flight_status = 'Cancelled';

SELECT 
    model AS modelo_avion, 
    capacity AS capacidad 
FROM aircraft 
WHERE capacity >= 200
ORDER BY capacity ASC
LIMIT 5
OFFSET 0; --number of rows that ignores at begining 

SELECT 
    model AS modelo_avion, 
    capacity AS capacidad
FROM aircraft 
WHERE capacity >= 200
ORDER BY capacity ASC
LIMIT 5
OFFSET 5;

SELECT 
    flight_code AS codigo_vuelo, 
    departure_at AS Fecha_salida 
FROM flights 
WHERE departure_at >= '2026-06-01 00:00' AND departure_at < '2026-07-01 00:00'
ORDER BY departure_at ASC;

SELECT 
    captain_name AS capitan, 
    copilot_name AS copiloto,
    attendants_count AS nuermo_asistentes
FROM crews 
WHERE attendants_count >= 5
ORDER BY captain_name ASC;


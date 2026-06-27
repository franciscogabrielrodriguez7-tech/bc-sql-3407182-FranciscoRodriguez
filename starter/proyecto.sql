-- =============================================================
-- week 5 OPERATORS AND FILTERS (BETWEEN, IN, LIKE, NOT, OR) 
-- =============================================================

SELECT 
    model AS modelo_avion, 
    capacity AS capacidad
FROM aircraft
WHERE aircraft_id BETWEEN 1 AND 10;

SELECT 
    model AS modelo_avion, 
    capacity AS capacidad
FROM aircraft
WHERE model IN ('Airbus A320', 'Boeing 787-8', 'Embraer E190');

SELECT 
    first_name AS nombre, 
    last_name AS apellido, 
    email
FROM passengers
WHERE email LIKE '%@gmail.com' OR email LIKE '%@email.com'
ORDER BY last_name ASC;


SELECT      --select to find the models of aircraft that have between 150 and 300 passenger capacity
    model AS modelo,
    capacity AS capacidad 
FROM aircraft
WHERE capacity BETWEEN 150 AND 300 
    AND is_active=1
ORDER BY capacity ASC;

SELECT 
    fly.flight_code AS codigo_vuelo,
    fly.origin_icao AS aeropuerto_origen,
    fly.destination_icao AS aeropuerto_destino
FROM flights AS fly
WHERE fly.destination_icao IN ('SKBO', 'SKRG', 'SKCL')
    AND fly.flight_status = 'Scheduled'
ORDER BY fly.aircraft_id ASC;


SELECT 
    first_name AS nombre, 
    last_name AS apellido, 
    email
FROM passengers
WHERE email NOT LIKE '%@gmail.com'  
ORDER BY last_name ASC;

SELECT 
    first_name AS nombre, 
    last_name AS apellido, 
    email, 
    phone_number AS telefono
FROM passengers
WHERE last_name LIKE 'Rod%'
ORDER BY first_name ASC;

-- SELECT comsposed 
SELECT 
    f.flight_code AS codigo_vuelo,
    f.origin_icao AS aeropuerto_origen,
    f.destination_icao AS aeropuerto_destino,
    f.departure_at AS fecha_salida
FROM flights AS f
WHERE f.destination_icao IN ('SKBO', 'SKRG')
    AND f.departure_at BETWEEN '2026-06-01 20:00' AND '2026-06-20 23:59'
    AND f.flight_status IN ('Scheduled', 'Delayed');

SELECT 
    f.flight_code AS codigo_vuelo, 
    f.crew_id AS tripulacion,
    f.flight_status AS estado,
    f.origin_icao AS origen,
    f.destination_icao AS destino
FROM flights AS f
WHERE (f.departure_at > 20260506153000 AND f.destination_icao = 'SKBO') --hora: 2026-05-06 15:30:00
   OR f.flight_status  = 'In-flight';


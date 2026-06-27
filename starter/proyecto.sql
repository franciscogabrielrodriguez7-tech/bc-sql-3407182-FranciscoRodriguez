-- ===============================================================
-- week 6 AGGREGATE FUNCTIONS (COUNT, SUM, AVG, MIN, MAX)
-- =============================================================

SELECT 
    COUNT(flight_code) AS total_vuelos
FROM flights;

SELECT 
    COUNT(passport_id) AS total_pasajeros
FROM passengers;

SELECT 
    COUNT(*) AS total_tripulantes
FROM crews;

SELECT 
    COUNT(is_active) AS aviones_activos
FROM aircraft
WHERE is_active = 1;

SELECT 
    avg(capacity) AS capacidad_promedio
FROM aircraft
WHERE is_active = 1;

SELECT  
    AVG(attendants_count) AS promedio_asistentes
FROM crews;

SELECT 
    SUM(capacity) AS capacidad_total
FROM aircraft
WHERE is_active = 1;

SELECT 
    SUM(attendants_count) AS total_asistentes
FROM crews;

SELECT 
    departure_at AS fecha_salida, 
    COUNT(flight_code) AS vuelos_del_dia,
    destination_icao AS destino,
    origin_icao AS origen
FROM flights
WHERE departure_at BETWEEN '2026-06-01 00:00' AND '2026-06-01 23:59'
    AND origin_icao = 'SKBO'
GROUP BY destination_icao
ORDER BY fecha_salida ASC;

SELECT 
    destination_icao AS destino,
    COUNT(flight_code) AS vuelos_del_mes,
    MIN(departure_at) AS primer_vuelo,
    MAX(departure_at) AS ultimo_vuelo
FROM flights
WHERE departure_at BETWEEN '2026-06-01 00:00' AND '2026-06-30 23:59'
    AND origin_icao = 'SKBO'
GROUP BY destination_icao
HAVING vuelos_del_mes >= 2
ORDER BY vuelos_del_mes DESC; 

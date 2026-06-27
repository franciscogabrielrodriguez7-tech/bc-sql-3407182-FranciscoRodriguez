.tables

SELECT 
    origin AS origen,
    destination AS destino,
    flight_number AS num_vuelo
FROM flights;

SELECT 
    model AS modelo,
    capacity AS capacidad
FROM aircraft
WHERE capacity > 100;

SELECT 
    name AS nombre,
    lastname AS apellido
FROM passengers
ORDER BY name asc;

SELECT COUNT(*) AS total_flights
FROM flights;

SELECT COUNT(*) AS total_passengers
FROM passengers;
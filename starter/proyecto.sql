-- ============================================================
-- Applying best practices to column names, more especific, to id
-- ============================================================
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




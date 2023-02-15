
SET SCHEMA 'bookings';

SELECT DISTINCT model as "ModelsToUfa" FROM aircrafts_data
INNER JOIN 
(SELECT aircraft_code FROM flights 
WHERE arrival_airport = (SELECT airport_code FROM airports_data 
	WHERE city @> '{"ru": "Уфа"}')) as codes 
ON aircrafts_data.aircraft_code = codes.aircraft_code;
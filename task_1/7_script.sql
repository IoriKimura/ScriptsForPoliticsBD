SET SCHEMA 'bookings';

SELECT subtable.aircraft_code, seats, flights 
FROM 
(SELECT aircraft_code, COUNT(seat_no) AS seats FROM seats GROUP BY aircraft_code) 
AS subtable 
INNER JOIN (SELECT aircraft_code, COUNT(flight_id) AS flights FROM flights GROUP BY aircraft_code) 
AS subtable1 ON subtable.aircraft_code = subtable1.aircraft_code ORDER BY seats DESC;


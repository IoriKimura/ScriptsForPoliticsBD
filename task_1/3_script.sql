SET SCHEMA 'bookings';

SELECT model as "ModelsWithMax" FROM aircrafts_data 
WHERE aircraft_code IN 
(SELECT aircraft_code FROM 
(SELECT * FROM (SELECT aircraft_code, COUNT(seat_no) FROM seats GROUP BY aircraft_code) as firstsub) 
as thirdsub WHERE count = (SELECT MAX(count) FROM (SELECT aircraft_code, COUNT(seat_no)
FROM seats GROUP BY aircraft_code) as secondsub));
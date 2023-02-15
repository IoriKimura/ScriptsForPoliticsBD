SET SCHEMA 'bookings';

SELECT ROUND(AVG(count)) as "PeopleFromPeterToMoscow"
FROM (SELECT flight_id, COUNT(ticket_no) FROM ticket_flights 
WHERE flight_id IN 
(SELECT flight_id FROM flights WHERE departure_airport IN 
(SELECT airport_code FROM airports_data WHERE city @> '{"ru": "Санкт-Петербург"}') 
AND
arrival_airport IN (SELECT airport_code FROM airports_data WHERE city @> '{"ru": "Москва"}')) 
GROUP BY flight_id) as sub;
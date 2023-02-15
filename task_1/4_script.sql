SET SCHEMA 'bookings';

SELECT flight_id FROM flights
JOIN (SELECT flight_id,count(ticket_no) AS amount_of_tickets FROM ticket_flights 
	  GROUP BY flight_id) AS flight_to_tickets USING (flight_id)
JOIN (SELECT aircraft_code, count(seat_no) AS amount_of_seats FROM seats
	  GROUP BY aircraft_code) AS aircraft_to_seats_amount USING(aircraft_code)
WHERE flight_to_tickets.tickets_amount < aircraft_to_seats_amount.seats_amount;
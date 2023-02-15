SET SCHEMA 'bookings';

SELECT passenger_name, seat_no 
FROM tickets
	INNER JOIN boarding_passes ON tickets.ticket_no = boarding_passes.ticket_no
WHERE passenger_name = (SELECT passenger_name 
						FROM tickets
						GROUP BY passenger_name 
						ORDER BY COUNT(ticket_no) DESC LIMIT 1);


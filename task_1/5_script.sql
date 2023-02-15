SET SCHEMA 'bookings';

SELECT passenger_id, total_amount FROM tickets
INNER JOIN bookings ON tickets.book_ref = bookings.book_ref;
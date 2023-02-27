SET SCHEMA 'practice2';

CREATE FUNCTION transfer_money (id_sender INTEGER, id_receiver INTEGER, t_amount NUMERIC) 
RETURNS void AS 
	'UPDATE practice2.accounts SET balance = balance - t_amount::money WHERE id = id_sender;
	UPDATE practice2.accounts SET balance = balance + t_amount::money WHERE id = id_receiver;
	INSERT INTO practice2.transactions ("id", account_id, amount) VALUES (DEFAULT, id_sender, t_amount::money);
	INSERT INTO practice2.transactions ("id", account_id, amount) VALUES (DEFAULT, id_receiver, t_amount::money);
	'
language SQL;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT transfer_money(1, 7, 3000.00);
SELECT * FROM practice2.transactions;
COMMIT;
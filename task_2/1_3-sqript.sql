--First transaction
BEGIN;
	INSERT INTO practice2.accounts ("id", "name", balance)
		VALUES(DEFAULT, 'Марк', 1000.00);
COMMIT;
--Second transaction
BEGIN;
	SELECT * FROM practice2.accounts;
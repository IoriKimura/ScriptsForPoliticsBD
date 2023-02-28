--Is is for first transaction
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

	SELECT 1;
	SELECT * FROM practice2.accounts;
	
--It is for second one
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	--DELETE FROM practice2.accounts WHERE "id" = 4;
	INSERT INTO practice2.accounts("id", "name", balance) VALUES (DEFAULT, 'Николай', 10000.00);
COMMIT;
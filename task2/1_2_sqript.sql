SET SCHEMA 'practice2';

BEGIN;
UPDATE accounts SET balance = balance + 1500.00::MONEY WHERE "id" = 2;
SELECT * FROM accounts;
COMMIT;

BEGIN;
SELECT * FROM accounts;
COMMIT;
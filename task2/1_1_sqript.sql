SET SCHEMA 'practice2';

CREATE TABLE IF NOT EXISTS practice2.accounts(
	"id" SERIAL PRIMARY KEY UNIQUE NOT NULL,
	"name" TEXT NOT NULL,
	balance MONEY NOT NULL
);

CREATE TABLE IF NOT EXISTS practice2.transactions(
	"id" SERIAL PRIMARY KEY UNIQUE NOT NULL,
	account_id INTEGER REFERENCES practice2.accounts("id"),
	ammount MONEY NOT NULL
);

INSERT INTO practice2.accounts("id", "name", balance)
	VALUES
		(DEFAULT, 'Никита', 10000.00),
		(DEFAULT, 'Артём', 9000.00),
		(DEFAULT, 'Максим', 8000.00),
		(DEFAULT, 'Виталий', 7000.00);

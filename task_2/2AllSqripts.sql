SET SCHEMA 'public';
--Добавляем расширение в новую БД
CREATE EXTENSION IF NOT EXISTS pageinspect;

--Создание таблицы users
CREATE TABLE IF NOT EXISTS public.users
(
	id SERIAL PRIMARY KEY UNIQUE NOT NULL,
	username VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	"version" INTEGER NOT NULL
)

--Создаём триггер для обновления версии строки
CREATE TRIGGER updating_version 
	BEFORE UPDATE ON users
	FOR EACH ROW 
	EXECUTE FUNCTION updating();
	
--Создание функции для триггера
CREATE FUNCTION updating() RETURNS TRIGGER AS 
$$
	BEGIN 
		NEW.version := NEW.version + 1;
		RETURN NEW;
	END;
$$ 
LANGUAGE plpgsql;

--Вставляем в users строку с данными
INSERT INTO public.users("id", username, email, "version")
VALUES (DEFAULT, 'Сергей', 'sergeyMIREA@gmail.com', 1);

--Обновляем строку, чтобы проверить, работает ли триггер
UPDATE public.users SET username = 'Sergey' WHERE "id" = 2;

--Используем запрос
SELECT '(0,'||lp||')' AS ctid, t_xmin as xmin, t_xmax as xmax,
 	CASE WHEN (t_infomask & 256) > 0 THEN 't' END AS xmin_c,
 	CASE WHEN (t_infomask & 512) > 0 THEN 't' END AS xmin_a,
 	CASE WHEN (t_infomask & 1024) > 0 THEN 't' END AS xmax_c,
 	CASE WHEN (t_infomask & 2048) > 0 THEN 't' END AS xmax_a
FROM heap_page_items(get_raw_page('users',0))
ORDER BY lp;

--TRUNCATE для users
TRUNCATE users;

--Транзакция
BEGIN;
INSERT INTO public.users("id", username, email, "version")
VALUES (DEFAULT, 'Артём', 'artemMIREA@gmail.com', 1)
RETURNING *, ctid, xmin, xmax;

SAVEPOINT savingdata;
INSERT INTO public.users("id", username, email, "version")
VALUES (DEFAULT, 'Анатолий', 'anatMIREA@gmail.com', 1)
RETURNING *, ctid, xmin, xmax;

ROLLBACK TO savingdata;
INSERT INTO public.users("id", username, email, "version")
VALUES (DEFAULT, 'Степан', 'stepanMIREA@gmail.com', 1)
RETURNING *, ctid, xmin, xmax;
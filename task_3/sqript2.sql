SET SCHEMA 'public';

--1. Посмотреть размер файла данных таблицы users
SELECT pg_size_pretty(pg_table_size('users'));

--2. Удаляем случайные строки из users
DELETE FROM users WHERE RANDOM() < 0.9;
SELECT * FROM users;

--3. Выполнить очистку
VACUUM VERBOSE;

--4. Ещё раз узнать текущий размер файла и сравнить со старым
SELECT pg_size_pretty(pg_table_size('users'));

--5. Снова зполнить таблицу и выполнить пункты 1 и 2
DO $$BEGIN
FOR count in 1..1000000 LOOP
    INSERT INTO users(username, email, category)
    VALUES ('username_' || count, 'username' || count || '@gmail.com',
            'FOO');
    END LOOP;
END; $$;
SELECT count(*) FROM users;
SELECT pg_size_pretty(pg_table_size('users'));
DELETE FROM users WHERE RANDOM() < 0.9;
SELECT count(*) FROM users;

--6. Выполните полную очистку
VACUUM FULL;

--7. Снова узнать размер файла
SELECT pg_size_pretty(pg_table_size('users'));

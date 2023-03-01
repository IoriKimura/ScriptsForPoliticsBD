--2. Создание новой таблицы users в vacuum_db
CREATE TABLE IF NOT EXISTS users (
    "id" SERIAL PRIMARY KEY UNIQUE NOT NULL,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    "category" CHAR(3) NOT NULL
) WITH (autovacuum_enabled = false);

--3. Скрипт для генирации пользователей
DO $$BEGIN
FOR count in 1..1000000 LOOP
    INSERT INTO users(username, email, category)
    VALUES ('username_' || count, 'username' || count || '@gmail.com',
            'FOO');
    END LOOP;
END; $$;

SELECT COUNT(*) FROM users;

--4. Использовать оператор Explain и вывести все записи, которые в поле category имеют foo
EXPLAIN SELECT * FROM users WHERE category = 'FOO';

--5. Выполните команду Analyze
EXPLAIN ANALYZE SELECT * FROM users WHERE category = 'FOO';

--6. Смотреть пункт 4.

--8. Временно уменьшить maintenance_work_mem до 1MB
SET MAINTENANCE_WORK_MEM TO '1MB';
SELECT pg_reload_conf();

--9. Обновить foo на bpp
UPDATE users SET category = 'BPP';

--10. Vacuum Verbose и pg_stat_progress_vacuum
VACUUM VERBOSE;
SELECT * FROM pg_stat_progress_vacuum;
SET SCHEMA 'public';

--1. Включаем в таблице автоочистку
ALTER TABLE users SET (AUTOVACUUM_ENABLED = TRUE);

--2.Настройте автоочистку на запуск при изменении 10% строк в таблице, время «сна» – одна секунда
ALTER SYSTEM SET autovacuum_naptime = '1s'; --Время сна 1сек
ALTER SYSTEM SET autovacuum_vacuum_threshold = 0;
ALTER SYSTEM SET autovacuum_vacuum_scale_factor = 0.1; --При 10%

--3. Снова 1 000 000 записей...
DO $$BEGIN
FOR count in 1..1000000 LOOP
    INSERT INTO users(username, email, category)
    VALUES ('username_' || count, 'username' || count || '@gmail.com',
            'FOO');
    END LOOP;
END; $$;
SELECT COUNT(*) FROM users;

--4. Узнать текущий размер файла
SELECT pg_size_pretty(pg_table_size('users'));

--5. Скрипт, который будет менять
CREATE PROCEDURE second_script()
LANGUAGE plpgsql
AS $$
BEGIN
    FOR count IN 1..20 LOOP
                UPDATE users
                SET email = 'was_updated'
                WHERE random() < 0.05;
            COMMIT;
            PERFORM pg_sleep(3);
    END LOOP;
END;
$$;
CALL second_script();
SELECT count(*) FROM users WHERE email = 'was_updated';

--6. Количество очисток
SELECT autovacuum_count  FROM pg_stat_all_tables WHERE relname = 'users';

--7. До и после
SELECT pg_size_pretty(pg_table_size('users'));

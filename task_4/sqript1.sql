--Задание 1.2. Создание таблицы orders
CREATE TABLE public.orders(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE ,
    customer_name VARCHAR(255) NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC NOT NULL
);

--Задание 1.3. Включить в файле конфигурации postgreSQL WAL и перезапустить сервер
SHOW config_file;

--Задание 1.4. Вставить в таблицу некоторые данные
INSERT INTO public.orders(customer_name, order_date, total_amount)
VALUES
        ('Sergey', '2023-10-10', 1000),
        ('Artem', '2023-09-09', 2000),
        ('Igor', '2023-08-08', 3000);

--Задание 1.5. Узнать сколько байт занимают сгенерированные журнальные записи
SELECT pg_current_wal_insert_lsn();
--0/C7870C18 - После того, как добавили
--0/С7873898 - После остальных изменений

--Задание 1.6. Изменить некоторые из существующих записей в таблице orders
UPDATE public.orders SET order_date = '2002-12-31' WHERE id = 1;
UPDATE public.orders SET order_date = '2002-10-31' WHERE id = 2;

--Задание 1.7. Удалить несколько записей из таблицы orders.
DELETE FROM public.orders WHERE id = 3;

--Задание 1.8. Проверить содержимое файлов журнала WAL
SELECT pg_walfile_name('0/C7870C18');

-- Задание 1.11. Повторить все те шаги по новой
INSERT INTO public.orders(customer_name, order_date, total_amount)
VALUES
        ('Sergey2', '2023-10-10', 1000),
        ('Artem2', '2023-09-09', 2000),
        ('Igor2', '2023-08-08', 3000);

SELECT pg_current_wal_insert_lsn(); --0/C7873F80

UPDATE public.orders SET order_date = '2002-12-31' WHERE id = 4;
UPDATE public.orders SET order_date = '2002-10-31' WHERE id = 5;

DELETE FROM public.orders WHERE id = 6;

SELECT pg_current_wal_insert_lsn(); --0/C7876DE8

SELECT pg_walfile_name('0/C7873F80');

SET SCHEMA 'public';

--Создаём таблицу t
CREATE TABLE IF NOT EXISTS public.t
(
	"id" INTEGER,
	"name" CHAR(2000)
)
WITH (FILLFACTOR = 75);

--Создаём индекс
CREATE INDEX t_name ON t ("name");

--Ставим расширение
CREATE EXTENSION IF NOT EXISTS pageinspect;

--Запрос
CREATE VIEW t_v AS
SELECT '(0,'||lp||')' AS ctid,
       CASE lp_flags
         WHEN 0 THEN 'unused'
         WHEN 1 THEN 'normal'
         WHEN 2 THEN 'redirect to '||lp_off
         WHEN 3 THEN 'dead'
       END AS state,
       t_xmin || CASE
         WHEN (t_infomask & 256) > 0 THEN ' (c)'
         WHEN (t_infomask & 512) > 0 THEN ' (a)'
         ELSE ''
       END AS xmin,
       t_xmax || CASE
         WHEN (t_infomask & 1024) > 0 THEN ' (c)'
         WHEN (t_infomask & 2048) > 0 THEN ' (a)'
         ELSE ''
       END AS xmax,
       CASE WHEN (t_infomask2 & 16384) > 0 THEN 't' END AS hhu,
       CASE WHEN (t_infomask2 & 32768) > 0 THEN 't' END AS hot,
       t_ctid
FROM heap_page_items(get_raw_page('t',0))
ORDER BY lp;

--Без HOT-обновлений
INSERT INTO public.t("name") VALUES('Q');
UPDATE t SET "name" = 'W';
UPDATE t SET "name" = 'E';
UPDATE t SET "name" = 'R';
UPDATE t SET "name" = 'T';

--C HOT-обновлений
DROP INDEX t_id;
CREATE INDEX t_id ON t ("id");


INSERT INTO public.t("id") VALUES(1);
UPDATE t SET "id" = 2;
UPDATE t SET "id" = 3;
UPDATE t SET "id" = 4;
UPDATE t SET "id" = 5;

SELECT * FROM heap_page_items(get_raw_page('t',0));


SELECT lower, upper, pagesize FROM page_header(get_raw_page('t',0));

SELECT * FROM t_v;
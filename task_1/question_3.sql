SET SCHEMA 'litte_lcompany';
--Английский символ
SELECT * FROM little_company.task1 WHERE "Name" LIKE 'A%';
--Русский символ
SELECT * FROM little_company.task1 WHERE "Name" LIKE 'А%';
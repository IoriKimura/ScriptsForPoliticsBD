SET SCHEMA 'litte_lcompany';
SELECT
	NULL <> 1 AS A,
	NULL <> NULL AS B,
	NULL = NULL AS C,
	NULL IS NOT NULL AS D,
	NULL IS NULL AS E;
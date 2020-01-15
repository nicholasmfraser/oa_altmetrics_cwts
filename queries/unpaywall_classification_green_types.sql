SELECT
	t1.year,
	SUM(t1.green) AS all_green,
	SUM(CASE WHEN t1.green = 1 AND t1.gold = 1 THEN 1 ELSE 0 END) AS gold_green,
	SUM(CASE WHEN t1.green = 1 AND t1.hybrid = 1 THEN 1 ELSE 0 END) AS hybrid_green,
	SUM(CASE WHEN t1.green = 1 AND t1.bronze = 1 THEN 1 ELSE 0 END) AS bronze_green,
	SUM(CASE WHEN t1.green = 1 AND (t1.gold = 1 OR t1.hybrid = 1 OR t1.bronze = 1) THEN 1 ELSE 0 END) AS journal_green,
	SUM(CASE WHEN t1.green = 1 AND t1.gold = 0 AND t1.hybrid = 0 AND t1.bronze = 0 THEN 1 ELSE 0 END) AS only_green
FROM
	userdb_frasernm.dbo.unpaywall_classification_nopmccor t1
WHERE
	t1.year < 2020
GROUP BY t1.year
SELECT
	t2.year,
	SUM(t1.closed) AS closed,
	SUM(t1.gold) + SUM(t1.hybrid) + SUM(t1.bronze) + SUM(t1.green) AS oa,
	SUM(t1.gold) AS gold,
	SUM(t1.hybrid) AS hybrid,
	SUM(t1.bronze) AS bronze,
	SUM(t1.green) AS green,
	SUM(CASE WHEN t1.green = 1 AND (t1.gold = 1 OR t1.hybrid = 1 OR t1.bronze = 1) THEN 1 ELSE 0 END) AS oa_green,
	SUM(CASE WHEN t1.green = 1 AND t1.gold = 0 AND t1.hybrid = 0 AND t1.bronze = 0 THEN 1 ELSE 0 END) AS closed_green
FROM
	userdb_frasernm.dbo.unpaywall_classification_nopmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
GROUP BY
	t2.year
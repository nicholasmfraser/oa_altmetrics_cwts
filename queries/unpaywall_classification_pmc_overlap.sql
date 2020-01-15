SELECT
	t1.year,
	SUM(t1.closed) as closed,
	SUM(t1.gold) AS gold,
	SUM(t1.hybrid) AS hybrid,
	SUM(t1.bronze) AS bronze,
	SUM(t2.green) - SUM(t1.closed) - SUM(t1.gold) - SUM(t1.hybrid) - SUM(t1.bronze) AS pmc_only
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_nopmccor t2
ON
	t1.doi = t2.doi
	AND t1.year = t2.year
WHERE
	t1.green = 0
	AND t2.green = 1
	AND t1.year < 2020
	AND t2.year < 2020
GROUP BY t1.year
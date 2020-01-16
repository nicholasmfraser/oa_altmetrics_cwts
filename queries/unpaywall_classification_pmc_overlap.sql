/* Comparing overlap of articles deposited in PMC with other OA types */
SELECT
	t1.year,
	SUM(t1.closed) as closed,
	SUM(t1.gold) AS gold,
	SUM(t1.hybrid) AS hybrid,
	SUM(t1.bronze) AS bronze
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
GROUP BY t1.year
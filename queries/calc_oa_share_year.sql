SET NOCOUNT ON;

/* Calculate the share of publications in each open access categorz */
SELECT
	t2.year,
	SUM(t1.closed) AS closed,
	COUNT(*) - SUM(t1.closed) AS [open],
	SUM(t1.gold) AS gold,
	SUM(t1.hybrid) AS hybrid,
	SUM(t1.bronze) AS bronze,
	SUM(t1.green) AS green
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
GROUP BY
	t2.year;
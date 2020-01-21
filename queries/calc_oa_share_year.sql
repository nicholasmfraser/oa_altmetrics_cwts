SET NOCOUNT ON;

/* Calculate the share of publications that are open versus closed */
SELECT
	t2.year,
	SUM(t1.closed) AS closed,
	COUNT(*) - SUM(t1.closed) AS oa
FROM
	userdb_frasernm.dbo.unpaywall_classification_nopmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
GROUP BY
	t2.year;
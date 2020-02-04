SET NOCOUNT ON;

/* Calculate the time difference between an article being published
and being shared on facebook, grouped by OA vs non-OA articles (2017 only) */
SELECT
	CASE WHEN t1.closed = 1 THEN 'closed' ELSE 'open' END AS type,
	DATEDIFF(dd, t3.citation_pubdate, t4.posted_on) as timediff,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
INNER JOIN
	altmetric_2017oct.dbo.main t3
ON
	t1.doi = t3.citation_doi
INNER JOIN
	altmetric_2017oct.dbo.wikipedia t4
ON
	t3.altmetric_id = t4.altmetric_id
WHERE
	YEAR(t3.citation_pubdate) = 2016
GROUP BY
	DATEDIFF(dd, t3.citation_pubdate, t4.posted_on), t1.closed;
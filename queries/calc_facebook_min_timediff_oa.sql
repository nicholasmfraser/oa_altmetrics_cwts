SET NOCOUNT ON;

/* Calculate the mean time difference between an article being published
and receiving its first mention on Facebook, grouped by OA vs non-OA articles (2016 only) */
SELECT DISTINCT
	s1.type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s1.min_timediff) OVER (PARTITION BY s1.type) AS median_min_timediff
FROM (
	SELECT
		t1.doi,
		CASE WHEN t1.closed = 1 THEN 'closed' ELSE 'open' END AS type,
		MIN(DATEDIFF(dd, t3.citation_pubdate, t4.posted_on)) AS min_timediff
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
		altmetric_2017oct.dbo.facebook t4
	ON
		t3.altmetric_id = t4.altmetric_id
	WHERE
		YEAR(t3.citation_pubdate) = 2016
	GROUP BY
		t1.doi, t1.closed) AS s1;
SET NOCOUNT ON;

/* Calculate the median time difference between an article being published
and receiving its first blog mention, grouped by all different access types */
SELECT DISTINCT
	s1.type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s1.min_timediff) OVER (PARTITION BY s1.type) AS median_min_timediff
FROM (
	SELECT
		t1.doi,
		'closed' AS type,
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
		altmetric_2017oct.dbo.blog t4
	ON
		t3.altmetric_id = t4.altmetric_id
	WHERE
		YEAR(t3.citation_pubdate) = 2016
		AND t4.posted_on IS NOT NULL
		AND t1.closed = 1
	GROUP BY
		t1.doi) AS s1
UNION ALL
SELECT DISTINCT
	s1.type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s1.min_timediff) OVER (PARTITION BY s1.type) AS median_min_timediff
FROM (
	SELECT
		t1.doi,
		'gold' AS type,
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
		altmetric_2017oct.dbo.blog t4
	ON
		t3.altmetric_id = t4.altmetric_id
	WHERE
		YEAR(t3.citation_pubdate) = 2016
		AND t4.posted_on IS NOT NULL
		AND t1.gold = 1
	GROUP BY
		t1.doi) AS s1
UNION ALL
SELECT DISTINCT
	s1.type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s1.min_timediff) OVER (PARTITION BY s1.type) AS median_min_timediff
FROM (
	SELECT
		t1.doi,
		'hybrid' AS type,
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
		altmetric_2017oct.dbo.blog t4
	ON
		t3.altmetric_id = t4.altmetric_id
	WHERE
		YEAR(t3.citation_pubdate) = 2016
		AND t4.posted_on IS NOT NULL
		AND t1.hybrid = 1
	GROUP BY
		t1.doi) AS s1
UNION ALL
SELECT DISTINCT
	s1.type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s1.min_timediff) OVER (PARTITION BY s1.type) AS median_min_timediff
FROM (
	SELECT
		t1.doi,
		'bronze' AS type,
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
		altmetric_2017oct.dbo.blog t4
	ON
		t3.altmetric_id = t4.altmetric_id
	WHERE
		YEAR(t3.citation_pubdate) = 2016
		AND t4.posted_on IS NOT NULL
		AND t1.bronze = 1
	GROUP BY
		t1.doi) AS s1
UNION ALL
SELECT DISTINCT
	s1.type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s1.min_timediff) OVER (PARTITION BY s1.type) AS median_min_timediff
FROM (
	SELECT
		t1.doi,
		'green' AS type,
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
		altmetric_2017oct.dbo.blog t4
	ON
		t3.altmetric_id = t4.altmetric_id
	WHERE
		YEAR(t3.citation_pubdate) = 2016
		AND t4.posted_on IS NOT NULL
		AND t1.green = 1
	GROUP BY
		t1.doi) AS s1;

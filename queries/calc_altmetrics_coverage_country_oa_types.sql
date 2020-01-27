SET NOCOUNT ON;

/* Calculate coverage of each altmetric indicator for each country and access type (closed, gold, hybrid, bronze, green) */
SELECT
	t4.country AS country,
	'closed' AS type,
	COUNT(*) AS items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS blogs,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS policies,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS wikipedia
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t3
ON
	t2.doi = t3.doi
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t4
ON
	t2.ut = t4.ut
WHERE
	t1.closed = 1
GROUP BY
	t4.country
UNION ALL
SELECT
	t4.country AS country,
	'gold' AS type,
	COUNT(*) AS items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS blogs,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS policies,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS wikipedia
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t3
ON
	t2.doi = t3.doi
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t4
ON
	t2.ut = t4.ut
WHERE
	t1.gold = 1
GROUP BY
	t4.country
UNION ALL
SELECT
	t4.country AS country,
	'hybrid' AS type,
	COUNT(*) AS items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS blogs,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS policies,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS wikipedia
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t3
ON
	t2.doi = t3.doi
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t4
ON
	t2.ut = t4.ut
WHERE
	t1.hybrid = 1
GROUP BY
	t4.country
UNION ALL
SELECT
	t4.country AS country,
	'bronze' AS type,
	COUNT(*) AS items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS blogs,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS policies,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS wikipedia
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t3
ON
	t2.doi = t3.doi
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t4
ON
	t2.ut = t4.ut
WHERE
	t1.bronze = 1
GROUP BY
	t4.country
UNION ALL
SELECT
	t4.country AS country,
	'green' AS type,
	COUNT(*) AS items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS blogs,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS policies,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS wikipedia
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor t1
INNER JOIN
	userdb_frasernm.dbo.wos_items t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t3
ON
	t2.doi = t3.doi
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t4
ON
	t2.ut = t4.ut
WHERE
	t1.green = 1
GROUP BY
	t4.country;
SET NOCOUNT ON;

/* Calculate number of items mentioned in each altmetric source, for each access type (closed, gold, hybrid, bronze, green) */
SELECT
	t2.year,
	'closed' AS type,
	COUNT(*) AS n_items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS n_blog,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS n_facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS n_news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS n_policy,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS n_twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS n_wikipedia
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
WHERE
	t1.closed = 1
GROUP BY t2.year
UNION ALL
SELECT
	t2.year,
	'gold' AS type,
	COUNT(*) AS n_items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS n_blog,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS n_facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS n_news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS n_policy,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS n_twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS n_wikipedia
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
WHERE
	t1.gold = 1
GROUP BY t2.year
UNION ALL
SELECT
	t2.year,
	'hybrid' AS type,
	COUNT(*) AS n_items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS n_blog,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS n_facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS n_news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS n_policy,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS n_twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS n_wikipedia
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
WHERE
	t1.hybrid = 1
GROUP BY t2.year
UNION ALL
SELECT
	t2.year,
	'bronze' AS type,
	COUNT(*) AS n_items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS n_blog,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS n_facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS n_news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS n_policy,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS n_twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS n_wikipedia
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
WHERE
	t1.bronze = 1
GROUP BY t2.year
UNION ALL
SELECT
	t2.year,
	'green' AS type,
	COUNT(*) AS n_items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 END) AS n_blog,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 END) AS n_facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 END) AS n_news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 END) AS n_policy,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 END) AS n_twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 END) AS n_wikipedia
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
WHERE
	t1.green = 1
GROUP BY t2.year;
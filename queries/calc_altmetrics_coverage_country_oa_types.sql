SET NOCOUNT ON;

/* Calculate coverage of each altmetric indicator in each subject classification */
SELECT
	t4.country AS country,
	'closed' AS type,
	CAST(SUM(t4.country_weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS wikipedia
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
	CAST(SUM(t4.country_weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS wikipedia
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
	CAST(SUM(t4.country_weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS wikipedia
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
	CAST(SUM(t4.country_weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS wikipedia
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
	CAST(SUM(t4.country_weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 * t4.country_weight END) AS DECIMAL) AS wikipedia
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
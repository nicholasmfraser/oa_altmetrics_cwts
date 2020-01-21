SET NOCOUNT ON;

/* Measure overall coverage of each altmetric indicator per year */
SELECT
	t1.year,
	CAST(SUM(CASE WHEN t2.count_blog = 0 THEN 0 ELSE 1 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS coverage_blog,
	CAST(SUM(CASE WHEN t2.count_facebook = 0 THEN 0 ELSE 1 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS coverage_facebook,
	CAST(SUM(CASE WHEN t2.count_news = 0 THEN 0 ELSE 1 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS coverage_news,
	CAST(SUM(CASE WHEN t2.count_policy = 0 THEN 0 ELSE 1 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS coverage_policy,
	CAST(SUM(CASE WHEN t2.count_twitter = 0 THEN 0 ELSE 1 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS coverage_twitter,
	CAST(SUM(CASE WHEN t2.count_wikipedia = 0 THEN 0 ELSE 1 END) AS DECIMAL) / CAST(COUNT(*) AS DECIMAL) AS coverage_wikipedia
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year;
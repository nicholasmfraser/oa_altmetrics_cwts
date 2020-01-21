SET NOCOUNT ON;

/* Calculate coverage of each altmetric indicator in OA versus non-OA publications */
SELECT
	t2.year,
	CASE WHEN t1.closed = 1 THEN 'closed' ELSE 'open' END AS type,
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
GROUP BY
	t2.year, t1.closed
ORDER BY 
	t2.year, t1.closed;

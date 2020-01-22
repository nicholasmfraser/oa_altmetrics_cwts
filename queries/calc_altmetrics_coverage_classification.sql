SET NOCOUNT ON;

/* Calculate coverage of each altmetric indicator in each subject classification */
SELECT
	t4.LR_main_field AS classification,
	CAST(SUM(t4.weight) AS DECIMAL) AS items,
	SUM(CASE WHEN t3.count_blog = 0 THEN 0 ELSE 1 * t4.weight END) AS blogs,
	SUM(CASE WHEN t3.count_facebook = 0 THEN 0 ELSE 1 * t4.weight END) AS facebook,
	SUM(CASE WHEN t3.count_news = 0 THEN 0 ELSE 1 * t4.weight END) AS news,
	SUM(CASE WHEN t3.count_policy = 0 THEN 0 ELSE 1 * t4.weight END) AS policies,
	SUM(CASE WHEN t3.count_twitter = 0 THEN 0 ELSE 1 * t4.weight END) AS twitter,
	SUM(CASE WHEN t3.count_wikipedia = 0 THEN 0 ELSE 1 * t4.weight END) AS wikipedia
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
	userdb_frasernm.dbo.wos_classification t4
ON
	t2.ut = t4.ut
GROUP BY
	t4.LR_main_field, t1.closed
ORDER BY 
	t4.LR_main_field, t1.closed;

SET NOCOUNT ON;

/* Calculate coverage of each altmetric indicator in each subject classification */
SELECT
	t3.LR_main_field AS classification,
	CAST(SUM(t3.weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t2.count_blog = 0 THEN 0 ELSE 1 * t3.weight END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t2.count_facebook = 0 THEN 0 ELSE 1 * t3.weight END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t2.count_news = 0 THEN 0 ELSE 1 * t3.weight END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t2.count_policy = 0 THEN 0 ELSE 1 * t3.weight END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t2.count_twitter = 0 THEN 0 ELSE 1 * t3.weight END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t2.count_wikipedia = 0 THEN 0 ELSE 1 * t3.weight END) AS DECIMAL) AS wikipedia
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.wos_classification t3
ON
	t1.ut = t3.ut
GROUP BY
	t3.LR_main_field
ORDER BY 
	t3.LR_main_field;

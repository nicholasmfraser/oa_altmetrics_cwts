SET NOCOUNT ON;

/* Calculate coverage of each altmetric indicator in each subject classification */
SELECT
	t3.country AS country,
	CAST(SUM(t3.country_weight) AS DECIMAL) AS items,
	CAST(SUM(CASE WHEN t2.count_blog = 0 THEN 0 ELSE 1 END) AS DECIMAL) AS blogs,
	CAST(SUM(CASE WHEN t2.count_facebook = 0 THEN 0 ELSE 1 END) AS DECIMAL) AS facebook,
	CAST(SUM(CASE WHEN t2.count_news = 0 THEN 0 ELSE 1 END) AS DECIMAL) AS news,
	CAST(SUM(CASE WHEN t2.count_policy = 0 THEN 0 ELSE 1 END) AS DECIMAL) AS policies,
	CAST(SUM(CASE WHEN t2.count_twitter = 0 THEN 0 ELSE 1 END) AS DECIMAL) AS twitter,
	CAST(SUM(CASE WHEN t2.count_wikipedia = 0 THEN 0 ELSE 1  END) AS DECIMAL) AS wikipedia,
	CAST(SUM(CASE WHEN t2.count_blog = 0 THEN 0 ELSE 1 * t3.country_weight END) AS DECIMAL) AS blogs_weighted,
	CAST(SUM(CASE WHEN t2.count_facebook = 0 THEN 0 ELSE 1 * t3.country_weight END) AS DECIMAL) AS facebook_weighted,
	CAST(SUM(CASE WHEN t2.count_news = 0 THEN 0 ELSE 1 * t3.country_weight END) AS DECIMAL) AS news_weighted,
	CAST(SUM(CASE WHEN t2.count_policy = 0 THEN 0 ELSE 1 * t3.country_weight END) AS DECIMAL) AS policies_weighted,
	CAST(SUM(CASE WHEN t2.count_twitter = 0 THEN 0 ELSE 1 * t3.country_weight END) AS DECIMAL) AS twitter_weighted,
	CAST(SUM(CASE WHEN t2.count_wikipedia = 0 THEN 0 ELSE 1 * t3.country_weight END) AS DECIMAL) AS wikipedia_weighted
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t3
ON
	t1.ut = t3.ut
GROUP BY
	t3.country
ORDER BY 
	t3.country;

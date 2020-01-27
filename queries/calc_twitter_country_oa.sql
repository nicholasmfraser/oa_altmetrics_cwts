SET NOCOUNT ON;

SELECT
	t4.country as author_country,
	CASE WHEN t5.closed = 1 THEN 'closed' ELSE 'open' END AS type,
	t3.country_code AS tweeter_country,
	SUM(t3.user_count) AS tweets
FROM
	userdb_frasernm.dbo.wos_items t1
LEFT JOIN
	altmetric_2019oct.dbo.pub_citation t2
ON
	t1.doi = t2.doi
LEFT JOIN
	altmetric_2019oct.dbo.pub_demographics_geo_twitter t3
ON
	t2.record_id = t3.record_id
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t4
ON
	t1.ut = t4.ut
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_pmccor t5
ON
	t1.doi = t5.doi
WHERE
	t3.country_code IS NOT NULL
GROUP BY
	t4.country, t5.closed, t3.country_code;
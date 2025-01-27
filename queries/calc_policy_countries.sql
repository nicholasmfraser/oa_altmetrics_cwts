SET NOCOUNT ON;

SELECT 
	t2.country AS author_country,
	t5.source_geo_country AS policy_country,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.wos_first_author_countries t2
ON
	t1.ut = t2.ut
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t3
ON
	t1.doi = t3.doi
INNER JOIN
	altmetric_2019oct.dbo.pub_citation t4
ON
	t3.doi = t4.doi
INNER JOIN
	altmetric_2019oct.dbo.pub_post_policy t5
ON
	t4.record_id = t5.record_id
WHERE
	t3.count_policy > 1
GROUP BY
	t2.country,
	t5.source_geo_country
ORDER BY
	COUNT(*) DESC;
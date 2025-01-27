SET NOCOUNT ON;

SELECT 
	t2.country AS author_country,
	t5.source_geo_country AS policy_country,
	COUNT(*) AS n_items,
	'closed' AS type
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
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_pmccor t6
ON
	t3.doi = t6.doi
WHERE
	t3.count_policy > 1
	AND t6.closed = 1
GROUP BY
	t2.country,
	t5.source_geo_country
UNION ALL
SELECT 
	t2.country AS author_country,
	t5.source_geo_country AS policy_country,
	COUNT(*) AS n_items,
	'golg' AS type
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
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_pmccor t6
ON
	t3.doi = t6.doi
WHERE
	t3.count_policy > 1
	AND t6.gold = 1
GROUP BY
	t2.country,
	t5.source_geo_country
UNION ALL
SELECT 
	t2.country AS author_country,
	t5.source_geo_country AS policy_country,
	COUNT(*) AS n_items,
	'hybrid' AS type
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
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_pmccor t6
ON
	t3.doi = t6.doi
WHERE
	t3.count_policy > 1
	AND t6.hybrid = 1
GROUP BY
	t2.country,
	t5.source_geo_country
UNION ALL
SELECT 
	t2.country AS author_country,
	t5.source_geo_country AS policy_country,
	COUNT(*) AS n_items,
	'bronze' AS type
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
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_pmccor t6
ON
	t3.doi = t6.doi
WHERE
	t3.count_policy > 1
	AND t6.bronze = 1
GROUP BY
	t2.country,
	t5.source_geo_country
UNION ALL
SELECT 
	t2.country AS author_country,
	t5.source_geo_country AS policy_country,
	COUNT(*) AS n_items,
	'green' AS type
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
INNER JOIN
	userdb_frasernm.dbo.unpaywall_classification_pmccor t6
ON
	t3.doi = t6.doi
WHERE
	t3.count_policy > 1
	AND t6.green = 1
GROUP BY
	t2.country,
	t5.source_geo_country;
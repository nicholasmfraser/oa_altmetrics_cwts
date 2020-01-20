SET NOCOUNT ON;

/* Blogs */
SELECT
	t1.year,
	'blog' AS indicator,
	count_blog as counts,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year, count_blog
UNION ALL
/* Facebook */
SELECT
	t1.year,
	'facebook' AS indicator,
	count_facebook as counts,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year, count_facebook
UNION ALL
/* News */
SELECT
	t1.year,
	'news' AS indicator,
	count_news as counts,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year, count_news
UNION ALL
/* Policy */
SELECT
	t1.year,
	'policy' AS indicator,
	count_policy as counts,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year, count_policy
UNION ALL
/* Twitter */
SELECT
	t1.year,
	'twitter' AS indicator,
	count_twitter as counts,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year, count_twitter
UNION ALL
/* Wikipedia */
SELECT
	t1.year,
	'wikipedia' AS indicator,
	count_wikipedia as counts,
	COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	userdb_frasernm.dbo.altmetric_counts t2
ON
	t1.doi = t2.doi
GROUP BY t1.year, count_wikipedia;
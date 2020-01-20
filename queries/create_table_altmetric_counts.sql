/* Drop table if it already exists */
DROP TABLE userdb_frasernm.dbo.altmetric_counts;

/* Create new table */
SELECT
	t1.doi,
	/* For all count data, we assume that if the article is not present in altmetric.com then the count is zero */
	CASE WHEN t3.blog IS NULL THEN 0 ELSE t3.blog END AS count_blog,
	CASE WHEN t3.facebook IS NULL THEN 0 ELSE t3.facebook END AS count_facebook,
	CASE WHEN t3.news IS NULL THEN 0 ELSE t3.news END AS count_news,
	CASE WHEN t3.policy IS NULL THEN 0 ELSE t3.policy END AS count_policy,
	CASE WHEN t3.twitter IS NULL THEN 0 ELSE t3.twitter END AS count_twitter,
	CASE WHEN t3.wikipedia IS NULL THEN 0 ELSE t3.wikipedia END AS count_wikipedia
INTO
	userdb_frasernm.dbo.altmetric_counts
FROM
	userdb_frasernm.dbo.wos_items t1
LEFT JOIN
	altmetric_2019oct.dbo.pub_citation t2
ON
	t1.doi = t2.doi
LEFT JOIN
	altmetric_2019oct.dbo.pub_counts t3
ON
	t2.record_id = t3.record_id;

/* Create index on DOI column */
CREATE INDEX idx_altmetric_counts_doi ON userdb_frasernm.dbo.altmetric_counts(doi);
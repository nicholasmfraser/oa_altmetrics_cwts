/* Drop table if it alreadz exists */
DROP TABLE userdb_frasernm.dbo.unpaywall_classification_nopmccor;

SELECT
	s1.doi, s1.year, s1.genre, s1.oa_status AS unpaywall_oa_status,
	/* Here we use OA location evidence to 'classify' OA types. 
	If an article conforms to rules for an OA type it receives the value '1', if not it receives the value '0' */
	MAX(CASE WHEN s1.is_oa = 'false' THEN 1 ELSE 0 END) AS closed,
	MAX(CASE WHEN s1.journal_is_oa  = 'true' THEN 1 ELSE 0 END) AS gold,
	MAX(CASE WHEN s1.journal_is_oa  = 'false' AND s1.host_type = 'publisher' AND s1.license IS NOT NULL THEN 1 ELSE 0 END) hybrid,
	MAX(CASE WHEN s1.journal_is_oa  = 'false' AND s1.host_type = 'publisher' AND s1.license IS NULL THEN 1 ELSE 0 END) bronze,
	MAX(CASE WHEN s1.host_type = 'repository' THEN 1 ELSE 0 END) green
INTO userdb_frasernm.dbo.unpaywall_classification_nopmccor
FROM (
	SELECT
		t1.doi, t1.year, t1.genre, t1.oa_status, t1.is_oa, t1.journal_is_oa, 
		t2.host_type, t2.license, t2.evidence
	FROM
		unpaywall_2019apr_json.dbo.pub t1
	LEFT JOIN
		unpaywall_2019apr_json.dbo.pub_oa_location t2
	ON
		t1.record_id = t2.record_id
	WHERE
		t1.year >= 2010 /* limit articles to publication years between 2010 and 2019 */
		AND t1.year <= 2019) AS s1
GROUP BY s1.doi, s1.year, s1.genre, s1.oa_status;

/* Create index on DOI column */
CREATE INDEX idx_unpaywall_classification_nopmccor_doi ON userdb_frasernm.dbo.unpaywall_classification_nopmccor(doi);
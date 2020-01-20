/* Drop table if it already exists */
DROP TABLE userdb_frasernm.dbo.unpaywall_classification_pmccor;

/* Create new table */
SELECT
	s2.doi, s2.year, s2.genre, s2.unpaywall_oa_status,
	s2.closed, s2.gold, s2.hybrid, s2.bronze,
	/* Correcting Green OA for PMC inclusion */
	CASE WHEN s2.repository = 1 AND s2.pmc = 0 THEN 1
	     WHEN s2.repository = 1 AND s2.pmc = 1 AND s2.gold = 0 AND s2.hybrid = 0 AND s2.bronze = 0 THEN 1 ELSE 0 END AS green
INTO userdb_frasernm.dbo.unpaywall_classification_pmccor
FROM (
	SELECT
		s1.doi, s1.year, s1.genre, s1.oa_status AS unpaywall_oa_status,
		/* Here we use OA location evidence to 'classify' OA types. 
		If an article conforms to rules for an OA type it receives the value '1', if not it receives the value '0' */
		MAX(CASE WHEN s1.is_oa = 'false' THEN 1 ELSE 0 END) AS closed,
		MAX(CASE WHEN s1.journal_is_oa  = 'true' THEN 1 ELSE 0 END) AS gold,
		MAX(CASE WHEN s1.journal_is_oa  = 'false' AND s1.host_type = 'publisher' AND s1.license IS NOT NULL THEN 1 ELSE 0 END) hybrid,
		MAX(CASE WHEN s1.journal_is_oa  = 'false' AND s1.host_type = 'publisher' AND s1.license IS NULL THEN 1 ELSE 0 END) bronze,
		MAX(CASE WHEN s1.host_type = 'repository' THEN 1 ELSE 0 END) repository,
		/* We also include whether the article is found via PMCID lookup, for correcting for the inclusion of PMC articles in Green OA */
		MAX(CASE WHEN s1.evidence = 'oa repository (via pmcid lookup)' THEN 1 ELSE 0 END) pmc
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
	GROUP BY s1.doi, s1.year, s1.genre, s1.oa_status) AS s2;

/* Create index on DOI column */
CREATE INDEX idx_unpaywall_classification_pmccor_doi ON userdb_frasernm.dbo.unpaywall_classification_pmccor(doi);
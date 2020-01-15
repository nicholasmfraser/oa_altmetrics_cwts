SELECT
	upw2.doi, upw2.year, upw2.genre, upw2.unpaywall_oa_status,
	upw2.closed, upw2.gold, upw2.hybrid, upw2.bronze,
	CASE WHEN upw2.repository = 1 AND upw2.pmc = 0 THEN 1
	     WHEN upw2.repository = 1 AND upw2.pmc = 1 AND upw2.gold = 0 AND upw2.hybrid = 0 AND upw2.bronze = 0 THEN 1
		 ELSE 0 END AS green
INTO dbo.unpaywall_classification_pmccor
FROM (
SELECT
	upw1.doi, upw1.year, upw1.genre, upw1.oa_status AS unpaywall_oa_status,
	MAX(CASE WHEN upw1.is_oa = 'false' THEN 1 ELSE 0 END) AS closed,
	MAX(CASE WHEN upw1.journal_is_oa  = 'true' THEN 1 ELSE 0 END) AS gold,
	MAX(CASE WHEN upw1.journal_is_oa  = 'false' AND upw1.host_type = 'publisher' AND upw1.license IS NOT NULL THEN 1 ELSE 0 END) hybrid,
	MAX(CASE WHEN upw1.journal_is_oa  = 'false' AND upw1.host_type = 'publisher' AND upw1.license IS NULL THEN 1 ELSE 0 END) bronze,
	MAX(CASE WHEN upw1.host_type = 'repository' THEN 1 ELSE 0 END) repository,
	MAX(CASE WHEN upw1.evidence = 'oa repository (via pmcid lookup)' THEN 1 ELSE 0 END) pmc
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
	t1.year >= 2010) AS upw1
GROUP BY upw1.doi, upw1.year, upw1.genre, upw1.oa_status) AS upw2
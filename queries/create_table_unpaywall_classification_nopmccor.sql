SELECT
	upw1.doi, upw1.year, upw1.genre, upw1.oa_status AS unpaywall_oa_status,
	MAX(CASE WHEN upw1.is_oa = 'false' THEN 1 ELSE 0 END) AS closed,
	MAX(CASE WHEN upw1.journal_is_oa  = 'true' THEN 1 ELSE 0 END) AS gold,
	MAX(CASE WHEN upw1.journal_is_oa  = 'false' AND upw1.host_type = 'publisher' AND upw1.license IS NOT NULL THEN 1 ELSE 0 END) hybrid,
	MAX(CASE WHEN upw1.journal_is_oa  = 'false' AND upw1.host_type = 'publisher' AND upw1.license IS NULL THEN 1 ELSE 0 END) bronze,
	MAX(CASE WHEN upw1.host_type = 'repository' THEN 1 ELSE 0 END) green
INTO dbo.unpaywall_classification_nopmccor
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
GROUP BY upw1.doi, upw1.year, upw1.genre, upw1.oa_status
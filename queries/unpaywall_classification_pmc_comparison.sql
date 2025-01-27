/* Comparing Green OA shares per year when including PMC and excluding PMC articles */
SELECT
	year,
	1 AS pmc_corrected,
	SUM(green) AS green
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor
GROUP BY year
UNION ALL
SELECT
	year,
	0 AS pmc_corrected,
	SUM(green) AS green
FROM
	userdb_frasernm.dbo.unpaywall_classification_nopmccor
GROUP BY year
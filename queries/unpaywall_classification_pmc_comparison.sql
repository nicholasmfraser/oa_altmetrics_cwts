SELECT
	year,
	'true' AS pmc_corrected,
	SUM(closed) AS closed,
	SUM(gold) AS gold,
	SUM(hybrid) AS hybrid,
	SUM(bronze) AS bronze,
	SUM(green) AS green
FROM
	userdb_frasernm.dbo.unpaywall_classification_pmccor
WHERE
	year < 2020
GROUP BY year
UNION ALL
SELECT
	year,
	'false' AS pmc_corrected,
	SUM(closed) AS closed,
	SUM(gold) AS gold,
	SUM(hybrid) AS hybrid,
	SUM(bronze) AS bronze,
	SUM(green) AS green
FROM
	userdb_frasernm.dbo.unpaywall_classification_nopmccor
WHERE
	year < 2020
GROUP BY year
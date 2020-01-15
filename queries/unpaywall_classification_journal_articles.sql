SELECT
	year,
	SUM(closed) AS closed,
	SUM(gold) + SUM(hybrid) + SUM(bronze) + SUM(green) AS oa,
	SUM(gold) AS gold,
	SUM(hybrid) AS hybrid,
	SUM(bronze) AS bronze,
	SUM(green) AS all_green,
	SUM(CASE WHEN green = 1 AND (gold = 1 OR hybrid = 1 OR bronze = 1) THEN 1 ELSE 0 END) AS journal_green,
	SUM(CASE WHEN green = 1 AND gold = 0 AND hybrid = 0 AND bronze = 0 THEN 1 ELSE 0 END) AS only_green
FROM
	userdb_frasernm.dbo.unpaywall_classification_nopmccor
WHERE
	year < 2020
	AND genre = 'journal-article'
GROUP BY
	year
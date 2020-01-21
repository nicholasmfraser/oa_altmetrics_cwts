SET NOCOUNT ON;

/* Calculate the share of publications that are in type of green OA */
SELECT
	s1.year,
	SUM(s1.all_green) AS all_green,
	SUM(s1.journal_green) AS journal_green,
	SUM(s1.no_journal_green) AS no_journal_green,
	SUM(s1.pmc_green) AS pmc_green,
	SUM(s1.no_pmc_green) AS no_pmc_green
FROM (
	SELECT
		t3.year,
		t1.doi,
		t2.green AS all_green,
		CASE WHEN t2.green = 1 AND (t1.gold = 1 OR t1.hybrid = 1 OR t1.bronze = 1) THEN 1 ELSE 0 END AS journal_green,
		CASE WHEN t2.green = 1 AND t1.gold = 0 AND t1.hybrid = 0 AND t1.bronze = 0 THEN 1 ELSE 0 END AS no_journal_green,
		CASE WHEN t1.green = 0 AND t2.green = 1 THEN 1 ELSE 0 END AS pmc_green,
		CASE WHEN t1.green = 1 AND t2.green = 1 THEN 1 ELSE 0 END AS no_pmc_green
	FROM
		userdb_frasernm.dbo.unpaywall_classification_pmccor t1
	INNER JOIN
		userdb_frasernm.dbo.unpaywall_classification_nopmccor t2
	ON
		t1.doi = t2.doi
		AND t1.year = t2.year
	INNER JOIN
		userdb_frasernm.dbo.wos_items t3
	ON
		t1.doi = t3.doi) AS s1
GROUP BY s1.year;
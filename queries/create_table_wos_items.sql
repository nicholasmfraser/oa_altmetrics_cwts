/* Drop table if exists already */
DROP TABLE userdb_frasernm.dbo.wos_items;

/* Create new table */
SELECT
	t1.ut, LOWER(t1.doi) AS doi, t1.pub_year as year, n_authors, n_institutes, n_countries, t2.source, t2.doc_type
INTO
	userdb_frasernm.dbo.wos_items
FROM
	woskb.dbo.cwts_ut t1
INNER JOIN
	woskb.dbo.cwts_pub_details t2
ON
	t1.ut = t2.ut
WHERE
	t1.doi IS NOT NULL /* ignore articles without DOIs - cannot be matched to Unpaywall */
	AND t1.DOI NOT LIKE '%,%' /* small number of articles contain commas in DOIs - do not include (issues with .csv export) */
	AND t1.pub_year BETWEEN 2012 AND 2018 /* limit to articles published between 2012 and 2018 */
	AND t2.doc_type IN ('Article', 'Review') /* limit to article and review documents */

/* Create indexes on UT and DOI columns */
CREATE INDEX idx_wos_items_ut ON userdb_frasernm.dbo.wos_items(ut);
CREATE INDEX idx_wos_items_doi ON userdb_frasernm.dbo.wos_items(doi);
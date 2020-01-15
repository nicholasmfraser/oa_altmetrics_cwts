/* Drop table if exists already */
DROP TABLE userdb_frasernm.dbo.wos_items;

/* Create new table */
SELECT
	LOWER(t3.AR) AS doi, /* convert doi to lowercase */
	t2.PY AS year,
	CASE WHEN DT_NO = 1 THEN 'ar' ELSE 're' END AS doctype
INTO
	userdb_frasernm.dbo.wos_items
FROM
	wosdb.dbo.UT t1
INNER JOIN
	wosdb.dbo.UI t2
ON
	t1.UI = t2.UI
	AND t2.PY >= 2012 /* limit to wos publication years 2012-2018 */
	AND t2.PY <= 2018 
	AND t2.PT = 'J' /* limit to articles published in journals */
	AND t1.DT_NO IN (1, 5) /* DT_NO 1 and 5 correspond to 'Article' and 'Review' doctypes respectively */
INNER JOIN
	wosdb.dbo.AR t3
ON
	t1.UT = t3.UT
	AND AR_TYPE = 'DOI'; /* only return articles that have an associated DOI */

/* Create index on DOI column */
CREATE INDEX idx_wos_items_doi ON userdb_frasernm.dbo.wos_items(doi);
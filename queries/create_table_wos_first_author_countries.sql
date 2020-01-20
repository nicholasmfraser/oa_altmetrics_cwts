/* Drop table if exists already */
DROP TABLE userdb_frasernm.dbo.wos_first_author_countries;

/* Create new table */
SELECT
	s1.ut, 
	s1.country,
	/* Calculate weight of country, e.g. for authors belonging to two countries, each has a weight of 0.5 */
	1/CAST(COUNT(s1.country) OVER(PARTITION BY ut) AS FLOAT) AS country_weight
INTO
	userdb_frasernm.dbo.wos_first_author_countries
FROM (
	SELECT DISTINCT
		t1.ut, 
		t4.country_iso_alpha2_code as country
	FROM
		userdb_frasernm.dbo.wos_items t1
	INNER JOIN
		wosaddr1913.dbo.pub_author_affiliation t2
	ON
		t1.ut = t2.ut
	INNER JOIN
		wosaddr1913.dbo.pub_affiliation t3
	ON
		t2.ut = t3.ut
		AND t2.aff_count = t3.aff_count
	INNER JOIN
		wosaddr1913.dbo.country t4
	ON
		t3.country_iso_num_code = t4.country_iso_num_code
	WHERE
		t2.au_count = 1
		AND t4.country_iso_alpha2_code IS NOT NULL /* Limit to first authors */
	) AS s1; 

/* Create index on UT  column */
CREATE INDEX idx_wos_first_author_countries_ut ON userdb_frasernm.dbo.wos_first_author_countries(ut);
SET NOCOUNT ON; 

/* Count the number of articles included by country for our WOS sample */
SELECT
	country, COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_first_author_countries
GROUP BY
	country;
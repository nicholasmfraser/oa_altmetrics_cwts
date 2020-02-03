SET NOCOUNT ON; 

/* Count the number of articles included by year for our WOS sample */
SELECT
	year, COUNT(*) AS n_items
FROM
	userdb_frasernm.dbo.wos_items
GROUP BY
	year;
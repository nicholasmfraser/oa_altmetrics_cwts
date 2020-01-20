SET NOCOUNT ON; 

/* Count the number of articles included by country for our WOS sample */
SELECT
	LR_main_field, CAST(SUM(weight) AS DECIMAL) AS n_items
FROM
	userdb_frasernm.dbo.wos_classification
GROUP BY
	LR_main_field
ORDER BY
	SUM(weight) DESC;
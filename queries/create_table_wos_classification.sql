/* Drop table if exists already */
DROP TABLE userdb_frasernm.dbo.wos_classification;

/* Create new table */
/* Publications are clustered into research areas based on citation relations, see https://onlinelibrary.wiley.com/doi/full/10.1002/asi.22748 */
/* Clusters are then assigned to a Leiden Ranking field at the micro-field (cluster_id3) level */
SELECT
	t1.ut, t3.weight, t4.LR_main_field
INTO
	userdb_frasernm.dbo.wos_classification
FROM
	userdb_frasernm.dbo.wos_items t1
INNER JOIN
	wosclassification1913.dbo.clustering t2
ON
	t1.ut = t2.ut
INNER JOIN
	wosclassification1913.dbo.cluster_LR_main_field3 t3
ON
	t2.cluster_id3 = t3.cluster_id3
INNER JOIN
	wosclassification1913.dbo.LR_main_field t4
ON
	t3.LR_main_field_no = t4.LR_main_field_no;

/* Create index on UT  column */
CREATE INDEX idx_wos_classification_ut ON userdb_frasernm.dbo.wos_classification(ut);
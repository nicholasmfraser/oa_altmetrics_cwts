R Notebook
================
Nicholas Fraser

# Open Access and Altmetrics

This notebook contains documentation for the study on the relationship
between Open Access (OA) and altmetrics.

## Article Corpus

Articles were derived from the in-house Web of Science database
maintained by CWTS.

The following tables were used:

  - wosdb.dbo.UT (source item)
  - wosdb.dbo.UI (source issue)
  - wosdb.dbo.AR (additional item identifier)

Articles were limited to those published in publication years 2012-2018,
articles published in journals, ‘Article’ and ‘Review’ document types,
and articles with valid (non-null) DOIs. DOIs were converted to
lowercase for matching with other datasets (e.g. Unpaywall,
Altmetric.com).

A table containing relevant items was extracted with the SQL query
[create\_table\_wos\_items.sql](queries/create_table_wos_items.sql)

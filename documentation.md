R Notebook
================
Nicholas Fraser

# Open Access and Altmetrics

This notebook contains documentation for the study on the relationship
between Open Access (OA) and altmetrics.

## Research Questions

  - **RQ1**: Do OA articles receive more altmetric attention than non-OA
    articles?
  - **RQ2**: Do articles with different *types* of OA differ in the
    altmetric attention they receive?
  - **RQ3**: Which additional factors influence the relationship between
    OA and altmetrics?

With respect to RQ3, the following factors will be considered:

  - Time
  - Discipline
  - Country of authorship
  - Publication venue (journal)

## Web of Science

### Article Corpus

Articles were derived from the in-house Web of Science (WOS) database
maintained by CWTS ([query](queries/create_table_wos_items.sql)).

The following tables were used to build the article corpus:

  - woskb.dbo.cwts\_ut
  - woskb.dbo.cwts\_pub\_details

Extracted fields included:

  - ut
  - doi (limited to non-null values)
  - year (limited to 2012:2018)
  - n\_authors
  - n\_institutes
  - n\_countries
  - source (journal name)
  - doc type (limited to ‘Article’ and ‘Review’)

DOIs were converted to lowercase for matching with other datasets
(e.g. Unpaywall, Altmetric.com). A small number of DOIs (N \~ 250) were
found to include a comma in the DOI string (causing issues with .csv
export) and were thus removed.

##### Distribution of WOS articles per year ([query](queries/calc_wos_items_year.sql))

![](documentation_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### Author Countries

ISO Alpha-2 country codes of **first** authors were extracted for the
set of articles defined above
([query](queries/create_table_wos_first_author_countries.sql)),
combining the following tables:

  - userdb\_frasernm.dbo.wos\_items (as defined above)
  - wosaddr1913.dbo.pub\_author\_affiliation
  - wosaddr1913.dbo.pub\_affiliation
  - wosaddr1913.dbo.country

Where authors were affiliated with more than one country, country
affiliations were weighted accordingly (e.g. an author belonging to the
UK and US would count as 0.5 towards the UK, and 0.5 towards the US).

##### Top 30 countries included in WOS article corpus ([query](queries/calc_wos_items_country.sql))

![](documentation_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### Subject Classifications

Subject classifications are assigned to 5 major subject areas, which
conform to the subject classifications used in the [Leiden
Ranking](https://leidenranking.com). The fields are defined
algorithmically (as outlined
[here](https://leidenranking.com/information/fields)), based on the
publication-level classification system detailed in [Waltman and van Eck
(2012)](https://onlinelibrary.wiley.com/doi/full/10.1002/asi.22748). In
brief terms, publications are initially clustered into research areas at
3 levels of granularity, based on citation relations. The classification
system here uses the level of highest granularity, where publications
are clustered into 4535 micro-level fields of science. For each
micro-level field, the overlap with each of the 252 WOS subject areas
(excluding Multidisciplinary Sciences) is determined. Each of these 252
subject categories is then assigned to the 5 main fields of the Leiden
Ranking.

For this study, classification was conducted using the following tables
([query](queries/create_table_wos_classification.sql)):

  - userdb\_frasernm.dbo.wos\_items (as defined above)
  - wosclassification1913.dbo.clustering
  - wosclassification1913.dbo.cluster\_LR\_main\_field3
  - wosclassification1913.dbo.LR\_main\_field

Note that publications can belong to more than one field, which are then
weighted accordingly (i.e. a publication belonging to both “Biomedical
and Health Sciences” and “Life and Earth Sciences” would be assigned a
weight of 0.5 for both fields).

##### Proportion of WOS articles contained in each subject classification ([query](queries/calc_wos_items_classification.sql))

![](documentation_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Altmetrics Data

Altmetrics data were derived from the CWTS in-house database of
Altmetric.com (version October 2019)
([query](queries/create_table_altmetric_counts.sql)), using the
following tables:

  - userdb\_frasernm.dbo.wos\_items (as defined above)
  - altmetric\_2019oct.dbo.pub\_citation
  - altmetric\_2019oct.dbo.pub\_counts

Counts were initially extracted for the following altmetric indicators:

  - Blogs
  - Facebook
  - News
  - Policy
  - Twitter
  - Wikipedia

Where no altmetric information was found for an article, counts were
registered as zero.

The following metrics are used for measuring altmetric activity:

  - **Altmetric Coverage**: The number of articles that are mentioned in
    a given altmetric source. E.g. if 30 articles out of 100 total
    articles are mentioned on Twitter, the Twitter coverage is 30%.
  - **Relative Altmetric Coverage**: The number of articles that are
    mentioned in a given altmetric source **for a specific group**,
    relative to the entire population. This can be explained with the
    following example: a population of 100 articles consists of 40 OA
    and 60 non-OA articles. The Twitter coverage of the entire
    population is 30%, but the coverage of the OA group is 50%. Thus,
    the relative coverage of the OA group is 50/30 = 1.66. An
    interpretation is that OA articles are 66% more likely to receive OA
    coverage than the population as a whole.

## OA Classification

OA classification was conducted using data from Unpaywall. Unpaywall
data (from the April 2019 data dump) has been parsed into a relational
(SQL) database at CWTS.

The following tables were used:

  - unpaywall\_2019apr\_json.dbo.pub (article details)
  - unpaywall\_2019apr\_json.dbo.pub\_oa\_location (article oa location
    details)

Articles were limited to those with a publication date between 2010 and
2019. This is slightly more inclusive than the WOS articles (2012-2019),
to account for potential differences in recorded publication years
between the two datasets (and thus ensures maximum coverage of WoS
articles in the Unpaywall dataset).

OA classification was first conducted following the workflow detailed in
Figure 1 from [Robinson-Garcia et
al. (2019)](https://arxiv.org/abs/1906.03840):

![robinson\_garcia\_unpaywall\_classification](figures/external/robinson_garcia_unpaywall_classification.PNG)

This classification diverges from the OA classification scheme [used by
Unpaywall
directly](https://support.unpaywall.org/support/solutions/articles/44001777288-what-do-the-types-of-oa-status-green-gold-hybrid-and-bronze-mean-)
in two ways:

  - Green OA is a non-exclusive category, meaning that it can overlap
    with other journal-based OA categories. E.g. a paper can be
    published in a Gold OA journal, and hosted on a Green OA repository,
    and would thus be labelled both ‘Gold’ and ‘Green’.
  - Articles hosted on PubMed Central (PMC) are, however, not classified
    as Green OA *if* they are available through another OA outlet. As
    authors do not submit manuscripts to PMC directly, it is not a
    ‘self-archiving’ repository in the ‘traditional’ sense.

Some implications of these two points are considered below.

### PMC

To test the influence of the inclusion/exclusion of articles contained
in PMC on Green OA rates, two classification procedures were conducted:
one including all PMC articles in Green OA
([create\_table\_unpaywall\_classification\_nopmccor.sql](queries/create_table_unpaywall_classification_nopmccor.sql)),
and one excluding PMC articles from Green OA when they match with an
alternative kind of OA
([create\_table\_unpaywall\_classification\_pmccor.sql](queries/create_table_unpaywall_classification_pmccor.sql)).

##### Green OA articles in Unpaywall including and excluding PMC ([query](queries/calc_unpaywall_classification_pmc_comparison.sql))

![](documentation_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

PMC clearly contributes a large proportion of Green OA from 2010 to
2017. In 2018 and 2019, no PMC articles are found to contribute to Green
OA - notably, no articles are found for these year in the Unpaywall data
where the evidence is described as “oa repository (via pmcid lookup)”.
However, when checking the same articles from 2018 and 2019 directly via
the Unpaywall API, PMC *is* included as an evidence source. A
possibility is that Unpaywall only crawl PMC sporadically (as articles
in Gold OA journals, such as PLOS ONE, are deposited immediately to
PMC), or that a technical issue occurred \[**to do:** investigate this
issue further. Contact Unpaywall?\]

##### Overlap of articles in PMC with journal-based OA types ([query](queries/calc_unpaywall_classification_pmc_overlap.sql))

![](documentation_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

PMC appears to overlap most strongly (and overlap has grown most
rapidly) with Gold OA, but also a non-negligible amount with Hybrid and
Bronze OA. Note, as previously, PMC articles are missing from 2018 and
2019.

### Exclusivity of Green OA

Following the classification procedure of Robinson-Garcia et al. (2019),
Green OA is treated as a non-exclusive category, i.e. an article is
labelled as Green if it is available via a repository, regardless of its
availability status at the journal page. However, some questions remain
about this approach in the context of understanding OA impact - for
example, from the readership perspective, will readers really use (and
be more likely to cite/mention) an article if it is an OA repository,
when it is also available directly on a journal page? And from the
authors perspective - do the authors who publish in OA journals **and**
self-archive their papers represent a different demographic/category of
authors, than those who **only** self-archive? The impact dynamics are
therefore likely different for Green OA, depending on the availability
of the corresponding journal article.

##### Number of Green OA articles that are open and closed at the corresponding journal page ([query](queries/calc_unpaywall_classification_green_types.sql))

![](documentation_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

It appears that Green OA growth is more strongly represented by articles
which are also available at the corresponding journal page, than closed
articles. Note, however, that the above figures includes PMC articles -
as shown in the previous section, there is also a large overlap of PMC
with Gold OA, and to a lesser extent with Hybrid and Bronze OA.

##### Number of Green OA articles published in different types of OA journals ([query](queries/calc_unpaywall_classification_green_types.sql))

![](documentation_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

The results show that the contribution of Gold articles to Green OA
shares has grown most strongly between 2010 and 2017. However,
approximately 75% of the growth can be attributed to growth in deposits
to PMC. Interestingly, whilst the contribution of Hybrid OA has grown
over this time period, the contribution of Bronze OA remains relatively
static, and even falls marginally from 2014 onwards.

### Recommendations for classifying Green OA in this study

From the above results, a general recommendation is that Green OA should
not be considered a ‘black box’ in the context of understanding impact
metrics, as it includes multiple archiving routes, and interacts
strongly with other forms of OA. However, creating many other
‘categories’ of Green OA (i.e. one category for Green OA including PMC
and one excluding PMC) for analysis purposes is also sub-optimal, as
categories become increasingly granular and large-scale mechanisms
influencing impact are lost.

For simplification purposes, PMC is therefore excluded as a form of
Green OA in the following study. The reasoning for this is based on: (1)
that PMC clearly represents a different *form* of archiving than other
forms of Green OA, i.e. the author takes no direct action to deposit
their work, (2) that PMC largely overlaps with other forms of
journal-based OA, in particular with Gold OA, which may skew results
towards these OA forms, and (3) there exist data quality issues, with
respect to missing PMC data in 2018 and 2019.

## Altmetric Coverage and OA

### By Year

##### Total altmetric coverage per indicator ([query](queries/calc_altmetrics_coverage_year.sql))

![](documentation_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

The highest coverage is observed in Twitter, followed by Facebook, then
news and blogs, Wikipedia and policies. Different temporal trends are
observed for each indicator, e.g. Twitter coverage increases between
2012 and 2016, which may reflect rapid user growth on the platform
itself. Conversely, policy citations decrease over time, likely because
policy citations take longer to accrue (\~years) than mentions on social
media (\~days to weeks) (see [Fang and
Costas, 2018](https://openaccess.leidenuniv.nl/handle/1887/65278)).

##### Relative altmetric coverage in OA versus non-OA publications ([query](queries/calc_altmetrics_coverage_year_oa.sql))

![](documentation_files/figure-gfm/unnamed-chunk-10-1.png)<!-- --> In
general terms, OA articles receive greater coverage in all altmetric
indicators than non-OA articles. The advantage is surprisingly stable
across altmetric indicators, with values of relative coverage between
1.25-1.75 for OA articles (i.e. OA articles receive 25-75 % more
coverage than the baseline coverage of all articles). For some
indicators, e.g. Facebook, news articles, Twitter and Wikipedia, the OA
advantage appears to weaken over time, whilst for blogs the advantage
remains relatively stable, and even increases marginally for policies.

##### Relative altmetric coverage in different access types ([query](queries/calc_altmetrics_coverage_year_oa_types.sql))

![](documentation_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

### By Classification

##### Abbrevations for subject classifications

  - BHS: Biomedical and Health Sciences
  - LES: Life and Earth Sciences
  - MCS: Mathematics and Computer Sciences
  - PSE: Physical Sciences and Engineering
  - SSH: Social Sciences and Humanities

##### Total altmetric coverage per indicator ([query](queries/calc_altmetrics_coverage_classification.sql))

![](documentation_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

##### Relative altmetric coverage in OA versus non-OA publications ([query](queries/calc_altmetrics_coverage_classification_oa.sql))

Coverage is defined as the number of articles that are mentioned by a
particular altmetric sources The *relative coverage* per group is

![](documentation_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

##### Relative altmetric coverage in different access types ([query](queries/calc_altmetrics_coverage_classification_oa_types.sql))

![](documentation_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

### By Country

##### Total altmetric coverage per indicator ([query](queries/calc_altmetrics_coverage_country.sql))

![](documentation_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

##### Relative altmetric coverage in OA versus non-OA publications ([query](queries/calc_altmetrics_coverage_country_oa.sql))

![](documentation_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

##### Relative altmetric coverage in different access types ([query](queries/calc_altmetrics_coverage_country_oa_types.sql))

![](documentation_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

##### By Journal

There are 11,149 distinct journal titles associated with our WOS sample.
In the following section, journals are grouped into percentiles on the
basis of their Journal Impact Factor.

##### Total altmetric coverage per indicator ([query](queries/calc_altmetrics_coverage_journal.sql))

![](documentation_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

##### Relative altmetric coverage in OA versus non-OA publications ([query](queries/calc_altmetrics_coverage_journal_oa.sql))

![](documentation_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

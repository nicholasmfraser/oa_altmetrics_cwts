R Notebook
================
Nicholas Fraser

# Open Access and Altmetrics

This notebook contains documentation for the study on the relationship
between Open Access (OA) and altmetrics.

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

``` r
read_csv("data/wos_items_year.csv") %>%
  ggplot() +
  geom_bar(aes(x = year, y = n_items), stat = "identity") +
  labs(x = "", 
       y = "Articles") +
  scale_x_continuous(breaks = 2012:2018) +
  scale_y_continuous(labels = scales::comma)
```

![](documentation_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### Author Countries

ISO Alpha-2 country codes of **first** authors were extracted for the
set of articles defined above
([query](queries/create_table_wos_first_authors.sql)), combining the
following tables:

  - userdb\_frasernm.dbo.wos\_items (as defined above)
  - wosaddr1913.dbo.pub\_author\_affiliation
  - wosaddr1913.dbo.pub\_affiliation
  - wosaddr1913.dbo.country

Where authors were affiliated with more than one country, country
affiliations were weighted accordingly (e.g. an author belonging to the
UK and US would count as 0.5 towards the UK, and 0.5 towards the US).

##### Top 30 countries included in WOS article corpus ([query](queries/calc_wos_items_country.sql))

``` r
read_csv("data/wos_items_country.csv") %>%
  mutate(country = countrycode::countrycode(country, "iso2c", "country.name"),
         proportion = n_items / sum(n_items)) %>%
  arrange(proportion) %>%
  top_n(30) %>%
  ggplot(aes(x = reorder(country, proportion), y = proportion)) +
  geom_bar(stat = "identity") + 
  labs(x = "",
       y= "Articles") +
  scale_y_continuous(labels = scales::percent) +
  coord_flip() +
  theme(text = element_text(size = 10))
```

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

``` r
read_csv("data/wos_items_classification.csv") %>%
  mutate(proportion = n_items / sum(n_items)) %>%
  arrange(proportion) %>%
  ggplot(aes(x = reorder(LR_main_field, proportion), y = proportion)) +
  geom_bar(stat = "identity") + 
  labs(x = "",
       y= "Articles") +
  scale_y_continuous(labels = scales::percent) +
  coord_flip() +
  theme(text = element_text(size = 10))
```

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

##### Overall coverage of WOS articles by different altmetric indicators per year ([query](queries/calc_altmetric_coverage_year.sql))

``` r
read_csv("data/altmetrics_coverage_year.csv") %>%
  pivot_longer(coverage_blog:coverage_wikipedia) %>%
  mutate(name = factor(name,
                       levels = c("coverage_blog", "coverage_facebook",
                                  "coverage_news", "coverage_policy",
                                  "coverage_twitter", "coverage_wikipedia"),
                       labels = c("Blogs", "Facebook", "News", "Policies",
                                  "Twitter", "Wikipedia"))) %>%
  ggplot() +
  geom_bar(aes(x = year, y = value, fill = name), stat = "identity") +
  facet_wrap(. ~ name) +
  labs(x = "", 
       y = "Coverage") +
  scale_x_continuous(breaks = 2012:2018) +
  scale_y_continuous(labels = scales::percent) +
  theme(legend.position = "none")
```

![](documentation_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

The best coverage is clearly observed in Twitter, followed by Facebook,
then news and blogs, Wikipedia and policies. Different temporal trends
are observed for each indicator, e.g. Twitter coverage increases greatly
between 2012 and 2016, which may reflect rapid user growth on the
platform itself. Conversely, policy citations decrease over time, likely
because policy citations take longer to accrue (\~years) than mentions
on social media (\~days to weeks).

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

The number of articles classified as Green OA are compared depending on
whether PMC is included or excluded as a source of Green OA (note: this
has no effect on other OA classification types):

![](documentation_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

PMC clearly contributes a large proportion of Green OA from 2010 to
2017. In 2018 and 2019, no PMC articles are found to contribute to Green
OA - notably, no articles are found for these year in the Unpaywall data
where the evidence is described as “oa repository (via pmcid lookup)”.
However, when checking the same articles from 2018 and 2019 directly via
the Unpaywall API, PMC *is* included as an evidence source. A
possibility is that Unpaywall only crawl PMC sporadically (as articles
in Gold OA journals, such as PLOS ONE, are deposited immediately to
PMC), or that a technical issue occurred.

The overlap of PMC with other journal-based OA types (gold, bronze,
hybrid) was also assessed:

![](documentation_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

PMC appears to overlap most strongly (and overlap has grown most
rapidly) with Gold OA, but also a non-negligible amount with Hybrid and
Bronze OA.

#### Should we exclude PMC from our analysis?

From these results there seems no ‘a priori’ reason to completely
exclude PMC. Even though authors do not deposit work to PMC, it remains
an open repository and discovery tool and may thus have an influence on
article impact. An alternative may eventually be to create a separate
category for PMC articles. For the following documentation, PMC articles
are included and labelled as Green OA.

### Green OA

Following the classification procedure of Robinson-Garcia et al. (2019),
Green OA is treated as a non-exclusive category, i.e. an article is
labelled as Green if it is available via a repository, regardless of its
availability status at the journal page. However, some questions remain
about this approach in the context of understanding OA impact - for
example, will authors really use (and be more likely to cite/mention) an
article if it is an OA repository, when it is also available directly
(and likely more easily) on a journal page? The impact dynamics are
therefore likely different for Green OA, depending on the availability
of the corresponding journal article.

To understand this better, the share of Green OA that is open (i.e. the
sum of Gold, Green and Bronze OA) and closed at the journal page is
shown:

![](documentation_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Interestingly, Green OA growth is driven more strongly by articles which
are also available at the corresponding journal page. The decrease in
Green OA coverage after 2018 is in part due to the issues with PMC
coverage documented above, and also likely due to journal embargo
periods. A more fine-grained analysis shows, for the articles available
at the journal page, the number of articles contributing to Green OA for
each journal type:

![](documentation_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

The results show that in general, the contribution of Gold and Hybrid
articles to Green OA shares has grown strongly between 2010 and 2017.
Interestingly, the contribution of Bronze OA articles over this time
period remains relatively static, and even falls marginally from 2014
onwards.

#### Should Green OA articles be labelled at a more granular level?

…to discuss…

### Open Access shares

Including all data from Unpaywall:

![](documentation_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->![](documentation_files/figure-gfm/unnamed-chunk-10-2.png)<!-- -->![](documentation_files/figure-gfm/unnamed-chunk-10-3.png)<!-- -->![](documentation_files/figure-gfm/unnamed-chunk-10-4.png)<!-- -->![](documentation_files/figure-gfm/unnamed-chunk-10-5.png)<!-- -->![](documentation_files/figure-gfm/unnamed-chunk-10-6.png)<!-- -->

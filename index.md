Newspapers from European digital libraries collections are part of the data set OLR’ed (Optical Layout Recognition) by the project Europeana Newspapers (www.europeana-newspapers.eu). The OLR refinement (performed by [CCS](http://content-conversion.com)) consists of the description of the structure of each issue and articles (spatial extent, title and subtitle, classification of content types) using a METS/ALTO format.

From each digital document is derived a set of bibliographical, descriptive and quantitative metadata relating to content and layout (date of publication, number of pages, articles, words, illustrations, etc.). XSLT or Perl scripts are used to extract those metadata from METS manifest and OCR files. 

The BaseX XML database and XQuery language are then used to search the datasets and output graphs.

![](https://altomator.files.wordpress.com/2016/01/3.png)


### Articles, blogs
- ["Mining, Visualising and Analysing Historical Newspaper Data: the French National Library Experience"](http://www.euklides.fr/blog/altomator/EN-DM/presentation_bxl_en.pdf) (presentation). Digital Approach towards serial publications, Ghent Centre for Digital Humanities (GhentCDH) (Bruxelles, September 2017)
- ["Innovative Approaches of Historical Newspapers: Data Mining, Data Visualization, Semantic Enrichment"](http://www.euklides.fr/blog/altomator/EN-DM/article_en2.pdf) (article), [presentation](http://www.euklides.fr/blog/altomator/EN-DM/presentation_en2.pdf). IFLA News Media section (Lexington, August 2016)
- ["Data Mining Historical Newspapers Metadata"](http://www.euklides.fr/blog/altomator/EN-DM/article_en.pdf) (article), [presentation](http://www.euklides.fr/blog/altomator/EN-DM/slides_en.pdf). IFLA News Media section 2016 (Hamburg, April 2016)
- ["Data Mining Historical Newspapers Metadata"](http://www.euklides.fr/blog/altomator/EN-DM/poster_en.pdf) (poster). Documents Analysis Systems (Santorini, April 2016)
- Blog posts (Fr) : [1](https://altomator.wordpress.com/2016/01/17/presse-ancienne-data-mining), [2](http://gallica.bnf.fr/blog/04032016/verdun-1916-quand-la-presse-etait-censuree)


### Dataset
The complete set of derived data contains about 5,500,000 atomic metadata from six national and regional French newspapers (1814-1945, 880,000 pages, 150,000 issues) from BnF press collections (Gallica, www.gallica.fr):
- *Le Matin*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb328123058/date)
- *Le Gaulois*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb32779904b/date)
- *Le Petit journal illustré*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb32836564q/date)
- *Le Journal des débats politiques et littéraires*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb39294634r/date)
- *Le Petit Parisien*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb34419111x/date)
- *L'Ouest-Eclair (Rennes)*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb32830550k/date)
- *L'Ouest-Eclair (Nantes)*: [see on Gallica](http://gallica.bnf.fr/ark:/12148/cb41193663x/date)

**Download Datasets** (147,978 issues) :
- *Le Matin* (1884-1942, 21,846 issues) : [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/matin.zip) /
[XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/matin.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/matin.zip)
- *Le Gaulois* (1868-1929, 21,241 issues): [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/gaulois.zip) /
[XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/gaulois.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/gaulois.zip)
- *Le Petit journal illustré,* supplément du dimanche (1884-1920, 1,899 issues): [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/PJI.zip) /
 [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/PJI.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/PJI.zip) 
- *Le Journal des débats politiques et littéraires* (1814-1944, 45,334 issues) : [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/JDPL.zip) /
[XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/JDPL.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/JDPL.zip) 
- *Le Petit Parisien* (1876-1944, 23,168 issues): [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/petit_parisien.zip) / 
[XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/petit_parisien.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/petit_parisien.zip)
- *L'Ouest-Eclair,* Rennes (1899-1942, 25,108 issues) : [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/OE-Rennes.zip) /
[XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/OE-Rennes.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/OE-Rennes.zip)
- *L'Ouest-Eclair,* Nantes (1915-1942, 9,382 issues) : [CSV](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/CSV/OE-Nantes.zip) /
[XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/OE-Nantes.zip) / [JSON](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/JSON/OE-Nantes.zip) 

**Note** : the OCRed text of the Europeana Newspapers corpus is also [available](http://data.theeuropeanlibrary.org/download/newspapers-by-country/README.html).

**Datasets with illustrations' caption text**
- *Le Matin*  : [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/matin-captions.zip) 
- *Le Gaulois* : [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/gaulois-captions.zip) 
- *Le Petit journal illustré,* supplément du dimanche : 
 [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/PJI-captions.zip) 
- *Le Journal des débats politiques et littéraires*  : [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/JDPL-captions.zip)  
- *Le Petit Parisien* : [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/petit_parisien-captions.zip)
- *L'Ouest-Eclair,* Rennes : [XML](http://www.euklides.fr/blog/altomator/EN-DM/Datasets/XML/OE-captions.zip)

### API
- Illustrations search in the datasets: see on the [Github](https://github.com/altomator/EN-data_mining) to try XQuery HTTP APIs using [BaseX](http://basex.org) (XML database engine and XPath/XQuery processor)
 

### Charts

Made with [Highcharts](www.highcharts.com) and Google Charts.

##### Page dimensions
*Journal des débats politiques et littéraires* : [Page format ](http://altomator.github.io/EN-data_mining/Charts/Formats/timeline-format-JDPL_complete_interactive.htm) (complete dataset, interactive timeline)

*Ouest-Eclair (Ed. Nantes)* : [Page format ](http://altomator.github.io/EN-data_mining/Charts/Formats/timeline-format-Ouest-Eclair_complete_interactive.htm) (complete dataset, interactive timeline)

##### Pages number
![](http://altomator.github.io/EN-data_mining/Charts//Samples/pages-mean.png)

[Average number of pages per issue](http://altomator.github.io/EN-data_mining/Charts/Samples/Pages/timeline-mean.htm) (timeline)


[Average number of pages per issue per title](http://altomator.github.io/EN-data_mining/Charts/Samples/Pages/timeline-issue.htm) (timeline)

##### Articles
![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Articles/articles.png)

[Average number of articles per issue](http://altomator.github.io/EN-data_mining/Charts/Samples/Articles/timeline-issue.htm) (timeline)

[Average number of articles per page](http://altomator.github.io/EN-data_mining/Charts/Samples/Articles/timeline-page.htm) (timeline)

*Le Matin* : [Average number of articles per issue](http://altomator.github.io/EN-data_mining/Charts/Samples/Articles/timeline-issue-Le_Matin_interactive.htm) (interactive timeline)

##### Illustrations
[Average number of illustrations for 1,000 pages](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/mean-page.htm)

[Average number of illustrations per page](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-mean.htm) (timeline)

[Average number of illustrations per page per title](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-page.htm) (timeline)

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Illustrations/illustrations-JDPL.png)

*Journal des débats politiques et littéraires* : [Number of illustrations per issue](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-illustrations-JDPL_complete_interactive.htm) (complete dataset, interactive timeline)


###### Front page

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Illustrations/illustrations-front.png)

[Average number of front page illustrations](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-front-mean.htm) (timeline)

[Average number of front page illustrations per title](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-front.htm) (timeline)

*Le Petit Journal  illustré* : 
- [Average number of illustrations on the front page](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-front-LPJI_interactive.htm) (interactive timeline)
- [Number of illustrations on the front page](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-front-LPJI_complete_interactive.htm) (complete dataset, interactive timeline)

*Le Petit Parisien* : [Average number of illustrations per page](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-front-LPP_interactive.htm) (interactive timeline)

*Ouest-Eclair* : [Number of illustrations on the front page](http://altomator.github.io/EN-data_mining/Charts/Samples/Illustrations/timeline-front-Ouest-Eclair_complete_interactive.htm) (complete dataset, interactive timeline)


##### Words
![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Words/mean-words.png)

[Average number of words per page](http://altomator.github.io/EN-data_mining/Charts/Samples/Words/mean-page.htm)

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Words/words-JDPL.png)

*Journal des débats politiques et littéraires* : [Number of words per page](http://altomator.github.io/EN-data_mining/Charts/Samples/Words/timeline-words-JDPL_complete_interactive.htm)  (complete dataset, interactive timeline)


##### Tables
[Average number of tables per issue](http://altomator.github.io/EN-data_mining/Charts/Samples/Tables/timeline-issue.htm) (timeline)



##### Layout and form factors
![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Articles/modern.png)

[Average number of articles, illustrations and illustrations on front page (per page)](http://altomator.github.io/EN-data_mining/Charts/Samples/Articles/modern_press.htm)

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/FormFactors/page-article-illus-ad.png)

[Page format; and words, illustrations, ads density (per page)](http://altomator.github.io/EN-data_mining/Charts/Samples/FormFactors/page-article-illus-ad.htm)

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/FormFactors/page-article-illus-ad-surface.png)

[Number of pages; words, illustrations, ads density (per surface)](http://altomator.github.io/EN-data_mining/Charts/Samples/FormFactors/page-article-illus-ad-surface.htm)

##### Content types
![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/content.png)

Average number of blocks per issue (timeline):

- [*Le Matin*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/Le_Matin.htm) 
- [*Le Gaulois*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/Le_Gaulois.htm) 
- [*Le Petit journal illustré*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/PJI.htm) 
- [*Le Journal des débats politiques et littéraires*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/JDPL.htm)
- [*Le Petit Parisien*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/Petit_Parisien.htm) 
- [*L'Ouest-Eclair* (Rennes)](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Content/Ouest_Eclair.htm) 


##### Data Quality

Issues per year:

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/DataQuality/Issues_year.png)

[*Whole dataset*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/DataQuality/Issues_year.htm)

Missing issues:

![](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/DataQuality/calendar.png)

[*Journal des débats politiques et littéraires*](http://www.euklides.fr/blog/altomator/EN-DM/Charts/Samples/Missing/JDPL.htm) (calendar)



##### Timeline
[Showcase timeline for the *Journal des débats politiques et littéraires* ](http://cdn.knightlab.com/libs/timeline/latest/embed/index.html?source=1g_5wor1L23oyUGoA8OVtqambhldaEn50V52j0gQs2tc&font=Bevan-PotanoSans&maptype=toner&lang=fr&start_at_slide=1&height=650)




### Author
2015, @altomator

Contact : jean-philippe.moreux@bnf.fr

This work has been part-funded through the EU Competitiveness and Innovation Framework Programme grant Europeana Newspapers (Ref. 297380)
 
![EN](http://www.marchermanger.fr/wp-content/uploads/2015/12/europeana_newspapers_logo.gif)

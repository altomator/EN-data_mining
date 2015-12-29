## EN-data_mining
*Data Mining Historical Newspaper Metadata (Europeana Newspaper Project)*

### Synopsis
Newspapers from European digital library collections collections are part of the data set OLR’ed (Optical Layout Recognition) by the project Europeana Newspaper (www.europeana-newspapers.eu). The OLR refinement consists of the description of the structure of each issue and articles (spatial extent, title and subtitle, classification of content types) using the METS/ALTO format. 

Of each digital document is derived a set of bibliographical and descriptive metadata relating to content (date of publication, number of pages, articles, words, illustrations, advertisements, etc.). Shell and XSLT scripts called with Xalan-Java are used to extract  metadata from METS manifest and OCR files. 

### Installation
You will need to install:
3 DOS shell scripts :
- cmd.dos
- sdd
- ddd

2 XSLT sheets
- ddd
- dd

Xalan-Java :
- dd
- dd

The documents must be stored in a "DOCS" folder.
The metadata will be generated in a "STATS" folder.


### Tests
1. Open a DOS command line.
2. Type
3. 

### Article, charts &  datasets

See http://altomator.github.io/EN-data_mining for a detailed presentation.

#### Charts
See [Charts](https://github.com/altomator/EN-data_mining/tree/master/Charts)

(Made with [Highcharts](www.highcharts.com))

#### Datasets
The complete set of derived data contains about 4,500,000 atomic metadata from six national and regional French newspapers (1814-1945, 880 000 pages, 150 000 issues) of Gallica (www.gallica.fr) press collections:
- *Le Matin*
- *Le Gaulois*
- *Le Petit journal illustré*
- *Le Journal des débats politiques et littéraires*
- *Le Petit Parisien*
- *Ouest-Eclair*

See [Datasets](https://github.com/altomator/EN-data_mining/tree/master/Datasets)



## License
CC0

<a href="http://creativecommons.org/publicdomain/zero/1.0/"><img src="https://camo.githubusercontent.com/4df6de8c11e31c357bf955b12ab8c55f55c48823/68747470733a2f2f6c6963656e7365627574746f6e732e6e65742f702f7a65726f2f312e302f38387833312e706e67" alt="CC0" data-canonical-src="https://licensebuttons.net/p/zero/1.0/88x31.png" style="max-width:100%;"></a>

This work has been part-funded through the EU Competitiveness and Innovation Framework Programme grant Europeana Newspapers (Ref. 297380)



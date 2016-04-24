## EN-data_mining
*Data Mining Historical Newspaper Metadata (Europeana Newspaper Project)*

### Synopsis
Newspapers from European digital librabries collections are part of the data set OLR’ed (Optical Layout Recognition) by the project Europeana Newspapers (www.europeana-newspapers.eu). The OLR refinement (performed by CCS) consists of the description of the structure of each issue and articles (spatial extent, title and subtitle, classification of content types) using the METS/ALTO formats.

From each digital document is derived a set of bibliographical and descriptive metadata relating to content (date of publication, number of pages, articles, words, illustrations, etc.). Shell and XSLT scripts called with Xalan-Java are used to extract some metadata from METS manifest or OCR files.

Detailled presentation :
- [English](http://altomator.github.io/EN-data_mining/)
- [Français](https://altomator.wordpress.com/2016/01/17/presse-ancienne-data-mining/)

### Installation
You can use XSLT (DOS scripts) or Perl script (faster).

Sample documents are stored in the "DOCS" folder.
The metadata are generated in a "STATS" folder.

#### XSLT
Two DOS shell scripts :
- batch-EN.bat
- xslt.cmd

Two XSLT sheets:
- analyseAltosCCS.xsl
- calculeStatsMETS_CSV.xsl

The XSLT are runned with Xalan-Java. Path to the Java bin must be set in xslt.cmd.

For each document, its metadata are stored in the STATS folder under two formats :
- XML (raw metadata, with detailled values for each page)
- CSV (metadata at the issue level)

An aggregated file (metadata.csv) contains all the CSV metadata.


##### Test
1. Open a DOS terminal.
2. Change dir to the batch folder
3. >batch-EN.bat 

#### Perl 
Faster and richer (more metadata) than the XSLT scripts.

One Perl script: extractMD.pl 
One shell script: batch.sh (runs the Perl script and packages the files)

For each document, metadata are stored in the STATS folder (available formats : XML, JSON, CSV, txt)


##### Test
1. Open a shell terminal.
2. Change dir to the batch folder
3. >perl extractMD.pl DOCS xml json


### Charts
See on [Github](https://github.com/altomator/EN-data_mining/tree/master/Charts) and [here](http://altomator.github.io/EN-data_mining/).

(Made with [Highcharts](www.highcharts.com))

### Datasets
The complete set of derived data contains about 4,500,000 atomic metadata from six national and regional French newspapers (1814-1945, 880,000 pages, 150,000 issues) of Gallica (www.gallica.fr) press collections:
- *Le Matin*
- *Le Gaulois*
- *Le Petit journal illustré*
- *Le Journal des débats politiques et littéraires*
- *Le Petit Parisien*
- *Ouest-Eclair*

See [Datasets](http://altomator.github.io/EN-data_mining)



## License
CC0

<a href="http://creativecommons.org/publicdomain/zero/1.0/"><img src="https://camo.githubusercontent.com/4df6de8c11e31c357bf955b12ab8c55f55c48823/68747470733a2f2f6c6963656e7365627574746f6e732e6e65742f702f7a65726f2f312e302f38387833312e706e67" alt="CC0" data-canonical-src="https://licensebuttons.net/p/zero/1.0/88x31.png" style="max-width:100%;"></a>

This work has been part-funded through the EU Competitiveness and Innovation Framework Programme grant Europeana Newspapers (Ref. 297380)



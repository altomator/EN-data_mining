#!/bin/bash
# bash script

echo " "

# unzip XML files
# gunzip DOCS/*/X/*.gz    



# extracting metadata 
perl extractMD.pl DOCS xml json csv


# generating XML .zip
cd STATS
mkdir XML
find . -name "*.xml" -maxdepth 1 -print0 -exec mv {} XML \;
zip -r metadata-xml.zip XML

# generating JSON .zip
mkdir JSON
find . -name "*.json" -maxdepth 1 -print0 -exec mv {} JSON \;
zip -r metadata-json.zip JSON

# generating CSF file
mkdir CSV
find . -name "*.csv" -maxdepth 1 -print0 -exec mv {} CSV \;
cd CSV
ls | xargs -n 32  cat >> ../metadata.csv
cd ..
cls
@echo off

@del /Q STATS\*.txt
@del /Q STATS\*.html
@del /Q STATS\*.xml


echo.

echo ----- Processing METS manifests and OCR ALTO files -----
call parseMETS.bat DOCS XSL\analyseAltosCCS.xsl -x

echo ----- Generating CSV files
call parseStats.bat STATS XSL\calculeStatsMETS_CSV.xsl txt -x


cd STATS
@copy/b *.txt metadata.csv
echo.
echo The .csv file is available in the STATS folder
cd ..
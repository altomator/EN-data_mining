@REM Set the Java classpath to include xalan.jar, serializer.jar, xml-apis.jar, and xercesImpl.jar -- or another conformant XML Parser -- (see Plugging in the Transformer and XML parser).
@REM Call java and the Process class with the appropriate flags and arguments (described below). The following command line, for example, includes the -IN, -XSL, and -OUT flags with their accompanying arguments -- the XML source document, the XSL stylesheet, and the output file:
@REM  java org.apache.xalan.xslt.Process -IN foo.xml -XSL foo.xsl -OUT foo.out 

@setlocal


@echo off
@REM le fichier xml à parser
@if %1"O" EQU "O" goto erreur

@REM la feuilles xslt
@if %2"O" EQU "O" goto erreur

@REM le nom du fichier en sortie
@if %3"O" EQU "O" goto erreur

@REM l'extension du fichier en sortie
@if %4"O" EQU "O" goto erreur

@REM parametre XSL : id du document
@if %5"O" EQU "O" goto erreur

@REM le mode : simulation ou traitement
@if %6"O" EQU "O" goto erreur

PATH=%PATH%;"C:\Program Files (x86)\Java\jre6\bin"

set LIBSPATH=..\Java\xalan.jar;..\Java\serializer.jar;..\Java\xml-apis.jar;..\Java\xercesImpl.jar


if "%6%"=="-exec" (@echo ...
"C:\Program Files (x86)\Java\jre6\bin\java.exe" -Xmx1024m -classpath %LIBSPATH% org.apache.xalan.xslt.Process  -IN %1  -XSL %2 -OUT %3.%4 -PARAM xslParam %5
) else (
echo "C:\Program Files (x86)\Java\jre6\bin\java.exe -Xmx1024m -classpath ... org.apache.xalan.xslt.Process  -IN %1  -XSL %2 -OUT %3.%4 -PARAM idDoc %5" )

@goto fin

:erreur
@echo Usage : %0 fichier.xml feuille.xsl fichier_out format id_doc -sim/-exec
goto fin


:fin

echo.
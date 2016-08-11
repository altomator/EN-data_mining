(:
 Recherche d'illustrations légendées dans une base BaseX
 Illustration Search in a BaseX Database
:)

declare namespace functx = "http://www.functx.com";

declare option output:method 'html';

(: Arguments avec valeurs par défaut 
   Args and default values               :)
declare variable $title as xs:string external := '.*'; (: titre du journal - newspaper title :)
declare variable $fromPage as xs:integer external := 1; (: toutes les pages - all the pages :)
declare variable $toPage as xs:integer external := 100; (: jusqu'à la page :)
declare variable $fromDate as xs:date external := xs:date("1800-01-01"); (: de la date :)
declare variable $toDate as xs:date external := xs:date("1950-01-01");  (: toute la collection - all :)
declare variable $keyword as xs:string external := '.*'; (: mot clé :)

(: URL Gallica de base 
   Gallica root URL :)
declare variable $rootURL as xs:string external := 'http://gallica.bnf.fr/ark:/12148/';

(: ARK des notices de titre dans Gallica
   ARK of newspaper titles in Gallica :)
declare variable $titlesARK as map(*) := map {
  "Nantes": "cb41193663x",
  "Rennes": "cb32830550k",
  "Caen": "cb41193642z",
  "Matin": "cb328123058",
  "Gaulois": "cb32779904b",
  "Le Journal": "cb39294634r",
  "Petit Journal": "cb32836564q",
  "Parisien": "cb34419111x",
  ".*": ""   (: si le paramètre $title a sa valeur par défaut - if $title has its default value :)
};

(: Conversion de formats de date 
   Date formats conversion       :)
declare function functx:mmddyyyy-to-date
  ( $dateString as xs:string? )  as xs:date? {

   if (empty($dateString))
   then ()
   else if (not(matches($dateString,
                        '^\D*(\d{2})\D*(\d{2})\D*(\d{4})\D*$')))
   then error(xs:QName('functx:Invalid_Date_Format'))
   else xs:date(replace($dateString,
                        '^\D*(\d{2})\D*(\d{2})\D*(\d{4})\D*$',
                        '$3-$2-$1'))
 } ;
 
(: Renvoie l'ARK à partir du paramètre $title 
   Get ARK title from the title 
:)
declare function local:computeARK($title) { 
  for $v in map:keys($titlesARK) 
  return if (fn:contains($title,$v))  (: la clé doit etre contenue dans le titre :)
   then map:get($titlesARK, $v)
   else ()
 
};

(: Construction de la page HTML 
   HTML page creation :)
declare function local:createOutput($data) {
<html>
   <head>
   <style>
result {{
    background-color: #ffffff;
    width: 100%;
}}
p.match {{
		padding: 10pt;
    display: block;
    margin-bottom: 15pt;
    margin-left: 15pt;
    width:80%;
    border-color: #d9b38c;
    border-style: dotted;
    border-width: 5px
}}
p.warning {{
    display: block;
    color: red
}}
title {{
    display: block;
    color: #000066;
    font-size: 15pt;
}}
h2 {{
    padding: 15pt;
    font-family: sans-serif; 
    font-size: 16pt;
}}
date:before {{
  color: black;
  content: "Date : ";
}}
page:before {{
  color: black;
  content: "Page : ";
}}
illustrations:before {{
  color: black;
  content: "Illustrations : ";
}}
page, illustrations, date{{   
    font-family: sans-serif; 
    font-size: 12pt;
    color: #000066;
}}
illCaption:before {{
  color: black;
  font-size: 12pt;
  content: "Caption : ";
}}
illCaption{{
    display: block;

    font-family: sans-serif; 
    font-size: 10pt
}}
a {{
    padding-top:5pt;   
    display: block;
    color: #000000;
    font-family: sans-serif;
    color: #660033
}}
   </style>   
   <title>Europeana Newspapers : illustrations search</title></head>
<body>
<h2>Illustrations</h2>
  {
  
  if (not(map:contains($titlesARK, $title))) then (
   <p class="warning">Titre inconnu : {data($title)}
    -- Valeurs autorisees : {map:for-each(
  $titlesARK, function($a, $b) { fn:concat($a," /")}
)} </p>
  
  )
  else (
  for $issue in $data//analyseAlto[matches(metad/titre,$title)
  and (xs:date(functx:mmddyyyy-to-date(metad/dateEdition/text())) gt $fromDate)
  and (xs:date(functx:mmddyyyy-to-date(metad/dateEdition/text())) lt $toDate)]
for $page in $issue/contenus/page[(position()>=$fromPage) and (position()<=$toPage)]
where   $page[(matches(legendes,$keyword,'i'))]      
let $date := $page/../../metad/dateEdition
let $tokens := fn:tokenize($date, "\.")
let $title := $page/../../metad/titre
let $url := fn:concat($rootURL,local:computeARK($title),"/date")

order by xs:date(functx:mmddyyyy-to-date($date))  
return 
<p class="match">
<title>{data($title)}</title>
<date>{data($date)}</date>
<illCaption>{$page/legendes}</illCaption>
<page>{$page/fn:count(preceding-sibling::page) + 1}</page>
<illustrations>{data($page/blocIllustration)}</illustrations>
<a href="{$url}{$tokens[3]}{$tokens[2]}{$tokens[1]}" target="_blank">See on Gallica</a>
</p>
)
}
 </body>   
</html>
  };        


(: Exécution de la requete sur la base BaseX - le nom de la base doit etre donné ici
   The BaseX database must be specify here                :)
let $data := collection("dataset-legendes")
  return
    local:createOutput($data)
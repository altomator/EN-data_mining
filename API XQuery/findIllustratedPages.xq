(:
 Recherche de pages illustrees
:)

declare namespace functx = "http://www.functx.com";

declare option output:method 'html';

(: Arguments avec valeurs par defaut :)
declare variable $title as xs:string external := '.*'; 
declare variable $fromPage as xs:integer external := 1; (: par daut toutes les pages :)
declare variable $toPage as xs:integer external := 100;
declare variable $fromDate as xs:date external := xs:date("1800-01-01");
declare variable $toDate as xs:date external := xs:date("1945-12-31");  (: par defaut toute la collection :)
declare variable $maxWords as xs:integer external := 500;
declare variable $maxImages as xs:integer external := 10;  (: par defaut quelques images :)

(: URL Gallica de base :)
declare variable $rootURL as xs:string external := 'http://gallica.bnf.fr/ark:/12148/';

(: ARK des notices de titre :)
declare variable $titlesARK as map(*) := map {
  "Nantes": "cb41193663x",
  "Rennes": "cb32830550k",
  "Caen": "cb41193642z",
  "Matin": "cb328123058",
  "Gaulois": "cb32779904b",
  "Le Journal": "cb39294634r",
  "Petit Journal": "cb32836564q",
  "Parisien": "cb34419111x",
  ".*": ""   (: si le paramre $title a sa valeur par daut :)
};


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
 
(: renvoie l'ARK partir du paramre $title :)
declare function local:computeARK($title) {
  for $v in map:keys($titlesARK) 
  return if (fn:contains($title,$v))
   then map:get($titlesARK, $v)
   else ()
 
};

(: construction de la page HTML :)
declare function local:createOutput($data) {
<html>
   <head>
   <style>
result {{
    background-color: #ffffff;
    width: 100%;
}}
li.match {{
		padding: 10pt;
   
    margin-bottom: 15pt;
   
    width:50%;
    border-color: #d9b38c;
    border-style: dotted;
    border-width: 3px
}}
li.warning {{
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
h3 {{
    padding-left: 15pt;padding-top:0pt;padding-bottom:0pt;
    font-family:sans-serif; 
    font-weight: normal;
    font-size: 12pt;
    color: #333333;
}}
date {{
    display: block;
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
  content: "Illustrations: ";
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
    font-family: serif;
    color: #660033
}}
   </style>  
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>  
   <title>Gallica/presse : pages illustrées</title></head>
<body>
<h2>Recherche de pages illustrées dans la presse <span style="color:#999999;font-size:28pt">Gallica</span></h2>
<h3><b>Pages indexées</b> : 636 902 </h3> <!-- count($data//page) -->
<h3><b>Titres</b> : Le Gaulois, Le Journal des débats politiques et littéraires, Le Matin, 
Ouest-Eclair (Rennes),  Le Petit Journal illustré, Le Petit Parisien  </h3> 
 <!-- count($data//distinct-values(//titre)) -->
<h3>titre (title): "{$title}"<br/>
moins de {$maxWords} mots (maxWords)<br/>
moins de {$maxImages} images (maxImages)<br/>
de la page  {$fromPage} à la page {$toPage} (fromPage,toPage) <br/>
de  {$fromDate} à la page {$toDate} (fromDate,toDate) </h3>

<ol>
  {
  
  if (not(map:contains($titlesARK, $title))) then (
   <li class="warning">Titre inconnu : {data($title)}
    -- Valeurs autorisees : {map:for-each(
  $titlesARK, function($a, $b) { fn:concat($a," /")}
)} </li>
  
  )
  else (
  for $issue in $data//analyseAlto[matches(metad/titre,$title)
  and (xs:date(functx:mmddyyyy-to-date(metad/dateEdition/text())) gt $fromDate)
  and (xs:date(functx:mmddyyyy-to-date(metad/dateEdition/text())) lt $toDate)]
for $page in $issue/contenus/page[(position()>=$fromPage) and (position()<=$toPage)]
where   $page/blocIllustration!=0 and $page/blocIllustration<=$maxImages and $page/nbMot < $maxWords
let $date := $page/../../metad/dateEdition
let $tokens := fn:tokenize($date, "\.")
let $title := $page/../../metad/titre
let $url := fn:concat($rootURL,local:computeARK($title),"/date")

order by xs:date(functx:mmddyyyy-to-date($date))  
return 
<li class="match">
<title>{data($title)}</title>
<date>{data($date)}</date>
<page>{$page/fn:count(preceding-sibling::page) + 1}</page>
<illustrations>{data($page/blocIllustration)}</illustrations>
<a href="{$url}{$tokens[3]}{$tokens[2]}{$tokens[1]}" target="_blank">See on Gallica</a>
</li>
)
}
</ol> </body>   
</html>
  };        


(: execution de la requete sur la base :)
let $data := collection("dataset-legendes")
  return
    local:createOutput($data)
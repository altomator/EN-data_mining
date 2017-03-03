(:
 Recherche d'illustrations legendees dans une base BaseX
 Illustration Search in a BaseX Database
:)

declare namespace functx = "http://www.functx.com";

declare option output:method 'html';

(: Arguments avec valeurs par defaut 
   Args and default values               :)
declare variable $title as xs:string external := '.*'; (: titre du journal - newspaper title :)
declare variable $fromPage as xs:integer external := 1; (: toutes les pages - all the pages :)
declare variable $toPage as xs:integer external := 100; (: jusqu'a la page :)
declare variable $fromDate as xs:date external := xs:date("1800-01-01"); (: de la date :)
declare variable $toDate as xs:date external := xs:date("1945-12-31");  (: toute la collection - all the collection :)
declare variable $keyword as xs:string external := 'TANANARIVE'; (: mot cle - keyword:)

declare variable $nresults as xs:integer external := 0;

(: URL Gallica de base 
   Gallica root URL :)
declare variable $rootURL as xs:string external := 'http://gallica.bnf.fr/ark:/12148/';

(: ARK des notices de titre dans Gallica
   ARK of newspaper title records in Gallica :)
declare variable $titlesARK as map(*) := map {
  (: "Nantes": "cb41193663x", :)
  "Ouest": "cb32830550k",
  (: "Caen": "cb41193642z", :)
  "Matin": "cb328123058",
  "Gaulois": "cb32779904b",
  "Le Journal": "cb39294634r",
  "Petit Journal": "cb32836564q",
  "Parisien": "cb34419111x",
  ".*": ""   (: si le parametre $title a sa valeur par defaut - if $title has its default value :)
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
 
(: Renvoie l'ARK partir du parametre $title 
   Get ARK title from the title string
:)
declare function local:computeARK($title) { 
  for $v in map:keys($titlesARK) 
  return if (fn:contains($title,$v))  (: la cle doit etre contenue dans le titre :)
   then map:get($titlesARK, $v)
   else ()
 
};

(: Construction de la page HTML 
   HTML page creation :)
declare function local:createOutput($data) {
<html>
   <head>
   <style>
body {{
color:black;
background-color:white;
background-repeat:no-repeat;
background-position:right top;
background-image:url(./bnf.jpg);
}}

li.match {{
    padding: 10pt;   
    margin-bottom: 15pt;
    width:80%;
    border-color: #d9b38c;
    border-style: dotted;
    border-width: 2px
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
date:before {{
  color: black;
  content: "Date : ";
}}
page:before {{
  color: black;
  content: "Page : ";
}}
illustrations:after {{
  color: black;
  content: " illustrations)";
}}
illustrations:before {{
  color: black;
  content: "  (";
}}
page, illustrations, date{{   
    font-family: sans-serif; 
    font-size: 12pt;
    padding-top:3pt;
    color: #000066;
}}
illCaption:before {{
  color: black;
  font-size: 12pt;
  content: "Légende : ";
}}
illCaption{{
    display: block;
    font-family: sans-serif; 
    font-size: 10pt
}}
a {{
    padding-top:4pt;   
    display: block;
    font-family: serif;
    font-size: 8pt
    color: #660033
}}
   </style>  
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
   <title>Gallica/presse : recherche d&#x27;illustrations</title></head>
<body>

<h2>Recherche d&#x27;illustrations dans la presse <span style="color:#999999;font-size:28pt">Gallica</span></h2>
<h3><b>Pages indexées</b> : 636 902 </h3> <!-- count($data//page) -->
<h3><b>Titres</b> : Le Gaulois, Le Journal des débats politiques et littéraires, Le Matin, 
Ouest-Eclair (Rennes),  Le Petit Journal illustré, Le Petit Parisien  </h3>  <!-- count($data//distinct-values(//titre)) -->
<h3>titre (title): "{$title}"<br/>
mot-clé (keyword) : "{$keyword}" <br/>
<small  style="color:gray;">Expressions régulières : Tout caractère : .  Toute suite de caractères : .*  Un caract. parmi x : [ ]  Caract. eéèê : [=e=] Caract. aàâ : [=a=] Tout chiffre : \d  Espace : \s   OU : | <br/>
 EXEMPLES : statue.*liberté|bartholdi, 14 juillet 18\d\d, \savion\s, new[-\s]york, m[=a=]laga</small></h3>
<h3>de la page  {$fromPage} à la page (fromPage,toPage) {$toPage}<br/>
de  {$fromDate} à la page (fromDate,toDate) {$toDate}</h3>
<ol>
  {
  if (not(map:contains($titlesARK, $title))) then (
   <li class="warning">Titre inconnu : {data($title)}
    -- Valeurs possibles : {map:for-each(
  $titlesARK, function($a, $b) { fn:concat($a," /")}
)} </li>
  
  )
  else (
    
  for $issue in $data//analyseAlto[matches(metad/titre,$title)
  and (xs:date(functx:mmddyyyy-to-date(metad/dateEdition/text())) gt $fromDate)
  and (xs:date(functx:mmddyyyy-to-date(metad/dateEdition/text())) lt $toDate)]
for $page in $issue/contenus/pages/page[(position()>=$fromPage) and (position()<=$toPage)]
where   $page/ills/ill[(matches(titre,$keyword,'i'))]      
let $date := $page/../../metad/dateEdition
let $tokens := fn:tokenize($date, "\.")
let $title := $page/../../metad/titre
let $url := fn:concat($rootURL,local:computeARK($title),"/date") (:calcul de l'URL Gallica - Gallica URL construction :)
let $npage := $page/fn:count(preceding-sibling::page) + 1

order by xs:date(functx:mmddyyyy-to-date($date))   (: tri des résultats par date croissante - sort the results by date :) 
return 
<li class="match">
<title>{data($title)}</title>
<date>{data($date)}</date>
<illCaption>{$page/legendes}</illCaption>
<page>{$npage}</page>
<illustrations>{data($page/blocIllustration)}</illustrations>
<a href="{$url}{$tokens[3]}{$tokens[2]}{$tokens[1]}/f{$npage}" target="_blank">Voir sur Gallica</a>
</li>
)
}
</ol></body>   
</html>
  };        


(: Exution de la requete sur la base BaseX - le nom de la base doit etre donnici
   The BaseX database must be specify here                :)
let $data := collection("test-PJI")
  return
    local:createOutput($data)
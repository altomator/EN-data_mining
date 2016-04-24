#!/usr/bin/perl -w

# Génération des métadonnées de documents METS/ALTO :
# paramètre 1 : dossier des documents à traiter
# paramétres suivants : formats de sortie
# perl extractMD.pl DOCS xml json

# use strict;
use warnings; 
use 5.010;
#use LWP::Simple;
use Data::Dumper; 
#use XML::Twig;
use Path::Class;
use Benchmark qw(:all) ;
use utf8::all;

$t0 = Benchmark->new;


# Pour avoir un affichage correct sur STDOUT
binmode(STDOUT, ":utf8");

$DPI=300;

# répertoire de stockage des métadonnées extraites
$OUT = "STATS";
if(-d $OUT){
		say "Ecriture dans $OUT...";
	} else 
	{
    mkdir ($OUT) || die ("Erreur creation dossier \n");
    say "Creation de $OUT...";
	}
	
	
# format de sortie
@FORMATS = ();

# répertoire de stockage des documents
$DOCS = "DOCS";

# nbre de documents traités
$nbDoc=0;

# page ALTO en cours
$numPageALTO=1;


# table de hashage métadonnées/valeurs
%hash = ();	

# filtrer sur les sections  du METS 
$handlerMETS = { 
	#'mets:dmdSec[@ID="MODSMD_ISSUE1"]'  => \&getMD,   # métadonnées biblio         
  #'mets:structMap[@TYPE="PHYSICAL"]'  => \&getNbPages, 
  'mets:structMap[@TYPE="LOGICAL"]'  => \&getNbArticles,  # nombre d'articles
};                                    
      
# filtrer sur les ALTO
$handlerALTO = { 
	'/alto/Layout' => \&getALTO, 
};     
                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                     
# ----------------------                                             
# récupération des métadonnées biblio                    
sub getMD {my ($t, $elt) = @_;                                       	                                                                   
	   #my $id = $elt->att('id');                                                                                                                   
	   $hash{"titre"} = $elt->child(0)->child(0)->child(0)->child(0)->child(0)->text();	
	   $hash{"date"} = $elt->child(0)->child(0)->child(0)->child(2)->child(0)->text();	  	   
	   $t -> purge();                              
	}                                                                  
 
# récupération des pages                    
sub getNbPages {my ($t, $elt) = @_;                                       	                                                                                                                                                                                         
	   $hash{"pages"} = scalar($elt->child(0)->children);		    
	   $t -> purge();                              
	}                                                                  
                  
	 
# récupération des articles                    
sub getNbArticles {my ($t, $elt) = @_;                                                                                                                                                                                                                        
	   $hash{"articles"} = scalar($elt->get_xpath('//mets:div[@TYPE="ARTICLE"]'));		    
	   $t -> purge();                              
	}    

# récupération des infos ALTO                    
sub getALTO {my ($t, $elt) = @_; 
	
	   #my $page = $elt->child(0)->att(PHYSICAL_IMG_NR);
	   if ($numPageALTO == 1) {
	     $hash{"largeur"} = int($elt->child(0)->att(WIDTH)*25.4/$DPI); 
	     $hash{"hauteur"} = int($elt->child(0)->att(HEIGHT)*25.4/$DPI); 
	     }  
	   # obtenus par match en fait                                                                                                                                                                                                                  
	   #$hash{$page."_mots"} = scalar($elt->get_xpath('//String'));
	   #$hash{$page."_blocsTexte"} = scalar($elt->get_xpath('//TextBlock'));	
	   #$hash{$page."_blocsPub"} = scalar($elt->get_xpath('//ComposedBlock[(@TYPE="Advertisement")]'));
	   #$hash{$numPageALTO."_blocsTab"} = scalar($elt->get_xpath('//ComposedBlock[(@TYPE="Table")]'));
	   #$hash{$numPageALTO."_illustrations"} = scalar($elt->get_xpath('//Illustration'));	
	   	    
	   $t -> purge();                              
	}    



####################################
## DEBUT 
if(scalar(@ARGV)<2){
	die "Aargument obligatoire :
	1 - dossier a traiter
	2 - formats de sortie : csv json xml txt
	";
}

$DOCS=shift @ARGV;
if(-e $DOCS){
		say "Lecture de $DOCS...";
	}
	else{
		die "$DOCS n'existe pas !\n";
	}
	
while(@ARGV){		
	push @FORMATS, shift;
}


my $dir = dir($DOCS);
say "--- documents : ".$dir->children(no_hidden => 1);

$dir->recurse(depthfirst => 1, callback => sub {
	my $obj = shift;
	
	if ($obj->is_dir) {
		if ($obj->basename ne "ALTO") {
		   $id = $obj->basename;
		   print "\n".$id."... ";
		   $nbDoc=$nbDoc + genereMD($obj,$id,$handlerMETS);
		   
		 } else {
		 	#print "ALTO...\n";
		 	genereMDALTO($obj,$obj->parent->basename,$handlerALTO);
		 	$hash{"pages"} = $numPageALTO-1;
		 		
		 	foreach my $f (@FORMATS) {
  			ecrireMD($f);}
			}
	}
});

say "\n\n=============================";
say "$nbDoc documents traites";	
say "=============================";

$t1 = Benchmark->new;
$td = timediff($t1, $t0);
say "the code took:",timestr($td);
    
########### FIN ##################



#open(FIC, "$fic") or die "Pas de fichier !\n";
#print "...\n";

#my $txt;
#while(<FIC>){
	#$txt=$_;
  #$nbURL++;
	#print "\n$nbURL : ";	
	#$nbDoc=$nbDoc + genereMD($txt,$handlerRefnum);
#}
#close FI;	
  	

# ----------------------
# traitement des MD d'un document via son METS
sub genereMD {
	my $rep=shift;
	my $idDoc=shift;
  my $handler=shift;
  
	
	my $ficMETS = $rep->file($idDoc."-METS.xml");	
	  if(-e $ficMETS){   
		   return lireMD($ficMETS,$idDoc,$handler);
	     }
	   else{
		   say "$ficMETS n'existe pas !";
		   return 0;
	   }
}
                                                      
	
# ----------------------
# parsing d'un METS et ecriture du fichier des MD 
sub lireMD {
	my $ficMETS=shift;
	my $idDoc=shift; # ID document
	my $handler=shift;
	
	my $t;
	my $articles = 0;
	my $titre = "inconnu";
	my $date = "inconnu";
	
	# raz hash
	%hash = ();
	
	print "chargement de $ficMETS...\n"; 
  #$t = XML::Twig -> new(output_filter=>'safe'); 
  #$t = XML::Twig -> new(); 
  #$t -> setTwigHandlers($handlerMETS); # parser avec un gestionnaire 
  #$t -> parsefile($ficMETS);  
  #$t -> purge(); # décharger le contenu parsé
  
  # extraire par regexp (plus rapide)   
  open my $fh, '<', $ficMETS or die "Impossible d'ouvrir : $ficMETS !";
  if ($articles==0) {
  	local $/;
  	( $titre ) = <$fh> =~ m/\<title\>(.+)\<\/title\>/; 
 	  seek $fh, 0, 0;  
  	( $date ) = <$fh> =~ m/\>(.+)\<\/mods:dateIssued/; 
  	seek $fh, 0, 0;
  	$hash{"titre"} = $titre;	
		$hash{"date"} = $date;
		$hash{"supplement"}=(length($idDoc)>10); # les supplements ont une extension _02_1
		if (length($idDoc)>10) {
		 $hash{"supplement"}="TRUE";}
		 	else {$hash{"supplement"}="FALSE";}
  }
  
  while (my $line = <$fh>) { 	
   $articles++  if $line =~ /ARTICLE/;   # TYPE="ARTICLE"
  } 
	$hash{"articles"} = $articles;
	   
	return 1;
}

# traitement des MD des fichiers ALTO
sub genereMDALTO {
	my $rep=shift;
	my $idDoc=shift;
  my $handler=shift;
  
  #print "REP :".$rep;
  #print "  ID : ". $idDoc."  ";
  $numPageALTO=1;
   
  # traiter tous les ALTO et ajouter dans le fichier des MD
	while (my $fichier = $rep->next) {
			if (index($fichier, ".xml") != -1) {
		    print $numPageALTO."\n";
		    lireMDALTO($fichier,$numPageALTO,$idDoc,$handler);
		    $numPageALTO++;   
		  }                                                                                                  
}}  


# analyse d'un fichier ALTO et ecriture du fichier des MD 
sub lireMDALTO {
	my $fichier=shift;
	my $numPage=shift;
	my $idDoc=shift; # ID document
	my $handler=shift;
	
	#my $t;
	
  my $mots = 0;
  my $textes = 0;
  my $pubs = 0;
  my $ills = 0;
  my $tabs = 0;
 
  
	# raz hash
	#%hash = ();
	
	#  extraire par parsing (lent...)
	#$t = XML::Twig -> new(output_filter=>'safe'); 
  #$t -> setTwigHandlers($handlerALTO); # parser avec un gestionnaire 
  #$t -> parsefile($fichier);        
  #$t -> purge(); # décharger le contenu parsé
   
  # extraire par regexp (plus rapide) 
  open my $fh, '<', $fichier or die "Impossible d'ouvrir : $fichier !";
  
  if ($numPage == 1) { 
  	local $/; 	 	
  	my ( $largeur ) = <$fh> =~ m/WIDTH=\"(\d+)\"/;
  	#my $largeur  = extraireChaine("WIDTH=\"(\d+)\"",$fh);
  	seek $fh, 0, 0;
    my ( $hauteur ) = <$fh> =~ m/HEIGHT=\"(\d+)\"/; 
    
    $hash{"largeur"} = int($largeur*25.4/$DPI); # conversion en mm
    $hash{"hauteur"} = int($hauteur*25.4/$DPI); 
    seek $fh, 0, 0;
}
  
  while (my $line = <$fh>) { 	
   $mots++  if $line =~ /<String/;
   $textes++ if $line =~ /<TextBlock/;
   $pubs++ if $line =~ /\"Advertisement/;
   $ills++ if $line =~ /\"Illustration/;
   $tabs++ if $line =~ /\"Table/;
  } 
   
  $hash{$numPage."_mots"} = $mots;  
  $hash{$numPage."_blocsTexte"} = $textes;
  $hash{$numPage."_blocsPub"} = $pubs;
  $hash{$numPage."_blocsIllustration"} = $ills;
  $hash{$numPage."_blocsTab"} = $tabs;
  
  close $fh;
}  





# ----------------------                            
# écriture des MD 
sub ecrireMD {
	my $format=shift;;  
  
  my $ficOut = $OUT."/".$id.".".$format;  
  
  # s'il existe déjà, supprimer
  if(-e $ficOut){
		unlink $ficOut;
	} 
	  
  if ((keys %hash)==0) {
  	say "HASH VIDE !";
  	  }
  # fichier des MD en sortie
  open my $fh, '>>', $ficOut; 
  
  if ($format eq "csv") {
  	print "csv...";
  	print {$fh} $hash{"titre"}.";";
  	print {$fh} $hash{"date"}.";";
  	print {$fh} $hash{"pages"}.";";
  	print {$fh} $hash{"articles"}.";";
  	print {$fh} $hash{"largeur"}.";";  # en mm
    print {$fh} $hash{"hauteur"}.";";
    print {$fh} $hash{"supplement"}.";";
    for($p = 1; $p <= $hash{"pages"}; $p++) { 	
      print {$fh} $hash{$p."_mots"}.";";
      print {$fh} $hash{$p."_blocsTexte"}.";";
      print {$fh} $hash{$p."_blocsTab"}.";";
      print {$fh} $hash{$p."_blocsPub"}.";";
      print {$fh} $hash{$p."_blocsIllustration"}.";";
      	}
     print {$fh} "\n";
  }
  elsif ($format eq "xml") {
  	print "xml...";
  	print {$fh} "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<analyseAlto>\n<metad>";
  	print {$fh} "<titre>".$hash{"titre"}."</titre>";
  	print {$fh} "<dateEdition>".$hash{"date"}."</dateEdition>";
  	print {$fh} "<nbPage>".$hash{"pages"}."</nbPage>";
  	print {$fh} "<suppl>".$hash{"supplement"}."</suppl></metad>";
  	print {$fh} "<contenus>";
  	print {$fh} "<nbArticle>".$hash{"articles"}."</nbArticle>";
  	print {$fh} "<largeur>".$hash{"largeur"}."</largeur>";  # en mm
    print {$fh} "<hauteur>".$hash{"hauteur"}."</hauteur>";     
    for($p = 1; $p <= $hash{"pages"}; $p++) {
      print {$fh} "<page>";  	
      print {$fh} "<nbMot>".$hash{$p."_mots"}."</nbMot>";
      print {$fh} "<blocTexte>".$hash{$p."_blocsTexte"}."</blocTexte>";
      print {$fh} "<blocTab>".$hash{$p."_blocsTab"}."</blocTab>";
      print {$fh} "<blocPub>".$hash{$p."_blocsPub"}."</blocPub>";
      print {$fh} "<blocIllustration>".$hash{$p."_blocsIllustration"}."</blocIllustration>";
      print {$fh} "</page>"; 
      }
    print {$fh} "</contenus></analyseAlto>\n";
  }
  elsif ($format eq "json") {
  	print "json...";
  	print {$fh} "{ \"metad\":\n";
  	print {$fh} " { \"titre\": \"".$hash{"titre"}."\",\n";
  	print {$fh} "   \"dateEdition\": \"".$hash{"date"}."\",\n";
  	print {$fh} "   \"nbPage\": ".$hash{"pages"}.",\n";
  	print {$fh} "     \"suppl\": \"".$hash{"supplement"}."\"},\n"; 
  	print {$fh} "  \"contenus\": {\n";
  	print {$fh} "     \"nbArticle\": ".$hash{"articles"}.",\n";
  	print {$fh} "     \"largeur\": ".$hash{"largeur"}.",\n";  # en mm
    print {$fh} "     \"hauteur\": ".$hash{"hauteur"}.",\n";    
    print {$fh} "  \"page\": [\n";
    for($p = 1; $p <= $hash{"pages"}; $p++) {      	
      print {$fh} "    {\"nbMot\": ".$hash{$p."_mots"}.",";
      print {$fh} " \"blocTexte\": ".$hash{$p."_blocsTexte"}.",";
      print {$fh} " \"blocTab\": ".$hash{$p."_blocsTab"}.",";
      print {$fh} " \"blocPub\": ".$hash{$p."_blocsPub"}.",";
      print {$fh} " \"blocIllustration\": ".$hash{$p."_blocsIllustration"}."}";
      if ($p<$hash{"pages"}) { print {$fh} ",\n";}
      }
    print {$fh} "]}}";}
  else {  # TXT
  	#say Dumper(\%hash); 
  	print "txt...";
  	while (my ($cle,$valeur)=each %hash) {
  	print {$fh} $cle.":".$valeur."\n";
  }}
  close $fh; 
}

  
# ----------------------                            
# calcul d'un ark  à partir d'un ID de document BnF 
sub calculeArk {my $id=shift;                       
    	                                                  
    	my $ark="1";                                      
    	my $type="NUMM"; #                                
    	                                                  
    	print substr($id, 0, 5);                          
    	print  "\n";                                      
    	if ($type ne "IFN"){                              
    		$ark="ark:/12148/".$id.arkControle("bpt6k".$id);    
    	} else                                            
    	{                                                 
    	  $ark="ark:/12148/".$id.arkControle("btv1b".$id);    
    	}                                                 
    	                                                  
    	return $ark;                                      
    	                                                  
    }  
                                                     
# calcul d'un caractère de controle ark à partir d'un nom ark
sub arkControle {my $txt=shift;                              
	                                                           
	my $ctrl="";                                               
	my $tableCar="0123456789bcdfghjkmnpqrstvwxz";              
	                                                           

     return 1;
}                                                            
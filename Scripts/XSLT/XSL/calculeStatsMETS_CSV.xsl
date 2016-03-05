<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 3 sp1 (http://www.altova.com) by BnF (BNF) -->
<!--Auteur  : BnF/DSR/DSC/NUM/JP Moreux, Version : 1.0 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:str="http://bibnum.bnf.fr/ns/alto_prod">
	<!-- paramètre XSL -->
	<xsl:param name="xslParam"/>
	<!-- variables globale  -->
	<xsl:variable name="numPages">
		<xsl:value-of select="//nbpages"/>
	</xsl:variable>
	<xsl:variable name="ocrCorrige">
		<xsl:value-of select="//ocrcorrige"/>
	</xsl:variable>
	<xsl:variable name="nl">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	<xsl:variable name="sep">
		<xsl:text>;</xsl:text>
	</xsl:variable>
	<xsl:output method="text" indent="no" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<!-- UD<xsl:value-of select="$sep"/>Titre<xsl:value-of select="$sep"/>ark<xsl:value-of select="$sep"/>Pages<xsl:value-of select="$sep"/>Date num<xsl:value-of select="$sep"/>NQA moyen (%)<xsl:value-of select="$sep"/>Qualité OCR<xsl:value-of select="$sep"/>Taux OCR de base (%)<xsl:value-of select="$sep"/>Taux OCR de base corr (%)<xsl:value-of select="$sep"/>Mots<xsl:value-of select="$sep"/>Mots par page<xsl:value-of select="$sep"/>AB<xsl:value-of select="$sep"/>C<xsl:value-of select="$sep"/>AB déq<xsl:value-of select="$sep"/>C déq<xsl:value-of select="$sep"/>C illegible<xsl:value-of select="$sep"/>Bloc txt<xsl:value-of select="$sep"/>Blocs txt déq.<xsl:value-of select="$sep"/>Blocs de titre<xsl:value-of select="$sep"/>Blocs tab<xsl:value-of select="$sep"/>Blocs script<xsl:value-of select="$sep"/>Blocs tampon<xsl:value-of select="$sep"/>Blocs pub<xsl:value-of select="$sep"/>Illustrations<xsl:value-of select="$sep"/>Elts graph.<xsl:value-of select="$sep"/>Blocs comp.<xsl:value-of select="$sep"/>Taux de couverture (%)<xsl:value-of select="$sep"/>Taux de couv. réel (%)<xsl:value-of select="$sep"/>Zones déqualifiées (%)<xsl:value-of select="$sep"/>Taux Q du marché (%)<xsl:value-of select="$sep"/>Taux Q réel (%)<xsl:value-of select="$sep"/>Alerte TQ<xsl:value-of select="$sep"/>Alerte zones déq.<xsl:value-of select="$sep"/>Alerte illegible<xsl:value-of select="$sep"/>Alerte titres<xsl:value-of select="$sep"/>Alerte HQ<xsl:value-of select="$nl"/> -->
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="fichier">

</xsl:template>
	<xsl:template match="metad">
		<xsl:variable name="ark">
			<xsl:value-of select="ark"/>
		</xsl:variable>
		<xsl:value-of select="ud"/>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="titre"/>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="$ark"/>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="dateEdition"/>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="$numPages"/>
		<xsl:value-of select="$sep"/>
	</xsl:template>
	<xsl:template match="ocr">
		<xsl:value-of select="dateNum"/>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="nqa"/>
		<xsl:value-of select="$sep"/>
		<xsl:choose>
			<xsl:when test="count(//qualiteHQ)=1">HQ</xsl:when>
			<xsl:otherwise>brute</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="ocrbase"/>
		<xsl:value-of select="$sep"/>
		<xsl:value-of select="$ocrCorrige"/>
		<xsl:value-of select="$sep"/>
	</xsl:template>
	<xsl:template match="contenus">
		<xsl:variable name="numArticle">
			<xsl:value-of select="nbArticle"/>
		</xsl:variable>
		<xsl:value-of select="$numArticle"/>
		<xsl:value-of select="$sep"/>
		<xsl:variable name="numTot">
			<xsl:value-of select="sum(page/nbString)"/>
		</xsl:variable>
		<xsl:value-of select="$numTot"/>
		<xsl:value-of select="$sep"/>
		<!-- <xsl:variable name="numCar"><xsl:value-of select="sum(//nbCar)"/></xsl:variable>
<xsl:value-of select="$numCar"/><xsl:value-of select="$sep"/>-->
		<xsl:value-of select="$sep"/>
		<!-- <xsl:variable name="numMoy"><xsl:value-of select="round(number($numTot div $numPages))"/></xsl:variable> 
<xsl:value-of select="$numMoy"/>-->
		<xsl:value-of select="$sep"/>
		<!-- Population qualifiée -->
		<!-- <xsl:variable name="numAB"><xsl:value-of select='sum(//nbAB)'/></xsl:variable>
 <xsl:variable name="numC"><xsl:value-of select="sum(//nbC)"/></xsl:variable>
  <xsl:value-of select="$numAB"/>-->
		<xsl:value-of select="$sep"/>
		<!-- <xsl:value-of select="$numC"/>-->
		<xsl:value-of select="$sep"/>
		<!--  Population déqualifiée -->
		<!-- <xsl:variable name="numABDeq"><xsl:value-of select='sum(//nbABDeq)'/></xsl:variable>
 <xsl:variable name="numCDeq"><xsl:value-of select="sum(//nbCDeq)"/></xsl:variable>
 <xsl:value-of select="$numABDeq"/>-->
		<xsl:value-of select="$sep"/>
		<!-- <xsl:value-of select="$numCDeq"/>-->
		<xsl:value-of select="$sep"/>
		<!--<xsl:variable name="numill"><xsl:value-of select="sum(//nbCill)"/></xsl:variable>
 <xsl:value-of select="$numill"/>-->
		<xsl:value-of select="$sep"/>
		<!--  Mesures  -->
		<xsl:variable name="numBloc">
			<xsl:value-of select="sum(page/blocTexte)"/>
		</xsl:variable>
		<xsl:value-of select="$numBloc"/>
		<xsl:value-of select="$sep"/>
		<!--  <xsl:variable name="numBlocDeq"><xsl:value-of select="sum(//blocIllegible)"/></xsl:variable>
 <xsl:value-of select="$numBlocDeq"/><xsl:value-of select="$sep"/> -->
		<xsl:value-of select="$sep"/>
		<!--  <xsl:variable name="numTitre"><xsl:value-of select="sum(//blocTitre)"/></xsl:variable>
<xsl:value-of select="$numTitre"/>-->
		<xsl:value-of select="$sep"/>
		<xsl:variable name="numTab">
			<xsl:value-of select="sum(page/blocTab)"/>
		</xsl:variable>
		<xsl:value-of select="$numTab"/>
		<xsl:value-of select="$sep"/>
		<!--  <xsl:variable name="numScript"><xsl:value-of select="sum(//blocScript)"/></xsl:variable>
 <xsl:value-of select="$numScript"/><xsl:value-of select="$sep"/>-->
		<xsl:value-of select="$sep"/>
		<!--   <xsl:variable name="numnonLatin"><xsl:value-of select="sum(//blocnonLatin)"/></xsl:variable>
 <xsl:value-of select="$numnonLatin"/><xsl:value-of select="$sep"/>-->
		<xsl:value-of select="$sep"/>
		<!--  <xsl:variable name="numTampon"><xsl:value-of select="sum(//blocTampon)"/></xsl:variable>
<xsl:value-of select="$numTampon"/><xsl:value-of select="$sep"/> -->
		<xsl:value-of select="$sep"/>
		<xsl:variable name="numPub">
			<xsl:value-of select="sum(page/blocPub)"/>
		</xsl:variable>
		<xsl:value-of select="$numPub"/>
		<xsl:value-of select="$sep"/>
		<xsl:variable name="numImg">
			<xsl:value-of select="sum(page/blocIllustration)"/>
		</xsl:variable>
		<xsl:value-of select="$numImg"/>
		<xsl:value-of select="$sep"/>
		<!--  Nombre d'images en page de une -->
		<xsl:variable name="numImg">
			<xsl:value-of select="page[1]/blocIllustration"/>
		</xsl:variable>
		<xsl:value-of select="$numImg"/>
		<xsl:value-of select="$sep"/>
		<!-- <xsl:variable name="numGE"><xsl:value-of select="sum(//blocGE)"/></xsl:variable>
<xsl:value-of select="$numGE"/>-->
		<xsl:value-of select="$sep"/>
		<!-- <xsl:variable name="numCB"><xsl:value-of select="sum(//blocCB)"/></xsl:variable>
<xsl:value-of select="$numCB"/>-->
		<xsl:value-of select="$sep"/>
		<!-- [text()] pour éviter que les balises vides -> NaN -->
		<!--<xsl:variable name="numCourbures"><xsl:value-of select="sum(//nbCourbures[text()])"/></xsl:variable> 
<xsl:value-of select="$numCourbures"/>-->
		<xsl:value-of select="$sep"/>
		<!--  Taux qualité -->
		<!-- Taux de couverture du marché : (1 - (ill. /A + B + C)) dans zones qualifiées &#x2014;&#160; seuil presse : 90 % / seuil imprimé : 95 %-->
		<!-- <xsl:variable name="tauxCouv"><xsl:value-of select="number(100*(1-($numill div ($numAB + $numC))))"/></xsl:variable>
<xsl:value-of select="round(100*$tauxCouv) div 100"/>-->
		<xsl:value-of select="$sep"/>
		<!-- Taux de couverture réel : (1 - (ill. + déq.) / total)) -->
		<!--  <xsl:variable name="populationDeq"><xsl:value-of select="number($numill + $numABDeq + $numCDeq)"/></xsl:variable>
  <xsl:variable name="tauxCouvReel"><xsl:value-of select="number(100*(1-($populationDeq div $numTot)))"/></xsl:variable>
 <xsl:value-of select="round(100*$tauxCouvReel) div 100"/>-->
		<xsl:value-of select="$sep"/>
		<!-- Zones déqualifiées :  (1 - (deq. / total))-->
		<!-- <xsl:variable name="zonesDeq"><xsl:value-of select="number(100*(($numABDeq + $numCDeq) div ($numTot)))"/></xsl:variable>
<xsl:value-of select="round(100*$zonesDeq) div 100"/>-->
		<xsl:value-of select="$sep"/>
		<!-- Taux Q du marché : moyenne des WC sur zones qualifiées-->
		<!-- <xsl:variable name="sommeWCmarche"><xsl:value-of select="sum(//sommeWCJ)"/></xsl:variable>
 <xsl:variable name="populationQmarche"><xsl:value-of select="sum(//populationWCJ)"/></xsl:variable>
 <xsl:variable name="tauxCalMarche"><xsl:value-of select="number(100*($sommeWCmarche div $populationQmarche))"/></xsl:variable>
<xsl:value-of select="round(100*$tauxCalMarche) div 100"/>-->
		<xsl:value-of select="$sep"/>
		<!-- Taux Q réel : moyenne des WC : moyenne des WC sur population totale -->
		<xsl:variable name="sommeWC">
			<xsl:value-of select="sum(//sommeWC)"/>
		</xsl:variable>
		<xsl:variable name="tauxCalReel">
			<xsl:value-of select="number(100*($sommeWC div $numTot))"/>
		</xsl:variable>
		<xsl:value-of select="round(100*$tauxCalReel) div 100"/>
		<xsl:value-of select="$sep"/>
		<!--  Alertes -->
		<!--   Taux qualité -->
		<!-- supprimer le % à la fin  -->
		<!-- <xsl:variable name="tauxCorr"><xsl:value-of select="number(substring($ocrCorrige,1,string-length($ocrCorrige) - 1))"/></xsl:variable> 
  
  <xsl:variable name="delta"><xsl:value-of select="number($tauxCalMarche) - number($tauxCorr)"/></xsl:variable>
  <xsl:choose>
            <xsl:when test="number($delta &lt; 0)"><xsl:value-of select="$delta"/></xsl:when>
            <xsl:otherwise>NON</xsl:otherwise> 
    </xsl:choose>-->
		<xsl:value-of select="$sep"/>
		<!--   Zones  déqualifiées -->
		<!-- <xsl:choose>
            <xsl:when test="number($zonesDeq &gt; 25.0)"><xsl:value-of select="round(100*$zonesDeq) div 100"/></xsl:when> 
             <xsl:otherwise>NON</xsl:otherwise>  
   </xsl:choose>-->
		<xsl:value-of select="$sep"/>
		<!--  Mots typés 'illegible' avec un WC > 0.5 -->
		<!--  <xsl:variable name="numPBill"><xsl:value-of select='sum(//nbPBill)'/></xsl:variable>
   <xsl:choose>
            <xsl:when test="$numPBill &gt; 0"><xsl:value-of select="$numPBill"/></xsl:when> 
            <xsl:otherwise>NON</xsl:otherwise>  
   </xsl:choose> -->
		<xsl:value-of select="$sep"/>
		<!--  Aucun bloc TextBlock typé 'titre' (Titre1 ou Titre2) -->
		<!--  <xsl:choose>
            <xsl:when test="$numTitre = 0">OUI</xsl:when> 
            <xsl:otherwise>NON</xsl:otherwise>  
   </xsl:choose>-->
		<xsl:value-of select="$sep"/>
		<!-- qualité HQ est obtenue sur un document OCR garanti -->
		<!-- OCR brut et taux >  -->
		<!-- <xsl:choose>
            <xsl:when test="(count(//qualiteHQ)=0) and number($tauxCorr &gt; 98.5) ">OUI</xsl:when> 
            <xsl:otherwise>NON</xsl:otherwise>  
   </xsl:choose> -->
		<!-- le document est un supplément de presse ? -->
		<xsl:variable name="longFichier">
			<xsl:value-of select="string-length($xslParam)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$longFichier>10">OUI</xsl:when>
			<xsl:otherwise>NON</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="count(//page)=0">
			<xsl:value-of select="$sep"/>Aucune donnée d'analyse concernant les pages ALTO n'est présente !    
</xsl:if>
		<xsl:variable name="ficAbsents">
			<xsl:value-of select="count(//FICHIER_ABSENT)"/>
		</xsl:variable>
		<xsl:if test="$ficAbsents!=0">
			<xsl:value-of select="$sep"/>Les données d'analyse de certaines pages ALTO (<xsl:value-of select="$ficAbsents"/>) sont absentes   
</xsl:if>
		<xsl:value-of select="$nl"/>
		<!-- fin de ligne  -->
	</xsl:template>
</xsl:stylesheet>

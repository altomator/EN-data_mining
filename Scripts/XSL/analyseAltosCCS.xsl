<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:alto="http://schema.ccs-gmbh.com/docworks/version20/alto-1-4.xsd" xmlns:str="http://exslt.org/strings" xmlns:mets="http://www.loc.gov/METS/" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" extension-element-prefixes="str">
	 
	<!-- paramètre XSL -->  
	<xsl:param name="xslParam" select="otherwise" />
	
	<!-- variables globale  -->
    <xsl:variable name="PATH">..\DOCS\</xsl:variable>
 
   
     
	<xsl:output method="xml" omit-xml-declaration="no"/>
	<xsl:template match="/">
		<analyseAlto>
			<metad>
			    
				<!-- métadonnées bibliographiques 
count(//mets:file[substring(@ID, 4)='ALTO'])-->
				<titre>
					<xsl:value-of select="//mods:titleInfo/mods:title"/>
				</titre>
				<genre>PERIODIQUE</genre>
				
				<dateEdition>
					<xsl:value-of select="//mods:dateIssued"/>
				</dateEdition>
				<xsl:variable name="nbPages">
					<xsl:value-of select="count(//mets:file[substring(@ID,0,5)='ALTO'])"/>
				</xsl:variable>
				<nbpages>
					<xsl:value-of select="$nbPages"/>
				</nbpages>
				
			</metad>
			<ocr>
				<!-- pas de taux qualité  -->
			</ocr>
			<!-- le numéro d'UC = le dossier où chercher les Alto -->
			<!-- analyse des contenus METS  -->
			<contenus>
			     <nbArticle>
					<xsl:value-of select="count(/mets:mets/mets:structMap[@TYPE='LOGICAL']//mets:div[@TYPE='ARTICLE'])"/>
				</nbArticle>
				<!-- 
				<blocTab>
					<xsl:value-of select="count(/mets:mets/mets:structMap[@TYPE='LOGICAL']//mets:div[@TYPE='TABLE'])"/>
				</blocTab>
				<blocPub>
					<xsl:value-of select="count(/mets:mets/mets:structMap[@TYPE='LOGICAL']//mets:div[@TYPE='ADVERTISEMENT'])"/>
				</blocPub>
				<blocIllustration>
					<xsl:value-of select="count(/mets:mets/mets:structMap[@TYPE='LOGICAL']//mets:div[@TYPE='ILLUSTRATION'])"/>
				</blocIllustration> 
				-->
			   <!-- <xsl:for-each select="//mets:file[substring(@ID,0,5)='ALTO']">
			        
					<xsl:variable name="tmp">
						<xsl:value-of select="@ID"/>
					</xsl:variable>
					
					<xsl:variable name="numPage">
					   <xsl:value-of select="number($nomFic)"/>
					</xsl:variable>   
					<xsl:value-of select="$numPage"/>
					</xsl:for-each>-->
					
					<!-- analyse des contenus ALTO  -->
					<xsl:for-each select="/mets:mets/mets:fileSec/mets:fileGrp/mets:fileGrp/mets:file[substring(@ID,0,5)='ALTO']/*">
					<page>
					    <xsl:variable name="tmp" select="@xlink:href"/>	
					    <xsl:variable name="ficAlto">
						     <xsl:value-of select="substring($tmp,10)"/> <!-- supprimer "file://."  -->
					    </xsl:variable>	
						<fichier>
						     <xsl:value-of select="$ficAlto"/>
						</fichier>  
						
						<!-- Calcul du chemin vers le fichier  -->
										
					<!-- Les dossiers des documents sont stockés dans le dossier DOCS, au même niveau que XSL  -->
					<xsl:variable name="chemin" select="concat($PATH,$xslParam)"/>
					<xsl:variable name="chemin" select="concat($chemin,'\')"/>   
					<xsl:variable name="chemin" select="concat($chemin,$ficAlto)"/>    
												    
					<xsl:choose>
							<xsl:when test="document($chemin)">
								<nbString>
								    <xsl:value-of select="count(document($chemin)/alto/Layout/Page/PrintSpace//String)"/>
								</nbString>
							</xsl:when>
							<xsl:otherwise>
								<FICHIER_ABSENT/>
							</xsl:otherwise>
						</xsl:choose>
						
						<nbCar><!-- pas utile
									<xsl:variable name="numCar">
										<xsl:for-each select="document($chemin)//String">
											<xsl:value-of select="@CONTENT"/>
										</xsl:for-each>
									</xsl:variable>
									<xsl:value-of select="string-length($numCar)"/>-->
						</nbCar>
						<!-- les blocs   -->
						<blocTexte>
								<xsl:value-of select="count(document($chemin)/alto/Layout/Page/PrintSpace//TextBlock)"/>
						</blocTexte>
						<blocTab>
								<xsl:value-of select="count(document($chemin)/alto/Layout/Page/PrintSpace//ComposedBlock[(@TYPE='Table')])"/>
						</blocTab>
						<!-- les publicités   -->
						<blocPub>
								<xsl:value-of select="count(document($chemin)/alto/Layout/Page/PrintSpace//ComposedBlock[(@TYPE='Advertisement')])"/>
						</blocPub> 
						<!-- les blocs de texte publicités   : inutile car un TextBlock par ComposedBlock 
						<blocTextePub>
								<xsl:value-of select="count(document($chemin)//ComposedBlock[(@TYPE='Advertisement')]/TextBlock)"/>
						</blocTextePub> -->
						<!-- les images  -->
						<blocIllustration>
								<xsl:value-of select="count(document($chemin)/alto/Layout/Page/PrintSpace//Illustration)+count(document($chemin)/alto/Layout/Page/PrintSpace//ComposedBlock[(@TYPE='Illustration')])"/>
						</blocIllustration>
						<!-- les blocs image publicités   : inutile car non segmentés 						
						<blocIllustrationPub>
								<xsl:value-of select="count(document($chemin)//ComposedBlock[(@TYPE='Advertisement')]/Illustration)"/>
						</blocIllustrationPub> -->
						<sommeWC>
							<xsl:value-of select="sum(document($chemin)/alto/Layout/Page/PrintSpace//String/@WC)"/>
						</sommeWC>		
					</page>	   
				</xsl:for-each>
			</contenus>
		</analyseAlto>
	</xsl:template>
</xsl:stylesheet>

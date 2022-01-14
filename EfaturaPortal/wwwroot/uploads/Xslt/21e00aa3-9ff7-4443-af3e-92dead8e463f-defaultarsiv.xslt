<?xml version="1.0" encoding="UTF-8"?>
	<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:ccts="urn:un:unece:uncefact:documentation:2"
	xmlns:clm54217="urn:un:unece:uncefact:codelist:specification:54217:2001"
	xmlns:clm5639="urn:un:unece:uncefact:codelist:specification:5639:1988"
	xmlns:clm66411="urn:un:unece:uncefact:codelist:specification:66411:2001"
	xmlns:clmIANAMIMEMediaType="urn:un:unece:uncefact:codelist:specification:IANAMIMEMediaType:2003"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase"
	xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2"
	xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
	xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="cac cbc ccts clm54217 clm5639 clm66411 clmIANAMIMEMediaType fn link n1 qdt udt xbrldi xbrli xdt xlink xs xsd xsi">
	<xsl:decimal-format name="european" decimal-separator="," grouping-separator="." NaN=""/>
<xsl:output version="4.0" method="html" indent="no" encoding="UTF-8"
	doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
	doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
<xsl:param name="SV_OutputFormat" select="'HTML'"/>

<xsl:template name="repNL">
  <xsl:param name="pText" select="."/>
  <xsl:if test="not(contains(substring(substring-before(concat($pText,'&#xA;'),'&#xA;'),0,8), '##') and not(contains(substring-before(concat($pText,'&#xA;'),'&#xA;'), '##internetSatis'))) and string-length(substring-before(concat($pText,'&#xA;'),'&#xA;'))>3">
  	<xsl:choose>
  	<xsl:when test="contains(substring-before(concat($pText,'&#xA;'),'&#xA;'), '##internetSatis')">
  		<b>* </b>  <xsl:copy-of select="substring-after(substring-after(substring-before(concat($pText,'&#xA;'),'&#xA;'),'##'),'#')"/><br />
  	</xsl:when>
  	<xsl:otherwise>
  		<b>* </b>  <xsl:copy-of select="substring-before(concat($pText,'&#xA;'),'&#xA;')"/><br />
  	</xsl:otherwise>
  	</xsl:choose>
	</xsl:if>
  <xsl:if test="contains($pText, '&#xA;')">
  	
   <xsl:call-template name="repNL">
    <xsl:with-param name="pText" select=
    "substring-after($pText, '&#xA;')"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

<xsl:template name="repNL2">
  <xsl:param name="pText" select="."/>
  <xsl:if test="contains(substring(substring-before(concat($pText,'&#xA;'),'&#xA;'),0,8), '##') and not(contains(substring-before(concat($pText,'&#xA;'),'&#xA;'), '##internetSatis'))">
  	<tr>
		<th><xsl:copy-of select="substring-after(substring-before(substring-before(concat($pText,'&#xA;'),'&#xA;'),':'),'##')"></xsl:copy-of>:</th>
		<td><xsl:copy-of select="substring-after(substring-before(concat($pText,'&#xA;'),'&#xA;'),':')"></xsl:copy-of></td>
		</tr>
	</xsl:if>
  <xsl:if test="contains($pText, '&#xA;')">
   <xsl:call-template name="repNL2">
    <xsl:with-param name="pText" select=
    "substring-after($pText, '&#xA;')"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

<xsl:variable name="XML" select="/"/>
<xsl:template name="removeLeadingZeros">
<xsl:param name="originalString"/>
	<xsl:choose>
		<xsl:when test="starts-with($originalString,'0')">
			<xsl:call-template name="removeLeadingZeros">
				<xsl:with-param name="originalString">
					<xsl:value-of select="substring-after($originalString,'0' )"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$originalString"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
		<xsl:template match="/">
	<xsl:comment>eFinans Şablon Tasarım Aracı İle Hazırlanmıştır.</xsl:comment>
	<html>
	<head>
<title>e-Arşiv Fatura</title>
<style type="text/css">
					.ph {overflow:hidden;max-height:250px;}
					.ph7 {text-align:center;margin-bottom:18px;}
					.ph8 img {margin-bottom: 18px;}
					.ph10 {
						float: left;
						width: 295px;
						margin-top: 14px;
						margin-right: 12px;
						padding: 8px;
					}

					body {
						margin: 7px 0 10px 0;
						text-align: center;
						background-color: #BBBBBB;
						font-family:Arial, Helvetica, sans-serif;
						background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAXCAYAAADgKtSgAAABCElEQVR42p1VWw7DIAzL/S/Z10E2pZKRZ8UB9oEKxaSJbdJ4nudzHMcYucY73VvB5Po8z3ce13UNMB/SAdzOXtz33WaGwzlyXuHzHfDAvcGrA1ryLj2YhwvaacFUgF/O2gbXIFwVzzt9Bi1OTDdXR/C+VhFdgB3K+IkKY8XnSlNmqB+rqg8+xJ5ncWbcMg62zASiysxVoTp0exknVqw349hVEaq647zyuDPACD7LqhJu9aZG9cXO9xBsdg9+3AKFXa9gB610xpcW7WTVgIM0ASdmSYvLmC+Po2VLUCcyV8F9vAzeZbvbzLR5hevFDKrWjOO/EKr5uaH//IAVx3oMWhg847167yz8BYJMf2ivVbLJAAAAAElFTkSuQmCC);
					}
					.documentContainer a {pointer-events:none;}
					.documentContainer,
					.documentContainerOuter {
							margin: 0 auto;
							}
					@media screen {
					body {color: #666;}
					.documentContainer {
							max-width: 945px;
							min-width: 945px;
							overflow:hidden;
							text-align: left;
							box-sizing: border-box;
							display:inline-block;
							-webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
							-moz-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
							box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
							background-color: white;
							position: relative;
							padding: 20px 20px 20px 28px;
						}
					
					.documentContainer:before, .documentContainer:after {
						content: "";
						position: absolute;
						z-index: -1;
						-webkit-box-shadow: 0 0 20px rgba(0,0,0,0.8);
						-moz-box-shadow: 0 0 20px rgba(0,0,0,0.8);
						box-shadow: 0 0 20px rgba(0,0,0,0.8);
						top: 50%;
						bottom: 0;
						left: 10px;
						right: 10px;
						-moz-border-radius: 100px / 10px;
						border-radius: 100px / 10px;
					}

					.documentContainer:after {
						right: 10px;
						left: auto;
						-webkit-transform: skew(8deg) rotate(3deg);
						-moz-transform: skew(8deg) rotate(3deg);
						-ms-transform: skew(8deg) rotate(3deg);
						-o-transform: skew(8deg) rotate(3deg);
						transform: skew(8deg) rotate(3deg);
					}
					}	

					#ustBolum{
						margin-top: 27px;
						margin-bottom: 15px;
					}
						.kutu {vertical-align: top;}
						
						.kutu table{float:none;}
						.gonderici {
							display: inline-block;
							padding: 8px 8px 8px 0;
							box-sizing: border-box;
						}
						.gonderici .partyName {font-weight:bold;}
						.alici {
							width: 370px;
							padding: 8px 4px 4px 0;
							box-sizing: border-box;
						}
						.alici .customerTitle {font-weight:bold;}
						.alici .kutu { border:1px solid #CCC; background-color:#F4F4F4;}
						
						#ETTN {
							margin-top: 7px;
							padding: 8px 4px 4px 0;
						}

						#despatchTable .placeHolder.companyLogo img {margin-bottom:18px;}
						
						#toplamlarContainer {overflow:hidden;}
						.toplamlar {float:right;width: 100%;}
						.toplamlar tr {text-align:right;}
						.toplamlar th {font-weight:normal;text-align:right;}
						.toplamlar table {width:238px;margin-top: 14px;border-spacing:0;}
						.toplamlar table td {font-weight: bold; width:25%; white-space:nowrap;min-width: 55px; vertical-align: top;
						}
						.toplamlar table th,
						.toplamlar table td{
							border-bottom: 1px solid #ccc;
							border-right: 1px solid #ccc;
							border-left: 1px solid #ccc;
							padding:3px;
						}
						.toplamlar table th {white-space:nowrap;border-right: none;}
						.toplamlar table th.is-long-true,
						#malHizmetTablosu > tbody > tr > td .is-long-true {white-space:pre-line;}
						.toplamlar table tr:first-child th,
						.toplamlar table tr:first-child td{
						border-top:1px solid #ccc;
						}
						.toplamlar table td span {font-weight:normal;color: #7C7C7C;}

						tr.payableAmount th:first-child {
							background-color: #f6f6f6;
						}

						tr.payableAmount td {
						background-color: #f6f6f6;
						}

						.toplamlar > div {
							display: inline-block;
						}
						.toplamTablo{
							margin-left: 31px;
							float:right;
						}
					#notlar {
						margin-top: 14px;
						border-top: 1px solid #DDD;
						overflow: hidden;
						padding-top: 8px;
						padding-bottom: 2px;

					}
					#notlar table {border:none;background:none;}
					.clearfix:before,
					.clearfix:after {
						content:"";
						display:table;
					}

					.box{display: inline-block;*display: inline;zoom: 1;width: 33%; box-sizing:border-box; vertical-align: top;}
					#b1{width: 40%;}
					#b2{width: 25%;}
					#b3{width: 35%;}
					#kunye {border-spacing:0;}
					#kunye tr{ border-bottom: 1px dotted #CCC;}
					#kunye td{ border:1px solid #CCC;border-top: none;padding:3px;width: 100%;}
					#kunye th{vertical-align:top;font-weight:bold;padding:3px;white-space: nowrap;border:1px solid #ccc;border-top: none;border-right: none;text-align:left;}
					#kunye tr:first-child td{border-top: 1px solid #ccc;}
					#kunye tr:first-child th{border-top: 1px solid #ccc;}
					#kunye td:nth-child(2) {word-break: break-all;}
					.satirlar {margin-top:20px;}
					#malHizmetTablosu
					{
						width:100%;
						font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
						background: #fff;
						border-collapse: collapse;
						text-align: right;
					}
					#malHizmetTablosu > tbody > tr > th
					{
						font-weight: normal;
						padding: 2px;
						text-align:right;
						color: black;
						padding-left: 3px;
						border-bottom: 2px solid #AAAAAA;
						background-color: #DFDFDF;
						border-right: 1px solid #B8B8B8;
						border-top: 1px solid #C5C5C5;
						padding-right: 5px;
						vertical-align: middle;
						min-height: 35px;
					}					
					#malHizmetTablosu > tbody > tr:first-child > th:first-child {border-left: 1px solid #B8B8B8;}
					#malHizmetTablosu > tbody > tr:first-child > th.mhColumn {min-width:72px;}
					#malHizmetTablosu > tbody > th > .thTopTitle {text-align:center;width: 89px;}
					#malHizmetTablosu > tbody > th .thSubTitle {width: 47px; display: inline-block;text-align: right;}
					#malHizmetTablosu > tbody > th .thSubTitle.HF {width:36px;}
					#malHizmetTablosu > tbody > tr > th.alignLeft {text-align:left;width: 50%;}

					#malHizmetTablosu > tbody > tr > td {
						word-break:break-all;
						padding-left:3px;
						border-bottom: 1px solid #ccc;
						color: #000;
						border-right: 1px solid #ccc;
						padding-right: 3px;
						text-align:right;
						height:25px;
					}
					#malHizmetTablosu > tbody > tr > td.iskontoOrani {padding-left:0; padding-right:0;}
					#malHizmetTablosu > tbody > tr > td.iskontoOrani td{text-align: center;}
					#malHizmetTablosu > tbody > tr:hover > td {border-right: 1px solid #969696;border-bottom: 1px solid #969696;border-top: 1px solid #969696;}
					#malHizmetTablosu > tbody > tr > td.wrap {white-space:normal;text-align:left;}
					#malHizmetTablosu > tbody > tr > td:first-child,
					#malHizmetTablosu > tbody > tr > th:first-child {border-left: 1px solid #B8B8B8;}

					#malHizmetTablosu > tbody > tr:hover > td
					{
						background-color: #D1D1D1 !important;
						cursor:default;
					}
					#malHizmetTablosu > tbody > tr:nth-child(even) > td {background-color: #FFF}
					#malHizmetTablosu > tbody > tr:nth-child(odd) > td {background-color: #EEE}
					.sumValue {white-space:nowrap;}
					.iskontoOraniHeader,
					.iskontoOraniDegerler {width:100%;border-spacing:0;}
					.iskontoOraniHeader td {border-top: 1px solid #969696;}
					.iskontoOraniHeader td,
					.iskontoOraniDegerler td
					{border-left: 1px solid #969696;}
					.iskontoOraniHeader td:first-child,
					.iskontoOraniDegerler td:first-child {border-left:none;}
					@media print {
						body {color: #000;text-align: left;background:none;background-color:#ffffff;margin:0;}
						.documentContainer {padding:0;min-height: initial;width: 845px !important;}
						#malHizmetTablosu {width: 845px;}
					}
					
					body,table{font-size:12px;}

</style>

	</head>
	<body>
			<div class="documentContainerOuter">
				<div class="documentContainer">
	<xsl:for-each select="$XML">
						<div id="ustBolum">
									<div id="b1" class="box"> 
										<div id="AccountingSupplierParty" class="gonderici kutu">
																	<xsl:for-each select="n1:Invoice">
									<xsl:for-each select="cac:AccountingSupplierParty">
									<xsl:for-each select="cac:Party">
									<div class="partyName">
									<xsl:if test="not(cac:Person/cbc:FirstName ='') or not(cac:Person/cbc:FamilyName ='')">
										<xsl:for-each select="cac:Person">
										<xsl:for-each select="cbc:Title">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:FirstName">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:MiddleName">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:FamilyName">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:NameSuffix">
										<xsl:apply-templates/>
										</xsl:for-each>
										</xsl:for-each>
										<br/>
									</xsl:if>
									<xsl:if test="not(cac:PartyName/cbc:Name ='')">
										<xsl:value-of select="cac:PartyName/cbc:Name"/>
									</xsl:if>
									</div>
									</xsl:for-each>
									</xsl:for-each>
									</xsl:for-each>
									
									<xsl:for-each select="n1:Invoice">
									<xsl:for-each select="cac:AccountingSupplierParty">
									<xsl:for-each select="cac:Party">
									<div class="addres">
									<xsl:for-each select="cac:PostalAddress">
									<xsl:for-each select="cbc:Region">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<xsl:for-each select="cbc:StreetName">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<xsl:for-each select="cbc:BuildingName">
									<xsl:apply-templates/>
									</xsl:for-each>
									<xsl:if test="cbc:BuildingNumber">
									<span>
									<xsl:text> No:</xsl:text>
									</span>
									<xsl:for-each select="cbc:BuildingNumber">
									<xsl:apply-templates/>
									</xsl:for-each>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:if>
									<xsl:for-each select="cbc:Room">
									<span>
									<xsl:text>Kapı No:</xsl:text>
									</span>
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>

									<xsl:if test="cbc:District !=''">
									<xsl:for-each select="cbc:District">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<br/>
									</xsl:if>
									
									<xsl:if test="cbc:PostalZone != '' ">
										<xsl:for-each select="cbc:PostalZone">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
									</xsl:if>
									<xsl:for-each select="cbc:CitySubdivisionName">
									<xsl:apply-templates/>
									</xsl:for-each>
									<span>
									<xsl:text> / </xsl:text>
									</span>
									<xsl:for-each select="cbc:CityName">
									<xsl:apply-templates/>
									</xsl:for-each>
									</xsl:for-each>
									</div>
									</xsl:for-each>
									</xsl:for-each>
									</xsl:for-each>
									
									<xsl:for-each select="n1:Invoice">
									<xsl:for-each select="cac:AccountingSupplierParty">
									<xsl:for-each select="cac:Party">
									<div class="telFax">
									<xsl:for-each select="cac:Contact">
									<xsl:if test="cbc:Telephone !=''">
									<span>
									<xsl:text>Tel: </xsl:text>
									</span>
									<xsl:for-each select="cbc:Telephone">
									<xsl:apply-templates/>
									</xsl:for-each>
									</xsl:if>
									<xsl:if test="cbc:Telefax !=''">
									<span>
									<xsl:text> Faks: </xsl:text>
									</span>
									<xsl:for-each select="cbc:Telefax">
									<xsl:apply-templates/>
									</xsl:for-each>
									</xsl:if>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									</div>
									</xsl:for-each>
									</xsl:for-each>
									</xsl:for-each>
									
								<xsl:for-each
									select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cbc:WebsiteURI">
									<div class="WebsiteURI">
									<xsl:text>Web Sitesi: </xsl:text>
									<xsl:value-of select="."/>
									</div>
								</xsl:for-each>
								
								<xsl:for-each
									select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
									<div class="eMail">
									<xsl:text>e-Posta: </xsl:text>
									<xsl:value-of select="."/>
									</div>
								</xsl:for-each>
								
									<div class="taxOffice">
										<xsl:text>Vergi Dairesi: </xsl:text>
										<xsl:value-of
										select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name"
										/>
									</div>
									
								<xsl:for-each
								select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
								<xsl:if test="@schemeID != 'MUSTERINO'">
								<div class="partyID">
									<xsl:choose>
										<xsl:when test="@schemeID = 'TICARETSICILNO'">
											<xsl:text>Ticaret Sicil No</xsl:text>
										</xsl:when>
										<xsl:when test="@schemeID = 'MERSISNO'">
											<xsl:text>MERSİS No</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="@schemeID"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text>: </xsl:text>
									<xsl:value-of select="."/>
								</div>
								</xsl:if>
								</xsl:for-each>
								
								

						</div>
						
						<div class="alici kutu">
														<div class="customerTitle">
									<xsl:text>SAYIN</xsl:text>
								</div>
								
								<div class="partyName">
									<xsl:for-each select="n1:Invoice">
									<xsl:for-each select="cac:AccountingCustomerParty">
									<xsl:for-each select="cac:Party">
									<div class="partyName">
									<xsl:if test="not(cac:Person/cbc:FirstName ='') or not(cac:Person/cbc:FamilyName ='')">
										<xsl:for-each select="cac:Person">
										<xsl:for-each select="cbc:Title">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:FirstName">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:MiddleName">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:FamilyName">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
										<xsl:for-each select="cbc:NameSuffix">
										<xsl:apply-templates/>
										</xsl:for-each>
										</xsl:for-each>
										<br/>
									</xsl:if>
									<xsl:if test="not(cac:PartyName/cbc:Name ='')">
										<xsl:value-of select="cac:PartyName/cbc:Name"/>
									</xsl:if>
									</div>
									</xsl:for-each>
									</xsl:for-each>
									</xsl:for-each>
								</div>	
								
								<div class="addres">
									<xsl:for-each select="n1:Invoice">
									<xsl:for-each select="cac:AccountingCustomerParty">
									<xsl:for-each select="cac:Party">
									<xsl:for-each select="cac:PostalAddress">
									<xsl:for-each select="cbc:Region">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<xsl:if test="cbc:StreetName !=''">
									<xsl:for-each select="cbc:StreetName">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									</xsl:if>

									<xsl:for-each select="cbc:BuildingName">
									<xsl:apply-templates/>
									</xsl:for-each>
									<xsl:if test="cbc:BuildingNumber !=''">
									<xsl:for-each select="cbc:BuildingNumber">
									<span>
									<xsl:text> No:</xsl:text>
									</span>
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<br/>
									</xsl:if>

									<xsl:if test="cbc:Room !=''">
									<xsl:for-each select="cbc:Room">
									<span>
									<xsl:text>Kapı No:</xsl:text>
									</span>
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<br/>
									</xsl:if>

									<xsl:if test="cbc:District !=''">
									<xsl:for-each select="cbc:District">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									<br/>
									</xsl:if>

									<xsl:if test="cbc:PostalZone != '' ">
										<xsl:for-each select="cbc:PostalZone">
										<xsl:apply-templates/>
										<span>
										<xsl:text>&#160;</xsl:text>
										</span>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="cbc:CitySubdivisionName != '' ">
									<xsl:for-each select="cbc:CitySubdivisionName">
									<xsl:apply-templates/>
									<span>
									<xsl:text>/ </xsl:text>
									</span>
									</xsl:for-each>
									</xsl:if>
									
									<xsl:if test="cbc:CityName != ''">
									<xsl:for-each select="cbc:CityName">
									<xsl:apply-templates/>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									</xsl:if>
									</xsl:for-each>

									</xsl:for-each>
									</xsl:for-each>
									</xsl:for-each>
								</div> 
								
<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone !='' or //n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
									<xsl:for-each select="n1:Invoice">
									<xsl:for-each select="cac:AccountingCustomerParty">
									<xsl:for-each select="cac:Party">
									<div class="telFax">
									<xsl:for-each select="cac:Contact">
									<xsl:if test="cbc:Telephone !=''">
									<span>
									<xsl:text>Tel: </xsl:text>
									</span>
									<xsl:for-each select="cbc:Telephone">
									<xsl:apply-templates/>
									</xsl:for-each>
									</xsl:if>
									<xsl:if test="cbc:Telefax !=''">
									<span>
									<xsl:text> Faks: </xsl:text>
									</span>
									<xsl:for-each select="cbc:Telefax">
									<xsl:apply-templates/>
									</xsl:for-each>
									</xsl:if>
									<span>
									<xsl:text>&#160;</xsl:text>
									</span>
									</xsl:for-each>
									</div>
									</xsl:for-each>
									</xsl:for-each>
									</xsl:for-each>
									
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cbc:WebsiteURI != ''">
								<xsl:for-each
								select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cbc:WebsiteURI">
								<div class="WebsiteURI">
									<xsl:text>Web Sitesi: </xsl:text>
									<xsl:value-of select="."/>
								</div>
								</xsl:for-each>
								
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail != ''">
								<xsl:for-each
								select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail">
								<div class="eMail">
									<xsl:text>e-Posta: </xsl:text>
									<xsl:value-of select="."/>
								</div>
								</xsl:for-each>
								
</xsl:if> 
									<div class="taxOffice">
										<xsl:text>Vergi Dairesi: </xsl:text>
										<xsl:value-of
										select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name"
										/>
									</div>
									
								<xsl:for-each
								select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification">
								<div class="partyID">
									<xsl:choose>
										<xsl:when test="cbc:ID/@schemeID = 'TICARETSICILNO'">
											<xsl:text>Ticaret Sicil No</xsl:text>
										</xsl:when>
										<xsl:when test="cbc:ID/@schemeID = 'MERSISNO'">
											<xsl:text>MERSİS No</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="cbc:ID/@schemeID"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text>: </xsl:text>
									<xsl:value-of select="cbc:ID"/>
								</div>
								</xsl:for-each>
								

						</div>
    <div id="ETTN"> 
						<span style="font-weight:bold; ">
							<xsl:text>ETTN: </xsl:text>
						</span>
						<xsl:for-each select="n1:Invoice">
							<xsl:for-each select="cbc:UUID">
							<xsl:apply-templates/>
							</xsl:for-each>
						</xsl:for-each>
		</div> 


				</div> 
<div id="b2" class="box"> 
						
								<div class="ph empty ph6">
								<xsl:text disable-output-escaping="yes"><![CDATA[<div><img style="display: block; margin-left: auto; margin-right: auto;" src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMZaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzMiA3OS4xNTkyODQsIDIwMTYvMDQvMTktMTM6MTM6NDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjZDNDJBNEI2QjVCRDExRThCQjM0REIwQkZGMEQxODY0IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjZDNDJBNEI1QjVCRDExRThCQjM0REIwQkZGMEQxODY0IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzQgV2luZG93cyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSIzREVENkU1N0FDREVDNEJBNzkxNUM2M0NCN0RENzM0NyIgc3RSZWY6ZG9jdW1lbnRJRD0iM0RFRDZFNTdBQ0RFQzRCQTc5MTVDNjNDQjdERDczNDciLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7/7gAOQWRvYmUAZMAAAAAB/9sAhAABAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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" alt="e-Arşiv Fatura Logo" width="86" height="84" align="middle"/></div>
<div style="text-align: center;"><span style="font-size: 11pt; font-weight: bold;">e-Arşiv Fatura<br/><br/><img src="data:image/jpeg;base64,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" alt="" width="150" height="58"/></span></div>
]]></xsl:text>
								</div>

</div> 
	<div id="b3" class="box">
	<div id="despatchTable">
				<div class="ph empty ph7">
		<xsl:text disable-output-escaping="yes"><![CDATA[<img src="data:image/jpeg;base64,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" alt="" width="200" height="196"/>
]]></xsl:text>
		</div>
	<div style="clear:both;"></div>
		<table id="kunye">
			<tbody>
													<tr>
											<th>
												<xsl:text>Tarih:</xsl:text>
											</th>
											<td>
											<xsl:for-each select="n1:Invoice">
											<xsl:for-each select="cbc:IssueDate">
											<xsl:value-of select="substring(.,9,2)"
											/>-<xsl:value-of select="substring(.,6,2)"
											/>-<xsl:value-of select="substring(.,1,4)"/>
											</xsl:for-each>
											</xsl:for-each>
											</td>
										</tr>
											<tr>
											<th>
												<xsl:text>Fatura No:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="n1:Invoice">
												<xsl:for-each select="cbc:ID">
												<xsl:apply-templates/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
										</tr>
										<tr>
											<th style="width:105px;">
												<xsl:text>Özelleştirme No:</xsl:text>
											</th>
											<td style="width:110px;">
												<xsl:for-each select="n1:Invoice">
												<xsl:for-each select="cbc:CustomizationID">
												<xsl:apply-templates/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
										</tr>
										<tr>
											<th>
												<xsl:text>Senaryo:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="n1:Invoice">
												<xsl:for-each select="cbc:ProfileID">
												<xsl:apply-templates/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
										</tr>
										<tr>
											<th>
												<xsl:text>Fatura Tipi:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="n1:Invoice">
												<xsl:for-each select="cbc:InvoiceTypeCode">
												<xsl:apply-templates/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
										</tr>
<xsl:if test="//n1:Invoice/cbc:AccountingCost !=''">
										<tr>
											<th>
												<xsl:text>Fatura Alt Tipi:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="n1:Invoice">
												<xsl:for-each select="cbc:AccountingCost">
												<xsl:apply-templates/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
										</tr>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:AdditionalDocumentReference[cbc:DocumentType = 'İade Edilen Fatura'] or //n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
										<tr>
											<th style="vertical-align:top;">
												<xsl:text>İade Fatura No:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
												<xsl:if test="position() !=1"><br/></xsl:if>
												<xsl:value-of select="cbc:ID"/>
												</xsl:for-each>
											</td>
										</tr>
										<tr>
											<th style="vertical-align:top;">
												<xsl:text>İade Fatura Tarihi:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="//n1:Invoice/cac:BillingReference/cac:InvoiceDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
												<xsl:if test="position() !=1"><br/></xsl:if>
												<xsl:value-of select="substring(cbc:IssueDate,9,2)"
												/>-<xsl:value-of select="substring(cbc:IssueDate,6,2)"
												/>-<xsl:value-of select="substring(cbc:IssueDate,1,4)"/>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:when>
									<xsl:when test="//n1:Invoice/cac:AdditionalDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
										<tr>
											<th style="vertical-align:top;">
												<xsl:text>İade Fatura No:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
												<xsl:if test="position() !=1"><br/></xsl:if>
												<xsl:value-of select="cbc:ID"/>
												</xsl:for-each>
											</td>
										</tr>
										<tr>
											<th style="vertical-align:top;">
												<xsl:text>İade Fatura Tarihi:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference[cbc:DocumentType = 'İade Edilen Fatura']">
												<xsl:if test="position() !=1"><br/></xsl:if>
												<xsl:value-of select="substring(cbc:IssueDate,9,2)"
												/>-<xsl:value-of select="substring(cbc:IssueDate,6,2)"
												/>-<xsl:value-of select="substring(cbc:IssueDate,1,4)"/>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
</xsl:if> 
										<xsl:for-each
											select="n1:Invoice/cac:DespatchDocumentReference">
											<tr>
											<th>
											<xsl:text>İrsaliye No:</xsl:text>
											</th>
											<td>
											<xsl:call-template name="removeLeadingZeros">  
											  <xsl:with-param name="originalString" select="cbc:ID"/>
											</xsl:call-template>
											</td>
											</tr>
											<tr>
											<th>
												<xsl:text>İrsaliye Tarihi:</xsl:text>
											</th>
											<td>
												<xsl:for-each select="cbc:IssueDate">
												<xsl:value-of select="substring(.,9,2)"
												/>-<xsl:value-of select="substring(.,6,2)"
												/>-<xsl:value-of select="substring(.,1,4)"/>
												</xsl:for-each>
											</td>
											</tr>
										</xsl:for-each>
<xsl:if test="//n1:Invoice/cac:OrderReference">
											<tr>
											<th>
												<xsl:text>Sipariş No:</xsl:text>
											</th>
											<td>
												<xsl:for-each
												select="n1:Invoice/cac:OrderReference">
												<xsl:for-each select="cbc:ID">
												<xsl:apply-templates/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
											</tr>
											<tr>
											<th>
												<xsl:text>Sipariş Tarihi:</xsl:text>
											</th>
											<td>
												<xsl:for-each
												select="n1:Invoice/cac:OrderReference">
												<xsl:for-each select="cbc:IssueDate">
												<xsl:value-of select="substring(.,9,2)"
												/>-<xsl:value-of select="substring(.,6,2)"
												/>-<xsl:value-of select="substring(.,1,4)"/>
												</xsl:for-each>
												</xsl:for-each>
											</td>
											</tr>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:PaymentMeans/cbc:PaymentDueDate or //n1:Invoice/cac:PaymentTerms/cbc:PaymentDueDate">
											<xsl:choose>
												<xsl:when test="//n1:Invoice/cac:PaymentTerms/cbc:PaymentDueDate">
													<tr>
														<th>
															<xsl:text>Son Ödeme Tarihi:</xsl:text>
														</th>
														<td>
															<xsl:for-each select="n1:Invoice/cac:PaymentTerms">
																<xsl:for-each select="cbc:PaymentDueDate">
																	<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/> <br/>
																</xsl:for-each>
															</xsl:for-each>
														</td>
													</tr>
												</xsl:when>
												<xsl:otherwise>
													<xsl:if test="//n1:Invoice/cac:PaymentMeans/cbc:PaymentDueDate">
													<tr>
														<th>
															<xsl:text>Son Ödeme Tarihi:</xsl:text>
														</th>
														<td>
															<xsl:for-each select="n1:Invoice/cac:PaymentMeans">
																<xsl:for-each select="cbc:PaymentDueDate">
																	<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/> <br/>
																</xsl:for-each>
															</xsl:for-each>
														</td>
													</tr>
													</xsl:if>
												</xsl:otherwise>
											</xsl:choose>
</xsl:if> 
<xsl:if test="//n1:Invoice/cbc:IssueTime">
											<tr>
												<th>
													<xsl:text>Oluşma Zamanı:</xsl:text>
												</th>
												<td>
													<xsl:value-of select="//n1:Invoice/cbc:IssueTime"/>
												</td>
											</tr>
</xsl:if> 

			</tbody>
		</table>

	</div> 
	</div> 

					</div> 
					<div class="satirlar"> 
						
					<table id="malHizmetTablosu">
						<tbody>
							<tr>
															<th data-id="SATIRLAR_SIRANO">
									<xsl:text>Sıra No</xsl:text>
								</th>
								<th data-id="SATIRLAR_MALHIZMET" class="alignLeft">
									<xsl:text>Mal Hizmet</xsl:text>
								</th>
								<th data-id="SATIRLAR_MIKTAR">
									<xsl:text>Miktar</xsl:text>
								</th>
								<th data-id="SATIRLAR_BIRIMFIYAT">
									<xsl:text>Birim Fiyat</xsl:text>
								</th>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric and //n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric !=0">
								<th data-id="SATIRLAR_ISKONTOORANI">
									<xsl:text>İskonto/Artırım Oranı</xsl:text>
								</th>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge">
								<th data-id="SATIRLAR_ISKONTOTUTARI">
									<xsl:text>İskonto/(A)rtırım Tutarı</xsl:text>
								</th>
</xsl:if> 
								<th data-id="SATIRLAR_MHTUTARI" class="mhColumn">
									<xsl:text>Mal Hizmet Tutarı</xsl:text>
								</th>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode ='0015'">
								<th data-id="SATIRLAR_KDVORANI">
									<xsl:text>KDV Oranı</xsl:text>
								</th>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode ='0015'">
								<th data-id="SATIRLAR_KDVTUTARI">
									<xsl:text>KDV Tutarı</xsl:text>
								</th>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TaxExemptionReasonCode > 0">
								<th data-id="SATIRLAR_VERGIIADEMUAFIYET">
									<xsl:text>Vergi İ.M. Sebebi</xsl:text>
								</th>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode !='0015' or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
								<th data-id="SATIRLAR_DIGERVERGI">
									<xsl:text>Diğer Vergiler</xsl:text>
								</th>
</xsl:if> 

							</tr>
								<xsl:for-each select="//n1:Invoice/cac:InvoiceLine">
									<xsl:apply-templates select="."/>
								</xsl:for-each>
							</tbody>
						</table>
				</div>

	</xsl:for-each> 
			<div id="toplamlarContainer">
						<div class="toplamlar">
							<div class="toplamTablo"> 
				<table>
					<tr>
						<th>
							<xsl:text>Mal Hizmet Toplam Tutarı:</xsl:text>
						</th>
						<td>
								<xsl:value-of
									select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount, '###.##0,00', 'european')"/>
								<xsl:if
									test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID">
									<xsl:text> </xsl:text><span>
									<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of
											select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID"
										/>
									</xsl:if></span>
								</xsl:if>
						</td>
					</tr>
					<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !=0">
					<tr>
						<th>
								<xsl:text>Toplam İskonto: </xsl:text>
						</th>
						<td>
								<xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount, '###.##0,00', 'european')"/>
								<xsl:if
									test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID">
									<xsl:text> </xsl:text><span>
									<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of
											select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID"
										/>
									</xsl:if></span>
								</xsl:if>
						</td>
					</tr>
					</xsl:if>
					<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount !=0">
					<tr>
						<th>
							<xsl:text>Toplam Artırım:</xsl:text>
						</th>
						<td>
								<xsl:value-of
									select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount, '###.##0,00', 'european')"/>
								<xsl:if
									test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount/@currencyID">
									<xsl:text> </xsl:text><span>
									<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of
											select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount/@currencyID"
										/>
									</xsl:if></span>
								</xsl:if>
						</td>
					</tr>
					</xsl:if>
					<xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode='0015']">
					<tr>
						<th>
							<xsl:text>KDV Matrahı </xsl:text>
							<xsl:text>(%</xsl:text><xsl:value-of select="cbc:Percent"/><xsl:text>):</xsl:text>
						</th>
						
						<td>
								<xsl:value-of
									select="format-number(./cbc:TaxableAmount[../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode='0015'], '###.##0,00', 'european')"/>
								<xsl:if
									test="./cbc:TaxableAmount/@currencyID">
									<xsl:text> </xsl:text><span>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of
											select="./cbc:TaxableAmount/@currencyID"/>
									</xsl:if></span>
								</xsl:if>
						</td>
					</tr>
					</xsl:for-each>
					<tr>
						<th class="sumTitle">
							<span>
								<xsl:text>Vergi Hariç Tutar: </xsl:text>
							</span>
						</th>
						
						<td class="sumValue">
								<xsl:value-of
									select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount, '###.##0,00', 'european')"/>
								<xsl:if
									test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount">
									<xsl:text> </xsl:text><span>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of
											select="
											//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID"
										/>
									</xsl:if></span>
								</xsl:if>
						</td>
					</tr>
					<xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[not(starts-with(./cac:TaxCategory/cbc:TaxExemptionReasonCode,'8') and (string-length(./cac:TaxCategory/cbc:TaxExemptionReasonCode) =3))]">
						<tr>
							
                        <th class="sumTitle is-long-{string-length(cac:TaxCategory/cac:TaxScheme/cbc:Name) > 15}">
							<xsl:text>Hesaplanan </xsl:text>
							<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
							<xsl:text> (%</xsl:text>
							<xsl:value-of select="cbc:Percent"/>
							<xsl:text>) </xsl:text>
							<xsl:if test="cac:TaxCategory/cbc:TaxExemptionReasonCode > 0">
							(<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode"/>)
							</xsl:if>
							<xsl:text>: </xsl:text>
						</th>
						<td class="sumValue">
							<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
								<xsl:text> </xsl:text>
								<xsl:value-of
									select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/><span>
								<xsl:if test="../../cbc:TaxAmount/@currencyID">
									<xsl:text> </xsl:text>
										<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
									</xsl:if>
								</xsl:if></span>
							</xsl:for-each>
						</td>
						</tr>
					</xsl:for-each>
					<xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
						<tr>
						<th class="sumTitle">
									<xsl:text>Tevkifata Tabi İşlem Tutarı (KDV): </xsl:text>
							</th>
							<td class="sumValue">
								<xsl:value-of select="format-number(sum(n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount[../../../cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')] and ../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode =0015]), '###.##0,00', 'european')"/>
								<span>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text> TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:text> </xsl:text><xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
								</xsl:if>
								</span>
							</td>
						</tr>
						<tr>
							<th>
									<xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. KDV: </xsl:text>
							</th>
							<td class="sumValue">
								<xsl:value-of select="format-number(sum(n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal/cbc:TaxableAmount[starts-with(../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]), '###.##0,00', 'european')"/>
								<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text> TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:text> </xsl:text><xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
								</xsl:if></span>
							</td>
						</tr>

						<xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
						<tr>
							<th>
								<xsl:text>KDV Tevkifat Tutarı (</xsl:text><xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>):
							</th>
							<td class="sumValue">
								<xsl:value-of select="format-number(cbc:TaxAmount, '###.##0,00', 'european')"/>
								<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text> TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:text> </xsl:text><xsl:value-of select="//n1:Invoice/cbc:DocumentCurrencyCode"/>
								</xsl:if></span>
							</td>
						</tr>
						</xsl:for-each>

					</xsl:if>


					<xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]">
						<tr>
							<th>
								<xsl:text>Tevkifata Tabi İşlem Tutarı (ÖTV)</xsl:text>
							</th>
							<td class="sumValue">
								<xsl:value-of select="format-number(sum(n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount[../../../cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4') and ../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode =0071]]), '###.##0,00', 'european')"/>
								<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text> TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
								</xsl:if></span>
							</td>
						</tr>
						<tr>
							<th>
								<xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. ÖTV</xsl:text>
							</th>
							<td class="sumValue">
								<xsl:value-of select="format-number(sum(n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal/cbc:TaxableAmount[starts-with(../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]), '###.##0,00', 'european')"/>
								<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text> TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
								</xsl:if></span>
							</td>
						</tr>

						<xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]">
						<tr>
							<th>
								<xsl:text>ÖTV Tevkifat Tutarı (</xsl:text><xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>):
							</th>
							<td class="sumValue">
								<xsl:value-of select="../cbc:TaxAmount"/>
								<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text> TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:text> </xsl:text><xsl:value-of select="//n1:Invoice/cbc:DocumentCurrencyCode"/>
								</xsl:if></span>
							</td>
						</tr>
						</xsl:for-each>

					</xsl:if>

						
						<xsl:if test="sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount)>0">
							<tr>
								<th>
									<xsl:text>Tevkifata Tabi İşlem Tutarı:</xsl:text>
								</th>
								<td class="sumValue">
									<xsl:value-of select="format-number(sum(n1:Invoice/cac:InvoiceLine[cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:LineExtensionAmount), '###.##0,00', 'european')"/>
									<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
									</xsl:if></span>
								</td>
							</tr>
							<tr>
								<th>
									<xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. KDV:</xsl:text>
								</th>
								<td class="sumValue">
									<xsl:value-of select="format-number(sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
									<span><xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
										<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
									</xsl:if></span>
								</td>
							</tr>
						</xsl:if>


					<tr>
						<th>
							<xsl:text>Vergiler Dahil Toplam Tutar:</xsl:text>
						</th>
						<td class="sumValue">
							<xsl:for-each select="n1:Invoice">
								<xsl:for-each select="cac:LegalMonetaryTotal">
									<xsl:for-each select="cbc:TaxInclusiveAmount">
										<xsl:value-of
											select="format-number(., '###.##0,00', 'european')"/>
										<xsl:if
											test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID">
											<xsl:text> </xsl:text>
											<span><xsl:if
												test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
												<xsl:text>TL</xsl:text>
											</xsl:if>
											<xsl:if
												test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
												<xsl:value-of
												select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID"
												/>
											</xsl:if></span>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</td>
					</tr>
					<tr class="payableAmount">
						<th>
							<xsl:text>Ödenecek Tutar:</xsl:text>
						</th>
						<td>
							<xsl:for-each select="n1:Invoice">
								<xsl:for-each select="cac:LegalMonetaryTotal">
									<xsl:for-each select="cbc:PayableAmount">
										<xsl:value-of
											select="format-number(., '###.##0,00', 'european')"/>
										<xsl:if
											test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID">
											<xsl:text> </xsl:text>
											<span><xsl:if
												test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
												<xsl:text>TL</xsl:text>
											</xsl:if>
											<xsl:if
												test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
												<xsl:value-of
												select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"
												/>
											</xsl:if></span>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</td>
					</tr>
				</table>
				</div>


			</div>

			</div>
				<div id="notlar"> 
				<table>
					<tbody>
						<tr>
							<td>
								<xsl:for-each select="//n1:Invoice/cbc:Note">
									<xsl:if test="1=1">
										<xsl:call-template name="repNL">
											<xsl:with-param name="pText" select="." />
										</xsl:call-template>
									</xsl:if>
								</xsl:for-each>
								<div class="ekNot">
									<xsl:if test ="n1:Invoice/cbc:Note[contains(normalize-space(.),'Gönderim Şekli:ELEKTRONIK')] or n1:Invoice/cbc:Note[contains(normalize-space(.),'Gönderim Şekli: ELEKTRONIK')]">
									<span>e-Arşiv izni kapsamında elektronik ortamda iletilmiştir.</span><br/>
									</xsl:if>
									<xsl:if test ="n1:Invoice/cbc:Note[contains(.,'##internetSatis_odemeSekli')]">
									<span>Bu satış İnternet üzerinden yapılmıştır.</span>
									</xsl:if>
								</div>
								<xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cbc:TaxExemptionReasonCode,'8') and (string-length(./cac:TaxCategory/cbc:TaxExemptionReasonCode) =3)]">
										<span style="font-weight:bold; ">Özel Matrah Kodu: </span>
										<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode"/> - <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/>
										<br/>
										<span style="font-weight:bold; ">Özel Matrah Detayı: </span>
											<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
											(<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>)
											<xsl:text> Oran: %</xsl:text>
											<xsl:value-of select="cbc:Percent"/>
										
											Vergi Tutarı: 
											<xsl:value-of
												select="format-number(cbc:TaxAmount, '###.##0,00', 'european')"/>
												<xsl:text> </xsl:text>
												<xsl:if test="cbc:TaxAmount/@currencyID = 'TRY' or cbc:TaxAmount/@currencyID = 'TRL'">
													<xsl:text>TL</xsl:text>
												</xsl:if>
												<xsl:if test="cbc:TaxAmount/@currencyID != 'TRY' and cbc:TaxAmount/@currencyID != 'TRL'">
													<xsl:value-of select="cbc:TaxAmount/@currencyID"/>
												</xsl:if>
												Vergi Matrahı:
											<xsl:value-of
												select="format-number(cbc:TaxableAmount, '###.##0,00', 'european')"/>
												<xsl:text> </xsl:text>
												<xsl:if test="cbc:TaxableAmount/@currencyID = 'TRY' or cbc:TaxableAmount/@currencyID = 'TRL'">
													<xsl:text>TL</xsl:text>
												</xsl:if>
												<xsl:if test="cbc:TaxableAmount/@currencyID != 'TRY' and cbc:TaxableAmount/@currencyID != 'TRL'">
													<xsl:value-of select="cbc:TaxableAmount/@currencyID"/>
												</xsl:if>
										<br/>
								</xsl:for-each>

								<xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4') or starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
									<br/><span style="display:inline-block;font-weight:bold;  vertical-align: top;padding-right: 4px;">TEVKİFAT DETAYI: </span>
									<span style="display:inline-block;">
										<xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4') or starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
											<xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/> - <xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:Name"/> <br/>
										</xsl:for-each>
									</span>
									<div style="clear:both"></div>
								</xsl:if>

								<xsl:if test="//n1:Invoice/cac:AdditionalDocumentReference and //n1:Invoice/cac:AdditionalDocumentReference/cbc:DocumentType!='XSLT'">
									<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
									<xsl:if test="./cbc:DocumentType!='XSLT' and not(./cbc:DocumentTypeCode)">
									<br/><span style="font-weight:bold;">İLAVE DÖKÜMANLAR</span><br/>
									<xsl:if test="./cbc:ID">
										<span style="font-weight:bold;"> Belge No: </span>
										<xsl:value-of
                                                select="./cbc:ID"/>
									</xsl:if>
									<xsl:if test="./cbc:IssueDate">
										<span style="font-weight:bold;"> Belge Tarihi: </span>
										<xsl:value-of select="substring(./cbc:IssueDate,9,2)"
												/>-<xsl:value-of select="substring(./cbc:IssueDate,6,2)"
												/>-<xsl:value-of select="substring(./cbc:IssueDate,1,4)"/>
										
									</xsl:if>
									<xsl:if test="./cbc:DocumentType">
										<span style="font-weight:bold;"> Belge Tipi: </span>
										<xsl:value-of
                                                select="./cbc:DocumentType"/>
									</xsl:if>

									<xsl:if test="./cac:Attachment">
										<span style="font-weight:bold;"> Belge Adı: </span>
										<xsl:if test="./cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
										<xsl:value-of
                                                select="./cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@filename"/>
                                         </xsl:if>
									</xsl:if>

									<br/>
									</xsl:if>
								</xsl:for-each>
								</xsl:if>

								
								<xsl:if test="//n1:Invoice/cac:PaymentMeans">
								<br/><span style="font-weight:bold;">ÖDEME ŞEKLİ</span><br/>
								
								
								<xsl:for-each select="//n1:Invoice/cac:PaymentMeans">
									<xsl:if test="./cbc:PaymentMeansCode">
										<span style="font-weight:bold;">Ödeme Şekli: </span>
										

								<xsl:choose>
								<xsl:when test="./cbc:PaymentMeansCode  = 'ZZZ'">
									<span>
										<xsl:text>Diğer</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:PaymentMeansCode  = '20'">
									<span>
										<xsl:text>Çek</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:PaymentMeansCode  = '42'">
									<span>
										<xsl:text>Havale</xsl:text>
									</span>
								</xsl:when>
								
								<xsl:when test="./cbc:PaymentMeansCode  = '6'">
									<span>
										<xsl:text>Kredi</xsl:text>
									</span>
								</xsl:when>
								
								<xsl:when test="./cbc:PaymentMeansCode  = '48'">
									<span>
										<xsl:text>Kredi Kartı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:PaymentMeansCode  = '10'">
									<span>
										<xsl:text>Nakit</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:PaymentMeansCode  = '49'">
									<span>
										<xsl:text>Otomatik Ödeme</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:PaymentMeansCode  = '60'">
									<span>
										<xsl:text>Senet</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:PaymentMeansCode  = '1'">
									<span>
										<xsl:text>Sözleşme Kapsamında</xsl:text>
									</span>
								</xsl:when>

								</xsl:choose>

								</xsl:if>

								&#160;&#160;&#160;

								<xsl:if test="cbc:PaymentDueDate">
										<span style="font-weight:bold;">Son Ödeme Tarihi: </span>
										<xsl:value-of select="substring(cbc:PaymentDueDate,9,2)"
												/>-<xsl:value-of select="substring(cbc:PaymentDueDate,6,2)"
												/>-<xsl:value-of select="substring(cbc:PaymentDueDate,1,4)"/>&#160;&#160;&#160;
										
									</xsl:if>
									<xsl:if test="cbc:PaymentChannelCode">
										<span style="font-weight:bold;">Ödeme Kanalı: </span>
										<xsl:value-of
                                                select="cbc:PaymentChannelCode"/>&#160;&#160;&#160;
									</xsl:if>

									<xsl:if test="cac:PayeeFinancialAccount/cbc:ID">
											<span style="font-weight:bold;"> IBAN / Hesap No: </span>
											<xsl:value-of select="cac:PayeeFinancialAccount/cbc:ID"/>
											(<xsl:if test="cac:PayeeFinancialAccount/cbc:CurrencyCode = 'TRY' or cac:PayeeFinancialAccount/cbc:CurrencyCode = 'TRL'"><xsl:text>TL</xsl:text></xsl:if><xsl:if test="cac:PayeeFinancialAccount/cbc:CurrencyCode != 'TRY' and cac:PayeeFinancialAccount/cbc:CurrencyCode != 'TRL'"><xsl:value-of select="cac:PayeeFinancialAccount/cbc:CurrencyCode"/></xsl:if>)
									</xsl:if>

									<xsl:if test="cbc:InstructionNote">
										<br/><span style="font-weight:bold;">Ödeme Şekli Açıklaması:</span>
										<xsl:value-of
                                                select="cbc:InstructionNote"/>&#160;&#160;&#160;
									</xsl:if>


									<br/>

								</xsl:for-each>

								</xsl:if>

								
								<xsl:if test="//n1:Invoice/cac:InvoicePeriod">
								<br/><span style="font-weight:bold;">FATURA DÖNEM BİLGİLERİ</span><br/>
								
								
								<xsl:for-each select="//n1:Invoice/cac:InvoicePeriod">
									<xsl:if test="./cbc:StartDate">
										<span style="font-weight:bold;">Başlangıç Tarihi:</span>&#160;
										<xsl:value-of select="substring(./cbc:StartDate,9,2)"
												/>-<xsl:value-of select="substring(./cbc:StartDate,6,2)"
												/>-<xsl:value-of select="substring(./cbc:StartDate,1,4)"/>&#160;&#160;&#160;
										
										
									</xsl:if>
									<xsl:if test="./cbc:EndDate">
										<span style="font-weight:bold;">Bitiş Tarihi:</span>&#160;
										<xsl:value-of select="substring(./cbc:EndDate,9,2)"
												/>-<xsl:value-of select="substring(./cbc:EndDate,6,2)"
												/>-<xsl:value-of select="substring(./cbc:EndDate,1,4)"/>&#160;&#160;&#160;
										
									</xsl:if>

									<xsl:if test="./cbc:DurationMeasure">
										<span style="font-weight:bold;">Dönem Periyodu / Süresi: </span>
										<xsl:value-of
                                                select="./cbc:DurationMeasure"/>&#160;
										<xsl:choose>
								<xsl:when test="./cbc:DurationMeasure/@unitCode  = 'MON'">
									<span>
										<xsl:text>Ay</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:DurationMeasure/@unitCode  = 'DAY'">
									<span>
										<xsl:text>Gün</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="./cbc:DurationMeasure/@unitCode  = 'HUR'">
									<span>
										<xsl:text>Saat</xsl:text>
									</span>
								</xsl:when>
								
								<xsl:when test="./cbc:DurationMeasure/@unitCode  = 'ANN'">
									<span>
										<xsl:text>Yıl</xsl:text>
									</span>
								</xsl:when>

								</xsl:choose>

								&#160;

								</xsl:if>

								<br/>

								<xsl:if test="./cbc:Description">
									<span style="font-weight:bold;">Fatura Dönem Açıklaması:</span>&#160;
									<xsl:value-of select="./cbc:Description"/>&#160;&#160;&#160;
								</xsl:if>	

								</xsl:for-each>
								<br/>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cac:ReceiptDocumentReference">
									<br/><span style="font-weight:bold;">ALINDI BİLGİLERİ</span><br/>
									<xsl:for-each select="//n1:Invoice/cac:ReceiptDocumentReference">
										<xsl:if test="./cbc:ID">
											<span style="font-weight:bold;">Belge Numarası: </span>
											<xsl:value-of select="./cbc:ID"/>
										</xsl:if>
										<xsl:if test="./cbc:IssueDate">
											<span style="font-weight:bold;"> Belge Tarihi: </span>
											<xsl:value-of select="substring(./cbc:IssueDate,9,2)"
												/>-<xsl:value-of select="substring(./cbc:IssueDate,6,2)"
												/>-<xsl:value-of select="substring(./cbc:IssueDate,1,4)"/>
										</xsl:if>
										<xsl:if test="./cbc:DocumentType">
											<span style="font-weight:bold;"> Belge Tipi: </span>
											<xsl:value-of select="./cbc:DocumentType"/>
										</xsl:if>
										<br/>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cac:PaymentTerms/cbc:PenaltySurchargePercen or //n1:Invoice/cac:PaymentTerms/cbc:Amount or //n1:Invoice/cac:PaymentTerms/cbc:Note">
									<br/><span style="font-weight:bold;">ÖDEME KOŞULLARI</span><br/>
								
								<xsl:for-each select="//n1:Invoice/cac:PaymentTerms">
									<xsl:if test="./cbc:PenaltySurchargePercent">
										<span style="font-weight:bold;">Gecikme Ceza Oranı: </span>
										<xsl:text> %</xsl:text>
									<xsl:value-of
									select="format-number(./cbc:PenaltySurchargePercent, '###.##0,00', 'european')"/>&#160;&#160;&#160;
									</xsl:if>
									<xsl:if test="./cbc:Amount">
										<span style="font-weight:bold;">Gecikme Ceza Tutarı:</span>&#160;
										<xsl:value-of select="format-number(./cbc:Amount, '###.##0,00', 'european')"/>
									</xsl:if>

									<xsl:if test="./cbc:Amount/@currencyID">
										<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
											<xsl:text> TL</xsl:text>&#160;&#160;&#160;
										</xsl:if>
										<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
											<xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID"/>&#160;&#160;&#160;
										</xsl:if>
									</xsl:if>


									<xsl:if test="./cbc:Note">
										<span style="font-weight:bold;">Açıklama: </span>
										<xsl:value-of
                                                select="./cbc:Note"/>
									</xsl:if>

									<br/>

								</xsl:for-each>
								<br/>
								</xsl:if>

					
                    <xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
						<xsl:if test="cbc:Percent=0 and cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=&apos;0015&apos; and not(cac:TaxCategory/cbc:TaxExemptionReasonCode > 0)">  
							<b>Vergi İstisna Muafiyet Sebebi: </b>
							<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/>
							<br/>
						</xsl:if>
                    </xsl:for-each>

					
	                <xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[not(./cac:TaxCategory/cbc:TaxExemptionReasonCode=preceding::*)]">
	                    	<xsl:if test="cac:TaxCategory/cbc:TaxExemptionReasonCode > 0 and not(starts-with(./cac:TaxCategory/cbc:TaxExemptionReasonCode,'8') and (string-length(./cac:TaxCategory/cbc:TaxExemptionReasonCode) =3))">
	                        <b>Vergi İstisna Muafiyet Sebebi: </b>
							<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode"/> - <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/> - <xsl:value-of select="cac:TaxCategory/cbc:Name"/>
	                        <br/>
	                    </xsl:if>
	                </xsl:for-each>
					
							</td>
						</tr>
					</tbody>
				</table>
			</div> 
			<div class="ph empty ph12">
			<xsl:text disable-output-escaping="yes"><![CDATA[
]]></xsl:text>
			</div>

				</div> 
			</div>
	</body>

	</html>

	</xsl:template>
	
			<xsl:template match="//n1:Invoice/cac:InvoiceLine"> 
				<tr>
							<td>
				<span>
					<xsl:value-of select="format-number(./cbc:ID, '#')"/>
				</span>
			</td>
			<td class="wrap">
				<span>
					<xsl:value-of select="./cac:Item/cbc:Name"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="./cac:Item/cbc:BrandName"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="./cac:Item/cbc:ModelName"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="./cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="./cac:Item/cac:ItemInstance/cbc:SerialID"/>
				</span>
			</td>
			<td>
				<span>
					<xsl:value-of
						select="format-number(./cbc:InvoicedQuantity, '#.###.###,########', 'european')"/>
					<xsl:if test="./cbc:InvoicedQuantity/@unitCode">
						<xsl:for-each select="./cbc:InvoicedQuantity">
							<xsl:text> </xsl:text>
							<xsl:choose>
								<xsl:when test="@unitCode  = '26'">
									<span>
										<xsl:text>Ton</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'SET'">
									<span>
										<xsl:text>Set</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'BX'">
									<span>
										<xsl:text>Kutu</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'LTR'">
									<span>
										<xsl:text>LT</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'HUR'">
									<span>
										<xsl:text>Saat</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'NIU' or @unitCode  = 'C62'">
									<span>
										<xsl:text>Adet</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KGM'">
									<span>
										<xsl:text>KG</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KJO'">
									<span>
										<xsl:text>kJ</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'GRM'">
									<span>
										<xsl:text>G</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MGM'">
									<span>
										<xsl:text>MG</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'NT'">
									<span>
										<xsl:text>Net Ton</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'GT'">
									<span>
										<xsl:text>GT</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MTR'">
									<span>
										<xsl:text>M</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MMT'">
									<span>
										<xsl:text>MM</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KTM'">
									<span>
										<xsl:text>KM</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MLT'">
									<span>
										<xsl:text>ML</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MMQ'">
									<span>
										<xsl:text>MM3</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'CLT'">
									<span>
										<xsl:text>CL</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'CMK'">
									<span>
										<xsl:text>CM2</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'CMQ'">
									<span>
										<xsl:text>CM3</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'CMT'">
									<span>
										<xsl:text>CM</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'DMT'">
									<span>
										<xsl:text>DM</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MTK'">
									<span>
										<xsl:text>M2</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MTQ'">
									<span>
										<xsl:text>M3</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'DAY'">
									<span>
										<xsl:text> Gün</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MON'">
									<span>
										<xsl:text> Ay</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'PA'">
									<span>
										<xsl:text> Paket</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KWH'">
									<span>
										<xsl:text> KWH</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'D61'">
									<span>
										<xsl:text> Dakika</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'D62'">
									<span>
										<xsl:text> Saniye</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'ANN'">
									<span>
										<xsl:text> Yıl</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'AFF'">
									<span>
										<xsl:text> AFİF</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'AYR'">
									<span>
										<xsl:text> Altın Ayarı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'B32'">
									<span>
										<xsl:text> KG/Metre Kare</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'CCT'">
									<span>
										<xsl:text> Ton Başına Taşıma Kapasitesi</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'CPR'">
									<span>
										<xsl:text> Adet-Çift</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'D30'">
									<span>
										<xsl:text> Brüt Kalori Değeri</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'D40'">
									<span>
										<xsl:text> Bin Litre</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'GFI'">
									<span>
										<xsl:text> FISSILE İzotop Gramı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'GMS'">
									<span>
										<xsl:text> Gümüş</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'GRM'">
									<span>
										<xsl:text> Gram</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'H62'">
									<span>
										<xsl:text> Yüz Adet</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'K20'">
									<span>
										<xsl:text> Kilogram Potasyum Oksit</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'K58'">
									<span>
										<xsl:text> Kurutulmuş Net Ağırlıklı Kg.</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'K62'">
									<span>
										<xsl:text> Kilogram-Adet</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KFO'">
									<span>
										<xsl:text> Difosfor Pentaoksit Kilogramı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KGM'">
									<span>
										<xsl:text> Kilogram</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KH6'">
									<span>
										<xsl:text> Kilogram-Baş</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KHO'">
									<span>
										<xsl:text> Hidrojen Peroksit Kilogramı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KMA'">
									<span>
										<xsl:text> Metil Aminlerin Kilogramı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KNI'">
									<span>
										<xsl:text> Azotun Kilogramı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KOH'">
									<span>
										<xsl:text> Kg. Potasyum Hidroksit</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KPH'">
									<span>
										<xsl:text> Kg Potasyum Oksid</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KPR'">
									<span>
										<xsl:text> Kilogram-Çift</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KSD'">
									<span>
										<xsl:text> %90 Kuru Ürün Kg.</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KSH'">
									<span>
										<xsl:text> Sodyum Hidroksit Kg.</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KUR'">
									<span>
										<xsl:text> Uranyum Kilogramı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KWH'">
									<span>
										<xsl:text> Kilowatt Saat</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'KWT'">
									<span>
										<xsl:text> Kilowatt</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'LPA'">
									<span>
										<xsl:text> Saf Alkol Litresi</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'LTR'">
									<span>
										<xsl:text> Litre</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'MTR'">
									<span>
										<xsl:text> Metre</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'NCL'">
									<span>
										<xsl:text> Hücre Adedi</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'NCR'">
									<span>
										<xsl:text> Karat</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'OMV'">
									<span>
										<xsl:text> OTV Maktu Vergi</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'OTB'">
									<span>
										<xsl:text> OTV birim fiyatı</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'PR'">
									<span>
										<xsl:text> Çift</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'R9'">
									<span>
										<xsl:text> Bin Metre Küp</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'T3'">
									<span>
										<xsl:text> Bin Adet</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode  = 'TWH'">
									<span>
										<xsl:text> Bin Kilowatt Saat</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode = 'GRO'">
									<span>
										<xsl:text> Grosa</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode = 'DZN'">
									<span>
										<xsl:text> Düzine</xsl:text>
									</span>
								</xsl:when>
								<xsl:when test="@unitCode = 'MWH'">
									<span>
										<xsl:text> MEGAWATT SAAT (1000 kW.h)</xsl:text>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<span>
										<xsl:value-of select="@unitCode"/>
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:if>
				</span>
			</td>
			<td>
				<span>
					<xsl:value-of
						select="format-number(./cac:Price/cbc:PriceAmount, '###.##0,########', 'european')"/>
					<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
						<xsl:text> </xsl:text>
						<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
							<xsl:text>TL</xsl:text>
						</xsl:if>
						<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
							<xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID"/>
						</xsl:if>
					</xsl:if>
				</span>
			</td>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric and //n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric !=0">
				<td>
					<span>
						<xsl:text>&#160;</xsl:text>
						<xsl:for-each select="./cac:AllowanceCharge">
							<xsl:if test="./cbc:MultiplierFactorNumeric">
								<xsl:text> %</xsl:text>
								<xsl:value-of select="format-number(./cbc:MultiplierFactorNumeric * 100, '###.##0,00', 'european')"/><br/>
							</xsl:if>
						</xsl:for-each>
					</span>
				</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge">
				<td>
					<span>
						<xsl:for-each select="./cac:AllowanceCharge">
						<xsl:if test="./cbc:ChargeIndicator = 'true' and not(./cbc:Amount =0) ">(A)</xsl:if>
							<xsl:value-of
								select="format-number(./cbc:Amount, '###.##0,00', 'european')"
							/>
						<xsl:if test="./cbc:Amount/@currencyID">
							<xsl:text> </xsl:text>
							<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
								<xsl:text>TL</xsl:text>
							</xsl:if>
							<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
								<xsl:value-of select="./cbc:Amount/@currencyID"/>
							</xsl:if>
						</xsl:if><br/>
						</xsl:for-each>
					</span>
				</td>
</xsl:if> 
			<td>
				<span>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of
						select="format-number(./cbc:LineExtensionAmount, '###.##0,00', 'european')"/>
					<xsl:if test="./cbc:LineExtensionAmount/@currencyID">
						<xsl:text> </xsl:text>
						<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
							<xsl:text>TL</xsl:text>
						</xsl:if>
						<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
							<xsl:value-of select="./cbc:LineExtensionAmount/@currencyID"/>
						</xsl:if>
					</xsl:if>
				</span>
			</td>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode ='0015'">
			<td>
				<span>
					<xsl:for-each
						select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
						<xsl:if test="cbc:TaxTypeCode='0015' ">
							<xsl:text> </xsl:text>
							<xsl:if test="../../cbc:Percent">
								<xsl:text> %</xsl:text>
								<xsl:value-of
									select="format-number(../../cbc:Percent, '###.##0,00', 'european')"
								/>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</span>
			</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode ='0015'">
			<td>
				<span>
					<xsl:text>&#160;</xsl:text>
					<xsl:for-each
						select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
						<xsl:if test="cbc:TaxTypeCode='0015' ">
							<xsl:text> </xsl:text>
							<xsl:value-of
								select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
							<xsl:if test="../../cbc:TaxAmount/@currencyID">
								<xsl:text> </xsl:text>
								<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRY' or ../../cbc:TaxAmount/@currencyID = 'TRL'">
									<xsl:text>TL</xsl:text>
								</xsl:if>
								<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRY' and ../../cbc:TaxAmount/@currencyID != 'TRL'">
									<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</span>
			</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TaxExemptionReasonCode > 0">
			
			<td style="font-size: xx-small;white-space:normal;">
				<span>
					<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal[./cac:TaxCategory/cbc:TaxExemptionReasonCode > '0']">
					<xsl:if test="cac:TaxCategory/cbc:TaxExemptionReasonCode">
					<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode"/> - <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/> <br/><xsl:value-of select="cac:TaxCategory/cbc:Name"/><br/>
					</xsl:if>
					</xsl:for-each>
				</span>
			</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode !='0015' or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<td style="font-size:xx-small;">
				<div>
					<xsl:for-each
						select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
						<xsl:if test="cbc:TaxTypeCode!='0015' ">
							<span class="is-long-{string-length(cbc:Name) > 15}">
							<xsl:text> </xsl:text>
							<xsl:if test="starts-with(cbc:TaxTypeCode,'4') or starts-with(cbc:TaxTypeCode,'6')">
								<xsl:value-of select="cbc:TaxTypeCode"/> -
							</xsl:if>
							<xsl:value-of select="cbc:Name"/>
								<xsl:if test="../../cbc:Percent">
									<xsl:text> (%</xsl:text>
									<xsl:value-of
										select="format-number(../../cbc:Percent, '###.##0,00', 'european')"
									/>
									<xsl:text>)=</xsl:text>
								</xsl:if>
							<xsl:value-of
								select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
							<xsl:if test="../../cbc:TaxAmount/@currencyID">
								<xsl:text> </xsl:text>
								<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRY' or ../../cbc:TaxAmount/@currencyID = 'TRL'">
									<xsl:text>TL</xsl:text>
								</xsl:if>
								<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRY' and ../../cbc:TaxAmount/@currencyID != 'TRL'">
									<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
								</xsl:if>
							</xsl:if><br/>
							</span>
						</xsl:if>
					</xsl:for-each>

          			
					<xsl:for-each
						select="./cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
						<xsl:if test="cbc:TaxTypeCode!='0015' ">
							<span class="is-long-{string-length(cbc:Name) > 15}"><xsl:if test="starts-with(cbc:TaxTypeCode,'4') or starts-with(cbc:TaxTypeCode,'6')">
								<xsl:value-of select="cbc:TaxTypeCode"/> -
							</xsl:if><xsl:value-of select="cbc:Name"/></span>
								<xsl:if test="../../cbc:Percent">
									<xsl:text> (%</xsl:text>
									<xsl:value-of
										select="format-number(../../cbc:Percent, '###.##0,00', 'european')"
									/>
									<xsl:text>)=</xsl:text>
								</xsl:if>
							<xsl:value-of
								select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
							<xsl:if test="../../cbc:TaxAmount/@currencyID">
								<xsl:text> </xsl:text>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
									<xsl:text>TL</xsl:text>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
									<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>

				</div>
			</td>
</xsl:if> 

				</tr>
			</xsl:template>

	</xsl:stylesheet>

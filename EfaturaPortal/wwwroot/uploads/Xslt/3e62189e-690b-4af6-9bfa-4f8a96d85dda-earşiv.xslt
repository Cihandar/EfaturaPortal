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
<div style="text-align: center;"><span style="font-size: 11pt; font-weight: bold;">e-Arşiv Fatura<br/><br/><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPEAAAB6CAYAAABuvLUSAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA45pVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo2OEI4OTBFMjQ5QjMxMUVCODhGMkMxRTIzNjBBQkY3OSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo2OEI4OTBFMTQ5QjMxMUVCODhGMkMxRTIzNjBBQkY3OSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0idXVpZDpmYWY1YmRkNS1iYTNkLTExZGEtYWQzMS1kMzNkNzUxODJmMWIiIHN0UmVmOmRvY3VtZW50SUQ9IkM5RDJBNDYxNzhDNjQxNzlFODk2RkY0MTY2OTQ4NkVDIi8+IDxkYzpjcmVhdG9yPiA8cmRmOlNlcT4gPHJkZjpsaT5TZWFsaW5lPC9yZGY6bGk+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" alt="" width="241" height="122"/><br/></span></div>
]]></xsl:text>
								</div>

</div> 
	<div id="b3" class="box">
	<div id="despatchTable">
				<div class="ph empty ph7">
		<xsl:text disable-output-escaping="yes"><![CDATA[<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZQAAABwCAYAAAA5Z4aAAAAABGdBTUEAALGOfPtRkwAAACBjSFJNAACHDwAAjA8AAP1SAACBQAAAfXkAAOmLAAA85QAAGcxzPIV3AAAKL2lDQ1BJQ0MgUHJvZmlsZQAASMedlndUVNcWh8+9d3qhzTDSGXqTLjCA9C4gHQRRGGYGGMoAwwxNbIioQEQREQFFkKCAAaOhSKyIYiEoqGAPSBBQYjCKqKhkRtZKfHl57+Xl98e939pn73P32XuftS4AJE8fLi8FlgIgmSfgB3o401eFR9Cx/QAGeIABpgAwWempvkHuwUAkLzcXerrICfyL3gwBSPy+ZejpT6eD/0/SrFS+AADIX8TmbE46S8T5Ik7KFKSK7TMipsYkihlGiZkvSlDEcmKOW+Sln30W2VHM7GQeW8TinFPZyWwx94h4e4aQI2LER8QFGVxOpohvi1gzSZjMFfFbcWwyh5kOAIoktgs4rHgRm4iYxA8OdBHxcgBwpLgvOOYLFnCyBOJDuaSkZvO5cfECui5Lj25qbc2ge3IykzgCgaE/k5XI5LPpLinJqUxeNgCLZ/4sGXFt6aIiW5paW1oamhmZflGo/7r4NyXu7SK9CvjcM4jW94ftr/xS6gBgzIpqs+sPW8x+ADq2AiB3/w+b5iEAJEV9a7/xxXlo4nmJFwhSbYyNMzMzjbgclpG4oL/rfzr8DX3xPSPxdr+Xh+7KiWUKkwR0cd1YKUkpQj49PZXJ4tAN/zzE/zjwr/NYGsiJ5fA5PFFEqGjKuLw4Ubt5bK6Am8Kjc3n/qYn/MOxPWpxrkSj1nwA1yghI3aAC5Oc+gKIQARJ5UNz13/vmgw8F4psXpjqxOPefBf37rnCJ+JHOjfsc5xIYTGcJ+RmLa+JrCdCAACQBFcgDFaABdIEhMANWwBY4AjewAviBYBAO1gIWiAfJgA8yQS7YDApAEdgF9oJKUAPqQSNoASdABzgNLoDL4Dq4Ce6AB2AEjIPnYAa8AfMQBGEhMkSB5CFVSAsygMwgBmQPuUE+UCAUDkVDcRAPEkK50BaoCCqFKqFaqBH6FjoFXYCuQgPQPWgUmoJ+hd7DCEyCqbAyrA0bwwzYCfaGg+E1cBycBufA+fBOuAKug4/B7fAF+Dp8Bx6Bn8OzCECICA1RQwwRBuKC+CERSCzCRzYghUg5Uoe0IF1IL3ILGUGmkXcoDIqCoqMMUbYoT1QIioVKQ21AFaMqUUdR7age1C3UKGoG9QlNRiuhDdA2aC/0KnQcOhNdgC5HN6Db0JfQd9Dj6DcYDIaG0cFYYTwx4ZgEzDpMMeYAphVzHjOAGcPMYrFYeawB1g7rh2ViBdgC7H7sMew57CB2HPsWR8Sp4sxw7rgIHA+XhyvHNeHO4gZxE7h5vBReC2+D98Oz8dn4Enw9vgt/Az+OnydIE3QIdoRgQgJhM6GC0EK4RHhIeEUkEtWJ1sQAIpe4iVhBPE68QhwlviPJkPRJLqRIkpC0k3SEdJ50j/SKTCZrkx3JEWQBeSe5kXyR/Jj8VoIiYSThJcGW2ChRJdEuMSjxQhIvqSXpJLlWMkeyXPKk5A3JaSm8lLaUixRTaoNUldQpqWGpWWmKtKm0n3SydLF0k/RV6UkZrIy2jJsMWyZf5rDMRZkxCkLRoLhQWJQtlHrKJco4FUPVoXpRE6hF1G+o/dQZWRnZZbKhslmyVbJnZEdoCE2b5kVLopXQTtCGaO+XKC9xWsJZsmNJy5LBJXNyinKOchy5QrlWuTty7+Xp8m7yifK75TvkHymgFPQVAhQyFQ4qXFKYVqQq2iqyFAsVTyjeV4KV9JUCldYpHVbqU5pVVlH2UE5V3q98UXlahabiqJKgUqZyVmVKlaJqr8pVLVM9p/qMLkt3oifRK+g99Bk1JTVPNaFarVq/2ry6jnqIep56q/ojDYIGQyNWo0yjW2NGU1XTVzNXs1nzvhZei6EVr7VPq1drTltHO0x7m3aH9qSOnI6XTo5Os85DXbKug26abp3ubT2MHkMvUe+A3k19WN9CP16/Sv+GAWxgacA1OGAwsBS91Hopb2nd0mFDkqGTYYZhs+GoEc3IxyjPqMPohbGmcYTxbuNe408mFiZJJvUmD0xlTFeY5pl2mf5qpm/GMqsyu21ONnc332jeaf5ymcEyzrKDy+5aUCx8LbZZdFt8tLSy5Fu2WE5ZaVpFW1VbDTOoDH9GMeOKNdra2Xqj9WnrdzaWNgKbEza/2BraJto22U4u11nOWV6/fMxO3Y5pV2s3Yk+3j7Y/ZD/ioObAdKhzeOKo4ch2bHCccNJzSnA65vTC2cSZ79zmPOdi47Le5bwr4urhWuja7ybjFuJW6fbYXd09zr3ZfcbDwmOdx3lPtKe3527PYS9lL5ZXo9fMCqsV61f0eJO8g7wrvZ/46Pvwfbp8Yd8Vvnt8H67UWslb2eEH/Lz89vg98tfxT/P/PgAT4B9QFfA00DQwN7A3iBIUFdQU9CbYObgk+EGIbogwpDtUMjQytDF0Lsw1rDRsZJXxqvWrrocrhHPDOyOwEaERDRGzq91W7109HmkRWRA5tEZnTdaaq2sV1iatPRMlGcWMOhmNjg6Lbor+wPRj1jFnY7xiqmNmWC6sfaznbEd2GXuKY8cp5UzE2sWWxk7G2cXtiZuKd4gvj5/munAruS8TPBNqEuYS/RKPJC4khSW1JuOSo5NP8WR4ibyeFJWUrJSBVIPUgtSRNJu0vWkzfG9+QzqUvia9U0AV/Uz1CXWFW4WjGfYZVRlvM0MzT2ZJZ/Gy+rL1s3dkT+S453y9DrWOta47Vy13c+7oeqf1tRugDTEbujdqbMzfOL7JY9PRzYTNiZt/yDPJK817vSVsS1e+cv6m/LGtHlubCyQK+AXD22y31WxHbedu799hvmP/jk+F7MJrRSZF5UUfilnF174y/ariq4WdsTv7SyxLDu7C7OLtGtrtsPtoqXRpTunYHt897WX0ssKy13uj9l4tX1Zes4+wT7hvpMKnonO/5v5d+z9UxlfeqXKuaq1Wqt5RPXeAfWDwoOPBlhrlmqKa94e4h+7WetS212nXlR/GHM44/LQ+tL73a8bXjQ0KDUUNH4/wjowcDTza02jV2Nik1FTSDDcLm6eORR67+Y3rN50thi21rbTWouPguPD4s2+jvx064X2i+yTjZMt3Wt9Vt1HaCtuh9uz2mY74jpHO8M6BUytOdXfZdrV9b/T9kdNqp6vOyJ4pOUs4m3924VzOudnzqeenL8RdGOuO6n5wcdXF2z0BPf2XvC9duex++WKvU++5K3ZXTl+1uXrqGuNax3XL6+19Fn1tP1j80NZv2d9+w+pG503rm10DywfODjoMXrjleuvyba/b1++svDMwFDJ0dzhyeOQu++7kvaR7L+9n3J9/sOkh+mHhI6lH5Y+VHtf9qPdj64jlyJlR19G+J0FPHoyxxp7/lP7Th/H8p+Sn5ROqE42TZpOnp9ynbj5b/Wz8eerz+emCn6V/rn6h++K7Xxx/6ZtZNTP+kv9y4dfiV/Kvjrxe9rp71n/28ZvkN/NzhW/l3x59x3jX+z7s/cR85gfsh4qPeh+7Pnl/eriQvLDwG/eE8/s3BCkeAAAACXBIWXMAAAsSAAALEgHS3X78AAAAIXRFWHRDcmVhdGlvbiBUaW1lADIwMTU6MTI6MTcgMjM6MDU6MDjYFVlzAABMZUlEQVR4Xu1dB3wURRd/eyW9QgKEXkPvvRcRkSJFuihFkCpdQNQvxEavUqUjgmhAQDpIUUCkN+m9BEJCCaTf3e73f5dLuNSrCUnY+WV+l7ubmX3zZm/+O68KkiSRXGQOyByQOSBzQOaArRxQ2DqA3F/mgMwBmQMyB2QOMAdkQJHvA5kDMgdkDsgcsAsHZECxCxvlQWQOyByQOSBzQAYU+R6QOSBzQOaAzAG7cEAGFLuwUR5E5oDMAZkDMgdkQJHvAZkDMgdkDsgcsAsHZECxCxvlQWQOyByQOSBzQAYU+R6QOSBzQOaAzAG7cEAGFLuwUR5E5oDMAZkDMgdkQJHvAZkDMgdkDsgcsAsHZECxCxvlQWQOyByQOSBzQAYU+R6QOSBzQOaAzAG7cEDIycEh1wQ2yEMqpwokkD+4VUSUxEJ4zS2QkAuvTqhqUdRzQCsQvcD7cJIoRJJ0wSJJtyRRuhahiDw/PODUc7twWx5E5oDMAZkDOZgDOQpQ1kxqVoFI9bYgUANJFOth3fIZr11q4AlASbG86JukG97cRrt/JIEOKeKkXX2+/+tmDr4n5KnJHJA5IHPAKg5ka0BRKBTCT9+/1QAz70QktMdr4QQuJAMF/cdWAkpqfS/iWLORdLr1fb89dMEqzsudZA7IHJA5kMM4kC0BhUVZgqNrP4ip+kKcVSI1oMhgQIkHmfjTzTGcZ36MiNStHTHjcHQOuz/k6cgckDkgc8BsDmQrQPl5WvPSpFN+BpHWB5gh60DSPHlkIqAkkBEKYJstamPm9590PNzsFZAbyhyQOSBzIIdwIFsAyqopzYo6KNRfQ6zVA6cCZXLev+YTShJyoPh/JpE4OfjBo7kBy2/G5JD7RJ6GzAGZAzIHTHIgSwPKmrEtXZW+0hcAkpEJJxKDmCnJxLIYoCTQBisxGtX/u0ObTK5CDmggCMJnmMZHhqno8PoE9RDqt1gfTQ6YYpIpYL41Ma/jOW1e8nxkDtjCgSwLKOumv9OKJGEBJlfEeILZCFD0ZLPyPjpSHDxs1pEQWxYqq/fFBrsdNLZE5XmqUb1R2c9pNDbemVmdfnPpwzyd0XYV6mPMa6i5/eR2MgfeBA5kOcfGhYHN3NZPb7VYQcptycEkOy4I9D0dnZ2FC4sn1O+QHem3gGaYbNNtbLJ+qD74v6Khb8PkY2BTVqMWQnVIb3x8r0ItgAr7i6SFP0MpiOppYgxPtHFNrY1h/MIGkEhzGHzva/RlTfzfGfWiBbyRm8oceCM4kKUAZe3UFhVzuTqdAOc/yVHcF8hHIdDGJV/UnxfYtWK6m2h2nLdhUy8I2s8b0Z+g60pyMkPbvmjDn91FDcX7D43njPfwIxKiUWcxQKHeR/0lWZuqeH8F9R7qE7T9Ptn3kw1j8EniGV8P71sla/O+gY47eA3D992Sff8XPjuAuh6fPzKAF5uo7zW0m43PGmXH9ZJpljmQURzIMoCybmrLbkqF6igmWjqjJpsFxh2Sv6THgYXjaidxuMwCdNlKQnkMwKeI0thk16Dy6fKgARCmJgyOz3lDXsIbNCrrxYJRl+JzY7Emn2zYgo83+G9Q2Ym0M9q48TiG08o6/Munjn6o51DH43Mvo0lUNozBfYYZaJtsREde/P8T6lXUXqhPUQONvue5VEFl4KqOOh2nLga2ONTbhnaL8Pqf0TXlf2UOvPEcyBKA8uuM1l/ASXEtVsPlDViRuiqV6tiisfUq5aC5sriLCz8MsEk3nwZYh8JKeT5FJJRRhn/as4k1/mdFPp/Y3jJqw+DEpSvaLMbraVRW6ut9fPAZO//UQa2CugWVTyoMAMbWf0wPn4J6oPk8vP6BWp5FXIaxQ/HKTrDvov6F+hiV9T4JhQHOHZWBpgbGGGe49jHDZ4/w2TBUNjyQi8wBmQMGDrxWQAkMVCh+ndlqPraDbw2bwpuyMIUUKvpr0bjajXPIhBMABREL9E/1vOGzkr4nKn+WUDgcznlsxHwy4MLx07joTx+GwmPxhv+34X05vLJuhi3H+ITCJ5MpqGdQGQj4JMM+QPrN3XBSYfHbfnwWaxgjCq98ryfoYjimG5+U+PRzC7Ua6mUjGhJAbTHGeJ7wueF0VBbv5ZOJEbPkf2UOJHDgtQEKg0lZ93dX4jc+OBOWgzcWiEakILzOQgDIL+ArMhi1L2J0DSCRRsJ6LACfL0LdLpHE8v2UQb7sS6inQqncsXBC3Rb2Hfa1jMYgwKeIrdiAz6D+i/9ZpMQlvxFFXvifwSKh8EbOhfmdIM5iADnLJxFs4I74vxSq8QYOM3Lqj7octTYqnyKMdTcJ4Ma6k4TCIHffyHyZwYRPRf9DbWtoxKKzhJIwBp+wjAsDlUcyepI1kd/KHHhzOfBazIY5Btcv099dBrb3SWB9aubAcBJMsTJmmg3HiaJ4AI+jO4jEQ9F3X57tv+i4Rb4QcwKreXmSRz2gSiOM0xqbUcImk0iTnWiOEUnXduD3/yYoe7Pd3YiNn8VLvIE3QWWxEouTfkBlwGgE3ulPG2jHJxOO9JygJzuJ/71QC6HNS3xfDP/zqWE23o/EexYLnkX9Bu958+cxWD9TCzUPalPUP1H5JDHQ8D2/LkQ9hcqAw6dA5u0CtBliaMP0nsb7lhjvSx4ftS/erzB8z2DYg2ljuvgzw+cMQjzWpwZRWsJX2f4VfGB+8vwiUfdgfnIYoWy/qpk/gdcCKOtntp6OTXq08XTtsjlLdAini2W6ON2mXgH7ntuTnUu/aOyvVEm9IDTpjW1N/9RtF5rjiYzASentgZP/YaOEbFUMG1FaPjasu2hn0HswGAzCe/YtYvBh8ROb/PJGvtKwYfNpgfUi/fEZK+u743/WrXXDe7a24jGm44XvHRZRsXky16/wPYtN+XsGMvYPYXEYg0EB5i9qZbRhIwBuwwDH4jc2/WXxF9PBdPK1+XsGIw+8L8nvEwo+b4f/N6Ey/UPxPdOW7Qvm1QaTYEOHBNHjbfz/FuYnR9XO9qubuRPIdEBZP6P1UHgV8I8+SbFhc9ZJkviLVtJN7/X5vjMZzb7AZgpVwYYNu8EMeBxoTnFqseFUFRqn09QdOuX4jYyegz3Hx2ZUAuONTzYm60ZY7LURm5I22abMSnv24+An4JX4fpfRht0c/3dFnYHPLxs2Ot7Ev8N73uQSdCTT8C+fhNhhkq249uF73hD5+/14YSsvNull8Rhfn/sn6kjQhvUgbNX1EJVBga3FVqDNEcMYfH9ex/s5yWhnERxbrTHQfIHvzxh/nx3/By/YmIENJ/yS0b8e80tiSp0d5yfTnLkcyFRA+W3Gu81JodyBGzXB2iZxtlYCyhZRS+N7frHrki1sYxHciRMnVDdv3hS7dOkCaVkqSVKSXQAqIEWBCfU/Qld+MuanYH2xAVBI0omXNTHPag+dcyVBWW3LtN7IvtggWUdzGfdYCofKN5IhJiYNfvFp+0EqzdgQgkWQFheM2RGdWJzNALwHdVbyBwuLB5U7ZAsOZBqgrJ3WuqBaJZwBV3Lj5krBHAsB5S6J4sAen++BjsSyotFoqkqaiBbhDy+2jIkIq6CJeuah1UQrRU1snNLRWeVdoJLklb9SuMrRlWXK6RadTtd+9uc19ng5un2LHxE/KStsAhRO7CXRhkHTjnU2B9RM0femfY81YP8ePnUk6lTeNB5YOl/wjPVd7NyZvLARA4sDLSoYj0+grIMyjm6QqL+yaDC5cbbjQKYASteuCmWnOq1YmdmEOWQLoGCjXS3EvPy0R8A/Fj3FR4U/XPj46oEB989uCol8fj8PFCAK3Pzk4l3kSd7SzQAkFc575a/ykygo/75w4cL1atWqJSrxr1+/7li4cOGiDg4O7POgLwCT1gLpvlEoHfSWSsu+qFdfUCp/RkbhJLHH9PNNLStkqqAab4QA/gwdOOXf+dnubnrNBGM9WWzDG9rf4CGL3ORiggMZACj/4JJsNm5c2MrSHWtikWGMvHjZjwOZAii/zWo9Bg8sLPdO2DBTcMqME0oMjL6G9Bi3k81FzS5hwef8Qy/u2X3vzMa80LXoc6goVI4vilTvosxTsslaF5+SM589e3Yvd+7c1eIiQ+tGPbtbWdRE5yVBGevo7nvb3bfESVEUziqVypGa6GeFlI6ecwBqN0Mubv/HNVfhS96FqiaYvtKiCY28VUrdasyVlZyJxVJAQcdorU5Xbci048a+EWbPWW4oc8BcDmQAoFzHtVmvlrz4AFBkR1BzFyabtstwQPl1Vht/nH3PgD8cpdVaQHmGB/r2PcbuZK/mNEsgnFs6d+6sKleuXFxMTEzh20fmFwi9cWRX1PNg9nqGwlbxslSjwa75y7877L8rt3+sWLGi/9Nbh1aGXP/LP+zmv4I25jk/RSUZX6FUxwE4wgpV6egFkHEMvfG3MneRmnT14Dyq03P5fvc8pZoZd+DTWHP/ejMxZxaBxc/XwhOKodeRR1OPNwwAemXTe0smOxtwIAMAhY1KiqcydV/8tsKyAUtkEm3gQIYDStCc93Yje+LbxjRaJvKSQtD+7R5jdxs7r6WY8v379529HGInSgKNxalCeHBpx7vXDy7aHvOSrUfhUOBX7nbFNt+cdvHK31Gni2v96OKuVY8u/6l2cPF2cvMp/lzt7H3D2TPvfaXK4a5S5RIpCqJaG/3SRxv7onBsxNPSsZFPCju759XcPRPk+DI03hDLv/EQTf4KrdYrHTzmI5xKEpPfJV82+AISNb0pq3WAgo6i9MmAqf+yE162LNis2PiiPSr7dCQ+UJg5GfaM51Ank7H+HEPLbsXg38ImzEXTGZRNi3/MrE0QNDXB9dhhk/10rC0fWkpvBgCK3U4ooI0t8ax1/OUHMfZZWgKeGDvTWstbk/1AL0elHoBaP53Gt/Ed65TS3c9MXiyLNshQQAma/V4HqOY2Jk/HawGghOpIatzzs/StuDSRz8rfPbvp4I2jyz2qtP1uqWfh2lNP/fLJ8RePr/qwnqR4vY+fF6n5UVO1Ws1e3LfDg89HCgrV766+/rs2bdp0pFOnTvqwHukVtgSLjniy6djPn7wb9fy+Pu6TytFNylOykeDfeHCUg0uu2Tdu3Pi6ZMmSCeE+aMlX9cYKpJhiNaCQFBYTpyk1fOap56boy0rfg+e5DZsjR0GwWLGbbC6BWLOJts7PAG7vYZxPUZuYOR6bNrM58g8ZYSIMmlgEy2DLNFUxk6b0mhUEnalZbKXZJwMAhaUIyS3s2B8ol6WWXqDtZwN/bGEN/x7Zh2kern/cloHS6gs6ee2Go7LfFFu2mSosBmHzdjZP/wN0mdx/TA2YVb7PMEAJDGymKu/lipAZgr+VgBKh1Wgaf/D5HnYyS7VERUXli3t5t/qlXZOWvAi56qd2co9oNGh7k6e3Dm8/vWk8W2lJ5d4eKxSq0iHR4uTOnTtORYoUsTg1ryhqR17aPXVmXPQznTYumsIfXaS3Pt3zL6RZX926deuwMZAYE7v0ywYzccNwZN0kJXVQTS0ygDhp4NRjE7LKDZMeHYYfFm+O/MOy9ESS1tCnwKvq1s7fCNz4RMIWTdYW3ih5A9hk6caY/IIGU12mh59mjXOtWEtbQr+sACitQcxmVPZvSSgB4NnXlk7OToBifFk+8fIa/mrrqdfgv8OOuAwkTSydm1H72/ifDXCWgSbjcEE2DPn6umZYLK9yHm6wQxf8rZwaW992Sw9MeNy/pr0VdWnX5K0MJvw+V6FqSqgcom+fWK+3Jilep5d2+eZzxjc2pQYmQUFByqdPn3q8ePEiV3h4uNfBgweT+Mlotdrq0L80K9ti/FeV3pvcolLrwA0eefyVEgm/QFm/Ly0wYRoefH9kDB5HtlrJB1b8DJs3vLo9Nx2rSUmrI35cnVAP4nuODNwX1V5gwpdMsn7mEg96yqGyuJCd9iah2gImfFl2lPwN9QbG5XD5HNPLosKAi8omtRyQkkO+ZOl1tWhyhsbYFFnMxCFxOLTSGtSPUDm0TVYoHLKH+X+XxWmoFkc3Rx9X1FEYg8MI/Y7axMaJFUV/Nli6h3EXolq7Z9pIhn26ZwigBEExLShIH/LbmoIN+OtuY7fzjZlmwSZfw6t4mbMvQhIteck9r38kdBk1wh/+5+WRt0x4gbKtigQEBKSp1Ba1saeeB18QaxTVRj/4d/7Dm/sm3bx9cOqtPLqTL28f/znu4aXdZ6PDH/KPASbGirYQe33LABInOQwu32I8ByU0qWRkpXp0dDQnkbLWA95V6aQcYQ0fM7EPiyZ4w82IwrG6rCnsvc8e8PYEN6aDgYkByhrHyYnoxxGYc1yStWQLxDHYOLMlb+AcmNPijduaBbegD+fD4dhw1ohjeT4zUFMzPLCAhBRNOYo2x6FjsMq2JUNEXkGz3uuKYOGJWfYsEXnByOqv30/sbLZ+vZiuXBFmwDcv7pmWxJO3XItxR738Kh7456ePPqvRefaiXIVrckynNAtOJN5OTk4+AIlCYmxE4WePLnSNeHy9XPjDCx5Pbp9w0Glj8EMQRFh5hRSp3jVfriK1uz6LFLcWLFgwGjjB8aWeou9uc1b/xy/q1BVIyYpe/RO32SKveKuzZ5FSXKHRU09z4L4sV/BUxXLq9DZJjiYcbx1hfuGQKYdR/wdecfh5iwpogvk2MZCnVfhJRG80kUrhp1hTpY3hadxUu8TvQdMmvOFQMhlVsoLIKyE4p/Ec14BX6a1FqvzIAJFX8uuUAV2vnkjNWBXQ1ADN+HecXuEoAUlCDhkaM1gwIKVXsrVTbsYAyuz3/oYynhmvLxYACjaOuEpdx+xN92leo4mqcmhJ54NxkU+TiB2qdJi8Qe3oHvfgwrb3fKr0y+Pn52fxRsT0Pn/+3NPVVf3OkxtHJzw4vzVP2J1juTEJB6XaKbJk/f4xfpXa1HJ09LgZGhrq5uvry4EHE0tISIhr3rx5U934l3xRbwoAaqyeJ+k4NhqPl9hOpAEDp/37oxn3fKY3MQNQOCDkH1YSFgkemPoBpxjaDEDhwIcpYsoZBpplBq0ZASgXcN2lqKZOsyzKSy3rZ1YAFLZ25CjPxoWt9Ngk3yJrvXQAZQTGO5nOGvGplOOQmdLlZRSgcOK41ACFT8wJuXbSIl8GFGPOBM1uU5EEhXFuCbMBBc/in3cbsz0xVWtaHH9wceeWC9sCWSGWpFR9f8ZqtYObKOniFLmK1OhlxqZgsgn8WQrpoh5/fu/Mho53T21wg0GGq5tvySfV2k36x9m7YBIacGoZjXoEYjf2Fk5RZoyt6uqhduEIt4UtBhSSjg2cciz5D9Uk/ZnRwAxAsYWMa+CVxXJlMwDFFpq4rz0BhWXxbLyRPP9KqjRibmn5emQFQLGn2XBaVl7NwSuTolDwiXVUbIrNQUJTE7tlFKDYcm9la0Cxuw4FimprN/KbYfdumPNkSBBLJfFET1g9mHJ5eRUof9+zYNWVtqyocV+IxO5B5DU4X7U+pRv0+3VNXv+md5zccuf+d93AmndO/tqNFfrcHkDS4+Xjy9PxyrqVVAuLrHQk9sThhJ/Yd6LqE0uZV4RaC0fV4Ci5crEPB9gkmDc/a6tVp980SJ9mLpjYZ+oZOopxDC/jC6X1eYYRA55yJs/vcQGLTKntQBADvrX3laWiYTuQa78h7CryYmU81W1zF+Iu4yx9Zp1QRJ2ud7fPdq4yNTU+MZwJGnoKinfOg5GkVHh3wskCFdrWMDWGLd/j+kXint3ap3RyKx7+4KzGI3/lPx/eubBViH44V9JpFKdP/Lk4/GmwEkEenQTMHNeKBoDAHFB6KErCPYUQdyl40smrCR7wi8dWzSMoHWpLgrIFibpWEIklUfYlOcnAHwMmxOzslaUKngQ5XLy1GwaHsk/PLDqjTigc7yujDAlSXZ90dCgckoStohaCptumFjeLn1Ds5imfjsjLrBNKAh8xDltklUqFrxl1QnHCOib6o5laz5z0vV0BZcOstvUkhcCK1CTFpA5FotuXIqJLBQTsS03umGQstu46vKzTjpgXISkApUS9Plr/hgMdMjJS74oJjYqTmpq36Dk54OaBmfm9C1YhZ68CdP3Qj1S6yTDat3URTitJ7QlScWx8ic9gEy/tkwTdjgHfH2NzW31ZMK5mNYWg+EAggR3e8hkDCkSCZwdN+bdKVrwB8aNly572qO4W0sfz4TwoaZWMApT7uGCi4Uiyi/N9yP5PG8B/u4W+MUMpzzfOdlRTimIW43BSsOQlK4i8ZEBBxlEsTGp7GVvY8H33M+4rfojIccWugIIwK2xOmTzZkskTCrIsjuo6artZ4i4ASh0Ayh+pAYqje56HDftv/AiWVxzZ2G5leWCDCiQqu8Lp/n0Mqhc7Obl4UoOW/ejiLp5yfClUuT0JHiXo0okt9DSEdb7xxaSnvEQ3cKet14ia5QkJtgK7VnTIW8S1EwnSCAzBJpj6obQxsYWHzjnDN2WWKdgo2ZmN9QD6CAJ2LhkFKOaQyWE7PjGnoTltzAAUc4ZJr40MKKlw5zWcUEytI4u66+De4lQLOarYVYeChbMi7o4UExenYRNPswrrKBydvVM1KY59+dgv9Pp+9ly1uXDk4BWBTUasDGxyXkGq8wATdkRL1GHERr8kwdEb+cJe7aH3zm6i4H8XUvkKNendXtOpSJlEQ7f06RGoBMafoBaU1xaPq71n4bjaLQN/+08zcOrRtQhjXwv5vpivHDZCUDk6JomLZvNE7TMAG1JkBJgwdUms6Cwg19p+xpfoj3u6tAXXNNXUbqcdUxeSv88wDrDuzdZQKezLNCLDKHyNA9sNUNZNaeuNeVSxYi7bPxy/x+TxLyYidKwm5kUX5CS56lWwUpoexpf+nFVRExv1sRV06LusDGxcbUVg4xVOjooHUArwqSlFml9uV7PFQLr37zKoPV6leChQsQ2VajqKRGc/unJqBz2+j8gzlhVIuoTm8KLcsXBsrVOLxtfm2FM0eNqxPYOnHa+NU0w3nFiKWjZkprS2KrOfCcpYDMjryLnfrSlD0OkdVI5SYMtGbo3zW1r0stc408WWflmlpJWjxNrcJWmJrU2Ks1NhiL3Gstc4bO7P5sqcAno6qi2hUrLi79jme1IPKEHzOpRbFdhMnyvE2qJyEOqir+UAJQkczsJkiX4eXCE8+D+244ZHfJk0ZczwTSny3+7vv2PRmMlBDQ048CNOIq1Wfd3sT0GhPIldvTe+StPDumytjuTt4UFIzEVl3/mKilSPT73tnLcS7f5tEh3eOptunv+ToiNsud+oCujYjNPKkUVjatRhvRD0J+sHTzsx0dx5ZWK7NOOtWUgD//CDUBvjh1sNdTmqxXHX+Jrox2U3Kpt2s9nxTFRLF4TpsSm9tPH8QUsEKlv48UMKnzS3oNr6tGshi1M0f4RPUrM2NMuEOZWLn03lMx4/3ApCU/M14RMC++tYUlILCslRLiywsnx1OTacQGVfE37Y4Jhs1jwgJOpNLZlIVm+rB4BnF+5f8/T1nho0tUVqij6z5gD7rmpmNUzaSKfTvtxlTj9NTHixiCc3OJQD5SleLwgbP99YqZaQy3/mPb1h+PJnN06k+3TJuUtWBTbtAdHWOUGh2AY7pWamaHF2y0UqByc6d2I3Hd67lvYGTSaN2odcvQsR0gub6m7x9zgl1SWl8vCicbWXzPyspk9GGhxYTNyrDvyjCrahP5tas9isBH6onVE5EKPdCsa7gTrasAFwQMYkflJpXIhPNSPQz+4mpwaw24tX9prnp92pqCZP6XZjiNFATAve9kZ9bvQxP7BZG5AUyfTolQKRiJ18PzZcx9IpLEYHY38T/oENskKhzXpd43DxLA5lmmz6waI/O90uwlgJDwjmnob3o89cS5mRHdonKuV/n9e+DlLYLtaK2vadhmzm4HUWlQ1z221Ah47x92fSko6V1/Euo7bpQcJUeXR5zyn4feSv2nl+E8i1nc5tHrc27NY/6fpluOUuFlGh1VdnZy/+tZFxTC+OhFxMCSsq6C2gME8hI09OL9OW+rzi58oA83bXL+nRvet0cv/yVOafCk/M4FMq1w1FiuFhg6ceS8s6yRQbM+x7rIkbBm+C6mXhRfjBYAf4a0+/DpMkGEJoFE2jIZ9MToKmayYHslMD0MMn4vaoHPrf2rKST0HWdMb1ed3Y5J4B4DjGsUZEpb80xmInQn4441DuhzBWiDU0Gcbih96GqBx/61+MdceasUAT6/g4aCXfp39hHD6h2L3gOpytkqU1qRXeCPhUdBjXt0UMa3e67TVgEiuvTQvfn4Yn4o8kjfb99sM2W3Tk3TD3PTwBCBUsBJQ5AJQR5kzm0eW9Z85tm1iu0SebP3dyzz0D4eN3Hf2pH8xNpfTFbIgzVaJOL8G7SIP6G7/rfdapoMeHuN7nABN+MoSJr2kA5HbpAQp/X6BkLXLzykuXjnPk7qTFpJWXobm5QAaag15GxX4ybv5ZS0U45rBabiNzQOaAzAGrOJBkMw5//Owr7JxhELH8uXFex6Hmjsg6CICJfoO2pACizZYjwrQ4ThJ16pBr+1i8QlGSd4f85VuafhqTJMcb/6x0OLNp1JGmHw2OLVqu4bIEMLGEVlNtH1w/Rrf/O2Cqmb2+7+Tu4nh6/qha6WWGs9e15HFkDsgckDlgFgeSAEqvgH0xUBGyJQritdMPm+Z3XLdqDnKpmyhrp7flY7rFSn2FJJmtzHJwcNcfm4MvbM/z8uXL3Bz40a98q27ImmhWBF5tzAv1jcM/CjF3DlC9pj2oRMW3TE3L4u/ZlDgTSxFBSfsXjKkxIhOvKV9K5oDMAZkDaXIghbio3acbT+I0wMHUuHTzVNHp3+e2TzdEhUqh0ye4srSIQozZuhq1Wy49+LwIuewe9+Si3hvfp0iNHZXf+y4OQluzLWWQA4WuH15KEdd2UK0GHal01VakUluMhZZOlduzTJotangeHDzyLwjbDiJEyzG8wr5Y4u/MnoeBADUCcc5a8FmtNbNHF7F33g9r5ij3kTkgc+AN5kCqnvIswtr4Q7sdEGOxHT8X6ILFBbonLz7vFLAvhZjp17ltGilJyRn7zArLbtBHxEF/Yk7+ZT0BOl1ch31z3l4n6uIcXXIVuVO315peiOqrvyaU9U8u75uVy5p1FPCYn6/sO6R18KYrZ3ZTXExECs/+tOeVUv+CVJNxAOQzMPllU9rzEOtdELSxt4P/PRkcsE/UQmnHeUM4bAz77fD8+T0r6CKcBYr6tEd5dbH8rkUEhVQG6qGqGIu95DnkdSL4p6r3kcSjOp2m/bBZZ61WgFrDP7mPzAGZAzIHEjiQZuiVoHmtfVWCI2+KBeM3VL1Rwn1Ay7j3R/yxzth8NWhO29bIaMgmc5YASggAJbWcDqmuTmxsbNGTv/Q/8fLxNb0VTIWWE54WqKgXtdHCwGZujeq3vnL/dFCSoJSWLbNAuYvVJUffMnT59B6KDE8a9DMdpTyjCvNpp0jiPulx7NH+i45HATjy4DM2peaEOmxWyDomDvzINJsKpPgcbThaKQe1O1eqsOvl/u/5u7m7qJvgfVsAClu8JCmG9bkjaaRWQ+ecNFuUaBmP5NYyB2QOyBxImwPpxvLSmxILCj4FOCSzcjuMZ+oJHYZt0vsLBE1u7Su4qGC3LvWHNSynsky62YlJLeT0mzMCQnYZvc0iD+urfy3U3vp3tT5cvELpEFWp7dfT9m74Pg4oNtLJzdvHv1x9enh6fQL4Wb3ubnnKUK4Sjejqhb/pmSEmVzJAYdHUYURI3kAa3caPJ/9zHwDCQMHOao1R2WTS4hweJgjm5ERHEKJl8+zRNU6oSGBrtS6oXtzPaH2eakVqM3zmiVRzsljNFLmj3TgQFNRV2bBqnU5KpaKXoBAKIrTPeO/CgzkopFxkDmRrDpgMDrlpXvv+kNP/mJrZtE6U9goiTes86o89fGJZNaeZlzO59oZspi8ewismcCYNP5SbOKGwzbbZJeTqgaAzmz/nAI36IiocpOZD/hB+nd0pcYxipetQ5N1/SIwzbQBm6sKOHn7kXqAG3b1zhZ6H3uZt+yygcEVsdOx6eK0/Aojw6Y3Dr3OIFA7cpTI1ph2+Zy9dPRCz3sRBkZez0g3F+hinFo3U6XTvD5t12iynUTvQJA9hJgceXp1cX6FQL4BYuRKcafHTUsAARvmzd6HBPc0cQm4mcyDLcsAkoDDlv8/vOB2KBfY0TlKMZPnsebw4Qnq5ttfwfc+50S8zW1dVKRQIvyu8C0Bh0Y/+ZMHF8LT/CIBitjJ/7eS3yxWt0GJ4zN2D/TSRTxL1CUpnb/Kp0IH+O/oqgkvx8s3Iw1FB989t4ovZzHxH93xxZZsO0+Qq3qA2Yondw4AMIhxevgmq5eFmbKPoKviXwhlz3uhqLQBwMKYQ9AYU8H2JJZ3Yeeic09am3rWNSrl3Eg7cORjo5JDX8RtEeBiJU8kfuCtnk0IVqVYpj0MKMDVXoSHjZJbJHMjuHDALUDhxlrJB2/UAh8TTAU88FeVwDD7bCw3B75o43e4en23Th1lHnDAvJ1fnWgjPwk/R/tgQoUsQXNPzkl8SWNPFzcm7Hq4J71YBwETleKw6TXrR1QNJoxYIKicEZRxBR3bOT1wPPhWVrowgvVHB9PT2v3ZZJ8GtWNT5Z0UdxnwxKTNOImnRfAH8Szz9JW80f1S1JqRQTAagcLrgOB1JXYfPPAVklcvr4sCtc4H+jir1BpxGfAWJ+uYrO14v3gq9MaueQq06jBxCTXwKDtUbmMhF5kB25oBZgMITnDevtWMBUvMPITHeVerWRq9OBPjvGn5ACOOgO41N8KakU9wFCoUh6+FzxNnQh3ZwcSU3tcI5l0IUC5MkFBcEqSLSCFeH1roKLKZShEQvVr45vby2K1WRVuHqXehFjJZuwcFQq4lPmObg6EplqrUmlS6CHl35kzRRaWboNWsdtdCelGwwgCq9NYDi4litkenFZKZBttKbM6xKZzwJTwN1MHyQOg6deWpbplMqX5Dungtso1Qo1wBMLoka6lSw8oTE2GBht2fPx+fNfYuOKJNFY7TJKyhzwCIOmA0oPOqKaQ3dvZxzcy50fUhxU4CSQInJjI1omFp4EgBKislwu+oNe9DtwxyTLWWBSIH8yrUk0SEX3bpyhKJehOozKCpVDgiN4kfFy9YnpRRHkU9vU2TYLYoJD8a1LQ9b5FGwFi3ZGUYrVq+1iOF2aLwZ4NzenHFm9Krq6pBb8SXAeQiiDHT4dPYZ40B75gwht7GSAwzqt0/9738AjP/h/9XR90MHlmw5JzEtbPDlWf4OTgoOV9TTp+gwsyJuW0mK3M1OHAjEQub/hJT9F+HRQC6p77+pmcOmx6u181p7OJMaPipU73UBCtNXtUZLunvq13SX1cmzAOUr3ZRElTs9vH+JQu6eJ21cfJBiR2cPVHddwVL1jhYsWik6Jvx+kWfBF/I8vnXcRYp9blayKFefkvTukHUUEW2pP6JNdyPnHR9syQhzRlWrAgXWPDgTjYai3ib5X2CgQlXHoXqa+WgsoSuntnXxze3kV7rCXIWjuo2k0y24deif73TamMSju4uXq6p4g7c34gQZdXH7ju7G3+VUnmTXeSlVTsKT0PvvCqL4AR6h68LKEgamTh1c3bzMDhtl7dyPxp0MCQhIZiJr7WCZ1M+iE0oCTUHw+1Dm8tiIDSpF9kALg0MmTtOSEwp3cnByo9KlKlHwf3xgMl0UKkfyyl+RPPKVI4WTp6STlCc9fItP8ylU+Zyvr6/w4sWL0Z6enh8WLFjQYVDfztQQObzund9GKm36IrIYZV76es0dOnX6jGki7NNiPHg8xdKhBg5UqMs6VhmCh4DtI384zf4tVpU/ptQo6SCoOKy4XFLhgEKJnJrubpUUCqW7JjbmRlxkZIrouM4enqXQyi/y+bNjokZjVb4XmfkZzwE4FXvoNNrSsKB0x+EkFEYvWkg7/JCl9Rres3FOhpbo6Nju7QNOJ3WIy9Ar2j64VYDClw0KrOhA3sVXQpzCZquJJbMABT9cZEvUUvlytQmh7a3ihFLtEiM6+VGBUrWdbj3W0rotR2nL1u0UERFB8MKnkiVLUt9uLal2CZEiHhwjZRr2XEKeBtT785/p4cNMSRHdCTzmVAFWlbkjKxZ+Nue/+3jwyZHhs61iip06XflrdEUHR4dtEHPlhx5wYLGa3y5NPnTwlSm9VUrVEoGk1r4lx+y206XlYezIgcBmClWRcnkmInPqOMQ0vCcIYq8P5oT8vby/dy5Xd+cnOGq26TYzWNZJpsJzqwGFx2I58W+z27CpaiC/5c8yC1AS5sK6ker1OtKNw0tsNhHWigpy96tModp8NGXhZjp+Ij4RoQeyM86eGkBe0SfIRZMy/BhbJh98VIEmz0qxf9jxNk8cqgx4nGbGyoy4oDymaQ5cOTyqiUqh3oTfhIugoJ5Fa05KIY+9f/G7liqVwxYAzpi8JUfnyARLzKnpgyqUgn9akbv3NX/P2XYlUW9kmouvv8W8jz193Zycf8FppBnEW39qY2K69F3yTC+mWDc8P1uq7tU8Ib+eq4LNCkr7+meUuRTYBCgJpC4KfLu9r7cLi0HyZDagJIBYtcYf0rOrf9LLx/bZa3XId+RerDmt23ODFi6OT5pVqVIlmjdpOIWdXkIuHIHLqDjmq0kdhv1Ez58/z8gV5JvYEzzOVKVNRk4oJ4x99a8RXSAGWQ2gEPFE26VYnSn6METG5e5/39ZXK1U70WZuPv+xCcFXc8L0E+cwa2ilQgDUJTj8vsMHYFGjbf7ZksvZxhBk6QCf8kqlajuApDDcFH7WaB/3MVbA/zIyfyAkMn5dZwV/kqMWzo6TsYtT3qCJex8Nn7R/h04k8xQadpxAwlCnDv5E98KeUvmWEwiiLMvNtpLRpJSiKermH9SyyGXa88v3VBlgcu7cOWrU+mO6Ijaj8DhOSveqRAYfp9EjzU4hYy0HOJOeDCbWci8D+l3ZP+JTOCauw9AaknStUwOTB+cD66gExXaEG1qZU8HkhxFVK6jUKg73kxBQdnPUsquc6jZblKUD8jYWFKq/QWxhiDrm31nw+CNjMFnVV8EhyXuLko5N8eWSBgfsAigY+/SDRy+7dh25pfCpSyH/w3u75+E2YwWfaTXRMw9unFWqwcfrehev2+8pqVxsNu9zVImku7uFvu5djNq35gyiSPf4v+9p83kveqH1SCRLBU42r21RaDIzppSiiT5sv1yyBgcu7R82EeItFl290Op0LUrUm55iA71zNrAJCcrdEIsuLVB+wrCsQbl9qVj4Wc0GcH3muH4F9CNLtCUiJqpbdtHTLRqQ5z04UHOYIm/QPqfvwtBPk9Oucs/3Kb7f1n12SKalhbbvKmXOaHYBFDw1s5yUUwaXm7T4WEDfCTs3v4zSTMHiZHSKWnilwDNfkj6Min1W8IPxe0b3nLjfzdkjbyP/hv2cvg2KVJduNoI0Qop4lRZz11EbQv0aaWnj6hnk6OhIa9dvpF1XclGU5pWFsbMYxnoli8e2oMNeC9rKTTOIAzCdVlz6c8hciD8CcIkwnYbeKtNoZopgnLfPTGwHERhOJtJMgMnonOi8uHhcnTaJm3E8mqx8cenC+wHLb2YL67WFn+TtqiQhCIQ7QhU6p8/CRyOSr9OqwbmKYq37SXHROVJUac+fiV10KEwQlFhj8WJszvrc29NxzsxxTWJdnVScBbJMAuGm8rMntEvDsREiH+lvmChtUcRof+sRsC8h0m9X9OPrcMiRJKVWrZo05Yu+9Oz6HnLWBZuMHZ8egxEQk4LVDaj/6Bn6ZsvmfkUFYuKtzBReZenDr7ZTSEiGpCThdJA+4N1rcc+3502Xncc6GNhM5Vu3zHJBqfgQ+pAQPEE0L9N49oXkc7p98stPYYk4Hb+LTwtVDvgxO885LdoXT6jXG17DrDNRiZB3o04ePvfMhOwCnAv75ekOu6KfAPrAFFo44MdQmNXjB25UuiLs1Ht58+5lsOk59+GmnLiO9pyTPQGFAeNSKsS94H13QJcKJ96qXbi8PlhkfCyqJPGw0vFDYX3IZYDIv+i3L06M3dN7/EG2CeecIG1RO6A2R02mJk9JSfXq1alFk5r0ftNi9ODCNnJUWLc3a/HjqdVtHuUpVkt/kbN/BNDDS7tIo85HY3+8QpcupcYGm5dtPebfzeZR5AGs5gDCzjuUdff6BdEYOgBMHuhERfMKb8/FvfmqnFoyUJ2rSu5Z+L4X7tHuhat9nUJBbzUBWajjkq8ajEfw0e+xAcPnD94ZWnH00JknZmchEtMlZeHHvh2xRuuhgFehrn64JLRPaiK6NcPyfYvTie8Hcx8NyC5ze5102g1QeBL4ASGVbXwQxzTKGXy+1cfL+eDEwTWjfXO7FQVQsNzVW9RJDlhYPAgI0dg4n0iC8AC5Rq6FhEVcGTHjcDTG5uRZNVDroyLqI1XmS1rLvDatW1HAyO704PwmctJYrvKJiBEpulAf+rDPIFq+cCrlf7mR4lR5aMLym3ThQooHVmvJNO73Pviy0R4DyWNYzoGDq/o6efsqNyCHSSsAyl1JJzYr33LRDeORrh8a7guDkF9xailKotCuWO1vOQp3jirsKgAwmY5wSqPAAxxQxDitqOszZOrxTI9BZC1j5/XJ3RrWXBux3/Ces+XR9dD3OZtq8vFWDs3bVaUQPg8LeVx3xHoxPsSGXNLlgL0BBUm26DszeW44eRDb+fKOzh6hrETnz9mEyh2VMzpypkOunAExseTKlYuePrUt0CMPVqFCBRrUpzM1ruBEd89ugTON+UZUap/K1HnMbwTvevoGSnslctMPn32CbtxIss+YyY50m/FECwBQsoVc2h4TzkpjnFrSzkXl57MZYq7meKq9i3zUTSu0WnrTmMZrf41uiMjBa7HhXtfEaDv7N54WlpXmYA9algysqVb5uS4DmHzIZsEAlAitTvP+oCnHs42D5ry+uRsi7fcuOC0i47Z0MEQMaxmwXEzxu1o2OF99lVL4RSdJTfvOe8TZU+ViBgfsDSiFcE32/EvMfWIGDRY3mThxIu3cuZOOHj1qcd/0OrR+pzF9NaAJPbu2G6ct8/KoHA4pR9/MWE5Xj6yihzdOUdshKwhhXOxKFwabCzAZbu9B5fFMc+DIig7urj5eWwEkjRhM8INJAiasoO/RdPh4QamaCPPhGfc1x79q3HifzWbrpimzT4vtS7t/KpGuM3SDAp84dKg4dvDJAxItPWjgFUkQdBJ/5gPhVhm9viT+O4j9xFsIPIp+MI/Ba1xs3KDRC/7LkCO6rTOe9VHuyiqV8iB0Jp4AlAtxoqbh8OVPnycfd/lgnwpKhWoPZtmjz7zH2cb02Vb+2KO/XU2SsOlxfBu7pTJt2rSp/unfuHTp0oWG9etA4eHh9ph/kjG27TpITXpMoY0X8lCs0rz4h61q5SIk3aJj/4WQd77iFBlpdwdaRjY5dpbdV9v0gAeDurq55HLn+xlJyySIueKaGJ9Mzu0ZnKd7k2E78PQxDJvPeyXqTfk8O4EJcwCi5NIIExOL5yeOXhkDERA/resrnuBjIITGq+CF95yRNMGwhsU/bHF4CQCLtoKhrRAR8URhdZw40ytifYtpH/oWVCkV2yAj9wT0PdDFiu+mBiYr+uUprRBUeyRJ+EoGE8v5bdcTiuEGZQW5dcG1ktFftmxZOnJgOx05coSWrg7Sx8paPXMwibHh1OyDSRQcHGz5jM3sUbVKZZo2+h3SPmTz+rSLTlLQyuP5yCd3LvqoY32q+04fM69gdrPtAOrWZreWG9qFA3vWtHTN7eKzTaFUNIZO5D50z02qtVuRKMuE2XBzxJ1dBRHXGY1O6Fuh2awMMe2zy2RsGGTttGYFSac+gBNJCb33u6iL0Wh17fp//Xe2EXMFdlW4eTn5HIJFf2UAZiSJ2oZDVz5NES142Se+ZRUqxZ9os6j3/JCvbWDbG9vVricU5iI2P35yiQ+CZWNha6llq38l97BNNLpjXvp51kC6eWghqR3dMjrECZ0+c5Z6jF5JpZum74umRNCits1r0fWbd2jn30kMfmycfWJ3iyML2+vCb+o4W6Ez8Xby/gMmH41xRweTRtssAUyOBnV1vrh78Bw8lW/A01hA6cazW+dUMFk/7Z38CnLYBz6UMNwLsdCfdMxOYMJGBJ5OuVYAJNiIB0I56pkamHDYFVIqWbz1uwwm1v/y7X5CYVJwjH4PL5utJ+tVTzc3Nzr+58905+CkxA/zlWlOl8KL0fTZC+jkyZP2uEyaYyC0Pa2b3pO0ISn81hL7uJXrQw3aZIhV4V4AdIoUARk64Td88KOz6zurChTiAI6sgH8sCLomVduv09uBn93et4pKqebsi4hNLX5c6e3FKSOF5hD+/TyplZ/aUTgAfYm//mSiE2O1Gk3H3gEQGWSjMutD388RzeB76EzYJDTw05WPJyYnf9EnuSupBPVetNtyf/HjT7KLh39WXAa7n1AMk/wDr3bRmLNOIhj+9pLwyiP90eW9lPvxKloztScd2Leb2rRpk2G8DQ0NpaDDLygyLu008mqV1dbL6dHNupMvM2xi8sApOHBwVTMnZb78v+MLFts+0QDMGUxOLampPvtH3wkKQcmBDhdUeGfxWzkaTOa08nNwVu7DXP0NTILDltQ5u4HJ9A996gNF4kVXEm1/ujoshRhr0Sd5GyoF1QESpO0ymNi+KWQIoOCpmjfDUfpltLF88/VEcgrZjPV+FZarUJWOlKv6MNp3SYFIwMvoxIkTNl4l/e6LflxGVd9JO/DjsxcZYqL+M9hoU3bFDGVKDht857zWjk4O3htxvObghi9g69Sydsefz53c+EFVRb4K/yK7YhMxTle9/DuLF2QXT3Brlmj9/A75nQX1fjwiJSjgNYhY0bXnhL38kJhtyrQOCncFCT+DYH4SDI6Kie2d/OSxqJ/v+5jnbmxS6x/8GNpXPpnYvrwZAij6BwJJYhnRaltI7NixI/XpWJvylKhL3jXHUNG6/fXD5S5Sm35YtJKGDB1O69evp0ePHtlyGbP6LvzlMCUNyvCq2+Vbdnc5YBO28WYRJjeymQOcLM7Ly4HjOb2LGgNT2HZREY8unNr4wSQEPdwJV/C5lVova1G53fLbNl8sCw/w+7zWBRFu4gBILG0gE5I96t5z/J5NWZjsVEkTXHOzjLwIb0WYQ5/x68NDjRsu7JtnMAmK9fhs9sAloYNlMLHPCmcYoBjIG41Xq1JYent7U61atWjY/5ZQnXbjqXbTTrRy6xXy9CtHpy8/oIGtfOjK38vovfcyTtxlzOJNW3aS6Mh+lklLrE5N+4/Y3SGa0/xa7r5vn3vijRplCcRZBYoX/xWiEb6RtEgO0A06Ehc3t7znJYEKxkiRFSu3W7UypzNl8+KORRVKJwaTUoa5snShd7dxO6zODvq6eDathzdH1Bikvz6iPI/4KTTRIo1jc83rm2cGKYS5QJoRA34M+Twnnzgzew0yRClvPAko6NvjPculbS6clvef/Zvo+t0nNG3KJJo6uCo9e/qYCtX6mIaMm5EhCnqlUqk3T2Z/mMO/fEZPb7Bo+VXJX6kDVWo5zua5GQ3AVnLvAFDkFL325GoqYzGYlHfI9ysApD2qhE3mO6VCWQGhVSphNx1cs/MvHNI8x5dNC98vi5Ayu6F4L2hwWISjoi6w88itE7Pj5Kf18PkLIsqGcGAMexmnLR2wPj7j4pyOubwUXqpf8Hl9qOi7D14WkiPjrL3ONcvoEwqLvjZhgsjPa3vRarU0aOREuh/8mE6du0zdv9xFZWq0omcn59KE7oVo39bVVKdOHdsvZDRCw4YNSYq4SxqNhlw9k0R/0SuI1my3q6kwy856yWBi1yVMdTCOGlxWlYcTY7XnBljLp9hkOOfFRe0DqcKbAiY7fuxRQ61WHcS8OVZeQtnQdfR2Tuud7cqUbt7NcdpsqCdcom8TwGTuR3BY9FQdhc6kJFz868lgkjFLm+GAYiCbnTlSOBJZMyVWwM+dG5+OOxQZGiu2GE0hHu1g1oiwDxcX0NiOuen0wbXU84Pu5OTESdZsK8M+6UZh9y/qB1E7JB3Pr0wLmjp3hW0XeNWbTyQ9ASYZ561pL0qz+TgMJoqCDqywfT9hKvAU/08jifVqdv3tizoj1meIlUVWY9uOld3bQGW9H2B6Vr/9xu/Cd19KL/tlWzGQQsFidi5hL18+0T/IzuyVqz2C9B3FDG9HxmlqDln+5HxWW4ucQk+mAIohqGFHMM0qfUpyZt+7xxFeXpXegz6nFQd1FJX/AypQvDLdOzKPulS8TwfWTaDfVs2k1q1aEfuzWFr8/PzIPeY8hYXH6hNnRb58kjiEVlJT4I9HLB0yvfb/A5/eCBGLPZlm6VhBkKFTftUq9Oti6BsiSlKveh9tbtKgx+/xTw5vQNmz+sNhMIP+HZssEvtIHIiV4+9Bzir26jV83/PMYgE7HtrrWoEd3PLjlKn320J4lV8ewiV11ke+MxSk/A2ikhkwG241bs0zOCHIJaM4kOE6FGPCoU+ph/esI3C2ZUJ88oiJeRUglGNpbdq0iVoBOPj/wYMGUPu3q5GfRwxdP/cXKcQoxNkqTUqPonTm6hO6di+c9uz9k+7cuZNuxOLPhn5EzQpfo3uuHeirr2fQT9+2JfFZfNy7km99SSWr280ggK3hehvMrW1hjdw3HQ4wmPg0a7YCmxgnx4KFsGKxEKf8vP7AP96YTWbn2g89VKT8EYEdO4pacZBO0jwCimyNd17U/dRu0EZOUpchJRA6DHJyb4W87G8j/1EV6GyK4roeeGXLun9jomP6/LA38o61F5/U3aefUqAl8GFkSBmiFISe0IsVUJDYc8TqJ5wvXi4ZzIFMBRSeC0CFk2JxXo+0PQVNTLp+/fo0ZswYWrBgAe3du5fWrFxC1SqVorJVESkjWSlXrhyVKlWKCvjloRpVSlPRgr7k7uoER0UlObrno7r1OOZdyuJfqgTNGlqRdDHhNH2bTg88k/sUJJXuOeWt1I2qthxhr6VhC5S2ciZGe7Ez9XF2zWns5+CgnAsw6WQAkykN++18o0yz9//apxFMaFciKaGrGKfp/nbvn/dtX95jF6IEt+AcWfCzKd1u6Ea7514I7F3SX03SZ7jGB7iKM17DASBHJZ3uDmipis9qxkc31n09Y9vzAGvvBADKCgBKbwYU7DPRCG65XqeRRoxd/8T+kWStJTKH98t0QDGACosbEpyOrGLxooXzqGlZ3Dge/vT8yu8Ul7sxNWhhn4SGbE12dMNXFHZlB/mU60A12oyjvr17UudyN0iCRWKr/j9YRXMqnfipiTNY2j1Esb0IzO7j7JxWt6DKSTlSoVANAJC4sugSr0ubDNj7SVbUE4Scm+GqdVaUxAlCdyMk4nLjxgE2h8LfHdQ/lxMJ3yEO1yfYvP/SxcR80LzP2uCtSz7wUSqlR8ASJcLW73hvwG+t7LneCMro4ORRaiL4PBrzUeMEtE2nERc+vHF/z6Ljot5TeUKHPF8DVL4yhHfpMn37s9+spQGAsh+A0kQPKJIwdMza0PnWjiX3s44DrwVQDKDSyQAqJlP3pjY1Dw8POrF/Hd388xv910Vr96EjV0X6YcGPdPp0+vp/T09P8vHxoTJlylC1qpXpm2+/T7yEq6srndg6le4c/4ni8FO+pnyXRo8LoI0rJ5G3wwsaN/tPOnbsmHXcTtrrAN6+BzDhXPFysSMHOBFU4RKKdwEcvREtuC0SY6lgCsxAwvX3sH37Ondaz3ECzStHtiAniuBVCZFoyyK0eSFBqXRGvpwDZZsvtEtcK6QWVr5Vp3FnaMX7YcNvhM1VbTDfDdbqtC0KlR3LmVAtLpyyOJ8q90BoRnjDdsSm/r/QDS9/6LR+vX7uO1f1bIvPtgBQSKvTDWk3IGiBxRdJo0PgwLI+LpLwO8ZuACC5qtPo+n75063D3Jz1Jl90ylMXojbkcJe6Y84C8HMLTicdOJ2wpTSw7sTB0XEWTiVdWCOjBxQSvhrzc+i3lo4lt7eNA68NUJhs3ACcypc9lFkpaFFp3rw5/fBFO2z8fNAh8ilen3xL1KcY57K0ddt2uvjfefL2dCXf3J7k6aomH08HKpjPm1wdRAoPvaWPWBwW60FzV2ynXbs5RBNRtSoVac64dyjy3iH9e7+aA6ly094IQqqkJyF3qLh/JbtkicTQbP/eBWDyRlgTWbSwVjZeFVjcyUfl3kzB+d6VinYAEF+Ax3HcY5EKlbKJHlAExb5Y8UGrlkOvxKZ1GU6Y1bL0+xVUanU99OdaG2OWxKuCASn+hKMHJ/GO5pZLy5bb0hwrvamEXgx0I0fPBoJa2Ri+L50xXnx4eJ3uP7z+AZFQLOmkcfh/RYEyYwZbwpaDQUPdnJyEvri/RqF/IdTfouI0n7XouiyJNcuulT1H4ruZDCiiVle37cAgu8TfC+xb3MnNyeVvAEUNjH35hSaqgYOoKqKUqAGuVx+VQTOfIVFXiFarm3pn69M565kQC0rgu965VO7CMKzxSFR2EIM7DbWNF3nR/cjgp6UC9qXMxmjBJeSmFnLgtQKKAVQ4rDTHCeJsj2YV1on8tXcLRT1EpGEHL7p5cAZV7baU7p7aABPf86SNCCaFLgpjxVtCijBg0Qqu5OVXhlx8/OnSfR1Nmb0kMfc7n0o+G9KNqud9QGroSLiUqPcxlWoQH+rFzmUexhuBH7tFPx4705Dth+P9feOEEuVxAmmG3MtvY0Nuis9YpPUIeUp+I0FcLSgcSiKp0s8AGASbVR6PiNa99d5nf6c4ER5a0spP4ax+B3nG3wZ4cJThPKjBqMcYlGAldCJGEXfWReVyGOOXMIDT/rLN5zUzl5GnTgW65HNW1ROU6sYYg4GvJsZWx4OUHqCgV9AN9i386ToWxR08GKjy93O/DAfDfQXLfvaJqeswELarO6oO8ih+CKV3D2zWbhhvq6gR/1e/w0I2C05Rdq3q+RnaTbUnoIAMhfvgCixeGx8PGNp7mI4HTkKeej2JTgzH9Y7js2OY2983rjzet/68iOCT5hUMrwho74XsmdQLzoudFCQdQK7JiV+uf3YysJ2nj7Or+hzAxA8AA308zR/1U2jaQfjMu6TcygIOvHZAYVqx+Hnx8isqMuOZLhzjKywsjI4fP04lS5akrau/odmrD9LSpUvJ39+fihUrRt5enjihuFGsRkuPQsLo8ePH+iCSL1++2k9q1qxJn/ZtT0VcH1D0o/gULlFxAhWuM4BqNO9tmhDLWvCT7DAAyY+WdZNbMwdW9VU4OebOX0OtUNcjpVAfmzCfHnywv0jY4M9iV94pkmL7Gd25wwEIzLRzWo23FEr1dnzvICiFyxpB2ajl0IP6eE5s7ZX37Wa1SenYGljTCuNURr2GMfYAeg5A1Hm4wQdBD405f27bxwiDrvjecEIJliRFnfIt5iW1XzfqcOXIeHdEm6yrVKkaYkw+IdVCfwcGI4wh4v8rqGUNgKLD7tfIO/+gRDv0h9dnT8duPBqbcH+cUJamdhecO/SFP3QGDbFxN4Fi/S1RJ/nhZBOKDXuNLk67oE7beenmQtf7oYjCH3pAEcU5bT/5bYQld9uSUTX9RJWyoU7SVQRAlAENSA8slcRYTgadCCfkugia9gHYjut0scdoXfBVS+JmdcVCF23tWlGtUtWHjwP4KDQGUHhDpLVJp9BND/z1eZIAqpO7+oDntBd7iotB/LX0RYTus4CNKVP9WjJXua15HMgSgGIAFY5PzwHdOEqxRbbpU6ZMoVOnTukDRaZV2JyYc5tUr16dOrSsR42q+dGFv9eRo/Rc3yVW4U1FKrelzYceUEDgd+Zxz/xWN9G0O8DELsoX8y+bc1quH1Pgd+wt7VE1EF2dxsZyBDvzUWycBztNuZkkOujWSTWrqdWK/disPbB5x5BSrKQVnt51FPzeQe739jjVtMZ3ntjcOb/4HzqtalvDfpvTzG1ydksfFqNtQB+WfL3QClSvcovFiXqNqwcH+pDCpZJCqaoE8VUltGWAcoKupRxeJfS5BcA4wackjHAsXBBOe6mkwkql4wUDoOzyLji4ZcJqBV+enFuhdrqPp3qVVhR7wvzJUdRpfXSSmBumvj4wuS2IJ31nROdpgo2bc8Ffxqa9X9JpN4YfOn2gcYB5Oe31ccyUpc4DCErzqUinFeeJOs0PnYZvvZ7cYGHJl7CSc1RUwMmjKppClCUWwnWL4zWPATyCAWznACCoUid8VpxPKDqddvL4pVc/N+dO5NPHyOZORZUOqhrgVXWsTQ1O2YvTCP6Hmp0IIgkpSNJp1nyzJSLNWHeTe+RuqFIoNqC/b7z4SwrHOTBIEMSjcHC8jzWIA+D44H0eAJMvltUHgkw/QSFViIsVGg1angnRZs1hSDZsk2UAJYF3WGj+YfETWQFz+ens7EwFChSg69dTfyDj/PNhD2+QIvoBPYFITBMTQS7uueD67kZ3H0XQlXuRtO63LRkSCwxzYFf64bLy3dzVTNmOxVu/jMw/jBTSaYWoOt5pxp00dU+bv6tUwlHteBgbdV6DzuMhNnicBpTVcG/hRbkNm/vm6NiI7S2H/vPCFFUnNvYsrlarT8UDkF6HAj8qYT2AqZRCKVQCwFXC5/kTlP74PgSXOYJT1C4SlLei4pQnytUJ0MeSMi4h12e0xemFE3mxyGszAKU9fx92a15DCIpg+YRTh15kpE9uxU/68f9rxTiEk78MXcvv+P9ibLT2UJXmk62OrrB5cY+iSqX2Z4BUPYNOA5FJxGe4Fk46uJZOdDHoO/iV6eC/m6gbJK0YDJHWuWhd9LkRM84nznHW0Epj0HaaEd1/iVrtbvwG7ml1YqSkk5Q41bggFKcnQDI/xikCOCutEyV/iLBcGAQAIDD7RXQNBYGP4lmtRIenbQ43O6z3tB5u+ZVKp2+xFj0wnqM+wVaCwj5+/MT3AB4t3t7CY+yefgtDhpi6J+Tv0+ZAlgMUJhU3gTdepqP24be2LiDLU/mEwpX/h+yWoqOj9T/QDCz8xDsQP6Jsk3s7A3mRKUNvDizu5eDodQKbO/QceosuBgAGlG2CpNh875lyb6+Afa88Ys2g6symj9bgpPGB0XgJSnmI2hT3MP5F7E6nBFKd1Ci0J8rVn3XXjGEp9Nr0KoJajZOWHlAkQN2f2FS9ITKqjvvyITbeLwStLhpe/C80cXFhiCUXhmzTYf51Al8mPz2Ycz1Tbf5Y1KkOxm0GuCgBQPHAdaNwcoGVmfgQNN3XiZrgOI02mB5GP+y/6Pir5ESpDMx6FNcB5QJwmoHSX+fOv7Ok4GgMlIBFnXgbba5yhUf7WTginjoRE3Fx3z7RZpPpKT29vXFaqacmRTF9LABBeKqQpDCIQZ8qSfM0VhSePl/5/IUlYjhTvHyTv8+SgJKwINj86+P/OajVs9EiRYBWFt3NNIScyUakZ29St31XpRPEWd9hh76FTfoAzDF2vzv25GlbNuBTmz9or1Q41MaGH40N6TlEWvdJVN6NdZCuVXtrkU0Oc6G3ZgfixDQGtLowsGDzvQ1R1k8xL6NmFaowLtt777O1l6OkrA6leREAlRMSCsXptLoYAM1LraQN0caJj5/fDwtN8EnJ3nefTL3+MBCfXDHrFpZSgLruqOxBm5CrISsSzGKYhahTwFO7xCzLipOUabIvB65fH+7o7uCfX6cSXuTPP/hVsDj7XkYeTeZApnAgywOK0WmFD6zsYc9Ke06gk1UKWw4xkMyXgSSrLIlMh8wBmQOvgwPZBlCMmYNTS12872sAGI/XwDj2IdmPugx1oxyH6zWsgHxJmQMyB7IcB7IloBidWjhqMecB54CTbB2WMkev/VjO8bYYRNjLnUEkSY5q+11GHknmgMwBmQPZkwPZGlCSnVrYGgzhIvXZ2lgkVhW1DKqrFUvD1iVXUdnX4AQqx2I5CRCxKsyGFdeXu8gckDkgcyDbcSDHAEpqnGe/A8OphcO6+KGyObInKp9sOCgl2w2zGSlbZrEdfQgq52O4D/Cw2WQx290NMsEyB2QOyBywgQM5GlBs4IvcVeaAzAGZAzIHLORApqQAtpAmubnMAZkDMgdkDmRDDsiAkg0XTSZZ5oDMAZkDWZEDMqBkxVWRaZI5IHNA5kA25IAMKNlw0WSSZQ7IHJA5kBU5IANKVlwVmSaZAzIHZA5kQw78H32spQTKyCP6AAAAAElFTkSuQmCC" alt="" width="270"/>
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
			<xsl:text disable-output-escaping="yes"><![CDATA[<hr/><strong>Banka Bilgileri </strong><br/>
<table style="float: left; height: 82px;" border="1" width="514" cellspacing="0" cellpadding="3" align="center">
<tbody>
<tr>
<td><strong>Banka</strong></td>
<td><strong>Döviz</strong></td>
<td><strong>Iban</strong></td>
</tr>
<tr>
<td>T.GARANTİ BANKASI</td>
<td>TL</td>
<td>TR80 0006 2000 6720 0006 2966 15</td>
</tr>
<tr>
<td>T.GARANTİ BANKASI</td>
<td>EURO</td>
<td>TR96 0006 2000 6720 0009 0891 51</td>
</tr>
<tr>
<td>T.GARANTİ BANKASI</td>
<td>USD</td>
<td>TR79 0006 2000 6720 0009 0553 13</td>
</tr>
</tbody>
</table>
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

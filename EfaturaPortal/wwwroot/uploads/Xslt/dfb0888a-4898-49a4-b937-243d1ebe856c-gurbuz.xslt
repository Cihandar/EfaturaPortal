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
		<xsl:if test="not(contains(substring(substring-before(concat($pText,'&#xA;'),'&#xA;'),0,8), '##')) and string-length(substring-before(concat($pText,'&#xA;'),'&#xA;'))>3">
			<b>* </b>
			<xsl:copy-of select="substring-before(concat($pText,'&#xA;'),'&#xA;')"/>
			<br />
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
		<xsl:if test="contains(substring(substring-before(concat($pText,'&#xA;'),'&#xA;'),0,8), '##')">
			<tr>
				<th>
					<xsl:copy-of select="substring-after(substring-before(substring-before(concat($pText,'&#xA;'),'&#xA;'),':'),'##')"/>:</th>
				<td>
					<xsl:copy-of select="substring-after(substring-before(concat($pText,'&#xA;'),'&#xA;'),':')"/>
				</td>
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
	<xsl:template name="TransportMode">
		<xsl:param name="TransportModeType" />
		<xsl:choose>
			<xsl:when test="$TransportModeType=1">Denizyolu</xsl:when>
			<xsl:when test="$TransportModeType=2">Demiryolu</xsl:when>
			<xsl:when test="$TransportModeType=3">Karayolu</xsl:when>
			<xsl:when test="$TransportModeType=4">Havayolu</xsl:when>
			<xsl:when test="$TransportModeType=5">Posta</xsl:when>
			<xsl:when test="$TransportModeType=6">Çok araçlı</xsl:when>
			<xsl:when test="$TransportModeType=7">Sabit taşıma tesisleri</xsl:when>
			<xsl:when test="$TransportModeType=8">İç su taşımacılığı</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$TransportModeType"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Packaging">
		<xsl:param name="PackagingType" />
		<xsl:choose>
			<xsl:when test="$PackagingType='1A'">Drum, steel</xsl:when>
			<xsl:when test="$PackagingType='1B'">Drum, aluminium</xsl:when>
			<xsl:when test="$PackagingType='1D'">Drum, plywood</xsl:when>
			<xsl:when test="$PackagingType='1F'">Container, flexible</xsl:when>
			<xsl:when test="$PackagingType='1G'">Drum, fibre</xsl:when>
			<xsl:when test="$PackagingType='1W'">Drum, wooden</xsl:when>
			<xsl:when test="$PackagingType='2C'">Barrel, wooden</xsl:when>
			<xsl:when test="$PackagingType='3A'">Jerrican, steel</xsl:when>
			<xsl:when test="$PackagingType='3H'">Jerrican, plastic</xsl:when>
			<xsl:when test="$PackagingType='43'">Bag, super bulk</xsl:when>
			<xsl:when test="$PackagingType='44'">Bag, polybag</xsl:when>
			<xsl:when test="$PackagingType='4A'">Box, steel</xsl:when>
			<xsl:when test="$PackagingType='4B'">Box, aluminium</xsl:when>
			<xsl:when test="$PackagingType='4C'">Box, natural wood</xsl:when>
			<xsl:when test="$PackagingType='4D'">Box, plywood</xsl:when>
			<xsl:when test="$PackagingType='4F'">Box, reconstituted wood</xsl:when>
			<xsl:when test="$PackagingType='4G'">Box, fibreboard</xsl:when>
			<xsl:when test="$PackagingType='4H'">Box, plastic</xsl:when>
			<xsl:when test="$PackagingType='5H'">Bag, woven plastic</xsl:when>
			<xsl:when test="$PackagingType='5L'">Bag, textile</xsl:when>
			<xsl:when test="$PackagingType='5M'">Bag, paper</xsl:when>
			<xsl:when test="$PackagingType='6H'">Composite packaging, plastic receptacle</xsl:when>
			<xsl:when test="$PackagingType='6P'">Composite packaging, glass receptacle</xsl:when>
			<xsl:when test="$PackagingType='7A'">Case, car</xsl:when>
			<xsl:when test="$PackagingType='7B'">Case, wooden</xsl:when>
			<xsl:when test="$PackagingType='8A'">Pallet, wooden</xsl:when>
			<xsl:when test="$PackagingType='8B'">Crate, wooden</xsl:when>
			<xsl:when test="$PackagingType='8C'">Bundle, wooden</xsl:when>
			<xsl:when test="$PackagingType='AA'">Intermediate bulk container, rigid plastic</xsl:when>
			<xsl:when test="$PackagingType='AB'">Receptacle, fibre</xsl:when>
			<xsl:when test="$PackagingType='AC'">Receptacle, paper</xsl:when>
			<xsl:when test="$PackagingType='AD'">Receptacle, wooden</xsl:when>
			<xsl:when test="$PackagingType='AE'">Aerosol</xsl:when>
			<xsl:when test="$PackagingType='AF'">Pallet, modular, collars 80cms * 60cms</xsl:when>
			<xsl:when test="$PackagingType='AG'">Pallet, shrinkwrapped</xsl:when>
			<xsl:when test="$PackagingType='AH'">Pallet, 100cms * 110cms</xsl:when>
			<xsl:when test="$PackagingType='AI'">Clamshell</xsl:when>
			<xsl:when test="$PackagingType='AJ'">Cone</xsl:when>
			<xsl:when test="$PackagingType='AL'">Ball</xsl:when>
			<xsl:when test="$PackagingType='AM'">Ampoule, non-protected</xsl:when>
			<xsl:when test="$PackagingType='AP'">Ampoule, protected</xsl:when>
			<xsl:when test="$PackagingType='AT'">Atomizer</xsl:when>
			<xsl:when test="$PackagingType='AV'">Capsule</xsl:when>
			<xsl:when test="$PackagingType='B4'">Belt</xsl:when>
			<xsl:when test="$PackagingType='BA'">Barrel</xsl:when>
			<xsl:when test="$PackagingType='BB'">Bobbin</xsl:when>
			<xsl:when test="$PackagingType='BC'">Bottlecrate / bottlerack</xsl:when>
			<xsl:when test="$PackagingType='BD'">Board</xsl:when>
			<xsl:when test="$PackagingType='BE'">Bundle</xsl:when>
			<xsl:when test="$PackagingType='BF'">Balloon, non-protected</xsl:when>
			<xsl:when test="$PackagingType='BG'">Bag</xsl:when>
			<xsl:when test="$PackagingType='BH'">Bunch</xsl:when>
			<xsl:when test="$PackagingType='BI'">Bin</xsl:when>
			<xsl:when test="$PackagingType='BJ'">Bucket</xsl:when>
			<xsl:when test="$PackagingType='BK'">Basket</xsl:when>
			<xsl:when test="$PackagingType='BL'">Bale, compressed</xsl:when>
			<xsl:when test="$PackagingType='BM'">Basin</xsl:when>
			<xsl:when test="$PackagingType='BN'">Bale, non-compressed</xsl:when>
			<xsl:when test="$PackagingType='BO'">Bottle, non-protected, cylindrical</xsl:when>
			<xsl:when test="$PackagingType='BP'">Balloon, protected</xsl:when>
			<xsl:when test="$PackagingType='BQ'">Bottle, protected cylindrical</xsl:when>
			<xsl:when test="$PackagingType='BR'">Bar</xsl:when>
			<xsl:when test="$PackagingType='BS'">Bottle, non-protected, bulbous</xsl:when>
			<xsl:when test="$PackagingType='BT'">Bolt</xsl:when>
			<xsl:when test="$PackagingType='BU'">Butt</xsl:when>
			<xsl:when test="$PackagingType='BV'">Bottle, protected bulbous</xsl:when>
			<xsl:when test="$PackagingType='BW'">Box, for liquids</xsl:when>
			<xsl:when test="$PackagingType='BX'">Box</xsl:when>
			<xsl:when test="$PackagingType='BY'">Board, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='BZ'">Bars, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='CA'">Can, rectangular</xsl:when>
			<xsl:when test="$PackagingType='CB'">Crate, beer</xsl:when>
			<xsl:when test="$PackagingType='CC'">Churn</xsl:when>
			<xsl:when test="$PackagingType='CD'">Can, with handle and spout</xsl:when>
			<xsl:when test="$PackagingType='CE'">Creel</xsl:when>
			<xsl:when test="$PackagingType='CF'">Coffer</xsl:when>
			<xsl:when test="$PackagingType='CG'">Cage</xsl:when>
			<xsl:when test="$PackagingType='CH'">Chest</xsl:when>
			<xsl:when test="$PackagingType='CI'">Canister</xsl:when>
			<xsl:when test="$PackagingType='CJ'">Coffin</xsl:when>
			<xsl:when test="$PackagingType='CK'">Cask</xsl:when>
			<xsl:when test="$PackagingType='CL'">Coil</xsl:when>
			<xsl:when test="$PackagingType='CM'">Card</xsl:when>
			<xsl:when test="$PackagingType='CN'">Container, not otherwise specified as transport equipment</xsl:when>
			<xsl:when test="$PackagingType='CO'">Carboy, non-protected</xsl:when>
			<xsl:when test="$PackagingType='CP'">Carboy, protected</xsl:when>
			<xsl:when test="$PackagingType='CQ'">Cartridge</xsl:when>
			<xsl:when test="$PackagingType='CR'">Crate</xsl:when>
			<xsl:when test="$PackagingType='CS'">Case</xsl:when>
			<xsl:when test="$PackagingType='CT'">Carton</xsl:when>
			<xsl:when test="$PackagingType='CU'">Cup</xsl:when>
			<xsl:when test="$PackagingType='CV'">Cover</xsl:when>
			<xsl:when test="$PackagingType='CW'">Cage, roll</xsl:when>
			<xsl:when test="$PackagingType='CX'">Can, cylindrical</xsl:when>
			<xsl:when test="$PackagingType='CY'">Cylinder</xsl:when>
			<xsl:when test="$PackagingType='CZ'">Canvas</xsl:when>
			<xsl:when test="$PackagingType='DA'">Crate, multiple layer, plastic</xsl:when>
			<xsl:when test="$PackagingType='DB'">Crate, multiple layer, wooden</xsl:when>
			<xsl:when test="$PackagingType='DC'">Crate, multiple layer, cardboard</xsl:when>
			<xsl:when test="$PackagingType='DG'">Cage, Commonwealth Handling Equipment Pool (CHEP)</xsl:when>
			<xsl:when test="$PackagingType='DH'">Box, Commonwealth Handling Equipment Pool (CHEP), Eurobox</xsl:when>
			<xsl:when test="$PackagingType='DI'">Drum, iron</xsl:when>
			<xsl:when test="$PackagingType='DJ'">Demijohn, non-protected</xsl:when>
			<xsl:when test="$PackagingType='DK'">Crate, bulk, cardboard</xsl:when>
			<xsl:when test="$PackagingType='DL'">Crate, bulk, plastic</xsl:when>
			<xsl:when test="$PackagingType='DM'">Crate, bulk, wooden</xsl:when>
			<xsl:when test="$PackagingType='DN'">Dispenser</xsl:when>
			<xsl:when test="$PackagingType='DP'">Demijohn, protected</xsl:when>
			<xsl:when test="$PackagingType='DR'">Drum</xsl:when>
			<xsl:when test="$PackagingType='DS'">Tray, one layer no cover, plastic</xsl:when>
			<xsl:when test="$PackagingType='DT'">Tray, one layer no cover, wooden</xsl:when>
			<xsl:when test="$PackagingType='DU'">Tray, one layer no cover, polystyrene</xsl:when>
			<xsl:when test="$PackagingType='DV'">Tray, one layer no cover, cardboard</xsl:when>
			<xsl:when test="$PackagingType='DW'">Tray, two layers no cover, plastic tray</xsl:when>
			<xsl:when test="$PackagingType='DX'">Tray, two layers no cover, wooden</xsl:when>
			<xsl:when test="$PackagingType='DY'">Tray, two layers no cover, cardboard</xsl:when>
			<xsl:when test="$PackagingType='EC'">Bag, plastic</xsl:when>
			<xsl:when test="$PackagingType='ED'">Case, with pallet base</xsl:when>
			<xsl:when test="$PackagingType='EE'">Case, with pallet base, wooden</xsl:when>
			<xsl:when test="$PackagingType='EF'">Case, with pallet base, cardboard</xsl:when>
			<xsl:when test="$PackagingType='EG'">Case, with pallet base, plastic</xsl:when>
			<xsl:when test="$PackagingType='EH'">Case, with pallet base, metal</xsl:when>
			<xsl:when test="$PackagingType='EI'">Case, isothermic</xsl:when>
			<xsl:when test="$PackagingType='EN'">Envelope</xsl:when>
			<xsl:when test="$PackagingType='FB'">Flexibag</xsl:when>
			<xsl:when test="$PackagingType='FC'">Crate, fruit</xsl:when>
			<xsl:when test="$PackagingType='FD'">Crate, framed</xsl:when>
			<xsl:when test="$PackagingType='FE'">Flexitank</xsl:when>
			<xsl:when test="$PackagingType='FI'">Firkin</xsl:when>
			<xsl:when test="$PackagingType='FL'">Flask</xsl:when>
			<xsl:when test="$PackagingType='FO'">Footlocker</xsl:when>
			<xsl:when test="$PackagingType='FP'">Filmpack</xsl:when>
			<xsl:when test="$PackagingType='FR'">Frame</xsl:when>
			<xsl:when test="$PackagingType='FT'">Foodtainer</xsl:when>
			<xsl:when test="$PackagingType='FW'">Cart, flatbed</xsl:when>
			<xsl:when test="$PackagingType='FX'">Bag, flexible container</xsl:when>
			<xsl:when test="$PackagingType='GB'">Bottle, gas</xsl:when>
			<xsl:when test="$PackagingType='GI'">Girder</xsl:when>
			<xsl:when test="$PackagingType='GL'">Container, gallon</xsl:when>
			<xsl:when test="$PackagingType='GR'">Receptacle, glass</xsl:when>
			<xsl:when test="$PackagingType='GU'">Tray, containing horizontally stacked flat items</xsl:when>
			<xsl:when test="$PackagingType='GY'">Bag, gunny</xsl:when>
			<xsl:when test="$PackagingType='GZ'">Girders, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='HA'">Basket, with handle, plastic</xsl:when>
			<xsl:when test="$PackagingType='HB'">Basket, with handle, wooden</xsl:when>
			<xsl:when test="$PackagingType='HC'">Basket, with handle, cardboard</xsl:when>
			<xsl:when test="$PackagingType='HG'">Hogshead</xsl:when>
			<xsl:when test="$PackagingType='HN'">Hanger</xsl:when>
			<xsl:when test="$PackagingType='HR'">Hamper</xsl:when>
			<xsl:when test="$PackagingType='IA'">Package, display, wooden</xsl:when>
			<xsl:when test="$PackagingType='IB'">Package, display, cardboard</xsl:when>
			<xsl:when test="$PackagingType='IC'">Package, display, plastic</xsl:when>
			<xsl:when test="$PackagingType='ID'">Package, display, metal</xsl:when>
			<xsl:when test="$PackagingType='IE'">Package, show</xsl:when>
			<xsl:when test="$PackagingType='IF'">Package, flow</xsl:when>
			<xsl:when test="$PackagingType='IG'">Package, paper wrapped</xsl:when>
			<xsl:when test="$PackagingType='IH'">Drum, plastic</xsl:when>
			<xsl:when test="$PackagingType='IK'">Package, cardboard, with bottle grip-holes</xsl:when>
			<xsl:when test="$PackagingType='IL'">Tray, rigid, lidded stackable (CEN TS 14482:2002)</xsl:when>
			<xsl:when test="$PackagingType='IN'">Ingot</xsl:when>
			<xsl:when test="$PackagingType='IZ'">Ingots, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='JB'">Bag, jumbo</xsl:when>
			<xsl:when test="$PackagingType='JC'">Jerrican, rectangular</xsl:when>
			<xsl:when test="$PackagingType='JG'">Jug</xsl:when>
			<xsl:when test="$PackagingType='JR'">Jar</xsl:when>
			<xsl:when test="$PackagingType='JT'">Jutebag</xsl:when>
			<xsl:when test="$PackagingType='JY'">Jerrican, cylindrical</xsl:when>
			<xsl:when test="$PackagingType='KG'">Keg</xsl:when>
			<xsl:when test="$PackagingType='KI'">Kit</xsl:when>
			<xsl:when test="$PackagingType='LE'">Luggage</xsl:when>
			<xsl:when test="$PackagingType='LG'">Log</xsl:when>
			<xsl:when test="$PackagingType='LT'">Lot</xsl:when>
			<xsl:when test="$PackagingType='LU'">Lug</xsl:when>
			<xsl:when test="$PackagingType='LV'">Liftvan</xsl:when>
			<xsl:when test="$PackagingType='LZ'">Logs, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='MA'">Crate, metal</xsl:when>
			<xsl:when test="$PackagingType='MB'">Bag, multiply</xsl:when>
			<xsl:when test="$PackagingType='MC'">Crate, milk</xsl:when>
			<xsl:when test="$PackagingType='ME'">Container, metal</xsl:when>
			<xsl:when test="$PackagingType='MR'">Receptacle, metal</xsl:when>
			<xsl:when test="$PackagingType='MS'">Sack, multi-wall</xsl:when>
			<xsl:when test="$PackagingType='MT'">Mat</xsl:when>
			<xsl:when test="$PackagingType='MW'">Receptacle, plastic wrapped</xsl:when>
			<xsl:when test="$PackagingType='MX'">Matchbox</xsl:when>
			<xsl:when test="$PackagingType='NA'">Not available</xsl:when>
			<xsl:when test="$PackagingType='NE'">Unpacked or unpackaged</xsl:when>
			<xsl:when test="$PackagingType='NF'">Unpacked or unpackaged, single unit</xsl:when>
			<xsl:when test="$PackagingType='NG'">Unpacked or unpackaged, multiple units</xsl:when>
			<xsl:when test="$PackagingType='NS'">Nest</xsl:when>
			<xsl:when test="$PackagingType='NT'">Net</xsl:when>
			<xsl:when test="$PackagingType='NU'">Net, tube, plastic</xsl:when>
			<xsl:when test="$PackagingType='NV'">Net, tube, textile</xsl:when>
			<xsl:when test="$PackagingType='OA'">Pallet, CHEP 40 cm x 60 cm</xsl:when>
			<xsl:when test="$PackagingType='OB'">Pallet, CHEP 80 cm x 120 cm</xsl:when>
			<xsl:when test="$PackagingType='OC'">Pallet, CHEP 100 cm x 120 cm</xsl:when>
			<xsl:when test="$PackagingType='OD'">Pallet, AS 4068-1993</xsl:when>
			<xsl:when test="$PackagingType='OE'">Pallet, ISO T11</xsl:when>
			<xsl:when test="$PackagingType='OF'">Platform, unspecified weight or dimension</xsl:when>
			<xsl:when test="$PackagingType='OK'">Block</xsl:when>
			<xsl:when test="$PackagingType='OT'">Octabin</xsl:when>
			<xsl:when test="$PackagingType='OU'">Container, outer</xsl:when>
			<xsl:when test="$PackagingType='P2'">Pan</xsl:when>
			<xsl:when test="$PackagingType='PA'">Packet</xsl:when>
			<xsl:when test="$PackagingType='PB'">Pallet, box Combined open-ended box and pallet</xsl:when>
			<xsl:when test="$PackagingType='PC'">Parcel</xsl:when>
			<xsl:when test="$PackagingType='PD'">Pallet, modular, collars 80cms * 100cms</xsl:when>
			<xsl:when test="$PackagingType='PE'">Pallet, modular, collars 80cms * 120cms</xsl:when>
			<xsl:when test="$PackagingType='PF'">Pen</xsl:when>
			<xsl:when test="$PackagingType='PG'">Plate</xsl:when>
			<xsl:when test="$PackagingType='PH'">Pitcher</xsl:when>
			<xsl:when test="$PackagingType='PI'">Pipe</xsl:when>
			<xsl:when test="$PackagingType='PJ'">Punnet</xsl:when>
			<xsl:when test="$PackagingType='PK'">Package</xsl:when>
			<xsl:when test="$PackagingType='PL'">Pail</xsl:when>
			<xsl:when test="$PackagingType='PN'">Plank</xsl:when>
			<xsl:when test="$PackagingType='PO'">Pouch</xsl:when>
			<xsl:when test="$PackagingType='PP'">Piece</xsl:when>
			<xsl:when test="$PackagingType='PR'">Receptacle, plastic</xsl:when>
			<xsl:when test="$PackagingType='PT'">Pot</xsl:when>
			<xsl:when test="$PackagingType='PU'">Tray</xsl:when>
			<xsl:when test="$PackagingType='PV'">Pipes, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='PX'">Pallet</xsl:when>
			<xsl:when test="$PackagingType='PY'">Plates, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='PZ'">Planks, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='QA'">Drum, steel, non-removable head</xsl:when>
			<xsl:when test="$PackagingType='QB'">Drum, steel, removable head</xsl:when>
			<xsl:when test="$PackagingType='QC'">Drum, aluminium, non-removable head</xsl:when>
			<xsl:when test="$PackagingType='QD'">Drum, aluminium, removable head</xsl:when>
			<xsl:when test="$PackagingType='QF'">Drum, plastic, non-removable head</xsl:when>
			<xsl:when test="$PackagingType='QG'">Drum, plastic, removable head</xsl:when>
			<xsl:when test="$PackagingType='QH'">Barrel, wooden, bung type</xsl:when>
			<xsl:when test="$PackagingType='QJ'">Barrel, wooden, removable head</xsl:when>
			<xsl:when test="$PackagingType='QK'">Jerrican, steel, non-removable head</xsl:when>
			<xsl:when test="$PackagingType='QL'">Jerrican, steel, removable head</xsl:when>
			<xsl:when test="$PackagingType='QM'">Jerrican, plastic, non-removable head</xsl:when>
			<xsl:when test="$PackagingType='QN'">Jerrican, plastic, removable head</xsl:when>
			<xsl:when test="$PackagingType='QP'">Box, wooden, natural wood, ordinary</xsl:when>
			<xsl:when test="$PackagingType='QQ'">Box, wooden, natural wood, with sift proof walls</xsl:when>
			<xsl:when test="$PackagingType='QR'">Box, plastic, expanded</xsl:when>
			<xsl:when test="$PackagingType='QS'">Box, plastic, solid</xsl:when>
			<xsl:when test="$PackagingType='RD'">Rod</xsl:when>
			<xsl:when test="$PackagingType='RG'">Ring</xsl:when>
			<xsl:when test="$PackagingType='RJ'">Rack, clothing hanger</xsl:when>
			<xsl:when test="$PackagingType='RK'">Rack</xsl:when>
			<xsl:when test="$PackagingType='RL'">Reel</xsl:when>
			<xsl:when test="$PackagingType='RO'">Roll</xsl:when>
			<xsl:when test="$PackagingType='RT'">Rednet</xsl:when>
			<xsl:when test="$PackagingType='RZ'">Rods, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='SA'">Sack</xsl:when>
			<xsl:when test="$PackagingType='SB'">Slab</xsl:when>
			<xsl:when test="$PackagingType='SC'">Crate, shallow</xsl:when>
			<xsl:when test="$PackagingType='SD'">Spindle</xsl:when>
			<xsl:when test="$PackagingType='SE'">Sea-chest</xsl:when>
			<xsl:when test="$PackagingType='SH'">Sachet</xsl:when>
			<xsl:when test="$PackagingType='SI'">Skid</xsl:when>
			<xsl:when test="$PackagingType='SK'">Case, skeleton</xsl:when>
			<xsl:when test="$PackagingType='SL'">Slipsheet</xsl:when>
			<xsl:when test="$PackagingType='SM'">Sheetmetal</xsl:when>
			<xsl:when test="$PackagingType='SO'">Spool</xsl:when>
			<xsl:when test="$PackagingType='SP'">Sheet, plastic wrapping</xsl:when>
			<xsl:when test="$PackagingType='SS'">Case, steel</xsl:when>
			<xsl:when test="$PackagingType='ST'">Sheet</xsl:when>
			<xsl:when test="$PackagingType='SU'">Suitcase</xsl:when>
			<xsl:when test="$PackagingType='SV'">Envelope, steel</xsl:when>
			<xsl:when test="$PackagingType='SW'">Shrinkwrapped</xsl:when>
			<xsl:when test="$PackagingType='SX'">Set</xsl:when>
			<xsl:when test="$PackagingType='SY'">Sleeve</xsl:when>
			<xsl:when test="$PackagingType='SZ'">Sheets, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='T1'">Tablet</xsl:when>
			<xsl:when test="$PackagingType='TB'">Tub</xsl:when>
			<xsl:when test="$PackagingType='TC'">Tea-chest</xsl:when>
			<xsl:when test="$PackagingType='TD'">Tube, collapsible</xsl:when>
			<xsl:when test="$PackagingType='TE'">Tyre</xsl:when>
			<xsl:when test="$PackagingType='TG'">Tank container, generic</xsl:when>
			<xsl:when test="$PackagingType='TI'">Tierce</xsl:when>
			<xsl:when test="$PackagingType='TK'">Tank, rectangular</xsl:when>
			<xsl:when test="$PackagingType='TL'">Tub, with lid</xsl:when>
			<xsl:when test="$PackagingType='TN'">Tin</xsl:when>
			<xsl:when test="$PackagingType='TO'">Tun</xsl:when>
			<xsl:when test="$PackagingType='TR'">Trunk</xsl:when>
			<xsl:when test="$PackagingType='TS'">Truss</xsl:when>
			<xsl:when test="$PackagingType='TT'">Bag, tote</xsl:when>
			<xsl:when test="$PackagingType='TU'">Tube</xsl:when>
			<xsl:when test="$PackagingType='TV'">Tube, with nozzle</xsl:when>
			<xsl:when test="$PackagingType='TW'">Pallet, triwall</xsl:when>
			<xsl:when test="$PackagingType='TY'">Tank, cylindrical</xsl:when>
			<xsl:when test="$PackagingType='TZ'">Tubes, in bundle/bunch/truss</xsl:when>
			<xsl:when test="$PackagingType='UC'">Uncaged</xsl:when>
			<xsl:when test="$PackagingType='UN'">Unit</xsl:when>
			<xsl:when test="$PackagingType='VA'">Vat</xsl:when>
			<xsl:when test="$PackagingType='VG'">Bulk, gas (at 1031 mbar and 15Â°C)</xsl:when>
			<xsl:when test="$PackagingType='VI'">Vial</xsl:when>
			<xsl:when test="$PackagingType='VK'">Vanpack</xsl:when>
			<xsl:when test="$PackagingType='VL'">Bulk, liquid</xsl:when>
			<xsl:when test="$PackagingType='VO'">Bulk, solid, large particles (Â“nodulesÂ”)</xsl:when>
			<xsl:when test="$PackagingType='VP'">Vacuum-packed</xsl:when>
			<xsl:when test="$PackagingType='VQ'">Bulk, liquefied gas (at abnormal temperature/pressure)</xsl:when>
			<xsl:when test="$PackagingType='VN'">Vehicle</xsl:when>
			<xsl:when test="$PackagingType='VR'">Bulk, solid, granular particles (Â“grainsÂ”)</xsl:when>
			<xsl:when test="$PackagingType='VS'">Bulk, scrap metal</xsl:when>
			<xsl:when test="$PackagingType='VY'">Bulk, solid, fine particles (Â“powdersÂ”)</xsl:when>
			<xsl:when test="$PackagingType='WA'">Intermediate bulk container</xsl:when>
			<xsl:when test="$PackagingType='WB'">Wickerbottle</xsl:when>
			<xsl:when test="$PackagingType='WC'">Intermediate bulk container, steel</xsl:when>
			<xsl:when test="$PackagingType='WD'">Intermediate bulk container, aluminium</xsl:when>
			<xsl:when test="$PackagingType='WF'">Intermediate bulk container, metal</xsl:when>
			<xsl:when test="$PackagingType='WG'">Intermediate bulk container, steel, pressurised > 10 kpa</xsl:when>
			<xsl:when test="$PackagingType='WH'">Intermediate bulk container, aluminium, pressurised > 10 kpa</xsl:when>
			<xsl:when test="$PackagingType='WJ'">Intermediate bulk container, metal, pressure 10 kpa</xsl:when>
			<xsl:when test="$PackagingType='WK'">Intermediate bulk container, steel, liquid</xsl:when>
			<xsl:when test="$PackagingType='WL'">Intermediate bulk container, aluminium, liquid</xsl:when>
			<xsl:when test="$PackagingType='WM'">Intermediate bulk container, metal, liquid</xsl:when>
			<xsl:when test="$PackagingType='WN'">Intermediate bulk container, woven plastic, without coat/liner</xsl:when>
			<xsl:when test="$PackagingType='WP'">Intermediate bulk container, woven plastic, coated</xsl:when>
			<xsl:when test="$PackagingType='WQ'">Intermediate bulk container, woven plastic, with liner</xsl:when>
			<xsl:when test="$PackagingType='WR'">Intermediate bulk container, woven plastic, coated and liner</xsl:when>
			<xsl:when test="$PackagingType='WS'">Intermediate bulk container, plastic film</xsl:when>
			<xsl:when test="$PackagingType='WT'">Intermediate bulk container, textile with out coat/liner</xsl:when>
			<xsl:when test="$PackagingType='WU'">Intermediate bulk container, natural wood, with inner liner</xsl:when>
			<xsl:when test="$PackagingType='WV'">Intermediate bulk container, textile, coated</xsl:when>
			<xsl:when test="$PackagingType='WW'">Intermediate bulk container, textile, with liner</xsl:when>
			<xsl:when test="$PackagingType='WX'">Intermediate bulk container, textile, coated and liner</xsl:when>
			<xsl:when test="$PackagingType='WY'">Intermediate bulk container, plywood, with inner liner</xsl:when>
			<xsl:when test="$PackagingType='WZ'">Intermediate bulk container, reconstituted wood, with inner liner</xsl:when>
			<xsl:when test="$PackagingType='XA'">Bag, woven plastic, without inner coat/liner</xsl:when>
			<xsl:when test="$PackagingType='XB'">Bag, woven plastic, sift proof</xsl:when>
			<xsl:when test="$PackagingType='XC'">Bag, woven plastic, water resistant</xsl:when>
			<xsl:when test="$PackagingType='XD'">Bag, plastics film</xsl:when>
			<xsl:when test="$PackagingType='XF'">Bag, textile, without inner coat/liner</xsl:when>
			<xsl:when test="$PackagingType='XG'">Bag, textile, sift proof</xsl:when>
			<xsl:when test="$PackagingType='XH'">Bag, textile, water resistant</xsl:when>
			<xsl:when test="$PackagingType='XJ'">Bag, paper, multi-wall</xsl:when>
			<xsl:when test="$PackagingType='XK'">Bag, paper, multi-wall, water resistant</xsl:when>
			<xsl:when test="$PackagingType='YA'">Composite packaging, plastic receptacle in steel drum</xsl:when>
			<xsl:when test="$PackagingType='YB'">Composite packaging, plastic receptacle in steel crate box</xsl:when>
			<xsl:when test="$PackagingType='YC'">Composite packaging, plastic receptacle in aluminium drum</xsl:when>
			<xsl:when test="$PackagingType='YD'">Composite packaging, plastic receptacle in aluminium crate</xsl:when>
			<xsl:when test="$PackagingType='YF'">Composite packaging, plastic receptacle in wooden box</xsl:when>
			<xsl:when test="$PackagingType='YG'">Composite packaging, plastic receptacle in plywood drum</xsl:when>
			<xsl:when test="$PackagingType='YH'">Composite packaging, plastic receptacle in plywood box</xsl:when>
			<xsl:when test="$PackagingType='YJ'">Composite packaging, plastic receptacle in fibre drum</xsl:when>
			<xsl:when test="$PackagingType='YK'">Composite packaging, plastic receptacle in fibreboard box</xsl:when>
			<xsl:when test="$PackagingType='YL'">Composite packaging, plastic receptacle in plastic drum</xsl:when>
			<xsl:when test="$PackagingType='YM'">Composite packaging, plastic receptacle in solid plastic box</xsl:when>
			<xsl:when test="$PackagingType='YN'">Composite packaging, glass receptacle in steel drum</xsl:when>
			<xsl:when test="$PackagingType='YP'">Composite packaging, glass receptacle in steel crate box</xsl:when>
			<xsl:when test="$PackagingType='YQ'">Composite packaging, glass receptacle in aluminium drum</xsl:when>
			<xsl:when test="$PackagingType='YR'">Composite packaging, glass receptacle in aluminium crate</xsl:when>
			<xsl:when test="$PackagingType='YS'">Composite packaging, glass receptacle in wooden box</xsl:when>
			<xsl:when test="$PackagingType='YT'">Composite packaging, glass receptacle in plywood drum</xsl:when>
			<xsl:when test="$PackagingType='YV'">Composite packaging, glass receptacle in wickerwork hamper</xsl:when>
			<xsl:when test="$PackagingType='YW'">Composite packaging, glass receptacle in fibre drum</xsl:when>
			<xsl:when test="$PackagingType='YX'">Composite packaging, glass receptacle in fibreboard box</xsl:when>
			<xsl:when test="$PackagingType='YY'">Composite packaging, glass receptacle in expandable plastic pack</xsl:when>
			<xsl:when test="$PackagingType='YZ'">Composite packaging, glass receptacle in solid plastic pack</xsl:when>
			<xsl:when test="$PackagingType='ZA'">Intermediate bulk container, paper, multi-wall</xsl:when>
			<xsl:when test="$PackagingType='ZB'">Bag, large</xsl:when>
			<xsl:when test="$PackagingType='ZC'">Intermediate bulk container, paper, multi-wall, water resistant</xsl:when>
			<xsl:when test="$PackagingType='ZD'">Intermediate bulk container, rigid plastic, with structural equipment, solids</xsl:when>
			<xsl:when test="$PackagingType='ZF'">Intermediate bulk container, rigid plastic, freestanding, solids</xsl:when>
			<xsl:when test="$PackagingType='ZG'">Intermediate bulk container, rigid plastic, with structural equipment, pressurised</xsl:when>
			<xsl:when test="$PackagingType='ZH'">Intermediate bulk container, rigid plastic, freestanding, pressurised</xsl:when>
			<xsl:when test="$PackagingType='ZJ'">Intermediate bulk container, rigid plastic, with structural equipment, liquids</xsl:when>
			<xsl:when test="$PackagingType='ZK'">Intermediate bulk container, rigid plastic, freestanding, liquids</xsl:when>
			<xsl:when test="$PackagingType='ZL'">Intermediate bulk container, composite, rigid plastic, solids</xsl:when>
			<xsl:when test="$PackagingType='ZM'">Intermediate bulk container, composite, flexible plastic, solids</xsl:when>
			<xsl:when test="$PackagingType='ZN'">Intermediate bulk container, composite, rigid plastic, pressurised</xsl:when>
			<xsl:when test="$PackagingType='ZP'">Intermediate bulk container, composite, flexible plastic, pressurised</xsl:when>
			<xsl:when test="$PackagingType='ZQ'">Intermediate bulk container, composite, rigid plastic, liquids</xsl:when>
			<xsl:when test="$PackagingType='ZR'">Intermediate bulk container, composite, flexible plastic, liquids</xsl:when>
			<xsl:when test="$PackagingType='ZS'">Intermediate bulk container, composite</xsl:when>
			<xsl:when test="$PackagingType='ZT'">Intermediate bulk container, fibreboard</xsl:when>
			<xsl:when test="$PackagingType='ZU'">Intermediate bulk container, flexible</xsl:when>
			<xsl:when test="$PackagingType='ZV'">Intermediate bulk container, metal, other than steel</xsl:when>
			<xsl:when test="$PackagingType='ZW'">Intermediate bulk container, natural wood</xsl:when>
			<xsl:when test="$PackagingType='ZX'">Intermediate bulk container, plywood</xsl:when>
			<xsl:when test="$PackagingType='ZY'">Intermediate bulk container, reconstituted wood</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$PackagingType"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/">
	<xsl:comment>eFinans Şablon Tasarım Aracı İle Hazırlanmıştır.</xsl:comment>
	<html>
	<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>
	<xsl:text disable-output-escaping="yes">
		<![CDATA[e-Fatura]]>
	</xsl:text>
</title>
<style type="text/css">
					.ph {overflow:hidden;max-height:250px;}
					.ph7 {margin-bottom:18px;}
					.ph8 img {margin-bottom: 18px;}
					.ph10 {
						float: left;
						width: 295px;
						margin-top: 14px;
						margin-right: 12px;
						padding: 8px;
					}
					body {
					    background-color: #FFFFFF;
					    font-family: 'Tahoma', "Times New Roman", Times, serif;
					    font-size: 11px;
					    color: #666666;
					    margin-left=0.6in;
					    margin-right=0.6in;
					    margin-top=0.79in;
					    margin-bottom=0.79in;
					}
					table {font-size: 11px;border-spacing:0;}

					.documentContainer {
						min-width:800px;
						max-width:800px;
						padding-top: 22px;
					}
					.documentContainer a {pointer-events:none;}
					#ustBolum {margin-bottom: 15px;}
					.box{display: inline-block;*display: inline;zoom: 1;width: 33%; box-sizing:border-box; vertical-align: top;}
					#b1{width: 40%;}
					#b2{width: 25%;}
					#b3{width: 35%;}
					#kunye {border-spacing:0;}
					#kunye tr{border-bottom: 1px dotted gray;}
					#kunye td{border:1px solid gray;border-top: none;width: 100%;}
					#kunye th{vertical-align:top;font-weight:bold;white-space: nowrap;border:1px solid gray;border-top: none;border-right: none;text-align:left;border-collapse:collapse;}
					#kunye tr:first-child td{border-top: 1px solid gray;}
					#kunye tr:first-child th{border-top: 1px solid gray;}
					#kunye td:nth-child(2) {word-break: break-all;}
					#malHizmetTablosu {width:100%;}
					#malHizmetTablosu, .toplamlar table {
						border-width: 2px;
						border-style: inset;
						border-color: black;
						border-collapse: collapse;
					}
					#malHizmetTablosu tr {}
					#malHizmetTablosu th {text-align:right;}
					#malHizmetTablosu th, .toplamlar table th {border: 1px solid black;text-align:right;}
					.toplamlar table th {line-height:17px;}
					.toplamlar table th.is-long-true,
					#malHizmetTablosu > tbody > tr > td .is-long-true {white-space:normal;}
					#malHizmetTablosu td {text-align: right;}
					#malHizmetTablosu td.wrap {
						white-space: normal;
						text-align: left;
					}

					#malHizmetTablosu td , .toplamlar table td {border: 1px solid black;}
					#malHizmetTablosu th.alignLeft {text-align:left;width: 50%;}
					#toplamlarContainer {overflow:hidden;}

					.toplamlar > div {
						display: inline-block;
					}
					.toplamlar table td {text-align: right;}
					.toplamTablo{
						margin-left: 31px;
						float:right;
					}
					#AccountingSupplierParty {
						border-top: 3px solid black;
						border-bottom: 3px solid black;
						padding-top: 8px;
						padding-bottom: 8px;
						margin-bottom: 12px;
					}
					.alici {
						border-top: 3px solid black;
						padding-top: 8px;
						margin-top: 80px;
						border-bottom: 3px solid black;
						margin-bottom: 8px;
						padding-bottom: 8px;
					}
					.efaturaLogo {text-align:center;}
					.efaturaLogo img {width:91px;}

					h1, h2 {
					    padding-bottom: 3px;
					    padding-top: 3px;
					    margin-bottom: 5px;
					    text-transform: uppercase;
					    font-family: Arial, Helvetica, sans-serif;
					}
					h1 {
					    font-size: 1.4em;
					    text-transform:none;
					}
					h2 {
					    font-size: 1em;
					    color: brown;
					}
					h3 {
					    font-size: 1em;
					    color: #333333;
					    text-align: justify;
					    margin: 0;
					    padding: 0;
					}
					h4 {
					    font-size: 1.1em;
					    font-style: bold;
					    font-family: Arial, Helvetica, sans-serif;
					    color: #000000;
					    margin: 0;
					    padding: 0;
					}
					hr {
					    height:2px;
					    color: #000000;
					    background-color: #000000;
					    border-bottom: 1px solid #000000;
					}
					p, ul, ol {
					    margin-top: 1.5em;
					}
					ul, ol {
					    margin-left: 3em;
					}
					blockquote {
					    margin-left: 3em;
					    margin-right: 3em;
					    font-style: italic;
					}
					a {
					    text-decoration: none;
					    color: #70A300;
					}
					a:hover {
					    border: none;
					    color: #70A300;
					}
					#notlar {
						border: 2px solid black;
						margin-top: 13px;
						padding: 2px 2px 2px 20px;}
					@media print {
						body {margin:0;}
					}
					
					
					#ihracatBilgileri{
						border:2px solid black;
						margin-top:10px;
						padding:10px;
						position:relative;
						}
	
</style>

</head>
<body>
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
								select="n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification">

	<div class="./partyID">
		<xsl:choose>
			<xsl:when test="./cbc:ID/@schemeID = 'TICARETSICILNO'">
				<xsl:text>Ticaret Sicil No</xsl:text>
			</xsl:when>
			<xsl:when test="./cbc:ID/@schemeID = 'MERSISNO'">
				<xsl:text>MERSİS No</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="./cbc:ID/@schemeID"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>: </xsl:text>
		<xsl:value-of select="./cbc:ID"/>
	</div>

</xsl:for-each>
								


</div>

<div class="alici kutu">
	
	<div class="customerTitle">
	<xsl:text>SAYIN</xsl:text>
</div>

<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID = 'IHRACAT'">
	<b>
		<xsl:text>Unvanı: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name">
		<xsl:value-of select="." />
	</xsl:for-each>
	<br />
	<b>
		<xsl:text>İli: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName">
		<xsl:value-of select="."/>
	</xsl:for-each>
	<br />
	<b>
		<xsl:text>İlçesi: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CitySubdivisionName">
		<xsl:value-of select="."/>
	</xsl:for-each>
	<br />
	<b>
		<xsl:text>Sokak: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName">
		<xsl:value-of select="."/>
	</xsl:for-each>
	<br />
	<b>
		<xsl:text>Ülkesi: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:Name">
		<xsl:value-of select="."/>
	</xsl:for-each>
	<br />
	<b>
		<xsl:text>Resmi Unvanı: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName">
		<xsl:value-of select="."/>
	</xsl:for-each>
	<br />
	<b>
		<xsl:text>Vergi Numarası: </xsl:text>
	</b>
	<xsl:for-each select="//n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID">
		<xsl:value-of select="."/>
	</xsl:for-each>

</xsl:if>
<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
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
</xsl:if>

<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
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
</xsl:if>


<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telephone !='' or //n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Telefax !=''">
<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
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

</xsl:if> 
<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cbc:WebsiteURI != ''">
<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
	<xsl:for-each
								select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cbc:WebsiteURI">
		<div class="WebsiteURI">
			<xsl:text>Web Sitesi: </xsl:text>
			<xsl:value-of select="."/>
		</div>
	</xsl:for-each>
</xsl:if>

</xsl:if> 
<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail != ''">
<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
	<xsl:for-each
								select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail">
		<div class="eMail">
			<xsl:text>e-Posta: </xsl:text>
			<xsl:value-of select="."/>
		</div>
	</xsl:for-each>
</xsl:if>

</xsl:if> 
<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
	<div class="taxOffice">
		<xsl:text>Vergi Dairesi: </xsl:text>
		<xsl:value-of
										select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name"
										/>
	</div>
</xsl:if>

<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID != 'IHRACAT'">
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
</xsl:if>


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
	
	<div class="efaturaLogo">
	
	<img style="width:91px;" align="middle" alt="E-Fatura Logo"
										src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMZaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzMiA3OS4xNTkyODQsIDIwMTYvMDQvMTktMTM6MTM6NDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjZDNDJBNEI2QjVCRDExRThCQjM0REIwQkZGMEQxODY0IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjZDNDJBNEI1QjVCRDExRThCQjM0REIwQkZGMEQxODY0IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzQgV2luZG93cyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSIzREVENkU1N0FDREVDNEJBNzkxNUM2M0NCN0RENzM0NyIgc3RSZWY6ZG9jdW1lbnRJRD0iM0RFRDZFNTdBQ0RFQzRCQTc5MTVDNjNDQjdERDczNDciLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7/7gAOQWRvYmUAZMAAAAAB/9sAhAABAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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"/>

	<h1>
		<xsl:text>e-Fatura</xsl:text>
	</h1>
</div>


</div>

<div id="b3" class="box">
	
	<div id="despatchTable">
		
		<div class="ph empty ph7">
	
	<xsl:text disable-output-escaping="yes">
		<![CDATA[<img src="data:image/jpeg;base64,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RGJvb2wAAAAAAEludHJib29sAAAAAABCY2tnT2JqYwAAAAEAAAAAAABSR0JDAAAAAwAAAABSZCAgZG91YkBv4AAAAAAAAAAAAEdybiBkb3ViQG/gAAAAAAAAAAAAQmwgIGRvdWJAb+AAAAAAAAAAAABCcmRUVW50RiNSbHQAAAAAAAAAAAAAAABCbGQgVW50RiNSbHQAAAAAAAAAAAAAAABSc2x0VW50RiNQeGxAUgAAAAAAAAAAAAp2ZWN0b3JEYXRhYm9vbAEAAAAAUGdQc2VudW0AAAAAUGdQcwAAAABQZ1BDAAAAAExlZnRVbnRGI1JsdAAAAAAAAAAAAAAAAFRvcCBVbnRGI1JsdAAAAAAAAAAAAAAAAFNjbCBVbnRGI1ByY0BZAAAAAAAAAAAAEGNyb3BXaGVuUHJpbnRpbmdib29sAAAAAA5jcm9wUmVjdEJvdHRvbWxvbmcAAAAAAAAADGNyb3BSZWN0TGVmdGxvbmcAAAAAAAAADWNyb3BSZWN0UmlnaHRsb25nAAAAAAAAAAtjcm9wUmVjdFRvcGxvbmcAAAAAADhCSU0D7QAAAAAAEABIAAAAAQACAEgAAAABAAI4QklNBCYAAAAAAA4AAAAAAAAAAAAAP4AAADhCSU0EDQAAAAAABAAAAHg4QklNBBkAAAAAAAQAAAAeOEJJTQPzAAAAAAAJAAAAAAAAAAABADhCSU0nEAAAAAAACgABAAAAAAAAAAI4QklNA/UAAAAAAEgAL2ZmAAEAbGZmAAYAAAAAAAEAL2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAAAAYAAAAAAAEANQAAAAEALQAAAAYAAAAAAAE4QklNA/gAAAAAAHAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAOEJJTQQAAAAAAAACAAI4QklNBAIAAAAAAAgAAAAAAAAAADhCSU0EMAAAAAAABAEBAQE4QklNBC0AAAAAAAYAAQAAAAM4QklNBAgAAAAAABAAAAABAAACQAAAAkAAAAAAOEJJTQQeAAAAAAAEAAAAADhCSU0EGgAAAAADSQAAAAYAAAAAAAAAAAAA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LTEwLTIwVDE0OjMyOjExKzAzOjAwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDIxLTEwLTIwVDE0OjMyOjExKzAzOjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0xMC0yMFQxNDozMjoxMSswMzowMCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo3MDkzOTk0Njk5MzFFQzExQTQ3MkY5MTFFRjBBNjc2RCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo2RjkzOTk0Njk5MzFFQzExQTQ3MkY5MTFFRjBBNjc2RCIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjZGOTM5OTQ2OTkzMUVDMTFBNDcyRjkxMUVGMEE2NzZEIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjZGOTM5OTQ2OTkzMUVDMTFBNDcyRjkxMUVGMEE2NzZEIiBzdEV2dDp3aGVuPSIyMDIxLTEwLTIwVDE0OjMyOjExKzAzOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6NzA5Mzk5NDY5OTMxRUMxMUE0NzJGOTExRUYwQTY3NkQiIHN0RXZ0OndoZW49IjIwMjEtMTAtMjBUMTQ6MzI6MTErMDM6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpIiBzdEV2dDpjaGFuZ2VkPSIvIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8cGhvdG9zaG9wOkRvY3VtZW50QW5jZXN0b3JzPiA8cmRmOkJhZz4gPHJkZjpsaT5FOEQ4RUEzQjcxRTkwRjQzNEIzRDVCOTgyRjdBQTFBMDwvcmRmOmxpPiA8cmRmOmxpPnhtcC5kaWQ6NmVjMWYxN2MtZTYyYi1kMjQwLTg1MjItNjA5NzViMzY0OWJjPC9yZGY6bGk+IDwvcmRmOkJhZz4gPC9waG90b3Nob3A6RG9jdW1lbnRBbmNlc3RvcnM+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz7/7gAhQWRvYmUAZAAAAAABAwAQAwIDBgAAAAAAAAAAAAAAAP/bAIQACgcHBwgHCggICg8KCAoPEg0KCg0SFBAQEhAQFBEMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAELDAwVExUiGBgiFA4ODhQUDg4ODhQRDAwMDAwREQwMDAwMDBEMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8IAEQgAjADwAwERAAIRAQMRAf/EAOsAAQACAwEBAQAAAAAAAAAAAAAFBgIEBwMBCAEBAAMBAQEAAAAAAAAAAAAAAAECAwQFBhAAAQMDAgMIAQMFAQAAAAAAAQIDBAAFBhEHIDASEEAhMSIyExRQYCMWFTU2FzczEQACAgAEAgQHCwkHAgcBAAACAwEEABESBSITITEyFBBCUmIjM4MgQVFygpKiQ3MVBjBhcYGyU2OTJECRscHCs3RQo6HR4sM0JXUWEgABAgIFBwcKBQUAAAAAAAACAAEREjAhIjIDECBCUmITI/AxcqKy4kNAUGCCksIzU3PTYdLyk6NxY7PDBP/aAAwDAQECEQMRAAAA7MAAAAAAAAAAAAAAARUtW0YG/WZOAAAAAAAAAAAAHiQNmZ62rrXzzz0sVLARspKAAAGlKl3b0LlR9ABT7rhQAICyWqqd2lLo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" alt="" width="240" height="140"/>
]]>
	</xsl:text>
</div>
<div style="clear:both;"/>
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
<xsl:if test="//n1:Invoice/cbc:AccountingCost">
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
					<xsl:if test="position() !=1">
						<br/>
					</xsl:if>
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
					<xsl:if test="position() !=1">
						<br/>
					</xsl:if>
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
					<xsl:if test="position() !=1">
						<br/>
					</xsl:if>
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
					<xsl:if test="position() !=1">
						<br/>
					</xsl:if>
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
						<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
						<br/>
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
							<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
							<br/>
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
				<th data-id="SATIRLAR_SIRANO" style="text-align:left;">
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
<xsl:if test="//n1:Invoice/cbc:ProfileID='IHRACAT'">
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryTerms/cbc:ID[@schemeID='INCOTERMS']">
		<th data-id="SATIRLAR_IHRACAT">
			<span style="font-weight:bold;">
				<xsl:text>Teslim Şartı</xsl:text>
			</span>
		</th>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode">
		<th>
			<span style="font-weight:bold; width:5%;">
				<xsl:text>Eşya Kap Cinsi</xsl:text>
			</span>
		</th>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:ID">
		<th>
			<span style="font-weight:bold;">
				<xsl:text>Kap No</xsl:text>
			</span>
		</th>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity">
		<th>
			<span style="font-weight:bold;">
				<xsl:text>Kap Adet</xsl:text>
			</span>
		</th>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress">
		<th>
			<span>
				<xsl:text>Teslim/Bedel Ödeme Yeri</xsl:text>
			</span>
		</th>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode">
		<th>
			<span style="font-weight:bold;">
				<xsl:text>Gönderilme Şekli</xsl:text>
			</span>
		</th>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID">
		<th>
			<span style="font-weight:bold;">
				<xsl:text>GTİP</xsl:text>
			</span>
		</th>
	</xsl:if>
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
			<xsl:if test="count(//n1:Invoice/cac:InvoiceLine) &gt;= 20">
				<xsl:for-each select="//n1:Invoice/cac:InvoiceLine">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="count(//n1:Invoice/cac:InvoiceLine) &lt; 20">
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[1]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[1]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[2]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[2]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[3]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[3]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[4]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[4]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[5]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[5]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[6]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[6]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[7]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[7]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[8]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[8]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[9]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[9]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[10]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[10]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[11]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[11]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[12]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[12]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[13]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[13]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[14]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[14]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[15]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[15]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[16]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[16]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[17]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[17]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[18]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[18]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[19]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[19]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="//n1:Invoice/cac:InvoiceLine[20]">
						<xsl:apply-templates
											select="//n1:Invoice/cac:InvoiceLine[20]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//n1:Invoice"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</tbody>
	</table>
</div>


</xsl:for-each>

<div id="toplamlarContainer">
	
	<div class="toplamlar">
	
	<div class="toplamTablo">

<table id="toplamlar">
	<tbody>
				<tr>
			<th>
				<xsl:text>Mal Hizmet Toplam Tutarı:</xsl:text>
			</th>
			<td>
				<xsl:value-of
									select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount, '###.##0,00', 'european')"/>
				<xsl:if
									test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID">
					<xsl:text> </xsl:text>
					<span>
						<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
							<xsl:text>TL</xsl:text>
						</xsl:if>
						<xsl:if
										test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
							<xsl:value-of
											select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID"
										/>
						</xsl:if>
					</span>
				</xsl:if>
			</td>
		</tr>
		<xsl:if test="//n1:Invoice/cbc:ProfileID='IHRACAT'">
		<tr>
                                                                                <th>
                                                                                        <xsl:text>Nakliye:</xsl:text>
                                                                                </th>
                                                                                <td>
                                                                                <xsl:choose>

                                                                                        <xsl:when test="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:DeclaredForCarriageValueAmount">
                                                                                                <xsl:value-of
                                                                                                select="format-number(//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:DeclaredForCarriageValueAmount, '###.##0,00', 'european')"/>
                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:DeclaredForCarriageValueAmount/@currencyID">
                                                                                                                <xsl:text> </xsl:text>
                                                                                                                <span>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                                                                <xsl:text>TL</xsl:text>
                                                                                                                        </xsl:if>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                                                                <xsl:value-of
                                                                                                        select="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:DeclaredForCarriageValueAmount/@currencyID"
                                                                                                />
                                                                                                                        </xsl:if>
                                                                                                                </span>
                                                                                                        </xsl:if>


                                                                                        </xsl:when>


                                                                                        <xsl:when test="//n1:Invoice/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount">
                                                                                                <xsl:value-of
                                                                                                select="format-number(//n1:Invoice/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount, '###.##0,00', 'european')"/>
                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount/@currencyID">
                                                                                                                <xsl:text> </xsl:text>
                                                                                                                <span>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                                                                <xsl:text>TL</xsl:text>
                                                                                                                        </xsl:if>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                                                                <xsl:value-of
                                                                                                        select="//n1:Invoice/cac:Delivery/cac:Shipment/cbc:DeclaredForCarriageValueAmount/@currencyID"
                                                                                                />
                                                                                                                        </xsl:if>
                                                                                                                </span>
                                                                                                        </xsl:if>


                                                                                        </xsl:when>


                                                                                        <xsl:otherwise>
                                                                                                <xsl:value-of select="format-number(0, '###.##0,00', 'european')"/>
                                                                                                <xsl:text> </xsl:text>
                                                                                                <span>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                                                                <xsl:text>TL</xsl:text>
                                                                                                                        </xsl:if>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                                                                <xsl:value-of
                                                                                                        select="//n1:Invoice/cbc:DocumentCurrencyCode"
                                                                                                />
                                                                                                                        </xsl:if>
                                                                                                                </span>


                                                                                        </xsl:otherwise>

                                                                                </xsl:choose>
                                                                                </td>


                                                                        </tr>
	</xsl:if>
<xsl:if test="//n1:Invoice/cbc:ProfileID='IHRACAT'">
		<tr>
                                                                                <th>
                                                                                        <xsl:text>Sigorta:</xsl:text>
                                                                                </th>
                                                                                <td>
                                                                        <xsl:choose>

                                                                                        <xsl:when test="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:InsuranceValueAmount">
                                                                                                <xsl:value-of
                                                                                                select="format-number(//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:InsuranceValueAmount, '###.##0,00', 'european')"/>
                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:InsuranceValueAmount/@currencyID">
                                                                                                                <xsl:text> </xsl:text>
                                                                                                                <span>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                                                                <xsl:text>TL</xsl:text>
                                                                                                                        </xsl:if>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                                                                <xsl:value-of
                                                                                                        select="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:InsuranceValueAmount/@currencyID"
                                                                                                />
                                                                                                                        </xsl:if>
                                                                                                                </span>
                                                                                                        </xsl:if>
                                                                                        </xsl:when>

                                                                                        <xsl:when test="//n1:Invoice/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount">
                                                                                                <xsl:value-of
                                                                                                select="format-number(//n1:Invoice/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount, '###.##0,00', 'european')"/>
                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount/@currencyID">
                                                                                                                <xsl:text> </xsl:text>
                                                                                                                <span>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                                                                <xsl:text>TL</xsl:text>
                                                                                                                        </xsl:if>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                                                                <xsl:value-of
                                                                                                        select="//n1:Invoice/cac:Delivery/cac:Shipment/cbc:InsuranceValueAmount/@currencyID"
                                                                                                />
                                                                                                                        </xsl:if>
                                                                                                                </span>
                                                                                                        </xsl:if>
                                                                                        </xsl:when>

                                                                                        <xsl:otherwise>
                                                                                                <xsl:value-of select="format-number(0, '###.##0,00', 'european')"/>
                                                                                                <xsl:text> </xsl:text>
                                                                                                <span>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                                                                <xsl:text>TL</xsl:text>
                                                                                                                        </xsl:if>
                                                                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                                                                <xsl:value-of
                                                                                                        select="//n1:Invoice/cbc:DocumentCurrencyCode"
                                                                                                />
                                                                                                                        </xsl:if>
                                                                                                                </span>

                                                                                        </xsl:otherwise>

                                                                        </xsl:choose>
                                                                                </td>


                                                                        </tr>
	</xsl:if>
		                <xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !=0">
                        <tr>
                                <th>
                                        <xsl:text>Toplam İskonto: </xsl:text>
                                </th>
                                <td>
                                        <xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount, '###.##0,00', 'european')"/>
                                        <xsl:if
                                                                        test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID">
                                                <xsl:text> </xsl:text>
                                                <span>
                                                        <xsl:if
                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                <xsl:text>TL</xsl:text>
                                                        </xsl:if>
                                                        <xsl:if
                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                <xsl:value-of
                                                                                        select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID"
                                                                                />
                                                        </xsl:if>
                                                </span>
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
                                                <xsl:text> </xsl:text>
                                                <span>
                                                        <xsl:if
                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                <xsl:text>TL</xsl:text>
                                                        </xsl:if>
                                                        <xsl:if
                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                <xsl:value-of
                                                                                        select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount/@currencyID"
                                                                                />
                                                        </xsl:if>
                                                </span>
                                        </xsl:if>
                                </td>
                        </tr>
                </xsl:if>
                <xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode='0015']">
                        <tr>
                                <th>
                                        <xsl:text>KDV Matrahı </xsl:text>
                                        <xsl:text>(%</xsl:text>
                                        <xsl:value-of select="cbc:Percent"/>
                                        <xsl:text>):</xsl:text>
                                </th>

                                <td>
                                        <xsl:value-of
                                                                        select="format-number(./cbc:TaxableAmount[../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode='0015'], '###.##0,00', 'european')"/>
                                        <xsl:if
                                                                        test="./cbc:TaxableAmount/@currencyID">
                                                <xsl:text> </xsl:text>
                                                <span>
                                                        <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                <xsl:text>TL</xsl:text>
                                                        </xsl:if>
                                                        <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                <xsl:value-of
                                                                                        select="./cbc:TaxableAmount/@currencyID"/>
                                                        </xsl:if>
                                                </span>
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
                                        <xsl:text> </xsl:text>
                                        <span>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                        <xsl:text>TL</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                        <xsl:value-of
                                                                                        select="
                                                                                        //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID"
                                                                                />
                                                </xsl:if>
                                        </span>
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
                                                                        select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
                                                <span>
                                                        <xsl:if test="../../cbc:TaxAmount/@currencyID">
                                                                <xsl:text> </xsl:text>
                                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                        <xsl:text>TL</xsl:text>
                                                                </xsl:if>
                                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                        <xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
                                                                </xsl:if>
                                                        </xsl:if>
                                                </span>
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
                                                        <xsl:text> </xsl:text>
                                                        <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                </xsl:if>
                                        </span>
                                </td>
                        </tr>
				</xsl:if>
				<xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
                        <tr>
                                <th>
                                        <xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. KDV: </xsl:text>
                                </th>
                                <td class="sumValue">
                                        <xsl:value-of select="format-number(sum(n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal/cbc:TaxableAmount[starts-with(../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]), '###.##0,00', 'european')"/>
                                        <span>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                        <xsl:text> TL</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                        <xsl:text> </xsl:text>
                                                        <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                </xsl:if>
                                        </span>
                                </td>
                        </tr>
				</xsl:if>
                <xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">

                        <xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
                                <tr>
                                        <th>
                                                <xsl:text>KDV Tevkifat Tutarı (</xsl:text>
                                                <xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>):
                                        </th>
                                        <td class="sumValue">
                                                <xsl:value-of select="format-number(cbc:TaxAmount, '###.##0,00', 'european')"/>
                                                <span>
                                                        <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                <xsl:text> TL</xsl:text>
                                                        </xsl:if>
                                                        <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="//n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                        </xsl:if>
                                                </span>
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
                                        <span>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                        <xsl:text> TL</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                        <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                </xsl:if>
                                        </span>
                                </td>
                        </tr>
				</xsl:if>
                <xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]">
                        <tr>
                                <th>
                                        <xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. ÖTV</xsl:text>
                                </th>
                                <td class="sumValue">
                                        <xsl:value-of select="format-number(sum(n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal/cbc:TaxableAmount[starts-with(../cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]), '###.##0,00', 'european')"/>
                                        <span>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                        <xsl:text> TL</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                        <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                </xsl:if>
                                        </span>
                                </td>
                        </tr>
				</xsl:if>
                <xsl:if test="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]">
                        <xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4')]">
                                <tr>
                                        <th>
                                                <xsl:text>ÖTV Tevkifat Tutarı (</xsl:text>
                                                <xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>):
                                        </th>
                                        <td class="sumValue">
                                                <xsl:value-of select="../cbc:TaxAmount"/>
                                                <span>
                                                        <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                <xsl:text> TL</xsl:text>
                                                        </xsl:if>
                                                        <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="//n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                        </xsl:if>
                                                </span>
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
                                        <span>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                        <xsl:text>TL</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                        <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                </xsl:if>
                                        </span>
                                </td>
                        </tr>
				</xsl:if>
                
                <xsl:if test="sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount)>0">
                       <tr>
                                <th>
                                        <xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. KDV:</xsl:text>
                                </th>
                                <td class="sumValue">
                                        <xsl:value-of select="format-number(sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
                                        <span>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                        <xsl:text>TL</xsl:text>
                                                </xsl:if>
                                                <xsl:if test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                        <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                                                </xsl:if>
                                        </span>
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
                                                                <span>
                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                <xsl:text>TL</xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                <xsl:value-of
                                                                                                select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID"
                                                                                                />
                                                                        </xsl:if>
                                                                </span>
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
                                                                <span>
                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode = 'TRY' or //n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
                                                                                <xsl:text>TL</xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:if
                                                                                                test="//n1:Invoice/cbc:DocumentCurrencyCode != 'TRY' and //n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
                                                                                <xsl:value-of
                                                                                                select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"
                                                                                                />
                                                                        </xsl:if>
                                                                </span>
                                                        </xsl:if>
                                                </xsl:for-each>
                                        </xsl:for-each>
                                </xsl:for-each>
                        </td>
                </tr>

	</tbody>
</table>
</div>


</div>


</div>

<xsl:if test="//n1:Invoice/cbc:ProfileID != 'YOLCUBERABERFATURA' and //n1:Invoice/cbc:ProfileID = 'IHRACAT'">
	<div id="ihracatBilgileri">

		<table width="100%" border="0">
			<tbody>
				<tr>
					<th align="left">Eşya Bilgileri</th>
					<th align="left">Adres Bilgileri</th>
				</tr>
				<tr>
					<td valign="top" width="50%">


						<xsl:text>Teslim Şartı: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryTerms/cbc:ID[@schemeID='INCOTERMS']">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>Gönderilme Şekli: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode">
							<xsl:call-template name="TransportMode">
								<xsl:with-param name="TransportModeType">
									<xsl:value-of select="."/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
						<br />
						<xsl:text>GTİP No: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>Eşya Kap Cinsi: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode">
							<xsl:call-template name="Packaging">
								<xsl:with-param name="PackagingType">
									<xsl:value-of select="."/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
					</td>

					<td vaign="top" width="50%">
						<xsl:text>Ülke: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:Name">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>Şehir: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:CityName">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>İlçe: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:CitySubdivisionName">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>Posta Kodu: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:PostalZone">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>Sokak: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:StreetName">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>No: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:BuildingNumber">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
						<xsl:text>Bina Adı: </xsl:text>
						<xsl:for-each select="//n1:Invoice/cac:Delivery/cac:DeliveryAddress/cbc:BuildingName">
							<xsl:value-of select="."/>
						</xsl:for-each>
						<br />
					</td>
				</tr>
			</tbody>
		</table>

	</div>
</xsl:if>


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
						<br/>
						<span style="display:inline-block;font-weight:bold;  vertical-align: top;padding-right: 4px;">TEVKİFAT DETAYI: </span>
						<span style="display:inline-block;">
							<xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'4') or starts-with(./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode,'6')]">
								<xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/> - <xsl:value-of select="./cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
								<br/>
							</xsl:for-each>
						</span>
						<div style="clear:both"/>
					</xsl:if>


					<xsl:if test="count(//n1:Invoice/cac:AdditionalDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject) &gt; 1">
						<br/>
						<span style="font-weight:bold;">İLAVE DÖKÜMANLAR</span>
						<br/>
					</xsl:if>
					<xsl:if test="//n1:Invoice/cac:AdditionalDocumentReference and //n1:Invoice/cac:AdditionalDocumentReference/cbc:DocumentType!='XSLT'">
						<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
							<xsl:if test="./cbc:DocumentType!='XSLT' and not(./cbc:DocumentTypeCode)">
								<xsl:if test="./cbc:ID">
									<span style="font-weight:bold;">Belge No: </span>
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
						<br/>
						<span style="font-weight:bold;">ÖDEME ŞEKLİ</span>
						<br/>


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
								<span style="font-weight:bold;">Son Ödeme Tarihi:</span>&#160;
								<xsl:value-of select="substring(cbc:PaymentDueDate,9,2)"
												/>-<xsl:value-of select="substring(cbc:PaymentDueDate,6,2)"
												/>-<xsl:value-of select="substring(cbc:PaymentDueDate,1,4)"/>&#160;&#160;&#160;

							</xsl:if>
							<xsl:if test="cbc:PaymentChannelCode">
								<span style="font-weight:bold;">Ödeme Kanalı: </span>&#160;
								<xsl:value-of
                                                select="cbc:PaymentChannelCode"/>&#160;&#160;&#160;
							</xsl:if>

							<xsl:if test="cac:PayeeFinancialAccount/cbc:ID">
								<span style="font-weight:bold;"> IBAN / Hesap No: </span>
								<xsl:value-of select="cac:PayeeFinancialAccount/cbc:ID"/>
											(<xsl:if test="cac:PayeeFinancialAccount/cbc:CurrencyCode = 'TRY' or cac:PayeeFinancialAccount/cbc:CurrencyCode = 'TRL'">
									<xsl:text>TL</xsl:text>
								</xsl:if>
								<xsl:if test="cac:PayeeFinancialAccount/cbc:CurrencyCode != 'TRY' and cac:PayeeFinancialAccount/cbc:CurrencyCode != 'TRL'">
									<xsl:value-of select="cac:PayeeFinancialAccount/cbc:CurrencyCode"/>
								</xsl:if>)
							</xsl:if>

							<xsl:if test="cbc:InstructionNote">
								<br/>
								<span style="font-weight:bold;">Ödeme Şekli Açıklaması: </span>&#160;
								<xsl:value-of
                                                select="cbc:InstructionNote"/>&#160;&#160;&#160;
							</xsl:if>


							<br/>

						</xsl:for-each>

					</xsl:if>


					<xsl:if test="//n1:Invoice/cac:InvoicePeriod">
						<br/>
						<span style="font-weight:bold;">FATURA DÖNEM BİLGİLERİ</span>
						<br/>


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
								<span style="font-weight:bold;">Dönem Periyodu / Süresi:</span>&#160;
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
						<br/>
						<span style="font-weight:bold;">ALINDI BİLGİLERİ</span>
						<br/>
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
						<br/>
						<span style="font-weight:bold;">ÖDEME KOŞULLARI</span>
						<br/>

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


	</div>
</body>

</html>

</xsl:template>
	
<xsl:template match="//n1:Invoice/cac:InvoiceLine">
	
	<tr>
		<td style="text-align:left;">
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
					<xsl:when test="@unitCode = 'YRD'">
						<span>
							<xsl:text> Yard</xsl:text>
						</span>
					</xsl:when>
					<xsl:when test="@unitCode = 'DMK'">
						<span>
							<xsl:text> Desimetrekare</xsl:text>
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
		<xsl:for-each select="./cac:AllowanceCharge">
			<xsl:if test="./cbc:MultiplierFactorNumeric">
				<xsl:text> %</xsl:text>
				<xsl:value-of select="format-number(./cbc:MultiplierFactorNumeric * 100, '###.##0,00', 'european')"/>
				<br/>
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
			</xsl:if>
			<br/>
		</xsl:for-each>
	</span>
</td>
</xsl:if> 
<td>
	<span>
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
<xsl:if test="//n1:Invoice/cbc:ProfileID='IHRACAT'">
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryTerms/cbc:ID[@schemeID='INCOTERMS']">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:DeliveryTerms/cbc:ID[@schemeID='INCOTERMS']">
				<xsl:text>&#160;</xsl:text>
				<xsl:apply-templates/>
			</xsl:for-each>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode">
				<xsl:text>&#160;</xsl:text>
				<xsl:call-template name="Packaging">
					<xsl:with-param name="PackagingType">
						<xsl:value-of select="."/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:ID">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:ID">
				<xsl:text>&#160;</xsl:text>
				<xsl:apply-templates/>
			</xsl:for-each>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity">
				<xsl:text>&#160;</xsl:text>
				<xsl:apply-templates/>
			</xsl:for-each>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:DeliveryAddress">
				<xsl:text>&#160;</xsl:text>
				<xsl:apply-templates/>
			</xsl:for-each>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode">
				<xsl:text>&#160;</xsl:text>
				<xsl:call-template name="TransportMode">
					<xsl:with-param name="TransportModeType">
						<xsl:value-of select="."/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID">
		<td class="lineTableTd" align="right">
			<xsl:text>&#160;</xsl:text>
			<xsl:for-each select="cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID">
				<xsl:text>&#160;</xsl:text>
				<xsl:apply-templates/>
			</xsl:for-each>
		</td>
	</xsl:if>
</xsl:if>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TaxExemptionReasonCode > 0">

<td style="font-size: xx-small;white-space:normal;">
	<span>
		<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal[./cac:TaxCategory/cbc:TaxExemptionReasonCode > '0']">
			<xsl:if test="cac:TaxCategory/cbc:TaxExemptionReasonCode">
				<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReasonCode"/> - <xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/> - <xsl:value-of select="cac:TaxCategory/cbc:Name"/>
				<br/>
			</xsl:if>
		</xsl:for-each>
	</span>
</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode !='0015' or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
<td style="font-size: xx-small;">
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
					</xsl:if>
					<br/>
				</span>
			</xsl:if>
		</xsl:for-each>

		
		<xsl:for-each
						select="./cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<xsl:if test="cbc:TaxTypeCode!='0015' ">
				<span class="is-long-{string-length(cbc:Name) > 15}"><xsl:if test="starts-with(cbc:TaxTypeCode,'4') or starts-with(cbc:TaxTypeCode,'6')">
						<xsl:value-of select="cbc:TaxTypeCode"/> -
					</xsl:if>
					<xsl:value-of select="cbc:Name"/>
				</span>
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
<xsl:template match="//n1:Invoice">
	<tr>
		<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric and //n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:MultiplierFactorNumeric !=0">
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:AllowanceCharge">
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
</xsl:if> 
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode ='0015'">
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode ='0015'">
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
</xsl:if> 
	<xsl:if test="//n1:Invoice/cbc:ProfileID='IHRACAT'">
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryTerms/cbc:ID[@schemeID='INCOTERMS']">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:PackagingTypeCode">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:ID">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:TransportHandlingUnit/cac:ActualPackage/cbc:Quantity">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:ShipmentStage/cbc:TransportModeCode">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
	<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID">
		<td>
			<span>
				<xsl:text>&#160;</xsl:text>
			</span>
		</td>
	</xsl:if>
</xsl:if>
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TaxExemptionReasonCode > 0">
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
</xsl:if> 
<xsl:if test="//n1:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode !='0015' or //n1:Invoice/cac:InvoiceLine/cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
<td>
	<span>
		<xsl:text>&#160;</xsl:text>
	</span>
</td>
</xsl:if> 

	</tr>
</xsl:template>

</xsl:stylesheet>

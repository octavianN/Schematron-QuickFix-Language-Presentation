<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="xslChecks.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"  xmlns:func="http://www.oxygenxml.com/doc/xsl/functions"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc>
        <xd:desc>
            <xd:p>These prefixes will be merged with the unique ID of an XSLT element in order to
                uniquely identify each button that can expand/collapse a detail of an XSLT
                element.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="buttonPrefix">bt_</xsl:variable>
      
    <xd:doc>
        <xd:desc>
            <xd:p>Constructs an unique ID for the given detail node. A prefix will be used for each
                detail type in conjunction with the ID of the XSLT element it belongs to. The
                constructed ID will identify a DIV element in the XHTML that will contain the
                detail. This block will be able to be expanded/colapsed through Javascript.</xd:p>
        </xd:desc>
        <xd:param name="node">
            <xd:p>The node from the source that represents a specific detail.</xd:p>
        </xd:param>
    </xd:doc>
     <xsl:function name="func:getDivId" as="xs:string">
        <xsl:param name="node"/>
        <xsl:value-of
            select="concat('id_',$node/parent::node()/@id)"/>
    </xsl:function>
    
    <xsl:function name="func:getButtonId" as="xs:string" xmlns:xs="http://www.w3.org/2001/XMLSchema">
        <xsl:param name="node"/>
        <xsl:param name="buttonPrefix" as="xs:string"/>
        <xsl:value-of select="concat($buttonPrefix , func:getDivId($node))"/>
    </xsl:function>
</xsl:stylesheet>
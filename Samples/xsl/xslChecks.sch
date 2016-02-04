<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
    <sch:ns uri="http://www.oxygenxml.com/ns/doc/xsl" prefix="xd"/>
    <sch:pattern>
        <sch:rule context="xsl:function/xsl:param">
            <sch:report test="@required" sqf:fix="removeAttr removeAttrs">
                @required attribute is not allowed on a function parameter.</sch:report>
            <sqf:fix id="removeAttr">
                <sqf:description>
                    <sqf:title>Remove @required attribute</sqf:title>
                </sqf:description>
                <sqf:delete match="@required"/>
            </sqf:fix>
            <sqf:fix id="removeAttrs">
                <sqf:description>
                    <sqf:title>Remove all @required attribute</sqf:title>
                </sqf:description>
                <sqf:delete match="//xsl:function/xsl:param/@required"/>
            </sqf:fix>
        </sch:rule>
        
        <sch:rule context="xsl:variable | xsl:param">
            <sch:assert test="@as" sqf:fix="addAs" role="warn">
                It is recommended to add the @as attribute.
            </sch:assert>
            
            <sqf:fix id="addAs">
                <sqf:description>
                    <sqf:title>Add @as attribute</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="as"/>
            </sqf:fix>
        </sch:rule>
        
        <sch:rule context="xsl:function">
            <sch:assert test="preceding-sibling::element()[1]/local-name()='doc'" sqf:fix="addDoc" role="warn">
                The function does not have documentation.
            </sch:assert>
            <sqf:fix id="addDoc">
                <sqf:description>
                    <sqf:title>Add documentation</sqf:title>
                </sqf:description>
                <sqf:add position="before">
                    <xd:doc><xsl:text>
                        </xsl:text><xd:desc><xsl:text>
                            </xsl:text><xd:p>Function description</xd:p><xsl:text>
                        </xsl:text></xd:desc>
                        <xsl:for-each select="xsl:param"><xsl:text>
                            </xsl:text><xd:param name="{@name}"><xsl:text>
                                </xsl:text><xd:p>Param description</xd:p><xsl:text>
                            </xsl:text></xd:param>
                        </xsl:for-each><xsl:text>
                    </xsl:text></xd:doc><xsl:text>
                    </xsl:text>
                </sqf:add>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>   
</sch:schema>
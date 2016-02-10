<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:html="http://www.w3.org/1999/xhtml" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.w3.org/1999/xhtml" prefix="html"/>
    <sch:pattern>
        <sch:rule context="table">
            <sch:assert test="col" sqf:fix="title"> A title shouldn't be empty.</sch:assert>
            <sqf:fix id="title">
                <sqf:call-fix ref="createElementRowAsFirstChild">
                    <sqf:with-param name="match" select="."/>
                    <sqf:with-param name="el" select="'col'"/>
                    <sqf:with-param name="count" select="count(max(.//tr/count(td | th)))"/>
                </sqf:call-fix>
            </sqf:fix>
            <sqf:fix id="createElementRowAsFirstChild">
                <sqf:param name="match" type="node()*"/>
                <sqf:param name="el" type="xs:QName"/>
                <sqf:param name="count" type="xs:integer"/>
                <sqf:description>
                    <sqf:title>Create a row of <sch:value-of select="$count"/>
                        <sch:name path="$el"/> elements as a first child of the <sch:name path="$match"/> element(s).</sqf:title>
                </sqf:description>
                <sqf:add match="$match" position="first-child">
                    <xsl:for-each select="1 to $count">
                        <xsl:element name="{$el}"/>
                    </xsl:for-each>
                </sqf:add>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
<sch:rule context="title">
    <sch:report test="exists(b)" 
        sqf:fix="resolveBold deleteBold"> 
        Bold element is not allowed in title.</sch:report>
    <sqf:fix id="resolveBold">
        <sqf:description>
            <sqf:title>Change the bold element into text
            </sqf:title>
            <sqf:p>Remove the bold (b) markup and keeps the 
                text content</sqf:p>
        </sqf:description>
        <sqf:replace match="b" select="text()"/>
    </sqf:fix>
    <sqf:fix id="deleteBold">
        <sqf:description>
            <sqf:title>Delete the bold element</sqf:title>
            <sqf:p>Remove the bold (b) markup including the 
                text content</sqf:p>
        </sqf:description>
        <sqf:delete match="b"/>
    </sqf:fix>
</sch:rule>
    </sch:pattern>
</sch:schema>

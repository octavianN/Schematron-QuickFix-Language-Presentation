<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="Root">
            <sch:assert test="Element[@value]" sqf:fix="addAttr">
                The attribute @value must be set to each element.
            </sch:assert>
            
            <sqf:fix id="addAttr">
                <sqf:description>
                    <sqf:title>Add @value attribute on each element</sqf:title>
                </sqf:description>
                <sqf:delete match="//Element[not(@value)]/text()"/>
                <sqf:add match="//Element[not(@value)]" node-type="attribute" target="value" select="text()"/>
            </sqf:fix>
            
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
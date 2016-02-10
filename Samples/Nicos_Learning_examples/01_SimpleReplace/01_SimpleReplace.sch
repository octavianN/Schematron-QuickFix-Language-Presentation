<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="b">
            <sch:report test="ancestor::b" 
                sqf:fix="italic unwrap"> 
                Bold in bold is not allowed.</sch:report>
            <sqf:fix id="italic">
                <sqf:description>
                    <sqf:title>Change it to italic.</sqf:title>
                </sqf:description>
                <sqf:replace match="." node-type="element" target="i" select="node()"/>
            </sqf:fix>
            <sqf:fix id="unwrap">
                <sqf:description>
                    <sqf:title>Unwrap <sch:name/> element</sqf:title>
                </sqf:description>
                <sqf:replace select="node()"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
<sch:rule context="h2">
    <sch:assert test="preceding::h1" 
        sqf:fix="addH1"> 
        A h2 should not be used without a h1 before.</sch:assert>
    <sqf:fix id="addH1">
        <sqf:description>
            <sqf:title>Add a h1 element before the h2 element.</sqf:title>
        </sqf:description>
        <sqf:add node-type="element" target="h1" position="before"/>
    </sqf:fix>
</sch:rule>
    </sch:pattern>
</sch:schema>

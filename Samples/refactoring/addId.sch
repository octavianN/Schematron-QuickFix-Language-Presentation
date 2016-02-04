<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="section[not(@id)]">
            <sch:report test="true()" sqf:fix="addId addIds">All sections must have an ID</sch:report>
           
            <sqf:fix id="addId">
                <sqf:description>
                    <sqf:title>Add an ID with the section title</sqf:title>
                    <sqf:p>Add an ID to the current section using the section title.</sqf:p>
                </sqf:description>
                <sqf:add target="id" node-type="attribute" 
                    select="lower-case(replace(title/text(), '\s', '_'))"/>
            </sqf:fix>
            
            <sqf:fix id="addIds">
                <sqf:description>
                    <sqf:title>Add an ID for each section with the section title</sqf:title>
                    <sqf:p>Add an ID to each section using the section title.</sqf:p>
                </sqf:description>
                <sqf:add match="//section[not(@id)]" target="id" node-type="attribute" 
                    select="lower-case(replace(title/text(), '\s', '_'))"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>
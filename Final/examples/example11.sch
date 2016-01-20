<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
<sch:rule context="title">
    <sch:assert test="normalize-space(.) != ''" 
        sqf:fix="title"> 
        A title shouldn't be empty.</sch:assert>
    <sqf:fix id="title">
        <sqf:description>
            <sqf:title>Set a title</sqf:title>
            <sqf:p>This QuickFix will set a title by using a 
                User Entry.</sqf:p>
        </sqf:description>
        <sqf:user-entry name="title">
            <sqf:description>
                <sqf:title>Please enter the new title.
                </sqf:title>
            </sqf:description>
        </sqf:user-entry>
        <sqf:replace target="title" node-type="element"
            select="$title" />
    </sqf:fix>
</sch:rule>
    </sch:pattern>
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sqf:fixes>
<sqf:fix id="delete">
    <sqf:description>
        <sqf:title>Delete the <sch:name/> element</sqf:title>
        <sqf:p>The <sch:name/> element was missplaced in the 
            <sch:name path=".."/> element.</sqf:p>
        <sqf:p>This QuickFix will delete the <sch:name/> 
            element<sch:value-of select="
                if (./node()) 
                then ' with all its content.' 
                else '.'"/>
        </sqf:p>
    </sqf:description>
    <sqf:delete/>
</sqf:fix>
    </sqf:fixes>
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
    <sch:pattern>
        <sch:rule context="title">
            <sch:report test="preceding-sibling::abstract" sqf:fix="move"> 
                The abstract element shouldn't be placed before the <sch:name/> element.
            </sch:report>
            <sqf:fix id="move">
                <sqf:description>
                    <sqf:title>Move the abstract element after the title</sqf:title>
                    <sqf:p>The misplaced abstract element will be deleted and  
                        inserted directly after the title element.</sqf:p>
                </sqf:description>
                <sqf:delete match="preceding-sibling::abstract"/>
                <sqf:add match="." select="preceding-sibling::abstract" position="after"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>

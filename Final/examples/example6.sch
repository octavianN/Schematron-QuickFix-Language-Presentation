<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
<sch:rule context="title">
    <sch:report test="comment()" 
        sqf:fix="deleteComment"> 
        Comments are not allowed in the <sch:name/> element.</sch:report>
    <sqf:fix id="deleteComment">
        <sqf:description>
            <sqf:title>Delete the comment.</sqf:title>
        </sqf:description>
        <sqf:delete match="comment()"/>
    </sqf:fix>
</sch:rule>
    </sch:pattern>
</sch:schema>

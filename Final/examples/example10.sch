<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
<sch:rule context="text()">
<sch:report test="matches(., '____')" 
    sqf:fix="form"> 
    More than three underscores in a row shouldn't be used.</sch:report>
<sqf:fix id="form">
    <sqf:description>
        <sqf:title>Replace the missused characters by a form element.</sqf:title>
    </sqf:description>
    <sqf:stringReplace regex="___+">
        <form/>
    </sqf:stringReplace>
</sqf:fix>
</sch:rule>
    </sch:pattern>
</sch:schema>

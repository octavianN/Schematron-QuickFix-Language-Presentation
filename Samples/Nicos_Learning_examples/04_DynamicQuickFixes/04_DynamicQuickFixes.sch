<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:html="http://www.w3.org/1999/xhtml" queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.w3.org/1999/xhtml" prefix="html"/>
    <sch:pattern>
        <sch:rule context="head/title">
            <sch:assert test="string-length(normalize-space(.)) le 20 " 
                sqf:fix="title"> 
                A title shouldn't have more than 20 characters.</sch:assert>
            <sqf:fix id="title" use-for-each="//h1[string-length(.) le 20]">
                <sqf:description>
                    <sqf:title>
                        Set the title to "<sch:value-of select="$sqf:current"/>".
                    </sqf:title>
                </sqf:description>
                <sqf:replace target="title" node-type="element">
                    <sch:value-of select="$sqf:current"/>
                </sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>

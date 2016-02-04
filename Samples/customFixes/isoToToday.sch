<?xml version="1.0" encoding="UTF-8"?>
<!-- The code below is intended to offer a quick fix for an empty @when-iso element by suggesting the 
    insertion of either today's date or the current date and time in ISO-compliant form. It is ideal for 
    <change> elements, to save time in typing the day or time when a change was made. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="@when-iso">
            <sch:report test=". = ''" sqf:fix="insert-todays-date insert-current-dateTime">@iso-when should not be
                empty.</sch:report>
            
            <sqf:fix id="insert-todays-date">
                <sqf:description>
                    <sqf:title>Insert today's date (ISO)</sqf:title>
                </sqf:description>
                <sqf:replace match="." target="when-iso" node-type="attribute" select="current-date()"/>
            </sqf:fix>
            
            <sqf:fix id="insert-current-dateTime">
                <sqf:description>
                    <sqf:title>Insert today's date and time (ISO)</sqf:title>
                </sqf:description>
                <sqf:replace match="." target="when-iso" node-type="attribute" select="current-dateTime()"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>   
</sch:schema>
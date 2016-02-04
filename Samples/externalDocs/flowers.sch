<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:pattern>
    <sch:rule context="li">
      <!-- The list item must not end with semicolon -->
      <sch:report test="boolean(ends-with(text()[last()], ';'))" sqf:fix="removeSemicolon"
        role="warn"> Semicolon is not allowed after list item.</sch:report>

      <!-- Quick fix that removes the semicolon from every list item. -->
      <sqf:fix id="removeSemicolon">
        <sqf:description>
          <sqf:title>Remove semicolon</sqf:title>
        </sqf:description>
        <sqf:stringReplace match="text()[last()]" regex=";$"/>
      </sqf:fix>
      
      <sch:let name="conrefDoc" value="document(resolve-uri(substring-before(@conref, '#')))"/>
      <sch:let name="lastId" value="substring-after(@conref, '/')"/>
      <sch:let name="externalLi" value="$conrefDoc//li[@id=$lastId]"/>
      
      <sch:report test="boolean($externalLi[ends-with(text()[last()], ';')])" sqf:fix="removeSemicolonExt"
        role="warn"> Semicolon is not allowed after list item.</sch:report>
      
      <sqf:fix id="removeSemicolonExt">
        <sqf:description>
          <sqf:title>Remove semicolon</sqf:title>
        </sqf:description>
        <sqf:stringReplace match="$externalLi/text()[last()]" regex=";$"/>
      </sqf:fix>
      
    </sch:rule>
  </sch:pattern>
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:pattern>
    
    <!-- Table asserts -->
    <sch:rule context="table">
      <sch:let name="minColumsNo" value="min(//row/count(entry))"/>
      <sch:let name="reqColumsNo" value="max(//row/count(entry))"/>
      
      <!-- Check the number of cells on each row -->
      <sch:assert test="$minColumsNo >= $reqColumsNo" sqf:fix="addCells">Cells are missing. (The
        number of cells for each row must be <sch:value-of select="$reqColumsNo"/>)</sch:assert>
      
      <!-- Quick fix that adds the missing cells from a table. -->
      <sqf:fix id="addCells">
        <sqf:description>
          <sqf:title>Add enough empty cells on each row</sqf:title>
          <sqf:p>Add enough empty cells on each row to match the required number of cells.</sqf:p>
        </sqf:description>
        <sqf:add match="//row" position="last-child">
          <sch:let name="columnNo" value="count(entry)"/>
          <xsl:for-each select="1 to xs:integer($reqColumsNo - $columnNo)">
            <entry/><xsl:text>
						</xsl:text>
          </xsl:for-each>
        </sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
</sch:schema>

















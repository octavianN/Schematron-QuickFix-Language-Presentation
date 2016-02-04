<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
                version="2.0"
                xml:base="file:/E:/Demos/XML%20Prague%202016/Schematron%20QuickFix/SQFPresenration2016/Samples/xsl/xslChecks.sch_xslt_cascade"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. The name or details of 
    this mode may change during 1Q 2007.-->


<!--PHASES-->


<!--PROLOG-->
   <xsl:output xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:oqf="http://www.oxygenxml.com/quickfix"
               method="xml"/>
   <xsl:namespace-alias xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                        xmlns:oqf="http://www.oxygenxml.com/quickfix"
                        stylesheet-prefix="axsl"
                        result-prefix="xsl"/>

   <!--KEYS-->


   <!--DEFAULT RULES-->


   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:variable name="sameUri">
         <xsl:value-of select="saxon:system-id() = parent::node()/saxon:system-id()"
                       use-when="function-available('saxon:system-id')"/>
         <xsl:value-of select="true()" use-when="not(function-available('saxon:system-id'))"/>
      </xsl:variable>
      <xsl:if test="$sameUri = 'true'">
         <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      </xsl:if>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$sameUri = 'true'">
         <xsl:variable name="preceding"
                       select="count(preceding-sibling::*[local-name()=local-name(current())                                    and namespace-uri() = namespace-uri(current())])"/>
         <xsl:text>[</xsl:text>
         <xsl:value-of select="1+ $preceding"/>
         <xsl:text>]</xsl:text>
      </xsl:if>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="text()" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:text>text()</xsl:text>
      <xsl:variable name="preceding" select="count(preceding-sibling::text())"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="comment()" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:text>comment()</xsl:text>
      <xsl:variable name="preceding" select="count(preceding-sibling::comment())"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:text>processing-instruction()</xsl:text>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::processing-instruction())"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:choose>
         <xsl:when test="count(. | ../namespace::*) = count(../namespace::*)">
            <xsl:value-of select="concat('.namespace::-',1+count(namespace::*),'-')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>

   <!--SCHEMA METADATA-->
   <xsl:template match="/">
      <oqf:fixes xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix">
         <xsl:apply-templates select="/" mode="M1"/>
      </oqf:fixes>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="xsl:function/xsl:param" priority="103" mode="M1">
      <!--Declare the unique quick fix ID variable -->
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="execLateFix_d3e5"
                 tunnel="yes"/>
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="userEntriesValues_d3e5"
                 tunnel="yes"/>
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="lateFix_d3e5"
                 tunnel="yes"/>
      <xsl:variable xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                    xmlns:oqf="http://www.oxygenxml.com/quickfix"
                    name="quickFixUuid"
                    select="concat(generate-id(), '_M', 1)"/>

		    <!--REPORT -->
      <xsl:if xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
              test="@required"
              sqf:fix="removeAttr removeAttrs">
         <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                      xmlns:osf="http://www.oxygenxml.com/sch/functions"
                      xmlns:oxy="http://www.oxygenxml.com/schematron/validation">
            <xsl:text> @required attribute is not allowed on a function parameter.</xsl:text>
            <xsl:text>
Source:#line=;column=</xsl:text>
            <xsl:text xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                      xmlns:oqf="http://www.oxygenxml.com/quickfix">
Fixes:</xsl:text>
            <xsl:value-of xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                          xmlns:oqf="http://www.oxygenxml.com/quickfix"
                          select="concat('removeAttr_', $quickFixUuid, ' ')"/>
            <xsl:value-of xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                          xmlns:oqf="http://www.oxygenxml.com/quickfix"
                          select="concat('removeAttrs_', $quickFixUuid, ' ')"/>
         </xsl:message>
      </xsl:if>

      <!--QUICK FIXES -->
      <xsl:if xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
              xmlns:oqf="http://www.oxygenxml.com/quickfix"
              test="not($lateFix_d3e5) or ($lateFix_d3e5 = 'removeAttr')">
         <xsl:if test="true()             and (@required)">
            <xsl:text>
</xsl:text>
            <oqf:fix id="removeAttr_{$quickFixUuid}">
               <xsl:choose>
                  <xsl:when test="not($execLateFix_d3e5)">
                     <oqf:name>
                        <xsl:text>Remove @required attribute</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                
                     <xsl:variable name="firstValidOp" select="( .[@required]/'delete', 'noOperation')[1]"/>
                     <xsl:if test="$firstValidOp != 'noOperation'">
                        <oqf:lateOperation schemaSystemId="file:/E:/Demos/XML%20Prague%202016/Schematron%20QuickFix/SQFPresenration2016/Samples/xsl/xslChecks.sch_xslt_cascade">
                           <xsl:attribute name="role" select="$firstValidOp"/>
                           <xsl:attribute name="oqf:systemId"
                                          select="saxon:system-id()"
                                          use-when="function-available('saxon:system-id')"/>
                           <axsl:stylesheet version="3.0">
                              <axsl:import href="xslChecks-compiled.xsl"/>
                              <xsl:text>
</xsl:text>
                              <axsl:param name="userEntriesValues"/>
                              <axsl:param name="lateQuickFixName" required="yes"/>
                              <xsl:variable name="nodePath">
                                 <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                              </xsl:variable>
                              <axsl:template match="/">
                                 <oqf:fixes>
                                    <axsl:apply-templates mode="M1">
                                       <xsl:attribute name="select" select="$nodePath"/>
                                       <axsl:with-param name="execLateFix_d3e5" tunnel="yes" select="true()"/>
                                       <axsl:with-param name="userEntriesValues_d3e5"
                                                        tunnel="yes"
                                                        select="$userEntriesValues"/>
                                       <axsl:with-param name="lateFix_d3e5" tunnel="yes" select="$lateQuickFixName"/>
                                    </axsl:apply-templates>
                                 </oqf:fixes>
                              </axsl:template>
                              <xsl:if test="not(self::comment() | self::processing-instruction() | self::attribute())">
                                 <axsl:template mode="M1">
                                    <xsl:attribute name="match" select="concat($nodePath, '/node()')"/>
                                 </axsl:template>
                              </xsl:if>
                           </axsl:stylesheet>
                        </oqf:lateOperation>
                     </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                     <oqf:name>
                        <xsl:text>Remove @required attribute</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                     <xsl:if test="true()">
 
<!--For each context node generate the delete operation.-->
                        <xsl:for-each select="@required">
                           <xsl:sort select="position()" data-type="number" order="descending"/>
                           <xsl:choose>
                              <xsl:when test="self::attribute()">
                                 <xsl:variable name="context">
                                    <xsl:apply-templates select="parent::node()" mode="schematron-get-full-path"/>
                                 </xsl:variable>
                                 <oqf:setAttribute>
                                    <xsl:attribute name="oqf:name" select="node-name(current())"/>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                    <xsl:attribute name="oqf:delete" select="true()"/>
                                 </oqf:setAttribute>
                              </xsl:when>
                              <xsl:when test="self::text()">
                                 <xsl:variable name="context">
                                    <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                                 </xsl:variable>
                                 <oqf:changeText>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                 </oqf:changeText>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:variable name="context">
                                    <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                                 </xsl:variable>
                                 <oqf:delete>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                 </oqf:delete>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:for-each>
                     </xsl:if>
                     <xsl:text>
</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </oqf:fix>
         </xsl:if>
      </xsl:if>
      <xsl:if xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
              xmlns:oqf="http://www.oxygenxml.com/quickfix"
              test="not($lateFix_d3e5) or ($lateFix_d3e5 = 'removeAttrs')">
         <xsl:if test="true()             and (@required)">
            <xsl:text>
</xsl:text>
            <oqf:fix id="removeAttrs_{$quickFixUuid}">
               <xsl:choose>
                  <xsl:when test="not($execLateFix_d3e5)">
                     <oqf:name>
                        <xsl:text>Remove all @required attribute</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                
                     <xsl:variable name="firstValidOp"
                                   select="( .[//xsl:function/xsl:param/@required]/'delete', 'noOperation')[1]"/>
                     <xsl:if test="$firstValidOp != 'noOperation'">
                        <oqf:lateOperation schemaSystemId="file:/E:/Demos/XML%20Prague%202016/Schematron%20QuickFix/SQFPresenration2016/Samples/xsl/xslChecks.sch_xslt_cascade">
                           <xsl:attribute name="role" select="$firstValidOp"/>
                           <xsl:attribute name="oqf:systemId"
                                          select="saxon:system-id()"
                                          use-when="function-available('saxon:system-id')"/>
                           <axsl:stylesheet version="3.0">
                              <axsl:import href="xslChecks-compiled.xsl"/>
                              <xsl:text>
</xsl:text>
                              <axsl:param name="userEntriesValues"/>
                              <axsl:param name="lateQuickFixName" required="yes"/>
                              <xsl:variable name="nodePath">
                                 <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                              </xsl:variable>
                              <axsl:template match="/">
                                 <oqf:fixes>
                                    <axsl:apply-templates mode="M1">
                                       <xsl:attribute name="select" select="$nodePath"/>
                                       <axsl:with-param name="execLateFix_d3e5" tunnel="yes" select="true()"/>
                                       <axsl:with-param name="userEntriesValues_d3e5"
                                                        tunnel="yes"
                                                        select="$userEntriesValues"/>
                                       <axsl:with-param name="lateFix_d3e5" tunnel="yes" select="$lateQuickFixName"/>
                                    </axsl:apply-templates>
                                 </oqf:fixes>
                              </axsl:template>
                              <xsl:if test="not(self::comment() | self::processing-instruction() | self::attribute())">
                                 <axsl:template mode="M1">
                                    <xsl:attribute name="match" select="concat($nodePath, '/node()')"/>
                                 </axsl:template>
                              </xsl:if>
                           </axsl:stylesheet>
                        </oqf:lateOperation>
                     </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                     <oqf:name>
                        <xsl:text>Remove all @required attribute</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                     <xsl:if test="true()">
 
<!--For each context node generate the delete operation.-->
                        <xsl:for-each select="//xsl:function/xsl:param/@required">
                           <xsl:sort select="position()" data-type="number" order="descending"/>
                           <xsl:choose>
                              <xsl:when test="self::attribute()">
                                 <xsl:variable name="context">
                                    <xsl:apply-templates select="parent::node()" mode="schematron-get-full-path"/>
                                 </xsl:variable>
                                 <oqf:setAttribute>
                                    <xsl:attribute name="oqf:name" select="node-name(current())"/>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                    <xsl:attribute name="oqf:delete" select="true()"/>
                                 </oqf:setAttribute>
                              </xsl:when>
                              <xsl:when test="self::text()">
                                 <xsl:variable name="context">
                                    <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                                 </xsl:variable>
                                 <oqf:changeText>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                 </oqf:changeText>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:variable name="context">
                                    <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                                 </xsl:variable>
                                 <oqf:delete>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                 </oqf:delete>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:for-each>
                     </xsl:if>
                     <xsl:text>
</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </oqf:fix>
         </xsl:if>
      </xsl:if>
      <xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M1"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="xsl:variable | xsl:param" priority="102" mode="M1">
      <!--Declare the unique quick fix ID variable -->
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="execLateFix_d3e5"
                 tunnel="yes"/>
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="userEntriesValues_d3e5"
                 tunnel="yes"/>
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="lateFix_d3e5"
                 tunnel="yes"/>
      <xsl:variable xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                    xmlns:oqf="http://www.oxygenxml.com/quickfix"
                    name="quickFixUuid"
                    select="concat(generate-id(), '_M', 1)"/>

		    <!--ASSERT warn-->
      <xsl:choose>
         <xsl:when xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                   test="@as"
                   sqf:fix="addAs"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                         xmlns:osf="http://www.oxygenxml.com/sch/functions"
                         xmlns:oxy="http://www.oxygenxml.com/schematron/validation">
               <xsl:text>Warning:</xsl:text>
               <xsl:text> It is recommended to add the @as attribute. </xsl:text>
               <xsl:text>
Source:#line=;column=</xsl:text>
               <xsl:text xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                         xmlns:oqf="http://www.oxygenxml.com/quickfix">
Fixes:</xsl:text>
               <xsl:value-of xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                             xmlns:oqf="http://www.oxygenxml.com/quickfix"
                             select="concat('addAs_', $quickFixUuid, ' ')"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>

      <!--QUICK FIXES -->
      <xsl:if xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
              xmlns:oqf="http://www.oxygenxml.com/quickfix"
              test="not($lateFix_d3e5) or ($lateFix_d3e5 = 'addAs')">
         <xsl:if test="true()             and (not(@as))">
            <xsl:text>
</xsl:text>
            <oqf:fix id="addAs_{$quickFixUuid}">
               <xsl:choose>
                  <xsl:when test="not($execLateFix_d3e5)">
                     <oqf:name>
                        <xsl:text>Add @as attribute</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                
                     <xsl:variable name="firstValidOp" select="( ./'add', 'noOperation')[1]"/>
                     <xsl:if test="$firstValidOp != 'noOperation'">
                        <oqf:lateOperation schemaSystemId="file:/E:/Demos/XML%20Prague%202016/Schematron%20QuickFix/SQFPresenration2016/Samples/xsl/xslChecks.sch_xslt_cascade">
                           <xsl:attribute name="role" select="$firstValidOp"/>
                           <xsl:attribute name="oqf:systemId"
                                          select="saxon:system-id()"
                                          use-when="function-available('saxon:system-id')"/>
                           <axsl:stylesheet version="3.0">
                              <axsl:import href="xslChecks-compiled.xsl"/>
                              <xsl:text>
</xsl:text>
                              <axsl:param name="userEntriesValues"/>
                              <axsl:param name="lateQuickFixName" required="yes"/>
                              <xsl:variable name="nodePath">
                                 <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                              </xsl:variable>
                              <axsl:template match="/">
                                 <oqf:fixes>
                                    <axsl:apply-templates mode="M1">
                                       <xsl:attribute name="select" select="$nodePath"/>
                                       <axsl:with-param name="execLateFix_d3e5" tunnel="yes" select="true()"/>
                                       <axsl:with-param name="userEntriesValues_d3e5"
                                                        tunnel="yes"
                                                        select="$userEntriesValues"/>
                                       <axsl:with-param name="lateFix_d3e5" tunnel="yes" select="$lateQuickFixName"/>
                                    </axsl:apply-templates>
                                 </oqf:fixes>
                              </axsl:template>
                              <xsl:if test="not(self::comment() | self::processing-instruction() | self::attribute())">
                                 <axsl:template mode="M1">
                                    <xsl:attribute name="match" select="concat($nodePath, '/node()')"/>
                                 </axsl:template>
                              </xsl:if>
                           </axsl:stylesheet>
                        </oqf:lateOperation>
                     </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                     <oqf:name>
                        <xsl:text>Add @as attribute</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                     <xsl:if test="true()">

<!--For each context node generate the add operation.-->
                        <xsl:for-each select=".">
                           <xsl:sort select="position()" data-type="number" order="descending"/>
                           <xsl:variable name="nodeType"><!--The current node type to be added.-->
                              <xsl:choose>
                                 <xsl:when test="false()">
                                    <xsl:choose>
                                       <xsl:when test="self::attribute()">attribute</xsl:when>
                                       <xsl:when test="self::comment()">comment</xsl:when>
                                       <xsl:when test="self::processing-instruction()">pi</xsl:when>
                                       <xsl:otherwise>element</xsl:otherwise>
                                    </xsl:choose>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:value-of select="'attribute'"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:variable>
                           <!--Context of the operation-->
                           <xsl:variable name="context">
                              <xsl:choose>
                                 <xsl:when test="self::attribute()">
                                    <xsl:apply-templates select="parent::node()" mode="schematron-get-full-path"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:variable>
                           <!--Insert the content depending on the node type.-->
                           <xsl:choose>
                              <xsl:when test="$nodeType = 'element'">
                                 <oqf:insertElement oqf:name="as">
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                 </oqf:insertElement>
                              </xsl:when>
                              <xsl:when test="$nodeType = 'attribute' or $nodeType = '@'">
                                 <oqf:setAttribute oqf:name="as">
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                 </oqf:setAttribute>
                              </xsl:when>
                              <xsl:when test="not($nodeType) or $nodeType = '' or $nodeType = 'comment' or $nodeType = 'pi' or $nodeType = 'processing-instruction'">
                                 <oqf:insertFragment>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                    <xsl:choose>
                                       <xsl:when test="$nodeType = 'comment'">
                                          <xsl:comment/>
                                       </xsl:when>
                                       <xsl:when test="$nodeType = 'processing-instruction' or $nodeType = 'pi'">
                                          <xsl:processing-instruction name="as"/>
                                       </xsl:when>
                                       <xsl:otherwise/>
                                    </xsl:choose>
                                 </oqf:insertFragment>
                              </xsl:when>
                           </xsl:choose>
                        </xsl:for-each>
                     </xsl:if>
                     <xsl:text>
</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </oqf:fix>
         </xsl:if>
      </xsl:if>
      <xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M1"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="xsl:function" priority="101" mode="M1">
      <!--Declare the unique quick fix ID variable -->
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="execLateFix_d3e5"
                 tunnel="yes"/>
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="userEntriesValues_d3e5"
                 tunnel="yes"/>
      <xsl:param xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:oqf="http://www.oxygenxml.com/quickfix"
                 name="lateFix_d3e5"
                 tunnel="yes"/>
      <xsl:variable xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                    xmlns:oqf="http://www.oxygenxml.com/quickfix"
                    name="quickFixUuid"
                    select="concat(generate-id(), '_M', 1)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                   test="preceding-sibling::xd:doc"
                   sqf:fix="addDoc"/>
         <xsl:otherwise>
            <xsl:message xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                         xmlns:osf="http://www.oxygenxml.com/sch/functions"
                         xmlns:oxy="http://www.oxygenxml.com/schematron/validation">
               <xsl:text> The function does not have documentation. </xsl:text>
               <xsl:text>
Source:#line=;column=</xsl:text>
               <xsl:text xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                         xmlns:oqf="http://www.oxygenxml.com/quickfix">
Fixes:</xsl:text>
               <xsl:value-of xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                             xmlns:oqf="http://www.oxygenxml.com/quickfix"
                             select="concat('addDoc_', $quickFixUuid, ' ')"/>
            </xsl:message>
         </xsl:otherwise>
      </xsl:choose>

      <!--QUICK FIXES -->
      <xsl:if xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
              xmlns:oqf="http://www.oxygenxml.com/quickfix"
              test="not($lateFix_d3e5) or ($lateFix_d3e5 = 'addDoc')">
         <xsl:if test="true()             and (not(preceding-sibling::xd:doc))">
            <xsl:text>
</xsl:text>
            <oqf:fix id="addDoc_{$quickFixUuid}">
               <xsl:choose>
                  <xsl:when test="not($execLateFix_d3e5)">
                     <oqf:name>
                        <xsl:text>Add documentation</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                
                     <xsl:variable name="firstValidOp" select="( ./'add', 'noOperation')[1]"/>
                     <xsl:if test="$firstValidOp != 'noOperation'">
                        <oqf:lateOperation schemaSystemId="file:/E:/Demos/XML%20Prague%202016/Schematron%20QuickFix/SQFPresenration2016/Samples/xsl/xslChecks.sch_xslt_cascade">
                           <xsl:attribute name="role" select="$firstValidOp"/>
                           <xsl:attribute name="oqf:systemId"
                                          select="saxon:system-id()"
                                          use-when="function-available('saxon:system-id')"/>
                           <axsl:stylesheet version="3.0">
                              <axsl:import href="xslChecks-compiled.xsl"/>
                              <xsl:text>
</xsl:text>
                              <axsl:param name="userEntriesValues"/>
                              <axsl:param name="lateQuickFixName" required="yes"/>
                              <xsl:variable name="nodePath">
                                 <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                              </xsl:variable>
                              <axsl:template match="/">
                                 <oqf:fixes>
                                    <axsl:apply-templates mode="M1">
                                       <xsl:attribute name="select" select="$nodePath"/>
                                       <axsl:with-param name="execLateFix_d3e5" tunnel="yes" select="true()"/>
                                       <axsl:with-param name="userEntriesValues_d3e5"
                                                        tunnel="yes"
                                                        select="$userEntriesValues"/>
                                       <axsl:with-param name="lateFix_d3e5" tunnel="yes" select="$lateQuickFixName"/>
                                    </axsl:apply-templates>
                                 </oqf:fixes>
                              </axsl:template>
                              <xsl:if test="not(self::comment() | self::processing-instruction() | self::attribute())">
                                 <axsl:template mode="M1">
                                    <xsl:attribute name="match" select="concat($nodePath, '/node()')"/>
                                 </axsl:template>
                              </xsl:if>
                           </axsl:stylesheet>
                        </oqf:lateOperation>
                     </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                     <oqf:name>
                        <xsl:text>Add documentation</xsl:text>
                     </oqf:name>
                     <oqf:description/>
                     <xsl:text>
</xsl:text>
                     <xsl:if test="true()">

<!--For each context node generate the add operation.-->
                        <xsl:for-each select=".">
                           <xsl:sort select="position()" data-type="number" order="descending"/>
                           <xsl:variable name="nodeType"><!--The current node type to be added.-->
                              <xsl:choose>
                                 <xsl:when test="false()">
                                    <xsl:choose>
                                       <xsl:when test="self::attribute()">attribute</xsl:when>
                                       <xsl:when test="self::comment()">comment</xsl:when>
                                       <xsl:when test="self::processing-instruction()">pi</xsl:when>
                                       <xsl:otherwise>element</xsl:otherwise>
                                    </xsl:choose>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:value-of select="''"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:variable>
                           <!--Context of the operation-->
                           <xsl:variable name="context">
                              <xsl:choose>
                                 <xsl:when test="self::attribute()">
                                    <xsl:apply-templates select="parent::node()" mode="schematron-get-full-path"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:apply-templates select="current()" mode="schematron-get-full-path"/>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:variable>
                           <!--Insert the content depending on the node type.-->
                           <xsl:choose>
                              <xsl:when test="$nodeType = 'element'">
                                 <oqf:insertElement oqf:name="">
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                    <xsl:attribute name="oqf:position" select="'before'"/>
                                    <xd:doc>
                                       <xd:desc>
                                          <xd:p/>
                                       </xd:desc>
                                       <xsl:for-each select="xsl:param">
                                          <xd:param>
                                             <xsl:attribute name="@name"/>
                                             <xd:p/>
                                          </xd:param>
                                       </xsl:for-each>
                                    </xd:doc>
                                 </oqf:insertElement>
                              </xsl:when>
                              <xsl:when test="$nodeType = 'attribute' or $nodeType = '@'">
                                 <oqf:setAttribute oqf:name="">
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                    <xd:doc>
                                       <xd:desc>
                                          <xd:p/>
                                       </xd:desc>
                                       <xsl:for-each select="xsl:param">
                                          <xd:param>
                                             <xsl:attribute name="@name"/>
                                             <xd:p/>
                                          </xd:param>
                                       </xsl:for-each>
                                    </xd:doc>
                                 </oqf:setAttribute>
                              </xsl:when>
                              <xsl:when test="not($nodeType) or $nodeType = '' or $nodeType = 'comment' or $nodeType = 'pi' or $nodeType = 'processing-instruction'">
                                 <oqf:insertFragment>
                                    <xsl:attribute name="oqf:context" select="$context"/>
                                    <xsl:attribute name="oqf:systemId"
                                                   select="saxon:system-id()"
                                                   use-when="function-available('saxon:system-id')"/>
                                    <xsl:attribute name="oqf:position" select="'before'"/>
                                    <xsl:choose>
                                       <xsl:when test="$nodeType = 'comment'">
                                          <xsl:comment>
                                             <xd:doc>
                                                <xd:desc>
                                                   <xd:p/>
                                                </xd:desc>
                                                <xsl:for-each select="xsl:param">
                                                   <xd:param>
                                                      <xsl:attribute name="@name"/>
                                                      <xd:p/>
                                                   </xd:param>
                                                </xsl:for-each>
                                             </xd:doc>
                                          </xsl:comment>
                                       </xsl:when>
                                       <xsl:when test="$nodeType = 'processing-instruction' or $nodeType = 'pi'">
                                          <xsl:processing-instruction name="">
                                             <xd:doc>
                                                <xd:desc>
                                                   <xd:p/>
                                                </xd:desc>
                                                <xsl:for-each select="xsl:param">
                                                   <xd:param>
                                                      <xsl:attribute name="@name"/>
                                                      <xd:p/>
                                                   </xd:param>
                                                </xsl:for-each>
                                             </xd:doc>
                                          </xsl:processing-instruction>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <xd:doc>
                                             <xd:desc>
                                                <xd:p/>
                                             </xd:desc>
                                             <xsl:for-each select="xsl:param">
                                                <xd:param>
                                                   <xsl:attribute name="@name"/>
                                                   <xd:p/>
                                                </xd:param>
                                             </xsl:for-each>
                                          </xd:doc>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </oqf:insertFragment>
                              </xsl:when>
                           </xsl:choose>
                        </xsl:for-each>
                     </xsl:if>
                     <xsl:text>
</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </oqf:fix>
         </xsl:if>
      </xsl:if>
      <xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M1"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M1"/>
   <xsl:template match="@*|node()" priority="-2" mode="M1">
      <xsl:choose><!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <xsl:when test="not(@*)">
            <xsl:apply-templates select="node()" mode="M1"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates select="@*|node()" mode="M1"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>

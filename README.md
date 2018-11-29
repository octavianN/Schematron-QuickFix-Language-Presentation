# Schematron QuickFix

Fixing XML validation errors can be challenging for many users, especially if they are not very familiar with the syntax and structure of XML. For many years, development tools have provided ways to allow users to select actions that automatically fix reported issues for certain programming languages (such as Java, C, etc.). This functionality is usually called "Quick Fixes". In a similar way, XML tools provide Quick Fixes for XML validation errors. For instance, Eclipse has included XML Quick Fixes for over 10 years. Another example of this idea is the spell checking functionality, which provides a list of possible corrections and allows the user to select one of them as a replacement for an incorrect word.

The validation of XML documents against DTD, XML Schema, or RELAX NG schema provides a limited set of possible problems and is usually only able to detect basic structural errors (such as a missing element or attribute) and the corresponding automatic fixes are usually rather straightforward. A more interesting case would be if you are using Schematron to identify issues in XML documents, as the fixes in this case may range from trivial to very complex and there is no automatic way of fixing them.

Schematron solves the limitation that other types of schema have when validating XML documents because it allows the schema author to define the errors and control the messages that are presented to the user. Thus the validation errors are more accessible to users and it ensures that they understand the problem. These messages may also include hints for what the user can do to fix the problem, but this creates a gap because the user still needs to manually correct the issue. This could cause people to waste valuable time and creates the possibility of making additional errors while trying to manually fix the reported problem. Providing a Quick Fix functionality for Schematron validation errors will bridge this gap, saving time and avoiding the potential for causing other issues.

Two years ago, the idea of Schematron QuickFix (SQF) was discussed during the XML Prague conference and it started to take shape. It has now reached a point where we have a draft specification available, a W3C community group dedicated to XML Quick Fixes, and two independent SQF implementations. The first draft of the Schematron QuickFix specification was published in April 2015 and it is now available on 
[GitHub](http://schematron-quickfix.github.io/sqf) and within the 
[W3C Community Group](https://www.w3.org/community/quickfix/) "Quick-Fix Support for XML".

Schematron QuickFix defines a simple language to specify the actions that are used to fix the detected issues, layered on top of XPath and XSLT, and integrated within Schematron schemas through the Schematron annotation support.

In this session, we will present various use cases that are solved with Schematron QuickFixes, ranging from simple to complex, sometimes involving changes in multiple locations within a document, or even in external documents. We will also discuss the language and challenges related to the SQF implementation. Join us to learn how SQF can be useful in your next XML project!

Schematron QuickFix - XML Prague Presentation

[![Schematron QuickFix – a simple language to specify the actions that will be used to fix the Schematron detected issues](https://img.youtube.com/vi/RLMc0B0di5s/1.jpg "Schematron QuickFix - XML Prague Presentation")](https://www.youtube.com/watch?v=RLMc0B0di5s)

Octavian Nadolu - oXygen XML Editor
octavian_nadolu@oxygenxml.com

Nico Kutscherauer - data2type GmbH
kutscherauer@schematron-quickfix.com

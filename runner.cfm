﻿<cfsetting showDebugOutput="false">
<!--- Executes all tests in the 'specs' folder with simple reporter by default --->
<cfparam name="url.reporter" 		default="simple">
<cfparam name="url.directory" 		default="test.specs">
<cfparam name="url.recurse" 		default="true" type="boolean">
<cfparam name="url.bundles" 		default="">
<cfparam name="url.labels" 			default="">
<cfparam name="url.reportpath" 		default="#expandPath( "/test/results" )#">
<cfparam name="url.propertiesFilename" 	default="TEST.properties">
<cfparam name="url.propertiesSummary" 	default="false" type="boolean">

<!--- Include the TestBox HTML Runner --->
<cfinclude template="/testbox/system/testing/runners/HTMLRunner.cfm" >
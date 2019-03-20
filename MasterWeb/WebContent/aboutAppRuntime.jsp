<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.master.constant.ConstantSystem"%>
<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.master.util.MasterCacheUtil"%>
<%@page import="com.eaf.core.EAFVersion"%>
<%@ taglib uri="/WEB-INF/tld/JStartTagLib.tld" prefix="taglib"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">

<% 	request.setAttribute("_now", MasterCacheUtil.time);  %>
<link href="javascript/bootstrap/css/bootstrap.min.css?v=${ _now }" rel="stylesheet" />
<link href="javascript/bootstrap/font-awesome/css/font-awesome.min.css?v=${ _now }" rel="stylesheet" />

<link rel="stylesheet" href="theme/aboutAppRuntime.css"/>

<script type="text/javascript" src="javascript/3_3_30/jquery-ui-1.10.4.custom.20170416.min.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/bootstrap/js/bootstrap.min.js?v=${ _now }"></script>

</HEAD>

<BODY>
<%  String version = EAFVersion.VERSION;
	String buildID = EAFVersion.BUILD_ID;
%>
	<div class="wrapper">
		<section class="content-header"></section>
	
        <!-- Main content -->
    	<section class="content">
    	<div class="center-aboutAR">
    		<div class="aboutPanel">
    			<div><img class="img-center" style="width: 100px;" src="images/appdesigner.png"></div>
    			<div  class="headerAbout">App Runtime</div> 
    			<hr style="border-top: 1px solid #8c8b8b;">  				
    			<div class="contendAbout">
    				<div>
    					<span   class="col-sm-6">Version</span >
    					<span   class="col-sm-6"><%=version%>(<%=buildID %>)</span >
    				</div>
	    		</div> 
	    		<hr style="border-bottom: 1px solid #8c8b8b;">  	
    		</div>
    	</div>
    	<div class="center-aboutAR" style="height: 100%;">
	    	<div style="text-align: center;width: 100%;bottom: 0px;position: absolute;" >
	    		<span  style="margin-bottom: 20px;" class="col-sm-12 "><i class="fa fa-copyright" aria-hidden="true"></i> 2015 Avalant Co.,Ltd.</span >
	    	</div>
    	</div>
		</section>
	</div>
	
</BODY>
</html>

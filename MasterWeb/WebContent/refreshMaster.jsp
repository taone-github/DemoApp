
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="com.master.constant.ConstantSystem"%>
<%@page import="com.master.util.MasterConstant"%>
<html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="theme/Master.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="screen_template/frame/scripts/bootstrap/css/bootstrap.min.css"/>
<link rel="stylesheet" href="screen_template/frame/scripts/font-awesome/css/font-awesome.min.css"/>

<link rel="stylesheet" href="theme/refreshMaster.css"/>

<script type="text/javascript" src="screen_template/frame/scripts/jquery-2.1.4.js"></script>
<script type="text/javascript" src="screen_template/frame/scripts/bootstrap/js/bootstrap.min.js"></script>

</HEAD>

<BODY>

	<div class="wrapper">
<%
	try {
		com.master.util.MasterCacheUtil.getInstance().removeCache();
		ConstantSystem constantSystem = new ConstantSystem(ConstantSystem.SYSTEM_EAF, MasterConstant.EAF_MASTER_NAME);
		
		com.avalant.feature.ExtendFeature.getInstance().refreshFeature();
		System.out.println("Refresh Success!!!!");
%>
	<!-- Refresh Success!!!! -->
	<img class="img-center" alt="Refresh Success!!!!" src="images/refreshpage.svg">
	
<% 
	} catch (Exception e) {
		System.out.println("Refresh Error!!!!");
%>
	Refresh Error!!!!	
<% 
	}
%>
	</div>
	
</BODY>
</html>




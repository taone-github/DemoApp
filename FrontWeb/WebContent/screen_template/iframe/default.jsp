
<%@ taglib uri="/WEB-INF/JStartTagLib.tld" prefix="taglib"%>
<%@ page import="com.front.j2ee.pattern.control.*"%>
<%@ page import="com.oneweb.j2ee.system.LoadXML"%>
<jsp:useBean id="screenFlowManager" class="com.front.j2ee.pattern.control.FrontScreenFlowManager" scope="session" />
<%ScreenDefinition sd = (ScreenDefinition) LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getScreenDefinitionMap().get(screenFlowManager.getCurrentScreen());%>
<%@page import="com.front.constant.FrontMenuConstant"%>
<%@page import="com.oneweb.j2ee.pattern.control.ScreenDefinition"%>
<html>
<head>
<title><%=sd.getHtmlTitle()%></title>

</head>
<div><%@ include file="header.jsp" %></div>
<div><%@ include file="topNav.jsp" %></div>
<iframe frameborder="0" height="100%" width="100%" marginheight="0" marginwidth="0" scrolling="auto" name="mainframe" src="screen_template/iframe/main.jsp"></iframe>
</html>

<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.oneweb.j2ee.pattern.control.ScreenDefinition" %>
<%@page import="com.master.util.MasterConstant"%>
<jsp:useBean id="screenFlowManager" class="com.oneweb.j2ee.pattern.control.ScreenFlowManager" scope="session"/>
<%
	ScreenDefinition sd = (ScreenDefinition) LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getScreenDefinitionMap().get(screenFlowManager.getCurrentScreen());

	pageContext.getRequest().setAttribute("HtmlTitle", sd.getHtmlTitle());
	pageContext.getRequest().setAttribute("TopNav", sd.getTopNav());
	pageContext.getRequest().setAttribute("SubHeader", sd.getSubHeader());
	pageContext.getRequest().setAttribute("TopMenu", sd.getTopMenu());
	pageContext.getRequest().setAttribute("LeftNav", sd.getLeftNav());
	pageContext.getRequest().setAttribute("RightNav", sd.getRightNav());
	pageContext.getRequest().setAttribute("BottomNav", sd.getBottomNav());
	pageContext.getRequest().setAttribute("HtmlBody", sd.getHtmlBody());	
	pageContext.getRequest().setAttribute("CopyRight", sd.getCopyRight());
	
%>

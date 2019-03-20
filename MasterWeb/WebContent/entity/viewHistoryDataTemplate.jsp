<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	System.out.println("entitySession JSP ====> "+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(entitySession);
	String themeCode = form.getEntityM().getThemeCode();	
%>	
<jsp:include flush="true" page="../theme/theme.jsp">
<jsp:param name="themeCode" value="<%=themeCode%>"/>
</jsp:include> 
		
<%
	String templateCode = form.getEntityM().getTemplateCode();
	String viewHistoryDataJSP = templateCode + "/viewHistoryData.jsp";
	System.out.println("templateCode ====> "+templateCode);
	if (!"".equalsIgnoreCase(templateCode) && null != templateCode) {		
%>
		<jsp:include flush="true" page="<%=viewHistoryDataJSP %>"/>
<%
	} else {
%>
		<jsp:include flush="true" page="002/viewHistoryData.jsp"/>
<%
	}
%>

<%/*-- start include eventScript that contain the javascript function --*/%>
		<jsp:include flush="true" page="viewHistoryDataTemplateEventScript.jsp"/>
<%/*-- end include eventScript that contain the javascript function --*/%>

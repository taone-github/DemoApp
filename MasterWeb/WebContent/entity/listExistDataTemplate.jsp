<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	System.out.println("entitySession==>"+entitySession);
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

<form name ="masterForm">	
<div id = "moduleContainer" >

<%
	String templateCode = form.getEntityM().getTemplateCode();	
	String listExistDataJSP = templateCode + "/listExistData.jsp";
	
	if (!"".equalsIgnoreCase(templateCode) && null != templateCode) {		
%>
		<jsp:include flush="true" page="<%=listExistDataJSP %>"/>
<%
	}else {
%>
		<jsp:include flush="true" page="002/listExistData.jsp"/>
<%
	}
%>
</div> 
</form>

<%/* include eventScript that contain the javascript function */%>
<%/* reused by template01.jsp, template02.jsp */%>
<jsp:include flush="true" page="listExistDataTemplateEventScript.jsp"/>

<%// Decorate Elements %>
<div id="_messageBlock"
	 style="display: none; position: absolute; left: 50%; top: 50%; z-index: 256; color: #c0c0c0;">
	<div id="_messageBlock_background"
		 style="position: absolute; background: #ffffff; opacity: 0.67; filter: alpha(opacity=67);"></div>
	<div id="_messageBlock_message"
		 style="position: relative; z-index: 257; border: 1px solid #000000; padding: 0.5em 2em; font-size: 2em;"></div>
</div>

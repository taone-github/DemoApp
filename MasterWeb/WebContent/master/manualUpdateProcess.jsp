<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	if (MasterForm == null) {
		MasterForm = new MasterFormHandler();
		request.getSession().setAttribute(moduleSession,MasterForm);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");	
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(moduleSession);
	
	String filePath = (String)request.getParameter("filePath");
	System.out.println("filePath ==>"+filePath);
	
	String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
	String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
	System.out.println("manualContextPath -> " + manualContextPath);
	System.out.println("manualUrlPath -> " + manualUrlPath);
	
	pageContext.setAttribute("manualContextPath", manualContextPath);
	pageContext.setAttribute("manualUrlPath", manualUrlPath);
%>
<form name = "masterForm" action="FrontController" method="post">
	<input type ="hidden" name = "action" value="">
	<input type ="hidden" name = "handleForm" value = "">
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<%if (MasterForm.hasErrors()) { %>
		<tr>
			<td>
<%
	Vector v = MasterForm.getFormErrors();
	for (int i = 0; i < v.size(); i++) {
		out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(i) + "</span><br>");
	}
%>
			</td>
		</tr>
<%} %>
		<tr>
			<td>
				<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>
			</td>
		</tr>
	</table>
</form>
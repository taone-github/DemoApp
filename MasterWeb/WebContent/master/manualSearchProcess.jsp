<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.master.form.MasterFormHandler" %>
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
<form name ="masterForm" action="FrontController" >
<input type ="hidden" name = "action" value="searchMaster">
<input type ="hidden" name = "handleForm" value = "Y">
<table width=100% boder="0" cellpadding="0" cellspacing="0" align="center">
<tr>
<TD align ="center">

<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>

</TD>
</tr>
<tr>
<td align ="center">
	<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
	<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
	<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_SEARCH%>"/>
	</jsp:include>
</td>
</tr>

<tr>
<td align="center">
		<jsp:include flush="true" page="002/resultSearch.jsp"/>
</td>
</tr>
</table>

</form>
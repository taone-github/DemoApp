<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.avalant.display.many.ModuleManyFilter" %>
<!-- Start insertFieldMany.jsp -->

<%	
	String module = (String)request.getSession().getAttribute("module");
%>
<div id="filterMany<%=module%>">
<%
	System.out.println("Start filterMany.jsp");
%>
<%=ModuleManyFilter.getInstance().generateFieldForInsert(request)%>
</div>
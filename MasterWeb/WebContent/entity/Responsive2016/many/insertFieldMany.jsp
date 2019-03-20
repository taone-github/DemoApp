<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.avalant.display.many.ModuleManyInsertField" %>
<!-- Start insertFieldMany.jsp -->

<%	
	String module = (String)request.getSession().getAttribute("module");
%>
<div id="insertManyInline<%=module%>">
<%
	System.out.println("Start insertFieldMany.jsp");
%>
<%=ModuleManyInsertField.getInstance().generateFieldForInsert(request)%>
</div>

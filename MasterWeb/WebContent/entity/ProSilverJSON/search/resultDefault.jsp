<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%  
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
%>
<script>
<% com.avalant.display.SearchDisplayJSON mod = new com.avalant.display.SearchDisplayJSON();
	String result = mod.getSearchResultJSON(request); 
%>
$(document).ready(function() {
	var jsonData = <%=result%>;
	resultSearchJSON(jsonData,'<%=form.getMainModuleID()%>','<%=entityID%>');
});
</script>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.ModuleOneDisplay" %>
<%
	ModuleOneDisplay mdoDis = new ModuleOneDisplay(request);
%>
<%if(!mdoDis.isGrid()){ %>
<div class="boxboldbelow">
</div>
<%} %>

<%if(false){ %>
<div id="buttonCriteria">
<table align="center" height="0%" width="90%"  cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td align="right" width="80%">&nbsp;</td>
		<td align="right">
			<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
				<jsp:param name="module" value="<%=mdoDis.getModule()%>"/>
				<jsp:param name="action" value="ENTITY_MODULE"/>
			</jsp:include>
		</td>
	</tr>
</table>
</div>
<%} %>
<style type="text/css">
<%=mdoDis.getCustomStyle()%>
</style>
<script>

<% com.avalant.display.ModuleOneDisplayJSON mod = new com.avalant.display.ModuleOneDisplayJSON(request); %>
$(document).ready(function() {
	var jsonData = <%=mod.oneModuleFieldJSON()%>;
	moduleOne(jsonData,'<%=mdoDis.getModule()%>',<%=mdoDis.isGrid()%>);
});

</script>
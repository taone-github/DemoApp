<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.ModuleOneDisplay" %>
<%
	ModuleOneDisplay mdoDis = new ModuleOneDisplay(request);

%>
<%if(!mdoDis.isGrid()){ %>
<div class="boxboldbelow">
<%}%>
<%=mdoDis.oneModuleFieldHTML()%>
<%if(!mdoDis.isGrid()){ %>
</div>
<%} %>

<%if(!mdoDis.isGrid()){ %>
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
<style>
<%=mdoDis.getCustomStyle()%>
</style>
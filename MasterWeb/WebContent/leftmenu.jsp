
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.model.ProcessMenuM" %>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
<TBODY valign="top">
		<TR>
		<td><ul class="subMenu">
<%Vector vMenus = (Vector)request.getSession().getAttribute("ProcessMenus");
for(int i=0;i<vMenus.size();i++) {
		ProcessMenuM processMenuM = (ProcessMenuM)vMenus.get(i);
%>	<li id="<%=i%>_shh"><a href = ".<%=processMenuM.getActionMapping()%>"><img src='images/CreateContacts.gif' width='16' height='16' alt='Create Contact'  border='0' align='absmiddle'>&nbsp;<%=processMenuM.getDescription() %></a></li>
<%}%>		</ul></td>
		</TR>
	</TBODY>
</TABLE>
	
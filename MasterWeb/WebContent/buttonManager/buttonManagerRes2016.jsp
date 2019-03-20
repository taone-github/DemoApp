<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import= "com.master.button.DisplayButton"%>

<%
String module = (String)request.getParameter("module"); 
String action = (String)request.getParameter("action"); 
String role = (String)request.getParameter("role");
String align = (String)request.getParameter("align");  
if(null == align || "".equalsIgnoreCase(align)){
align = "right";
}

//System.out.println("JSP Module >>>>>>>>>>>>>>>"+module);
//System.out.println("JSP Action >>>>>>>>>>>>>>>"+action);
//System.out.println("JSP Role >>>>>>>>>>>>>>>"+role);
%>
<table class="entityButton" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td align = "<%=align%>">
			<%if ((null != role) && (!("").equals(role))) { %>
				<%=DisplayButton.displayResponsiveButton(module,action,role, request)%> 
			<%}else{%>
				<%=DisplayButton.displayResponsiveButton(request,module,action)%>
			<%}%>			
		</td>
	</tr>
</table>


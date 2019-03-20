<% 
if (session.getAttribute("hasActionError")!=null) {
	if(((Boolean)session.getAttribute("hasActionError")).booleanValue()) {
			String errMsg = (String)session.getAttribute("actionErrorMessage"); 
			//out.print("*&nbsp;"+errMsg+"<br>");
			out.print("<div class='alert bg-danger'>"+errMsg+"</div>");
	}
}
%>

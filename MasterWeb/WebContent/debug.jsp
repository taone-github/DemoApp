<%@page import="com.avalant.feature.v2.FT024_AccessControl"%>
<%
String aclDebug = request.getParameter("aclDebug");
if(aclDebug != null) {
	if("Y".equals(aclDebug)) {
		FT024_AccessControl.printLogDebug = true;
	} else {
		FT024_AccessControl.printLogDebug = false;
	}
}
%>
Success.
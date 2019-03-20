<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY>
<% System.out.println("Logout**************************"); %>
<form method="post" action="ibm_security_logout" name="logoutForm">
<input type="image" width="0" height="0" border="0" src="images/blank.gif" />
<input type="hidden" name="logoutExitPage" value="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/logoutMaster.jsp<%=(request.getSession().getAttribute("err")!=null)?"?err="+request.getSession().getAttribute("err"):"" %>">
</form>
<script language="JavaScript" type="text/JavaScript">
	document.logoutForm.submit();
</script>
</BODY>
</HTML>

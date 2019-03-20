<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY>

<form method="post" action="ibm_security_logout" name="logoutForm">
<input type="image" width="0" height="0" border="0" src="images/blank.gif" />
<input type="hidden" name="logoutExitPage" value="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/login_screen.jsp<%=(request.getSession().getAttribute("err")!=null)?"?err="+request.getSession().getAttribute("err"):"" %>">
</form>
<script language="javascript" src="/MasterWeb/javascript/custom_framework/jquery-1.3.2.js"></script>
<script language="JavaScript" type="text/JavaScript">		
	clearAllSession();
	parent.location.href="logout.jsp";
	function clearAllSession(){
	var result = "";
	var uri = "/MasterWeb/ManualServlet?className=manual.ktaxa.srt.manualclass.SessionUtilServlet";	
	var dataString = "mode=CLEAR";
	jQuery.ajax( {
		type :"POST",
		url :uri,
		data :dataString,
		async :false,// wait ultil complete
		success : function(data) {
			result = data;
		}
	});
	return result;
}
</script>
</BODY>
</HTML>

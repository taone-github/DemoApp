<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<html>
<head>
<link href="CSS/stylesheet.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="javascript/jquery-1.8.2.js"></script>
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<script language="javascript" type="text/javascript">

/* start detect closing browser */
window.onunload = closeApp;
function closeApp(){
	var iX = window.document.body.offsetWidth + window.event.clientX;
	var iY = window.event.clientY;
	if (iX <= 30 && iY < 0 ){
		window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
		}else{
		window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
	}
}
/* end detect closing browser */

// function logOut() {
// 	top.logOut();
// }
function home(){
	top.document.getElementById("middleframeset").cols="180,*"
	top.document.getElementById("leftframeset").rows = "0,*";
	//parent.top.mainframe.document.location.href = "http://admin05:8080/FrontWeb/screen_template/frame/main.jsp";
	parent.top.mainframe.document.location.href = "<%=hostPrefix%>/FrontWeb/screen_template/frame/main.jsp";
}
function open1() {
	top.document.getElementById("middleframeset").cols="0,*"
	top.document.getElementById("leftframeset").rows = "0,*";
	//parent.top.mainframe.document.location.href = "http://admin05:8080/MasterWeb/manual/jsp/crmTab/collaboration.jsp";
	parent.top.mainframe.document.location.href = "http://localhost:8080/MasterWeb/manual/jsp/crmTab/collaboration.jsp";
}
function open2() {
	w = window.open('http://192.168.0.217:8080/');
}

function open3() {
	w = window.open('http://192.168.0.54:8080/pentaho/');
}
</script>

<%@ include file="scripts/swapFrame.jsp" %>

</head>
<body background="" topmargin="0" leftmargin="0">
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 
<!-- start header zone-->
<div id="header">
<div class="logopadding" style="padding-left: 21px;"><img
					border="0" src="images/AssetLogo.png" width="124"
					height="28"></div>
<!-- star topright menu bar-->
<div class="barloginpadding">
  		<div class="barlogin">
				<div class="iconheader" style="padding-top: 5px;"><img src="images/User.png" /></div>
				<div class="nametext">Welcome : [ <b><%=request.getSession().getAttribute("userName") %> </b>]</div>
				<div class="iconheader" onclick="toggleDesignTab();"><img src="images/design.png" /></div>
				<div class="nametext" onclick="toggleDesignTab();">Design</div>
				<div class="iconheader" style="padding-top: 5px;"><img src="images/setting.png" /></div>
				<div class="nametext" onclick="toggleWorklist();">WorkList</div>
				<div class="iconheader" onclick="logOut();" style="padding-top: 5px;"><img src="images/logout.png" /></div>
				<div class="nametext2" onclick="logOut();">Logout</div>
  		</div>
</div>
</div><!-- end topright menu bar-->
</body>
</html>
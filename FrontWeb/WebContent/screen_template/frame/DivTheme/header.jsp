<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<html>
<head>
<link href="CSS/stylesheet.css" rel="stylesheet" type="text/css" />
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<script language="javascript" type="text/javascript">

	/* start detect closing browser */
	window.onunload = closeApp;
	function closeApp(){
		var iX = window.document.body.offsetWidth + window.event.clientX;
		var iY = window.event.clientY;
//		alert(''
//			+ '\nwindow.document.body.offsetWidth :'+ window.document.body.offsetWidth
//			+ '\nwindow.event.clientX :'+ window.event.clientX
//			+ '\nwindow.event.clientY :'+ window.event.clientY
//			+ '\niX :'+ iX
//			+ '\niY :'+ iY);
	
		if (iX <= 30 && iY < 0 ){
			window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
			//window.open("<%//=request.getContextPath()%>/CloseApplicationServlet","mywindowc",'width=1,height=1,left=2000,top=2000',status=1,toolbar=1);
		}else{
			window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
		}
	}
	/* end detect closing browser */

	function logOut() {
		top.logOut();
	}
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

</head>
<body background="" topmargin="0" leftmargin="0">
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 
<!-- start header zone-->
<div id="header">
<div class="logopadding" style="padding-left: 21px;"><div class="logoonhead"></div></div>
<!-- star topright menu bar-->
<div class="barloginpadding">
  		<div class="barlogin">
				<div class="profileborder"><img src="images/picprofile.jpg" /></div>
				<div class="nametext">Administrator</div>
				<div class="iconheader"><img src="images/setting.png" /></div>
				<div class="nametext">Setting</div>
				<div class="iconheader"><img src="images/logout.png" /></div>
				<div class="nametext2">Logout</div>
  		</div>
</div>
</div><!-- end topright menu bar-->
</body>
</html>
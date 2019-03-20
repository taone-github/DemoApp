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

<form method="POST" action="http://192.168.0.209:10038/wps/portal/2cportal/!ut/p/c1/04_SB8K8xLLM9MSSzPy8xBz9CP0os3iXEBPzICMzIwN_I1dLA6MwPycLZ4NAQ38DU_1wkA6cKtydzCHyBjiAo4G-n0d-bqp-QXZ2mqOjoiIA51jDlw!!/dl2/d1/L0lDUWtpQ1NTUW9LVVFBISEvb0lvZ0FFQ1FRREdJUXBURE9DNEpuQSEhL1lBeEpKNDUwLTRrc3V5bHcvN19EVDQ3UjI2MjBPMkU5MDJWTkI4QzBRMU9HMi93cHMucG9ydGxldHMubG9naW4!/" name="LoginForm" target="_blank">
<input type="hidden" name="wps.portlets.userid" value="wpsadmin">
<input type="hidden" name="password" value="password">
</form>
<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="list">
	<tbody>
	<tr>
    <td class="headerheight">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
	        	<td class="headerheightspace1">
	        	<img src="images/logo.png" width="144" height="40" /></td>
	        	<td class="headerheightspace2">&nbsp;</td>
	        	<td>
	        	<table>
	        	<tr>
	        	<td>
	        	<a href="#" class="headermenu1">Operation</a>
	        	</td>
	        	<td>
	        	<a href="#" class="headermenu1">Dashboard</a>
	        	</td>
	        	<td>
	        	<a href="#" class="headermenu1">Report&nbsp; <img src="images/arrow1.png" width="8" height="8" /></a>
	        	</td>
	        	</tr>
	        	</table>
	        	</td>
	        	<td class="headerheightspace3">
		        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			          	<tr>
			            <td class="headerheightspace5"><img src="images/picprofile1.jpg" width="30" height="30" /></td>
			            <td class="headerheightspace2">&nbsp;</td>
			            <td class="headertextprofile1">Administrator<br />
			              <a href="#" class="headermenu2">Edit profile </a><span class="headertextprofile2">|</span><a href="javascript:logOut()" class="headermenu3"> Sign Out </a></td>
			          	</tr>
		        	</table>
	        	</td>
	        	<td class="headerheightspace2">&nbsp;</td>
      		</tr>
    </table></td>
  </tr>
</tbody>
</table>
</body>
</html>
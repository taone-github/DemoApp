<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<html>
<head>
<link href="include/css/styles.css" type="text/css" rel="stylesheet" />

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
			<td colspan="5"><img height="1" width="100%" alt="" src="images/c.gif" /></td>
		</tr>
		<tr>
			<td  colspan="4" valign="top" width="80%" ><img  src="images/logo.gif" alt="" /></td>
			<td valign="middle" align="right" >
			<table width="40%" cellspacing="0" cellpadding="1" border="0" class="text">
				<tbody>
					<tr>
						<td valign="bottom" align="right" class="textTop"><nobr>wasadmin</nobr></td>
						<%/*<td width="25" rowspan="2"><img hspace="3" height="25" width="25" align="middle" src="images/login_icon.gif" alt="" /></td>*/%>
					</tr>
					<tr>
						<td valign="top" align="right" class="textTop"><nobr><%=SimpleDateFormat.getDateInstance(SimpleDateFormat.FULL,Locale.US).format(new Date())%></nobr></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>
<div id="subHeader">
	<table width="100%" cellspacing="0" cellpadding="0" border="0" <%//background="images/bg_submain.gif"%> align="center" class="list">
		<tbody>
			<tr height="18px">
				<td width="80%" valign="top">
					<div class="topmenu">
				<a href="javascript:home();">Home</a>
					</div>
					<div class="topmenu iconSep">
						<img src="images/iconsep.gif" alt="" />
					</div>
					<div class="topmenu">
						<a href="javascript:open1();">Collaboration</a>
					</div>
					<div class="topmenu iconSep">
						<img src="images/iconsep.gif" alt="" />
					</div>
					<div class="topmenu">
						<a href="javascript:open2();">Knowledge</a>
					</div>
					<div class="topmenu iconSep">
						<img src="images/iconsep.gif" alt="" />
					</div>
					<div class="topmenu">
						<a href="javascript:void(0);">Customer</a>
					</div>
					<div class="topmenu iconSep">
						<img src="images/iconsep.gif" alt="" />
					</div>
					<div class="topmenu">
						<a href="javascript:open3();">Analytics</a>
					</div>
					<div class="topmenu iconSep">
						<img src="images/iconsep.gif" alt="" />
					</div>
				</td>
				
				<td width="20%" valign="top" align="right">
					<table width="25%" cellspacing="0" cellpadding="0" border="0" >
						<tbody>
							<tr>
								<td valign="middle" align="center">
									<div class="topmenu iconSep">
										<img src="images/iconsep.gif" alt="" />
									</div>
								</td>
								<td valign="middle" align="center">
									<a href="javascript:void(0);">
										<img border="0" alt="Home" src="images/home1.gif" />
									</a>
								</td>
								<td valign="middle" align="center">
									<a href="javascript:logOut()">
										<img border="0" alt="Log Out" src="images/logout3.jpg" />
									</a>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>

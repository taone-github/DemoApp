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


//Sam add App Designer Tab
function hideDesignTab() {
	//top.document.getElementById("middleframeset").cols="0,0,*";
	animateFadeHide(79,0);
}

function showDesignTab() {
	//top.document.getElementById("middleframeset").cols="79,*,0";
	animateFadeShow(0,0);
}

var designopen = true;
function toggleDesignTab() {
	refreshCache();
	var oldCols = top.document.getElementById("middleframeset").cols;
	//if (designopen) {
	if(oldCols != "0,0,*"){
		hideDesignTab();
		designopen=false;
	} else {
		showDesignTab();
		designopen=true;
	}
}
function animateFadeHide(leftF,rightF){
if(leftF>0){
  	leftF = leftF-10;
  }else{
  	leftF = 0;
  }
  rightF = rightF + 150;
  var colF = leftF+",*,"+rightF;
  //alert(colF);
  if(rightF > 1100){
  	colF = "0,0,*";
  	top.document.getElementById("middleframeset").cols=colF;	
  }else{
  	top.document.getElementById("middleframeset").cols=colF;
  	setTimeout("animateFadeHide("+leftF+","+rightF+")", 60);
  }
}


function animateFadeShow(leftF,centF){
  if(leftF<97){
  	leftF = leftF+10;
  }else{
  	leftF = 96;
  }
  centF = centF + 150;
  var colF = leftF+","+centF+",*";
  //alert(colF);
  if(centF > 1100){
  	colF = "96,*,0";
  	top.document.getElementById("middleframeset").cols=colF;	
  }else{
  	top.document.getElementById("middleframeset").cols=colF;
  	setTimeout("animateFadeShow("+leftF+","+centF+")", 60);
  }
}

function refreshCache(){
	var uri = "/MasterWeb/refreshMaster.jsp?1=1";
	jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: "",
		   async:   false, 		   
		   success: function(data){
		   }
		});
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
				<div class="nametext2"><%=request.getSession().getAttribute("userNameForAd") %><br><%=request.getSession().getAttribute("roleNameFromAD") %></div>
				<div class="iconheader" onclick="toggleDesignTab();"><img src="images/design.png" /></div>
				<div class="nametext" onclick="toggleDesignTab();">Design</div>
				<div class="iconheader"><img src="images/setting.png" /></div>
				<div class="nametext">Setting</div>
				<div class="iconheader" onclick="logOut();"><img src="images/logout.png" /></div>
				<div class="nametext" onclick="logOut();">Logout</div>
  		</div>
</div>
</div><!-- end topright menu bar-->
</body>
</html>
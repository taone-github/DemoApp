<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<html>
<head>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" /> -->
<!-- <link href="../scripts/bootstrap/css/bootstrap.min.css" rel="stylesheet" /> -->
<link href="screen_template/frame/ERP/CSS/stylesheet.css" rel="stylesheet" type="text/css" />

<!-- <script type="text/javascript" src="javascript/jquery-2.1.4.js"></script> -->
<!-- <script type="text/javascript" src="../scripts/bootstrap/js/bootstrap.min.js"></script>  -->
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<script type="text/javascript">
	
	//function closeApp() {
<%-- 	window.open("<%=request.getContextPath()%>/logout.jsp","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1"); --%>
<%-- 	window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1"); --%>
	//}
	/* end detect closing browser */
	//window.onunload = window.onbeforeunload = closeApp;
	/* Logout on close */
	$(document).ready(function(){
//             $(window).bind('beforeunload', function(){
//             	closeApp();	
//             });
        	window.onunload = window.onbeforeunload = function() {
			    jQuery.ajax({
			        url: '<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true',
			        async: false
			    });
			};    
     });
	
	
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
	
	function switchLocale(val){
		var dataString = "locale="+val;
		$.ajax({
		   type: "POST",
		   url: "<%=hostPrefix%>/MasterWeb/ManualServlet?className=com.avalant.feature.SwitchLanguage",
		   data: dataString,
		   async:   false,
		   success: function(data){
			top.mainframe.location.reload();
		   }
		});
	}
	var isThai = true;
	function switchLang(){
		if(isThai){
			isThai = false;
			$('.language').html('EN');
			switchLocale('en_US');
		}else{
			isThai = true;
			$('.language').html('TH');
			switchLocale('th_TH');
		}
	}
</script>
<jsp:include page="scripts/swapFrame.jsp" flush="true"></jsp:include>
</head>
<!-- <body background="" topmargin="0" leftmargin="0" onload="toggleDesignTab()" > -->
<body background="" topmargin="0" leftmargin="0">
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" id="sessiontimeout" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 
<!-- start header zone-->
<nav class="navbar navbar-default navbar-static-top" role="navigation">
  <div class="container-fluid" id="header">
	  <div class="navbar-header">
		  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#ps1-navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
		  </button>
	      <a class="navbar-brand logopadding" href="#"><!-- <div class="logoonhead"></div> --></a>
      </div>
<!-- <div id="header"> -->
<!-- <div class="logopadding" ><div class="logoonhead"></div></div> -->
<!-- star topright menu bar-->

	<div class="collapse navbar-collapse" id="ps1-navbar-collapse"><!--class = barloginpadding barlogin  -->
		<ul class="nav navbar-nav navbar-right barloginpadding barlogin">
	        <li class="nav-item"><div class="nav-link nametext2">Welcome : [ <b><%=request.getSession().getAttribute("userName") %> </b>] <span class="sr-only">(current)</span></div></li>
<!-- 	        <li class="nav-item"><div class="nav-link hidden_me" onclick="toggleDesignTab();"><img src="images/design.png" />Design</div></li> -->
<!-- 	        <li class="nav-item"><div class="nav-link" onclick="toggleWorklist();"><img src="images/setting.png" />WorkList</div></li> -->
            <li class="nav-item"><div class="nav-link nametext2" onclick="logOut();"><img src="screen_template/frame/ERP/images/logout.png" /> Logout</div></li>
            <li class="nav-item"><div class="nav-link hidden_me" onclick="switchLang();">TH</div></li>
            
            <li class="nav-item"><div class="nav-link nametext2" onclick="top.openAppFrame('');"><img src="screen_template/frame/ERP/images/app_2.png" border="0" style="cursor:pointer" />Application</div></li>
            <li class="nav-item"><div class="nav-link nametext2" onclick="top.openTodoListFrame();"><img src="screen_template/frame/ERP/images/todolist_2.png" border="0" style="cursor:pointer" />To Do List</div></li>
	    </ul>
	</div>
</div>
</nav><!-- end topright menu bar-->
</body>
</html>
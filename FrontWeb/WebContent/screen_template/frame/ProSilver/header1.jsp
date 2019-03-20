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

<script language="JavaScript" type="text/javascript">

	/* start detect closing browser working only on IE*/
	//window.onunload = closeApp;
	function closeApp(){
		window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
		//xmlhttp.open("POST",< %=request.getContextPath()%>/"CloseApplicationServlet?closeApp=true",false);
	}
	/* end detect closing browser */
	
	/* Logout on close */
	$(document).ready(function(){
            $(window).bind('beforeunload', function(){
            	window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
            	//return true;
            });  

            $(".iconheader").click(function() {
            	jQuery.ajax({
					type : "POST",
					url : <%=request.getContextPath()%>/CloseApplicationServlet,
					data : "",
					async : true,						
					error: function(){
					},
					success : function(data) {								
					}
			});
            });          
     });
	/**/
	
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
<%@ include file="scripts/swapFrame.jsp" %>
</head>
<body background="" topmargin="0" leftmargin="0" onload="toggleDesignTab()">

<input type="hidden" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 
<!-- start header zone-->
<div id="header">
<div class="logopadding" style="padding-left: 21px;"><div class="logoonhead"></div></div>
<!-- star topright menu bar-->
<div class="barloginpadding">
  		<div class="barlogin">
				<div class="profileborder"><img src="images/picprofile.jpg" /></div>
				<div class="nametext"><%=request.getSession().getAttribute("userNameForAd") %> <%=request.getSession().getAttribute("roleNameFromAD") %></div>
				<div class="iconheader" onclick="toggleDesignTab();"><img src="images/design.png" /></div>
				<div class="nametext" onclick="toggleDesignTab();">Design</div>
				<div class="iconheader"><img src="images/setting.png" /></div>
				<div class="nametext" onclick="toggleWorklist();">WorkList</div>
				<div class="iconheader" onclick="logOut();"><img src="images/logout.png" /></div>
				<div class="nametext2" onclick="logOut();">Logout</div>
				<div class="taskheader" onclick=""><img src="/MasterWeb/images/task.png" /> &nbsp; Tasks</div>
				<div class="language" onclick="switchLang();">
					TH
				</div>
  		</div>
</div>
</div><!-- end topright menu bar-->
</body>
</html>
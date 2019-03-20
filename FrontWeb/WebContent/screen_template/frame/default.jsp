<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/JStartTagLib.tld" prefix="taglib"%>
<%@ page import="com.front.j2ee.pattern.control.*"%>
<%@ page import="com.oneweb.j2ee.system.LoadXML"%>
<jsp:useBean id="screenFlowManager" class="com.front.j2ee.pattern.control.FrontScreenFlowManager" scope="session" />
<%ScreenDefinition sd = (ScreenDefinition) LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getScreenDefinitionMap().get(screenFlowManager.getCurrentScreen());%>
<%@page import="com.front.constant.FrontMenuConstant"%>
<%@page import="com.oneweb.j2ee.pattern.control.ScreenDefinition"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title><%=sd.getHtmlTitle()%></title>
<meta http-equiv="X-UA-Compatible" content="IE=11,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<link rel="stylesheet" href="screen_template/frame/scripts/bootstrap/css/bootstrap.min.css"/>
<link rel="stylesheet" href="screen_template/frame/scripts/font-awesome/css/font-awesome.min.css"/>
<link rel="stylesheet" href="<c:url value="/css/languages.min.css" /> "/>
<!-- <link rel="stylesheet" href="screen_template/frame/scripts/font-awesome/css/ionicons.min.css"/> -->
<link rel="stylesheet" href="screen_template/frame/scripts/dist/css/AdminLTE.min.css"/>
<link rel="stylesheet" href="screen_template/frame/scripts/dist/css/AdminLTE_Custom.css"/>
    <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
          page. However, you can choose any other skin. Make sure you
          apply the skin class to the body tag so the changes take effect.
    -->
<!-- <link rel="stylesheet" href="screen_template/frame/scripts/dist/css/skins/skin-blue.min.css"/> -->
<link rel="stylesheet" href="screen_template/frame/scripts/dist/css/skins/skin-black.css"/>

<link rel="stylesheet" href="screen_template/frame/include/css/PD.css">
<!-- <link href="screen_template/frame/include/css/styles.css" rel="stylesheet" /> -->
<script type="text/javascript" src="screen_template/frame/scripts/dojo.js"></script>
<script type="text/javascript" src="screen_template/frame/scripts/jquery-custom-b.js"></script>
<script>
//Prevent auto-execution of scripts when no explicit dataType was provided (See gh-2432)
jQuery.ajaxPrefilter( function( s ) {
    if ( s.crossDomain ) {
        s.contents.script = false;
    }
});
</script>
<script type="text/javascript" src="screen_template/frame/scripts/jquery-migrate-1.0.0.js"></script>
<script type="text/javascript" src="screen_template/frame/scripts/bootstrap/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="screen_template/frame/scripts/dist/js/app.min.js"></script> -->
<script type="text/javascript" src="screen_template/frame/scripts/dist/js/app.js"></script>
<script type="text/javascript" src="screen_template/frame/scripts/localstorage.js"></script>
<% 
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 201612191556
* apply AdminLTE theme for responsive2016
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
%>
<script type="text/javascript" src="screen_template/frame/scripts/frontWeb.js?v=<%=new Date().getTime()%>"></script>

<%
	String themeFront 	  = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("themeFront");
	String headerHeight   = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("headerHeight");
	String frameWidthInit = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("frameWidthInit");
	String leftScrolling  = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("leftScrolling");
	String tabMainHeader  = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("tabMainHeader");
	String appDesignHost  = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("appDesignHost");
	appDesignHost 		  = "http://"+appDesignHost+"/EAFUIWeb/index.htm?userName="+request.getSession().getAttribute("userName");
%>

<script type="text/javascript">
var frameopen=true;
var framebotopen=true;
var middleframeset_cols;
var leftframeset_rows;

//------------------
function createPath(thePath) {
	if(document.all.appPath)	document.all.appPath.innerText = thePath;
}
function writeConsole(message,color) {
	if(color){
		if($('#textMessage') != null && $('#textMessage') != undefined) {
			var innerText = $('#textMessage').html();
			$('#textMessage').html(innerText+ "<font color=\""+color+"\">"+message+"</font><br/>");
		}
	}else{
		if($('#textMessage') != null && $('#textMessage') != undefined) {
			var innerText = $('#textMessage').html();
			$('#textMessage').html(innerText+ message+"<br/>");
		}
	}
}
function clearConsole() {
	if($('#textMessage') != null && $('#textMessage') != undefined) {
		$('#textMessage').html('');
	}
}
/*
 * FIX : 201707161311 : session timeout 
 */
function logOut(noConfirm){
	if(noConfirm || confirm("Do you want to log out from this application?")){
		ActivityTheme("","Log Out");
		jQuery.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true",
			data : {},
			async : false,
			success : function(data) {
				
			}
		});

		jQuery.ajax({
			type : "POST",
			url : "/MasterWeb/CloseApplicationServlet?closeApp=true",
			data : {},
			async : false,
			success : function(data) {
				
			}
		});

		window.location.href="<%=request.getContextPath()%>/login_screen.jsp";
		//window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1");
		//top.window.location.href="../../../login_screen.jsp";
//		top.window.close()
	}
}
function ActivityCallController(querystring) {
	var bindArgs = { 
		url: "<%=request.getContextPath()%>/ActivityController", 
		method: "POST", 
		content: querystring, 
		handle: function ActivityCallController_dojo(type, data, evt) { }, 
		mimetype: "text/html", 
		encoding: "UTF-8" 
	}; 
	dojo.io.bind(bindArgs); 
}
function ActivityTheme(desc,event) {
	var param = new Array(); 
	param['browser'] = getBrowserVerionTheme(); 
	param['OS'] = getOSTheme(); 
	param['resorution'] = getResolutionTheme(); 
	param['session'] = "<%=request.getSession().getId()%>"; 	 
	param['user'] = "wasadmin"; //mol 
	param['desc'] = desc; 
	param['event'] = event; 
	ActivityCallController(param);
}
function getOSTheme(){ 
	var OSName="Unknown OS"; 
	if (navigator.appVersion.indexOf("Win")!=-1) 
		OSName="Windows"; 
	if (navigator.appVersion.indexOf("Mac")!=-1) 
		OSName="MacOS"; 
	if (navigator.appVersion.indexOf("X11")!=-1) 
		OSName="UNIX"; 
	if (navigator.appVersion.indexOf("Linux")!=-1) 
		OSName="Linux";

	return OSName; 
} 

function getResolutionTheme(){ 
	var screenW = 640, screenH = 480; 
	if (parseInt(navigator.appVersion)>3) { 
		screenW = screen.width; 
		screenH = screen.height; 
	} else if (navigator.appName == "Netscape" && parseInt(navigator.appVersion)==3 && navigator.javaEnabled() ) { 
		var jToolkit = java.awt.Toolkit.getDefaultToolkit(); 
		var jScreenSize = jToolkit.getScreenSize(); 
		screenW = jScreenSize.width; 
		screenH = jScreenSize.height; 
	}

	return screenW+" X "+screenH;

}
function getBrowserVerionTheme(){ 
	var nVer = navigator.appVersion; 
	var nAgt = navigator.userAgent; 
	var browserName  = ''; 
	var fullVersion  = 0; 
	var majorVersion = 0;

	// In Internet Explorer, the true version is after "MSIE" in userAgent 
	if ((verOffset=nAgt.indexOf("MSIE"))!=-1) { 
		browserName  = "Microsoft Internet Explorer"; 
		fullVersion  = parseFloat(nAgt.substring(verOffset+5)); 
		majorVersion = parseInt(''+fullVersion); 
	}

	// In Opera, the true version is after "Opera" 
	else if ((verOffset=nAgt.indexOf("Opera"))!=-1) { 
		browserName  = "Opera"; 
		fullVersion  = parseFloat(nAgt.substring(verOffset+6)); 
		majorVersion = parseInt(''+fullVersion); 
	}

	// In most other browsers, "name/version" is at the end of userAgent 
	else if ( (nameOffset=nAgt.lastIndexOf(' ')+1) < (verOffset=nAgt.lastIndexOf('/')) ) { 
		browserName  = nAgt.substring(nameOffset,verOffset); 
		fullVersion  = parseFloat(nAgt.substring(verOffset+1)); 
		if (!isNaN(fullVersion)) 
			majorVersion = parseInt(''+fullVersion); 
		else {
			fullVersion  = 0; 
			majorVersion = 0;
		} 
	}

	// Finally, if no name and/or no version detected from userAgent... 
	if (browserName.toLowerCase() == browserName.toUpperCase() || fullVersion==0 || majorVersion == 0 ) { 
		browserName  = navigator.appName; 
		fullVersion  = parseFloat(nVer); 
		majorVersion = parseInt(nVer); 
	} 
	return browserName+" "+fullVersion;		
}


function forwordLogon() {
<%
String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>	

var uri = "<%=hostPrefix%><%=request.getContextPath()%>/screen_template/frame/sessionTimeout.jsp";
	//alert(uri);
	window.location.href =uri;	
}

/* --------------- CPB ------------------------ */
<%
	String appDesignUrl = "http://"+com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("appDesignHost")+"/EAFUIWeb/index.htm";
	String workFlowUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/MasterWeb/FrontController?action=loadToDoList&permChkStr1=MENU_130613140031254&permChkStr2=U001&permChkStr3=AVALANT_DEV";
	String leftWidth = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("menuWidth");
%>
var leftWidth = <%=leftWidth%>;
// function openAppFrame(uri)
// {
// 	//top.frames['designframe'].location.href = 'appDesignHost';
// 	//setTimeout("top.document.getElementById(\"middleframeset\").cols='175,*,0'", 60);
// 	//setTimeout("animateFadeShow(0,0)", 500);
// 	animateFadeShow(0,0, uri);
// }
// function openTodoListFrame()
// {
// 	animateFadeHide(leftWidth,0)
// 	//setTimeout("top.document.getElementById(\"middleframeset\").cols='0,0,*'", 60);
// }
// function animateFadeShow(leftF,centF, uri){
//   if(leftF<(leftWidth + 15)){
//   	leftF = leftF+15;
//   }else{
//   	leftF = leftWidth;
//   }
//   centF = centF + 350;
//   var colF = leftF+","+centF+",*";
//   //alert(colF);
//   if(centF > 1100){
//   	colF = leftWidth+",*,0";
//   	top.document.getElementById("middleframeset").cols=colF;	
  	
//   	if(uri != '')
// 	{
// 		top.frames['mainframe'].location.href = uri;
// 	}
// 	else
// 	{
<%-- 		top.frames['mainframe'].location.href = '<%=request.getContextPath()%>/screen_template/frame/main.jsp'; --%>
// 	}
  	
//   }else{
//   	top.document.getElementById("middleframeset").cols=colF;
//   	setTimeout("animateFadeShow("+leftF+","+centF+", '"+uri+"')", 10);
//   }
// }
// function animateFadeHide(leftF,rightF){
// if(leftF>0){
//   	leftF = leftF-15;
//   }else{
//   	leftF = 0;
//   }
//   rightF = rightF + 150;
//   var colF = leftF+",*,"+rightF;
//   //alert(colF);
//   if(rightF > 1100){
//   	colF = "0,0,*";
//   	top.document.getElementById("middleframeset").cols=colF;	
//   	top.frames['designframe'].location.href = '/MasterWeb/FrontController?page=TODO_LIST_SCREEN';
//   }else{
//   	top.document.getElementById("middleframeset").cols=colF;
//   	setTimeout("animateFadeHide("+leftF+","+rightF+")", 10);
//   }
// }

function toggleMobileVersion() {
// 	$("#appContent").toggle();
	$('#appContent').toggleClass('active');
	$("#mobileMenu").toggle();
}

function toggleOverFlow(){
	$(".sidebar-menu").hover(function(e) { 
		var overflows = $(this).css("overflow");
		if(overflows=="auto"){
	    	$(this).css("overflow","visible"); 
		}else{
			$(this).css("overflow","auto"); 
		}
	})
}
</script>

</head>

<body class="hold-transition skin-black sidebar-mini">
    
    <div class="wrapper">
    
    	<!-- Main Header -->
<!--     	<div class="navbar navbar-fixed-top" role="navigation">  navbar-default  -->
<!-- 	    	<header class="main-header"> -->
<%-- 	      		<jsp:include page="Responsive2016/header.jsp" flush="true"/> --%>
<!-- 	      	</header> -->
<!-- 		</div> -->
		
		<header class="main-header">
	    	<!-- <div class="navbar navbar-static-top" role="navigation">  <!-- navbar-default  --> 
		    	<jsp:include page="Responsive2016/header.jsp" flush="true"/>
			<!-- </div> -->
		</header>
	
		<aside class="main-sidebar appSidebar">
			<jsp:include page="Responsive2016/leftNav.jsp" flush="true"/>
		</aside>
	
		<% 
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		* FIX : 201612191556
		* apply AdminLTE theme for responsive2016
		* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		%>
<!-- 		<div class="content-wrapper" > -->
		<div class="content-wrapper" style="height: 0px;">
			<jsp:include page="Responsive2016/mainContent.jsp" flush="true"/>
		</div>
		<!-- /.content-wrapper -->

      	<!-- Main Footer -->
<!--       	<footer class="main-footer"> -->
<%--         	<jsp:include page="footer.jsp" flush="true"/> --%>
<!--       	</footer> -->
      	<div class="hidedesktop">
      		<aside class="control-sidebar control-sidebar-dark" id="mobSidebar">
      			<jsp:include page="Responsive2016/sidebarNav.jsp" flush="true"/>
      		</aside>
      		<div class="control-sidebar-bg"></div>
      	</div>
    </div>
</body>
</html>

<!-- /////////////////////////////////////////////////////////////////////////////////// -->
<style>
.content-wrapper { min-height: 0px; }
.ui-tooltip {
    position: absolute;
    z-index: 1070;
    opacity: 9;
    line-break: auto;
}

.ui-tooltip-content {
    padding: 3px 8px;
    color: #fff;
    text-align: center;
    background-color: #000;
    border-radius: 4px;
    font-size: 11px
}
</style>

<script>
// function resizeMainPage() {
// 	var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
// 	var window_height = $(window).height();
// 	$('#mainPage').attr("height", window_height - neg);

// 	//$('body').css('overflow-y', 'hidden');
// }
// resizeMainPage();

/*
 * customizing AdminLTE option
 * enableBSToppltip = false =>  disabled tooltip
 */
//$.AdminLTE.options.enableBSToppltip = false;

</script>

<!-- /////////////////////////////////////////////////////////////////////////////////// -->

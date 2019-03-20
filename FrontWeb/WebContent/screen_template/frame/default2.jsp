
<%@ taglib uri="/WEB-INF/JStartTagLib.tld" prefix="taglib"%>
<%@ page import="com.front.j2ee.pattern.control.*"%>
<%@ page import="com.oneweb.j2ee.system.LoadXML"%>
<jsp:useBean id="screenFlowManager" class="com.front.j2ee.pattern.control.FrontScreenFlowManager" scope="session" />
<%ScreenDefinition sd = (ScreenDefinition) LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getScreenDefinitionMap().get(screenFlowManager.getCurrentScreen());%>
<%@page import="com.front.constant.FrontMenuConstant"%>
<%@page import="com.oneweb.j2ee.pattern.control.ScreenDefinition"%>
<!DOCTYPE  html>
<html>
<head>
<title><%=sd.getHtmlTitle()%></title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<link href="screen_template/frame/scripts/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="screen_template/frame/scripts/dojo.js"></script>
<script type="text/javascript" src="screen_template/frame/scripts/jquery-2.1.4.js"></script>
<script type="text/javascript" src="screen_template/frame/scripts/bootstrap/js/bootstrap.min.js"></script>
<%
	
	String themeFront = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("themeFront");
	String headerHeight = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("headerHeight");
	String frameWidthInit = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("frameWidthInit");
	String leftScrolling = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("leftScrolling");
	String tabMainHeader = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("tabMainHeader");
	String appDesignHost = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("appDesignHost");
	appDesignHost = "http://"+appDesignHost+"/EAFUIWeb/index.htm?userName="+request.getSession().getAttribute("userName");
	
%>

<script type="text/javascript">
var frameopen=true;
var framebotopen=true;
var middleframeset_cols;
var leftframeset_rows;
$(document).ready(function() {
	if ( $(window).width() <= 739) {
		frameopen=true;
		toggleMenu();
	}
});
function forceHide() {
		top.document.getElementById("middleframeset").cols="41,*";
		top.document.getElementById("leftframeset").rows = "0,*";
		frameopen=false;
}
function toggleMenu() {
	if (frameopen) {// hide menu
	
		middleframeset_cols = top.document.getElementById("middleframeset").cols;
		leftframeset_rows = top.document.getElementById("leftframeset").rows;
		
		top.document.getElementById("middleframeset").cols="35,*";
		top.document.getElementById("leftframeset").rows = "0,*";
		//disableResize( top.menuheader );
		top.menuframe.document.location.href = "<%=request.getContextPath()%>/screen_template/frame/hideLeftNav.jsp";
		frameopen=false;
	} else {// show menu
		top.document.getElementById("middleframeset").cols=middleframeset_cols;
		top.document.getElementById("leftframeset").rows = leftframeset_rows;
		enableResize( top.menuheader );
		frameopen=true;
		top.menuframe.document.location.href = "<%=themeFront%>leftNav.jsp";
	}
}
function toggleBotMenu() {
	if (framebotopen) {
		top.document.getElementById("screenframeset").rows = "69,*,19";
		framebotopen=false;
		top.footer.document.images["arrow"].src = "images/arrow_up.gif";
	} else {
		top.document.getElementById("screenframeset").rows = "69,*,80";
		framebotopen=true;
		top.footer.document.images["arrow"].src = "images/arrow_down.gif";
	}
}
//------ Frame function ------
function disableResize(theObj) {
	theObj.noResize=true
}
function enableResize(theObj) {
	theObj.noResize=false
}

//------------------
function createPath(thePath) {
	if(top.mainheader.document.all.appPath)	top.mainheader.document.all.appPath.innerText = thePath;
}
function writeConsole(message,color) {
	if(color){
		if(top.footer.document.all.textMessage)	top.footer.document.all.textMessage.innerHTML += "<font color=\""+color+"\">"+message+"</font><br/>";
	}else{
		if(top.footer.document.all.textMessage)	top.footer.document.all.textMessage.innerHTML += message+"<br/>";
	}
}
function clearConsole() {
	if(top.footer.document.all.textMessage)	top.footer.document.all.textMessage.innerHTML = "";
}
function logOut(){
	if(confirm("Do you want to log out from this application?")){
		ActivityTheme("","Log Out");
		top.window.location.href="../../../logout.jsp";
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
function ActivityTheme(desc,event){
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

//Sam add main Header Tab
function hideMainTab() {
	top.document.getElementById("mainframeset").rows="0,*";
}

function showMainTab() {
	top.document.getElementById("mainframeset").rows="50,*";
}
var tabopen = true;
function toggleTab() {
	if (tabopen) {
		hideMainTab()
		tabopen=false;
	} else {
		showMainTab()
		tabopen=true;
	}
}



/* --------------- CPB ------------------------ */
<%
	String appDesignUrl = "http://"+com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("appDesignHost")+"/EAFUIWeb/index.htm";
	String workFlowUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/MasterWeb/FrontController?action=loadToDoList&permChkStr1=MENU_130613140031254&permChkStr2=U001&permChkStr3=AVALANT_DEV";
	String leftWidth = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("menuWidth");
%>
var leftWidth = <%=leftWidth%>;
function openAppFrame(uri)
{
	//top.frames['designframe'].location.href = 'appDesignHost';
	//setTimeout("top.document.getElementById(\"middleframeset\").cols='175,*,0'", 60);
	//setTimeout("animateFadeShow(0,0)", 500);
	animateFadeShow(0,0, uri);
}
function openTodoListFrame()
{
	animateFadeHide(leftWidth,0)
	//setTimeout("top.document.getElementById(\"middleframeset\").cols='0,0,*'", 60);
}
function animateFadeShow(leftF,centF, uri){
  if(leftF<(leftWidth + 15)){
  	leftF = leftF+15;
  }else{
  	leftF = leftWidth;
  }
  centF = centF + 350;
  var colF = leftF+","+centF+",*";
  //alert(colF);
  if(centF > 1100){
  	colF = leftWidth+",*,0";
  	top.document.getElementById("middleframeset").cols=colF;	
  	
  	if(uri != '')
	{
		top.frames['mainframe'].location.href = uri;
	}
	else
	{
		top.frames['mainframe'].location.href = '<%=request.getContextPath()%>/screen_template/frame/main.jsp';
	}
  	
  }else{
  	top.document.getElementById("middleframeset").cols=colF;
  	setTimeout("animateFadeShow("+leftF+","+centF+", '"+uri+"')", 10);
  }
}
function animateFadeHide(leftF,rightF){
if(leftF>0){
  	leftF = leftF-15;
  }else{
  	leftF = 0;
  }
  rightF = rightF + 150;
  var colF = leftF+",*,"+rightF;
  //alert(colF);
  if(rightF > 1100){
  	colF = "0,0,*";
  	top.document.getElementById("middleframeset").cols=colF;	
  	top.frames['designframe'].location.href = '/MasterWeb/FrontController?page=TODO_LIST_SCREEN';
  }else{
  	top.document.getElementById("middleframeset").cols=colF;
  	setTimeout("animateFadeHide("+leftF+","+rightF+")", 10);
  }
}

/* --------------- end CPB ------------------------ */
</script>

</head>

<%-- <frameset class="panelFrame" rows="<%=headerHeight%>,*,0" id="screenframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0> --%>
<%-- 	<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="header" src="screen_template/frame/<%=themeFront%>header.jsp"/> --%>
<%-- 	<frameset cols="<%=frameWidthInit%>" rows="*" id="middleframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0> --%>
<!-- 		<frameset rows="0,*" id="leftframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0> -->
<!-- 			<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="menuheader" src="screen_template/frame/leftHeader.jsp"/> -->
<%-- 			<frame frameborder="0" scrolling="<%=leftScrolling%>" marginwidth="0" marginheight="0" name="menuframe" src="screen_template/frame/<%=themeFront%>leftNav.jsp"/> --%>
<!-- 		</frameset> -->
<%-- 		<frameset rows="<%=tabMainHeader%>,*" id="mainframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0> --%>
<%-- 			<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="mainheader" id="mainheader" src="screen_template/frame/<%=themeFront%>mainHeader.jsp"/> --%>
<!-- 			<frame frameborder="0" scrolling="yes" marginwidth="0" marginheight="0" name="mainframe" src="screen_template/frame/main.jsp"/> -->
<%-- 				<%  --%>
<!-- 				// CPB  -->
<!-- 				%> -->
<!-- 		</frameset> -->
<!-- 		<frameset rows="*" id="designframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0> -->
<!-- 			<frame frameborder="0" scrolling="yes" marginwidth="0" marginheight="0" name="designframe" src="/MasterWeb/FrontController?page=TODO_LIST_SCREEN&a=1"/> -->
<!-- 		</frameset> -->
<!-- 	</frameset> -->
<%-- 	<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="footer" src="screen_template/frame/<%=themeFront%>footer.jsp"/> --%>
<!-- </frameset> -->
<!-- <noframes><body>Your browser does not handle frames!</body></noframes> -->


<frameset class="panelFrame" rows="<%=headerHeight%>,*,0" id="screenframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
	<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="header" src="screen_template/frame/<%=themeFront%>header.jsp"/>
	<frameset cols="<%=frameWidthInit%>" rows="*" id="middleframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
		<frameset rows="17,*" id="leftframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
			<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="menuheader" src="screen_template/frame/leftHeader.jsp"/>
			<frame frameborder="0" scrolling="<%=leftScrolling%>" marginwidth="0" marginheight="0" name="menuframe" src="screen_template/frame/<%=themeFront%>leftNav.jsp"/>
		</frameset>
		<frameset rows="<%=tabMainHeader%>,*" id="mainframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
			<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="mainheader" id="mainheader" src="screen_template/frame/<%=themeFront%>mainHeader.jsp"/>
			<frame frameborder="0" scrolling="yes" marginwidth="0" marginheight="0" name="mainframe" src="screen_template/frame/main.jsp"/>
		</frameset>
		<frameset rows="*" id="designframeset" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
<!-- 			<frame frameborder="0" scrolling="yes" marginwidth="0" marginheight="0" name="designframe" src="/MasterWeb/FrontController?page=TODO_LIST_SCREEN&a=1"/> -->
			<frame frameborder="0" scrolling="yes" marginwidth="0" marginheight="0" name="designframe" src=""/>
		</frameset>
	</frameset>
	<frame frameborder="0" noresize="0" scrolling="no" marginwidth="0" marginheight="0" name="footer" src="screen_template/frame/<%=themeFront%>footer.jsp"/>
</frameset>
<noframes><body>Your browser does not handle frames!</body></noframes>

</html>

<%@page import="com.eaf40.utils.StringUtils"%>
<%@page import="com.master.constant.ConstantSystem"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.eaf40.service.EAFServiceFactory"%>
<%@page import="com.master.util.MasterConstant"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.avalant.iam.service.UserInfoService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String username 	= (String)request.getSession().getAttribute("userName");
	String en_firstname = "";
	String en_lastname 	= "";
	String position 	= "";
	String department 	= "";
	String avatar 		= "";
	String userImg		= "screen_template/frame/scripts/dist/img/user-160x160.jpg";

	System.out.println("####################################################");
	if(("Y").equals(request.getSession().getAttribute("useIAM2"))){
		//System.out.println("################## START: USER INFO ###############");
		
		UserInfoService userInfo = new UserInfoService(request);	
		String accessToken = (String)request.getSession().getAttribute(MasterConstant.ACCESS_TOKEN);
		JSONObject objUserInfo = userInfo.getUserInfo(accessToken);
		en_firstname = objUserInfo != null ? objUserInfo.getString("en_firstname").trim() : "";
		en_lastname  = objUserInfo != null ? objUserInfo.getString("en_lastname").trim() : "";
		position 	 = objUserInfo != null ? objUserInfo.getString("position").trim() : "";
		department 	 = objUserInfo != null ? objUserInfo.getString("department").trim() : "";
		avatar 		 = objUserInfo != null ? objUserInfo.getString("avatar").trim() : "";
		if(!"".equals(avatar)) userImg = "data:image/png;base64,"+avatar;
		
		//System.out.println("################## END: USER INFO ###############");
	}
	
	List<String> langsName = EAFServiceFactory.getOnewebCfgService().getLangsName();
	pageContext.setAttribute("langsName", langsName);
	
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
			    jQuery.ajax({
			        url: '/MasterWeb/CloseApplicationServlet?closeApp=true',
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
<%-- <jsp:include page="scripts/swapFrame.jsp" flush="true"></jsp:include> --%>
<!-- </head> -->
<!-- <body background="" topmargin="0" leftmargin="0"> -->
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" id="sessiontimeout" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 

<!-- Logo -->
<a href="<%=hostPrefix %>/PAGERUNTIME/page/44161c94-6493-4407-953d-be06f43100cd" target="mainPage" class="logo" onclick=showLoader()>
  	<!-- mini logo for sidebar mini 50x50 pixels -->
  	<span class="logo-mini">
  		<img src="screen_template/frame/Responsive2016/images/oneweb_small.svg">
  	</span>
 	<!-- logo for regular state and mobile devices -->
  	<span class="logo-lg">
  		<img src="screen_template/frame/Responsive2016/images/oneweb.svg">
 	</span>
</a>





<!-- Header Navbar -->
<nav class="navbar navbar-static-top" role="navigation">
	<div class="container-fluid">
	  <!-- Navbar Left Menu -->
	  <!-- <div class="navbar-header"> -->
	   	<!-- Sidebar toggle button-->
	   	<a href="javascript:void(0)" class="sidebar-toggle desktop" data-toggle="offcanvas" onclick="toggleOverFlow()" role="button">
	   		<span class="sr-only">Toggle navigation</span>
	 	</a>
		<!-- Sidebar Toggle for mobile-->
		<a href="javascript:void(0)" class="sidebarmobile" onclick="toggleMobileVersion()" role="button">
			<img src="screen_template/frame/Responsive2016/images/menumobile.svg">
    	</a>
    	
    	
    	<!-- search form -->
    	<!-- <form class="navbar-form pull-left" role="search">
            <div class="input-group stylish-input-group">               
               <div class="input-group-addon">
               	  <button type="button" id='btnSearch' class="btn btn-white btn-sm btn-block">
               	     <span class="fa fa-search"></span>
              	  </button>
               </div>
               <input type="text" id='navSearch' class="form-control" placeholder="Search">
            </div>
         </form> -->
         <!-- /.search form -->
          
      <!-- </div> -->  <!--/.Navbar Left Menu -->
      
      <!-- Navbar Right Menu -->
	    <div class="navbar-custom-menu">
	    	<ul class="nav navbar-nav navbar-right">
	    		
	    		<% 
	    		if(langsName != null && langsName.size() > 0) {
	    			String defaultLang = EAFManualUtil.getConstantValue(ConstantSystem.LOCALE);
	    			if(StringUtils.isEmpty(defaultLang)) {
	    				defaultLang = langsName.get(0);
	    			}
	    			%>
	    			<li class="dropdown langs-menu">
		    			<a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
		    			<%
		    			if(!StringUtils.isEmpty(defaultLang) && defaultLang.indexOf("_") != -1) {
		    				%>
		    				<span id='defaltLang' lang="<%=defaultLang.split("_")[0]%>" country="<%=defaultLang.split("_")[1]%>" role="option"></span> <span class="caret"></span>
				            <%
		    			}
		    			%>
		    			</a>
		    			<ul class="dropdown-menu" role="menu">
		    			<%
		    			for(String langName : langsName) {
		    				if(langName.indexOf("_") != -1) {
			    				%>
			    				<li lang="<%=langName.split("_")[0]%>" country="<%=langName.split("_")[1]%>" role="option" onclick="$.FrontWeb._switchLanguage('<%=langName.split("_")[0]%>_<%=langName.split("_")[1]%>', this)"></li>
			    				<%
		    				}
		    			}
		    			%>
		    			</ul>
	    			</li>
	    			
	    			<style>
					.navbar-nav .langs-menu a {    
						padding-top: 22px;
	    				padding-bottom: 17px;
	    				line-height: 17px;
	    				padding-right: 21px;
	    				padding-left: 21px;}
	    			.navbar-nav .langs-menu ul.dropdown-menu li {
	    				cursor: pointer;
	    			}
	    			.navbar-nav .langs-menu ul.dropdown-menu li:HOVER {
	    				background: #5b6474;
	    				color: #ffffff;
	    			}
	    			
	    			.bfh-flag-AD,
.bfh-flag-AE,
.bfh-flag-AF,
.bfh-flag-AG,
.bfh-flag-AI,
.bfh-flag-AL,
.bfh-flag-AM,
.bfh-flag-AN,
.bfh-flag-AO,
.bfh-flag-AQ,
.bfh-flag-AR,
.bfh-flag-AS,
.bfh-flag-AT,
.bfh-flag-AU,
.bfh-flag-AW,
.bfh-flag-AX,
.bfh-flag-AZ,
.bfh-flag-BA,
.bfh-flag-BB,
.bfh-flag-BD,
.bfh-flag-BE,
.bfh-flag-BG,
.bfh-flag-BH,
.bfh-flag-BI,
.bfh-flag-BJ,
.bfh-flag-BL,
.bfh-flag-BM,
.bfh-flag-BN,
.bfh-flag-BO,
.bfh-flag-BR,
.bfh-flag-BS,
.bfh-flag-BT,
.bfh-flag-BW,
.bfh-flag-BY,
.bfh-flag-BZ,
.bfh-flag-CA,
.bfh-flag-CD,
.bfh-flag-CF,
.bfh-flag-CG,
.bfh-flag-CH,
.bfh-flag-CI,
.bfh-flag-CL,
.bfh-flag-CM,
.bfh-flag-CN,
.bfh-flag-CO,
.bfh-flag-CR,
.bfh-flag-CV,
.bfh-flag-CY,
.bfh-flag-CZ,
.bfh-flag-DJ,
.bfh-flag-DK,
.bfh-flag-DM,
.bfh-flag-DO,
.bfh-flag-DZ,
.bfh-flag-EC,
.bfh-flag-EE,
.bfh-flag-EG,
.bfh-flag-EH,
.bfh-flag-ER,
.bfh-flag-ES,
.bfh-flag-ET,
.bfh-flag-EU,
.bfh-flag-FI,
.bfh-flag-FJ,
.bfh-flag-FK,
.bfh-flag-FM,
.bfh-flag-FO,
.bfh-flag-FR,
.bfh-flag-FX,
.bfh-flag-GF,
.bfh-flag-GP,
.bfh-flag-MQ,
.bfh-flag-NC,
.bfh-flag-PF,
.bfh-flag-PM,
.bfh-flag-RE,
.bfh-flag-TF,
.bfh-flag-WF,
.bfh-flag-GA,
.bfh-flag-GB,
.bfh-flag-GD,
.bfh-flag-GE,
.bfh-flag-GG,
.bfh-flag-GH,
.bfh-flag-GL,
.bfh-flag-GM,
.bfh-flag-GN,
.bfh-flag-GQ,
.bfh-flag-GR,
.bfh-flag-GS,
.bfh-flag-GT,
.bfh-flag-GU,
.bfh-flag-GW,
.bfh-flag-GY,
.bfh-flag-HK,
.bfh-flag-HN,
.bfh-flag-HR,
.bfh-flag-HT,
.bfh-flag-HU,
.bfh-flag-ID,
.bfh-flag-IE,
.bfh-flag-IL,
.bfh-flag-IM,
.bfh-flag-IN,
.bfh-flag-IQ,
.bfh-flag-IS,
.bfh-flag-IT,
.bfh-flag-JE,
.bfh-flag-JM,
.bfh-flag-JO,
.bfh-flag-JP,
.bfh-flag-KE,
.bfh-flag-KG,
.bfh-flag-KH,
.bfh-flag-KI,
.bfh-flag-KM,
.bfh-flag-KN,
.bfh-flag-KP,
.bfh-flag-KR,
.bfh-flag-KV,
.bfh-flag-KW,
.bfh-flag-KY,
.bfh-flag-LA,
.bfh-flag-LC,
.bfh-flag-LK,
.bfh-flag-LR,
.bfh-flag-LS,
.bfh-flag-LT,
.bfh-flag-LU,
.bfh-flag-LV,
.bfh-flag-LY,
.bfh-flag-MA,
.bfh-flag-ME,
.bfh-flag-MG,
.bfh-flag-MH,
.bfh-flag-ML,
.bfh-flag-MM,
.bfh-flag-MP,
.bfh-flag-MR,
.bfh-flag-MS,
.bfh-flag-MT,
.bfh-flag-MU,
.bfh-flag-MV,
.bfh-flag-MW,
.bfh-flag-MZ,
.bfh-flag-NA,
.bfh-flag-NE,
.bfh-flag-NF,
.bfh-flag-NG,
.bfh-flag-NI,
.bfh-flag-NL,
.bfh-flag-NO,
.bfh-flag-NP,
.bfh-flag-NR,
.bfh-flag-NZ,
.bfh-flag-OM,
.bfh-flag-PA,
.bfh-flag-PE,
.bfh-flag-PG,
.bfh-flag-PH,
.bfh-flag-PK,
.bfh-flag-PL,
.bfh-flag-PN,
.bfh-flag-PS,
.bfh-flag-PT,
.bfh-flag-PW,
.bfh-flag-PY,
.bfh-flag-QA,
.bfh-flag-RS,
.bfh-flag-RU,
.bfh-flag-RW,
.bfh-flag-SA,
.bfh-flag-SB,
.bfh-flag-SC,
.bfh-flag-SD,
.bfh-flag-SE,
.bfh-flag-SG,
.bfh-flag-SH,
.bfh-flag-SI,
.bfh-flag-SK,
.bfh-flag-SM,
.bfh-flag-SN,
.bfh-flag-SO,
.bfh-flag-SR,
.bfh-flag-SS,
.bfh-flag-ST,
.bfh-flag-SV,
.bfh-flag-SY,
.bfh-flag-SZ,
.bfh-flag-TC,
.bfh-flag-TD,
.bfh-flag-TG,
.bfh-flag-TH,
.bfh-flag-TJ,
.bfh-flag-TM,
.bfh-flag-TN,
.bfh-flag-TP,
.bfh-flag-TR,
.bfh-flag-TT,
.bfh-flag-TV,
.bfh-flag-TW,
.bfh-flag-TZ,
.bfh-flag-UA,
.bfh-flag-UG,
.bfh-flag-US,
.bfh-flag-UY,
.bfh-flag-UZ,
.bfh-flag-VC,
.bfh-flag-VE,
.bfh-flag-VG,
.bfh-flag-VI,
.bfh-flag-VN,
.bfh-flag-VU,
.bfh-flag-WS,
.bfh-flag-YE,
.bfh-flag-ZA,
.bfh-flag-ZM,
.bfh-flag-BF,
.bfh-flag-CU,
.bfh-flag-DE,
.bfh-flag-IR,
.bfh-flag-KZ,
.bfh-flag-LB,
.bfh-flag-LI,
.bfh-flag-MC,
.bfh-flag-MD,
.bfh-flag-MK,
.bfh-flag-MN,
.bfh-flag-MO,
.bfh-flag-MX,
.bfh-flag-MY,
.bfh-flag-PR,
.bfh-flag-RO,
.bfh-flag-SL,
.bfh-flag-TO,
.bfh-flag-VA,
.bfh-flag-ZW {
  width: 16px;
  height: 14px;
  background: url(images/bootstrap-formhelpers-countries.flags.png) no-repeat;
}

.bfh-flag-AD:empty,
.bfh-flag-AE:empty,
.bfh-flag-AF:empty,
.bfh-flag-AG:empty,
.bfh-flag-AI:empty,
.bfh-flag-AL:empty,
.bfh-flag-AM:empty,
.bfh-flag-AN:empty,
.bfh-flag-AO:empty,
.bfh-flag-AQ:empty,
.bfh-flag-AR:empty,
.bfh-flag-AS:empty,
.bfh-flag-AT:empty,
.bfh-flag-AU:empty,
.bfh-flag-AW:empty,
.bfh-flag-AX:empty,
.bfh-flag-AZ:empty,
.bfh-flag-BA:empty,
.bfh-flag-BB:empty,
.bfh-flag-BD:empty,
.bfh-flag-BE:empty,
.bfh-flag-BG:empty,
.bfh-flag-BH:empty,
.bfh-flag-BI:empty,
.bfh-flag-BJ:empty,
.bfh-flag-BL:empty,
.bfh-flag-BM:empty,
.bfh-flag-BN:empty,
.bfh-flag-BO:empty,
.bfh-flag-BR:empty,
.bfh-flag-BS:empty,
.bfh-flag-BT:empty,
.bfh-flag-BW:empty,
.bfh-flag-BY:empty,
.bfh-flag-BZ:empty,
.bfh-flag-CA:empty,
.bfh-flag-CD:empty,
.bfh-flag-CF:empty,
.bfh-flag-CG:empty,
.bfh-flag-CH:empty,
.bfh-flag-CI:empty,
.bfh-flag-CL:empty,
.bfh-flag-CM:empty,
.bfh-flag-CN:empty,
.bfh-flag-CO:empty,
.bfh-flag-CR:empty,
.bfh-flag-CV:empty,
.bfh-flag-CY:empty,
.bfh-flag-CZ:empty,
.bfh-flag-DJ:empty,
.bfh-flag-DK:empty,
.bfh-flag-DM:empty,
.bfh-flag-DO:empty,
.bfh-flag-DZ:empty,
.bfh-flag-EC:empty,
.bfh-flag-EE:empty,
.bfh-flag-EG:empty,
.bfh-flag-EH:empty,
.bfh-flag-ER:empty,
.bfh-flag-ES:empty,
.bfh-flag-ET:empty,
.bfh-flag-EU:empty,
.bfh-flag-FI:empty,
.bfh-flag-FJ:empty,
.bfh-flag-FK:empty,
.bfh-flag-FM:empty,
.bfh-flag-FO:empty,
.bfh-flag-FR:empty,
.bfh-flag-FX:empty,
.bfh-flag-GF:empty,
.bfh-flag-GP:empty,
.bfh-flag-MQ:empty,
.bfh-flag-NC:empty,
.bfh-flag-PF:empty,
.bfh-flag-PM:empty,
.bfh-flag-RE:empty,
.bfh-flag-TF:empty,
.bfh-flag-WF:empty,
.bfh-flag-GA:empty,
.bfh-flag-GB:empty,
.bfh-flag-GD:empty,
.bfh-flag-GE:empty,
.bfh-flag-GG:empty,
.bfh-flag-GH:empty,
.bfh-flag-GL:empty,
.bfh-flag-GM:empty,
.bfh-flag-GN:empty,
.bfh-flag-GQ:empty,
.bfh-flag-GR:empty,
.bfh-flag-GS:empty,
.bfh-flag-GT:empty,
.bfh-flag-GU:empty,
.bfh-flag-GW:empty,
.bfh-flag-GY:empty,
.bfh-flag-HK:empty,
.bfh-flag-HN:empty,
.bfh-flag-HR:empty,
.bfh-flag-HT:empty,
.bfh-flag-HU:empty,
.bfh-flag-ID:empty,
.bfh-flag-IE:empty,
.bfh-flag-IL:empty,
.bfh-flag-IM:empty,
.bfh-flag-IN:empty,
.bfh-flag-IQ:empty,
.bfh-flag-IS:empty,
.bfh-flag-IT:empty,
.bfh-flag-JE:empty,
.bfh-flag-JM:empty,
.bfh-flag-JO:empty,
.bfh-flag-JP:empty,
.bfh-flag-KE:empty,
.bfh-flag-KG:empty,
.bfh-flag-KH:empty,
.bfh-flag-KI:empty,
.bfh-flag-KM:empty,
.bfh-flag-KN:empty,
.bfh-flag-KP:empty,
.bfh-flag-KR:empty,
.bfh-flag-KV:empty,
.bfh-flag-KW:empty,
.bfh-flag-KY:empty,
.bfh-flag-LA:empty,
.bfh-flag-LC:empty,
.bfh-flag-LK:empty,
.bfh-flag-LR:empty,
.bfh-flag-LS:empty,
.bfh-flag-LT:empty,
.bfh-flag-LU:empty,
.bfh-flag-LV:empty,
.bfh-flag-LY:empty,
.bfh-flag-MA:empty,
.bfh-flag-ME:empty,
.bfh-flag-MG:empty,
.bfh-flag-MH:empty,
.bfh-flag-ML:empty,
.bfh-flag-MM:empty,
.bfh-flag-MP:empty,
.bfh-flag-MR:empty,
.bfh-flag-MS:empty,
.bfh-flag-MT:empty,
.bfh-flag-MU:empty,
.bfh-flag-MV:empty,
.bfh-flag-MW:empty,
.bfh-flag-MZ:empty,
.bfh-flag-NA:empty,
.bfh-flag-NE:empty,
.bfh-flag-NF:empty,
.bfh-flag-NG:empty,
.bfh-flag-NI:empty,
.bfh-flag-NL:empty,
.bfh-flag-NO:empty,
.bfh-flag-NP:empty,
.bfh-flag-NR:empty,
.bfh-flag-NZ:empty,
.bfh-flag-OM:empty,
.bfh-flag-PA:empty,
.bfh-flag-PE:empty,
.bfh-flag-PG:empty,
.bfh-flag-PH:empty,
.bfh-flag-PK:empty,
.bfh-flag-PL:empty,
.bfh-flag-PN:empty,
.bfh-flag-PS:empty,
.bfh-flag-PT:empty,
.bfh-flag-PW:empty,
.bfh-flag-PY:empty,
.bfh-flag-QA:empty,
.bfh-flag-RS:empty,
.bfh-flag-RU:empty,
.bfh-flag-RW:empty,
.bfh-flag-SA:empty,
.bfh-flag-SB:empty,
.bfh-flag-SC:empty,
.bfh-flag-SD:empty,
.bfh-flag-SE:empty,
.bfh-flag-SG:empty,
.bfh-flag-SH:empty,
.bfh-flag-SI:empty,
.bfh-flag-SK:empty,
.bfh-flag-SM:empty,
.bfh-flag-SN:empty,
.bfh-flag-SO:empty,
.bfh-flag-SR:empty,
.bfh-flag-SS:empty,
.bfh-flag-ST:empty,
.bfh-flag-SV:empty,
.bfh-flag-SY:empty,
.bfh-flag-SZ:empty,
.bfh-flag-TC:empty,
.bfh-flag-TD:empty,
.bfh-flag-TG:empty,
.bfh-flag-TH:empty,
.bfh-flag-TJ:empty,
.bfh-flag-TM:empty,
.bfh-flag-TN:empty,
.bfh-flag-TP:empty,
.bfh-flag-TR:empty,
.bfh-flag-TT:empty,
.bfh-flag-TV:empty,
.bfh-flag-TW:empty,
.bfh-flag-TZ:empty,
.bfh-flag-UA:empty,
.bfh-flag-UG:empty,
.bfh-flag-US:empty,
.bfh-flag-UY:empty,
.bfh-flag-UZ:empty,
.bfh-flag-VC:empty,
.bfh-flag-VE:empty,
.bfh-flag-VG:empty,
.bfh-flag-VI:empty,
.bfh-flag-VN:empty,
.bfh-flag-VU:empty,
.bfh-flag-WS:empty,
.bfh-flag-YE:empty,
.bfh-flag-ZA:empty,
.bfh-flag-ZM:empty,
.bfh-flag-BF:empty,
.bfh-flag-CU:empty,
.bfh-flag-DE:empty,
.bfh-flag-IR:empty,
.bfh-flag-KZ:empty,
.bfh-flag-LB:empty,
.bfh-flag-LI:empty,
.bfh-flag-MC:empty,
.bfh-flag-MD:empty,
.bfh-flag-MK:empty,
.bfh-flag-MN:empty,
.bfh-flag-MO:empty,
.bfh-flag-MX:empty,
.bfh-flag-MY:empty,
.bfh-flag-PR:empty,
.bfh-flag-RO:empty,
.bfh-flag-SL:empty,
.bfh-flag-TO:empty,
.bfh-flag-VA:empty,
.bfh-flag-ZW:empty {
  width: 16px;
}

.bfh-flag-AD,
.bfh-flag-AE,
.bfh-flag-AF,
.bfh-flag-AG,
.bfh-flag-AI,
.bfh-flag-AL,
.bfh-flag-AM,
.bfh-flag-AN,
.bfh-flag-AO,
.bfh-flag-AQ,
.bfh-flag-AR,
.bfh-flag-AS,
.bfh-flag-AT,
.bfh-flag-AU,
.bfh-flag-AW,
.bfh-flag-AX,
.bfh-flag-AZ,
.bfh-flag-BA,
.bfh-flag-BB,
.bfh-flag-BD,
.bfh-flag-BE,
.bfh-flag-BG,
.bfh-flag-BH,
.bfh-flag-BI,
.bfh-flag-BJ,
.bfh-flag-BL,
.bfh-flag-BM,
.bfh-flag-BN,
.bfh-flag-BO,
.bfh-flag-BR,
.bfh-flag-BS,
.bfh-flag-BT,
.bfh-flag-BW,
.bfh-flag-BY,
.bfh-flag-BZ,
.bfh-flag-CA,
.bfh-flag-CD,
.bfh-flag-CF,
.bfh-flag-CG,
.bfh-flag-CH,
.bfh-flag-CI,
.bfh-flag-CL,
.bfh-flag-CM,
.bfh-flag-CN,
.bfh-flag-CO,
.bfh-flag-CR,
.bfh-flag-CV,
.bfh-flag-CY,
.bfh-flag-CZ,
.bfh-flag-DJ,
.bfh-flag-DK,
.bfh-flag-DM,
.bfh-flag-DO,
.bfh-flag-DZ,
.bfh-flag-EC,
.bfh-flag-EE,
.bfh-flag-EG,
.bfh-flag-EH,
.bfh-flag-ER,
.bfh-flag-ES,
.bfh-flag-ET,
.bfh-flag-EU,
.bfh-flag-FI,
.bfh-flag-FJ,
.bfh-flag-FK,
.bfh-flag-FM,
.bfh-flag-FO,
.bfh-flag-FR,
.bfh-flag-FX,
.bfh-flag-GF,
.bfh-flag-GP,
.bfh-flag-MQ,
.bfh-flag-NC,
.bfh-flag-PF,
.bfh-flag-PM,
.bfh-flag-RE,
.bfh-flag-TF,
.bfh-flag-WF,
.bfh-flag-GA,
.bfh-flag-GB,
.bfh-flag-GD,
.bfh-flag-GE,
.bfh-flag-GG,
.bfh-flag-GH,
.bfh-flag-GL,
.bfh-flag-GM,
.bfh-flag-GN,
.bfh-flag-GQ,
.bfh-flag-GR,
.bfh-flag-GS,
.bfh-flag-GT,
.bfh-flag-GU,
.bfh-flag-GW,
.bfh-flag-GY,
.bfh-flag-HK,
.bfh-flag-HN,
.bfh-flag-HR,
.bfh-flag-HT,
.bfh-flag-HU,
.bfh-flag-ID,
.bfh-flag-IE,
.bfh-flag-IL,
.bfh-flag-IM,
.bfh-flag-IN,
.bfh-flag-IQ,
.bfh-flag-IS,
.bfh-flag-IT,
.bfh-flag-JE,
.bfh-flag-JM,
.bfh-flag-JO,
.bfh-flag-JP,
.bfh-flag-KE,
.bfh-flag-KG,
.bfh-flag-KH,
.bfh-flag-KI,
.bfh-flag-KM,
.bfh-flag-KN,
.bfh-flag-KP,
.bfh-flag-KR,
.bfh-flag-KV,
.bfh-flag-KW,
.bfh-flag-KY,
.bfh-flag-LA,
.bfh-flag-LC,
.bfh-flag-LK,
.bfh-flag-LR,
.bfh-flag-LS,
.bfh-flag-LT,
.bfh-flag-LU,
.bfh-flag-LV,
.bfh-flag-LY,
.bfh-flag-MA,
.bfh-flag-ME,
.bfh-flag-MG,
.bfh-flag-MH,
.bfh-flag-ML,
.bfh-flag-MM,
.bfh-flag-MP,
.bfh-flag-MR,
.bfh-flag-MS,
.bfh-flag-MT,
.bfh-flag-MU,
.bfh-flag-MV,
.bfh-flag-MW,
.bfh-flag-MZ,
.bfh-flag-NA,
.bfh-flag-NE,
.bfh-flag-NF,
.bfh-flag-NG,
.bfh-flag-NI,
.bfh-flag-NL,
.bfh-flag-NO,
.bfh-flag-NP,
.bfh-flag-NR,
.bfh-flag-NZ,
.bfh-flag-OM,
.bfh-flag-PA,
.bfh-flag-PE,
.bfh-flag-PG,
.bfh-flag-PH,
.bfh-flag-PK,
.bfh-flag-PL,
.bfh-flag-PN,
.bfh-flag-PS,
.bfh-flag-PT,
.bfh-flag-PW,
.bfh-flag-PY,
.bfh-flag-QA,
.bfh-flag-RS,
.bfh-flag-RU,
.bfh-flag-RW,
.bfh-flag-SA,
.bfh-flag-SB,
.bfh-flag-SC,
.bfh-flag-SD,
.bfh-flag-SE,
.bfh-flag-SG,
.bfh-flag-SH,
.bfh-flag-SI,
.bfh-flag-SK,
.bfh-flag-SM,
.bfh-flag-SN,
.bfh-flag-SO,
.bfh-flag-SR,
.bfh-flag-SS,
.bfh-flag-ST,
.bfh-flag-SV,
.bfh-flag-SY,
.bfh-flag-SZ,
.bfh-flag-TC,
.bfh-flag-TD,
.bfh-flag-TG,
.bfh-flag-TH,
.bfh-flag-TJ,
.bfh-flag-TM,
.bfh-flag-TN,
.bfh-flag-TP,
.bfh-flag-TR,
.bfh-flag-TT,
.bfh-flag-TV,
.bfh-flag-TW,
.bfh-flag-TZ,
.bfh-flag-UA,
.bfh-flag-UG,
.bfh-flag-US,
.bfh-flag-UY,
.bfh-flag-UZ,
.bfh-flag-VC,
.bfh-flag-VE,
.bfh-flag-VG,
.bfh-flag-VI,
.bfh-flag-VN,
.bfh-flag-VU,
.bfh-flag-WS,
.bfh-flag-YE,
.bfh-flag-ZA,
.bfh-flag-ZM,
.bfh-flag-BF,
.bfh-flag-CU,
.bfh-flag-DE,
.bfh-flag-IR,
.bfh-flag-KZ,
.bfh-flag-LB,
.bfh-flag-LI,
.bfh-flag-MC,
.bfh-flag-MD,
.bfh-flag-MK,
.bfh-flag-MN,
.bfh-flag-MO,
.bfh-flag-MX,
.bfh-flag-MY,
.bfh-flag-PR,
.bfh-flag-RO,
.bfh-flag-SL,
.bfh-flag-TO,
.bfh-flag-VA,
.bfh-flag-ZW,
.bfh-flag-EUR,
.bfh-flag-XCD {
  margin-right: 5px;
}

.bfh-flag-AD {
  background-position: -1921px 0;
}

.bfh-flag-AE {
  background-position: -1904px 0;
}

.bfh-flag-AF {
  background-position: -3689px 0;
}

.bfh-flag-AG {
  background-position: -34px 0;
}

.bfh-flag-AI {
  background-position: -51px 0;
}

.bfh-flag-AL {
  background-position: -68px 0;
}

.bfh-flag-AM {
  background-position: -85px 0;
}

.bfh-flag-AN {
  background-position: -102px 0;
}

.bfh-flag-AO {
  background-position: -119px 0;
}

.bfh-flag-AQ {
  background-position: -136px 0;
}

.bfh-flag-AR {
  background-position: -153px 0;
}

.bfh-flag-AS {
  background-position: -170px 0;
}

.bfh-flag-AT {
  background-position: -187px 0;
}

.bfh-flag-AU {
  background-position: -204px 0;
}

.bfh-flag-AW {
  background-position: -221px 0;
}

.bfh-flag-AX {
  background-position: -238px 0;
}

.bfh-flag-AZ {
  background-position: -255px 0;
}

.bfh-flag-BA {
  background-position: -272px 0;
}

.bfh-flag-BB {
  background-position: -289px 0;
}

.bfh-flag-BD {
  background-position: -306px 0;
}

.bfh-flag-BE {
  background-position: -323px 0;
}

.bfh-flag-BG {
  background-position: -340px 0;
}

.bfh-flag-BH {
  background-position: -357px 0;
}

.bfh-flag-BI {
  background-position: -374px 0;
}

.bfh-flag-BJ {
  background-position: -391px 0;
}

.bfh-flag-BL {
  background-position: -408px 0;
}

.bfh-flag-BM {
  background-position: -425px 0;
}

.bfh-flag-BN {
  background-position: -442px 0;
}

.bfh-flag-BO {
  background-position: -459px 0;
}

.bfh-flag-BR {
  background-position: -476px 0;
}

.bfh-flag-BS {
  background-position: -493px 0;
}

.bfh-flag-BT {
  background-position: -510px 0;
}

.bfh-flag-BW {
  background-position: -527px 0;
}

.bfh-flag-BY {
  background-position: -544px 0;
}

.bfh-flag-BZ {
  background-position: -561px 0;
}

.bfh-flag-CA {
  background-position: -578px 0;
}

.bfh-flag-CD {
  background-position: -595px 0;
}

.bfh-flag-CF {
  background-position: -612px 0;
}

.bfh-flag-CG {
  background-position: -629px 0;
}

.bfh-flag-CH {
  background-position: -646px 0;
}

.bfh-flag-CI {
  background-position: -663px 0;
}

.bfh-flag-CL {
  background-position: -680px 0;
}

.bfh-flag-CM {
  background-position: -697px 0;
}

.bfh-flag-CN {
  background-position: -714px 0;
}

.bfh-flag-CO {
  background-position: -731px 0;
}

.bfh-flag-CR {
  background-position: -748px 0;
}

.bfh-flag-CV {
  background-position: -765px 0;
}

.bfh-flag-CY {
  background-position: -782px 0;
}

.bfh-flag-CZ {
  background-position: -799px 0;
}

.bfh-flag-DJ {
  background-position: -816px 0;
}

.bfh-flag-DK {
  background-position: -833px 0;
}

.bfh-flag-DM {
  background-position: -850px 0;
}

.bfh-flag-DO {
  background-position: -867px 0;
}

.bfh-flag-DZ {
  background-position: -884px 0;
}

.bfh-flag-EC {
  background-position: -901px 0;
}

.bfh-flag-EE {
  background-position: -918px 0;
}

.bfh-flag-EG {
  background-position: -935px 0;
}

.bfh-flag-EH {
  background-position: -952px 0;
}

.bfh-flag-ER {
  background-position: -969px 0;
}

.bfh-flag-ES {
  background-position: -986px 0;
}

.bfh-flag-ET {
  background-position: -1003px 0;
}

.bfh-flag-EU {
  background-position: -1020px 0;
}

.bfh-flag-FI {
  background-position: -1037px 0;
}

.bfh-flag-FJ {
  background-position: -1054px 0;
}

.bfh-flag-FK {
  background-position: -1071px 0;
}

.bfh-flag-FM {
  background-position: -1088px 0;
}

.bfh-flag-FO {
  background-position: -1105px 0;
}

.bfh-flag-FR,
.bfh-flag-FX,
.bfh-flag-GF,
.bfh-flag-GP,
.bfh-flag-MQ,
.bfh-flag-NC,
.bfh-flag-PF,
.bfh-flag-PM,
.bfh-flag-RE,
.bfh-flag-TF,
.bfh-flag-WF {
  background-position: -1122px 0;
}

.bfh-flag-GA {
  background-position: -1139px 0;
}

.bfh-flag-GB {
  background-position: -1156px 0;
}

.bfh-flag-GD {
  background-position: -1173px 0;
}

.bfh-flag-GE {
  background-position: -1190px 0;
}

.bfh-flag-GG {
  background-position: -1207px 0;
}

.bfh-flag-GH {
  background-position: -1224px 0;
}

.bfh-flag-GL {
  background-position: -1241px 0;
}

.bfh-flag-GM {
  background-position: -1258px 0;
}

.bfh-flag-GN {
  background-position: -1275px 0;
}

.bfh-flag-GQ {
  background-position: -1292px 0;
}

.bfh-flag-GR {
  background-position: -1309px 0;
}

.bfh-flag-GS {
  background-position: -1326px 0;
}

.bfh-flag-GT {
  background-position: -1343px 0;
}

.bfh-flag-GU {
  background-position: -1360px 0;
}

.bfh-flag-GW {
  background-position: -1377px 0;
}

.bfh-flag-GY {
  background-position: -1394px 0;
}

.bfh-flag-HK {
  background-position: -1411px 0;
}

.bfh-flag-HN {
  background-position: -1428px 0;
}

.bfh-flag-HR {
  background-position: -1445px 0;
}

.bfh-flag-HT {
  background-position: -1462px 0;
}

.bfh-flag-HU {
  background-position: -1479px 0;
}

.bfh-flag-ID {
  background-position: -1496px 0;
}

.bfh-flag-IE {
  background-position: -1513px 0;
}

.bfh-flag-IL {
  background-position: -1530px 0;
}

.bfh-flag-IM {
  background-position: -1547px 0;
}

.bfh-flag-IN {
  background-position: -1564px 0;
}

.bfh-flag-IQ {
  background-position: -1581px 0;
}

.bfh-flag-IS {
  background-position: -1598px 0;
}

.bfh-flag-IT {
  background-position: -1615px 0;
}

.bfh-flag-JE {
  background-position: -1632px 0;
}

.bfh-flag-JM {
  background-position: -1649px 0;
}

.bfh-flag-JO {
  background-position: -1666px 0;
}

.bfh-flag-JP {
  background-position: -1683px 0;
}

.bfh-flag-KE {
  background-position: -1700px 0;
}

.bfh-flag-KG {
  background-position: -1717px 0;
}

.bfh-flag-KH {
  background-position: -1734px 0;
}

.bfh-flag-KI {
  background-position: -1751px 0;
}

.bfh-flag-KM {
  background-position: -1768px 0;
}

.bfh-flag-KN {
  background-position: -1785px 0;
}

.bfh-flag-KP {
  background-position: -1802px 0;
}

.bfh-flag-KR {
  background-position: -1819px 0;
}

.bfh-flag-KV {
  background-position: -1836px 0;
}

.bfh-flag-KW {
  background-position: -1853px 0;
}

.bfh-flag-KY {
  background-position: -1870px 0;
}

.bfh-flag-LA {
  background-position: -1887px 0;
}

.bfh-flag-LC {
  background-position: 0 0;
}

.bfh-flag-LK {
  background-position: -17px 0;
}

.bfh-flag-LR {
  background-position: -1938px 0;
}

.bfh-flag-LS {
  background-position: -1955px 0;
}

.bfh-flag-LT {
  background-position: -1972px 0;
}

.bfh-flag-LU {
  background-position: -1989px 0;
}

.bfh-flag-LV {
  background-position: -2006px 0;
}

.bfh-flag-LY {
  background-position: -2023px 0;
}

.bfh-flag-MA {
  background-position: -2040px 0;
}

.bfh-flag-ME {
  background-position: -2057px 0;
}

.bfh-flag-MG {
  background-position: -2074px 0;
}

.bfh-flag-MH {
  background-position: -2091px 0;
}

.bfh-flag-ML {
  background-position: -2108px 0;
}

.bfh-flag-MM {
  background-position: -2125px 0;
}

.bfh-flag-MP {
  background-position: -2142px 0;
}

.bfh-flag-MR {
  background-position: -2159px 0;
}

.bfh-flag-MS {
  background-position: -2176px 0;
}

.bfh-flag-MT {
  background-position: -2193px 0;
}

.bfh-flag-MU {
  background-position: -2210px 0;
}

.bfh-flag-MV {
  background-position: -2227px 0;
}

.bfh-flag-MW {
  background-position: -2244px 0;
}

.bfh-flag-MZ {
  background-position: -2261px 0;
}

.bfh-flag-NA {
  background-position: -2278px 0;
}

.bfh-flag-NE {
  background-position: -2295px 0;
}

.bfh-flag-NF {
  background-position: -2312px 0;
}

.bfh-flag-NG {
  background-position: -2329px 0;
}

.bfh-flag-NI {
  background-position: -2346px 0;
}

.bfh-flag-NL {
  background-position: -2363px 0;
}

.bfh-flag-NO {
  background-position: -2380px 0;
}

.bfh-flag-NP {
  background-position: -2397px 0;
}

.bfh-flag-NR {
  background-position: -2414px 0;
}

.bfh-flag-NZ {
  background-position: -2431px 0;
}

.bfh-flag-OM {
  background-position: -2448px 0;
}

.bfh-flag-PA {
  background-position: -2465px 0;
}

.bfh-flag-PE {
  background-position: -2482px 0;
}

.bfh-flag-PG {
  background-position: -2499px 0;
}

.bfh-flag-PH {
  background-position: -2516px 0;
}

.bfh-flag-PK {
  background-position: -2533px 0;
}

.bfh-flag-PL {
  background-position: -2550px 0;
}

.bfh-flag-PN {
  background-position: -2567px 0;
}

.bfh-flag-PS {
  background-position: -2584px 0;
}

.bfh-flag-PT {
  background-position: -2601px 0;
}

.bfh-flag-PW {
  background-position: -2618px 0;
}

.bfh-flag-PY {
  background-position: -2635px 0;
}

.bfh-flag-QA {
  background-position: -2652px 0;
}

.bfh-flag-RS {
  background-position: -2669px 0;
}

.bfh-flag-RU {
  background-position: -2686px 0;
}

.bfh-flag-RW {
  background-position: -2703px 0;
}

.bfh-flag-SA {
  background-position: -2720px 0;
}

.bfh-flag-SB {
  background-position: -2737px 0;
}

.bfh-flag-SC {
  background-position: -2754px 0;
}

.bfh-flag-SD {
  background-position: -2771px 0;
}

.bfh-flag-SE {
  background-position: -2788px 0;
}

.bfh-flag-SG {
  background-position: -2805px 0;
}

.bfh-flag-SH {
  background-position: -2822px 0;
}

.bfh-flag-SI {
  background-position: -2839px 0;
}

.bfh-flag-SK {
  background-position: -2856px 0;
}

.bfh-flag-SM {
  background-position: -2873px 0;
}

.bfh-flag-SN {
  background-position: -2890px 0;
}

.bfh-flag-SO {
  background-position: -2907px 0;
}

.bfh-flag-SR {
  background-position: -2924px 0;
}

.bfh-flag-SS {
  background-position: -2941px 0;
}

.bfh-flag-ST {
  background-position: -2958px 0;
}

.bfh-flag-SV {
  background-position: -2975px 0;
}

.bfh-flag-SY {
  background-position: -2992px 0;
}

.bfh-flag-SZ {
  background-position: -3009px 0;
}

.bfh-flag-TC {
  background-position: -3026px 0;
}

.bfh-flag-TD {
  background-position: -3043px 0;
}

.bfh-flag-TG {
  background-position: -3060px 0;
}

.bfh-flag-TH {
  background-position: -3077px 0;
}

.bfh-flag-TJ {
  background-position: -3094px 0;
}

.bfh-flag-TM {
  background-position: -3111px 0;
}

.bfh-flag-TN {
  background-position: -3128px 0;
}

.bfh-flag-TP {
  background-position: -3145px 0;
}

.bfh-flag-TR {
  background-position: -3162px 0;
}

.bfh-flag-TT {
  background-position: -3179px 0;
}

.bfh-flag-TV {
  background-position: -3196px 0;
}

.bfh-flag-TW {
  background-position: -3213px 0;
}

.bfh-flag-TZ {
  background-position: -3230px 0;
}

.bfh-flag-UA {
  background-position: -3247px 0;
}

.bfh-flag-UG {
  background-position: -3264px 0;
}

.bfh-flag-US {
  background-position: -3281px 0;
}

.bfh-flag-UY {
  background-position: -3298px 0;
}

.bfh-flag-UZ {
  background-position: -3315px 0;
}

.bfh-flag-VC {
  background-position: -3332px 0;
}

.bfh-flag-VE {
  background-position: -3349px 0;
}

.bfh-flag-VG {
  background-position: -3366px 0;
}

.bfh-flag-VI {
  background-position: -3383px 0;
}

.bfh-flag-VN {
  background-position: -3400px 0;
}

.bfh-flag-VU {
  background-position: -3417px 0;
}

.bfh-flag-WS {
  background-position: -3434px 0;
}

.bfh-flag-YE {
  background-position: -3451px 0;
}

.bfh-flag-ZA {
  background-position: -3468px 0;
}

.bfh-flag-ZM {
  background-position: -3485px 0;
}

.bfh-flag-BF {
  background-position: -3502px 0;
}

.bfh-flag-CU {
  background-position: -3519px 0;
}

.bfh-flag-DE {
  background-position: -3536px 0;
}

.bfh-flag-IR {
  background-position: -3553px 0;
}

.bfh-flag-KZ {
  background-position: -3570px 0;
}

.bfh-flag-LB {
  background-position: -3587px 0;
}

.bfh-flag-LI {
  background-position: -3604px 0;
}

.bfh-flag-MC {
  background-position: -3621px 0;
}

.bfh-flag-MD {
  background-position: -3638px 0;
}

.bfh-flag-MK {
  background-position: -3655px 0;
}

.bfh-flag-MN {
  background-position: -3672px 0;
}

.bfh-flag-MO {
  background-position: -3706px 0;
}

.bfh-flag-MX {
  background-position: -3723px 0;
}

.bfh-flag-MY {
  background-position: -3740px 0;
}

.bfh-flag-PR {
  background-position: -3757px 0;
}

.bfh-flag-RO {
  background-position: -3774px 0;
}

.bfh-flag-SL {
  background-position: -3791px 0;
}

.bfh-flag-TO {
  background-position: -3808px 0;
}

.bfh-flag-VA {
  background-position: -3825px 0;
}

.bfh-flag-ZW {
  background-position: -3842px 0;
}

.bfh-flag-EUR {
  background: url(../img/eu.png) no-repeat;
}

.bfh-flag-XCD {
  background: url(../img/xcd.png) no-repeat;
}

.bfh-flag-AUD,
.bfh-flag-CHF,
.bfh-flag-DKK,
.bfh-flag-EUR,
.bfh-flag-XAF,
.bfh-flag-XCD,
.bfh-flag-XOF,
.bfh-flag-XPF,
.bfh-flag-ZAR {
  width: 16px;
  height: 14px;
  background: url(../img/bootstrap-formhelpers-currencies.flags.png) no-repeat;
}

.bfh-flag-AUD:empty,
.bfh-flag-CHF:empty,
.bfh-flag-DKK:empty,
.bfh-flag-EUR:empty,
.bfh-flag-XAF:empty,
.bfh-flag-XCD:empty,
.bfh-flag-XOF:empty,
.bfh-flag-XPF:empty,
.bfh-flag-ZAR:empty {
  width: 16px;
}

.bfh-flag-AUD,
.bfh-flag-CHF,
.bfh-flag-DKK,
.bfh-flag-EUR,
.bfh-flag-XAF,
.bfh-flag-XCD,
.bfh-flag-XOF,
.bfh-flag-XPF,
.bfh-flag-ZAR {
  margin-right: 5px;
}

.bfh-flag-AUD {
  background-position: -32px 0;
}

.bfh-flag-CHF {
  background-position: -224px 0;
}

.bfh-flag-DKK {
  background-position: -64px -16px;
}

.bfh-flag-EUR {
  background-position: -96px -16px;
}

.bfh-flag-XAF {
  background-position: -160px -80px;
}

.bfh-flag-XCD {
  background-position: -176px -80px;
}

.bfh-flag-XOF {
  background-position: -192px -80px;
}

.bfh-flag-XPF {
  background-position: -208px -80px;
}

.bfh-flag-ZAR {
  background-position: -224px -80px;
}
	    
					</style>
	    			<%
	    		}
	    		%>
	    		
	    	
	    		
	    	
	            <!-- Notifications Menu -->
	            <li class="dropdown notifications-menu">
	                <!-- Menu toggle button -->
	                <a href="http://localhost:8080/MasterWeb/FrontController?action=loadTodolist&1=1&menuId=MENU_PCMS01_02&permChkStr2=origcmr1&permChkStr3=5&permChkStr4=" 
	                	class="dropdown-toggle" target="mainframe"  data-toggle="dropdown" 
	                	id="notifications-id" style="padding-top: 17px;padding-bottom: 17px;">
	                	<img src="screen_template/frame/Responsive2016/images/ic_notifications.png">
	                </a>
	            </li><!-- .Notifications Menu -->
	            
	            
	            <!-- User Account Menu -->
	            <li class="dropdown user user-menu">
	                <!-- Menu Toggle Button -->
	                <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
	                  <!-- The user image in the navbar-->
	                  <span class="hidden-xs"><%=username%></span>
	                  <%-- <span class="hidden-xs"><%=request.getSession().getAttribute("userName")%></span> --%>
	                  <img alt="User Image" src="<%=userImg%>" class="user-img-rounded" >
	                  <%-- <img alt="User Image" src="data:image/png;base64,<%=avatar%>" class="user-img-rounded" > --%>
	                  <!-- <img src="screen_template/frame/scripts/dist/img/user2-160x160.jpg" class="user-img-rounded" alt="User Image"> -->
	                  <!-- hidden-xs hides the username on small devices so only the image appears. -->
	                </a>
	                <ul class="dropdown-menu shadow3">
	                  <!-- The user image in the menu -->
	                  <li class="user-header">
	                  	<img src="<%=userImg%>" class="img-rounded" alt="User Image">
	                  	<%-- <img src="data:image/png;base64,<%=avatar%>" class="img-rounded" alt="User Image"> --%>
	                    <!-- <img src="screen_template/frame/scripts/dist/img/user2-160x160.jpg" class="img-rounded" alt="User Image"> -->
	                    <p>
	                      <%-- <%=request.getSession().getAttribute("userName") %> - Web Developer --%>
	                      <%-- <%=en_firstname + " " + en_lastname %> --%>
	                      <%=!"".equals(en_firstname + en_lastname) ? (en_firstname + " " + en_lastname) : username%>	                      
	                      <small><%=position %> <%=!"".equals(position + department) ? "-" : ""%> <%=department %></small>
	                    </p>
	                  </li>
	                  <!-- Menu Body -->
					  <!--
	                  <li class="user-body">
	                  </li>-->
	                  <!-- Menu Footer-->
	                  <li class="user-footer">
	                    <div class="pull-left">
	                      <!-- <a href="javascript:void(0)" class="btn btn-default btn-flat">Profile</a> -->
	                    </div>
	                    <div class="pull-right">
	                      <a href="javascript:void(0)" class="btn btn-default btn-flat" onclick="logOut();">Sign out</a>
	                    </div>
	                  </li>
	                </ul>
	            </li>
	        </ul>
         
      </div> <!-- /.navbar-collapse -->
    
    </div>
</nav>
<!-- </body> -->
<!-- </html> -->
<%@page import="com.master.util.MasterCacheUtil"%>
<%@ page import="java.util.Date"%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/tld/JStartTagLib.tld" prefix="taglib"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="new_screen_definitions.jsp"%>
<!DOCTYPE  html> 
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<!--<![endif]-->
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<% 
boolean divTheme = com.avalant.feature.ExtendFeature.getInstance().useFeature("FT003_DivTmObj");
boolean googleMap = com.avalant.feature.ExtendFeature.getInstance().useFeature("GOOGLE_MAP"); 
request.setAttribute("_divTheme", divTheme);
request.setAttribute("_now", MasterCacheUtil.time);
request.setAttribute("_googleMap", googleMap);
%>

<script>var CONTEXTPATH="${pageContext.request.contextPath}";
		var FRONTCONTEXT="/FrontWeb";
</script>

<jsp:include page="massage/constant-javascript.jsp" flush="true" />
<jsp:include page="message/constant-master.jsp" flush="true" />

<link href="javascript/bootstrap/css/bootstrap.min.css?v=${ _now }" rel="stylesheet" />
<link href="javascript/bootstrap/font-awesome/css/font-awesome.min.css?v=${ _now }" rel="stylesheet" />

<link rel="stylesheet" href="theme/dist/css/skins/skin-blue.min.css?v=${ _now }"/>
<link rel="stylesheet" href="theme/dist/css/AdminLTE.min.css?v=${ _now }"/>
<link href="<c:url value="/eaf40/image-viewer/css/smart-data.css"/>?v=${_now}" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="javascript/field_property/money.js?v=${ _now }"></script>

<%
// 	boolean divTheme = com.avalant.feature.ExtendFeature.getInstance().useFeature("FT003_DivTmObj");
// 	boolean googleMap = com.avalant.feature.ExtendFeature.getInstance().useFeature("GOOGLE_MAP"); 
// 	request.setAttribute("_divTheme", divTheme);
// 	request.setAttribute("_now", MasterCacheUtil.time);
// 	request.setAttribute("_googleMap", googleMap);
 %>

<!-- <script type="text/javascript" src="javascript/3_3_30/jquery-custom-a.js?v=${ _now }"></script> -->
<script type="text/javascript" src="javascript/3_3_30/jquery-custom-a.min.js?v=${ _now }"></script>
<script>
//Prevent auto-execution of scripts when no explicit dataType was provided (See gh-2432)
jQuery.ajaxPrefilter( function( s ) {
    if ( s.crossDomain ) {
        s.contents.script = false;
    }
});
</script>
<!-- <script type="text/javascript" src="javascript/3_3_30/jquery-ui-1.10.0.min.js?v=${ _now }"></script> -->
<script type="text/javascript" src="javascript/3_3_30/jquery-ui-1.10.4.custom.20170416.min.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/bootstrap/js/bootstrap.min.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/bootstrap/js/bootstrap-dialog.min.js?v=${ _now }"></script>

<!-- EAF Version 3.3.30 use  jquery-1.7.2
<script type="text/javascript" src="javascript/custom_framework/jquery-1.3.2.js"></script>
 -->
<!-- <script type="text/javascript" src="javascript/3_3_30/jquery-1.7.2.min.js"></script>  -->

<c:choose>
 	<c:when test="${ _divTheme }">
 		<script type="text/javascript" src="javascript/custom_framework/jqueryEditInLineDivTheme.js?v=${ _now }"></script>
		<script type="text/javascript" src="javascript/custom_framework/jqueryScrollingNavigator.js?v=${ _now }"></script>
 	</c:when>
 	<c:otherwise>
 		<script type="text/javascript" src="javascript/custom_framework/jqueryEditInLine.js?v=${ _now }"></script>
 	</c:otherwise>
</c:choose>
 
<script type="text/javascript" src="javascript/custom_framework/jqueryUtil.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/custom_framework/blockScreen.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/custom_framework/jquery.blockUI.js?v=${ _now }"></script>

<%
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 201701221703
* change including jQuery MaskInput 1.3 from /manual/js to javascript/custom_framework/jquery.maskedinput-1.3.js
* (also delete file from workspace)
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
%>

<script type="text/javascript" src="javascript/custom_framework/jquery.maskedinput-1.3.1.min.js?v=${ _now }"></script>
<% 
// 000138
%>
<script type="text/javascript" src="javascript/3_3_30/jquery.form.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/constant.js?v=${ _now }"></script>
<%-- <script type="text/javascript" src="javascript/masterweb.min.js?v=${ _now }"></script> --%>
<script type="text/javascript" src="javascript/masterweb.js?v=${ _now }"></script>

<!-- <script type="text/javascript" src="date-picker.js"></script>   
<script type="text/javascript" src="DateFormat.js"></script> -->

<c:choose>
 	<c:when test="${ _divTheme }">
		<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/3_3_30/jquery-popcalendar.js?v=${ _now }"></script>
	</c:when>
 	<c:otherwise>
 		<script type="text/javascript" src="popcalendar.js?v=${ _now }"></script> 
	</c:otherwise>
</c:choose>

<!-- script language="JavaScript" src="date-picker.js" type="text/javascript"></script> -->

<script type="text/javascript" src="DateFormat.js?v=${ _now }" type="text/javascript"></script>
<script type="text/javascript" src="masterJS.js?v=${ _now }" ></script>
<script type="text/javascript" src="Ajax.js?v=${ _now }" ></script>
<script type="text/javascript" src="openDialog.js?v=${ _now }" ></script>
<script type="text/javascript" src="tiny_mce/tiny_mce.js?v=${ _now }"></script>
<script type="text/javascript" src="manual/js/manualAvale.js?v=${ _now }"></script>
<script type="text/javascript" src="sessionTimeOut.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/checkBoxUtil.js?v=${ _now }"></script>

<!-- <script type="text/javascript" src="javascript/3_3_30/jquery-ui-1.8.23.custom.min.js"></script> -->
<%
/*
 * FIX : 201707161311 : session timeout 
 */
 %>
<script type="text/javascript" src="javascript/3_3_30/jquery-migrate-1.0.0.js"></script>

<script type="text/javascript" src="javascript/3_3_30/jquery-radio-0.0.1.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/3_3_30/jquery-checkbox-0.0.1.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/3_3_30/jquery-listbox-0.0.1.js?v=${ _now }"></script>

<!-- script type="text/javascript" src="javascript/3_3_30/jquery-ui-1.8.10.offset.datepicker.min.js"></script-->
<!-- <script language="JavaScript" src="javascript/3_3_30/jquery-ui-1.10.3.custom.datepicker.js"></script> -->

<c:choose>
 	<c:when test="${ _divTheme }">
		<script type="text/javascript" src="javascript/3_3_30/eafObject.js?v=${ _now }"></script>
		<script type="text/javascript" src="javascript/3_3_30/eafJson.js?v=${ _now }"></script>
	</c:when>
</c:choose>

<script type="text/javascript" src="javascript/3_3_30/json2.js?v=${ _now }"></script>
<script type="text/javascript" src="javascript/3_3_30/swfobject.2.2.js?v=${ _now }"></script>

<c:if test="${ _googleMap }">
<!-- 	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpM2mhkGfeZSLIMey0XkcHh9ZYFdm2l-4&sensor=false"></script> -->
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpM2mhkGfeZSLIMey0XkcHh9ZYFdm2l-4&sensor=false&libraries=places"></script>
	
	<script type="text/javascript" src="javascript/3_3_30/googleMapUtil.js?v=${ _now }"></script>
</c:if>

<!-- Override some javascript function by Browser type -->
<%
String ua = request.getHeader( "User-Agent" );
System.out.println("User-Agent : " + ua);

if(ua.indexOf("Safari") != -1 
	|| ua.indexOf("Firefox") != -1 
	|| ua.indexOf("Chrome") != -1
	|| ua.indexOf("MSIE 9.0") != -1
	|| ua.indexOf("MSIE 10.0") != -1){
%>
<script type="text/javascript" src="javascript/3_3_30/newBrowserScript.js?v=${ _now }"></script>
<%}%>


<jsp:include flush="true" page="verify_action_error.jsp"></jsp:include> 


<% 
try {
	String entityID = (String)request.getSession().getAttribute("entityID");	

	String entitySession = entityID +"_session";
	
	System.out.println("entitySession==>"+entitySession);
	
	com.master.form.EntityFormHandler form = (com.master.form.EntityFormHandler) request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new com.master.form.EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	String themeCode = form.getEntityM().getThemeCode();
%>

<jsp:include flush="true" page="theme/theme.jsp">
	<jsp:param name="themeCode" value="<%=themeCode%>" />
</jsp:include> 

</head>
<title>Avalant</title>
<body style="height:100%;">
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 
	<input type="hidden" id="lang" value="<%=session.getAttribute("LOCALE").toString().toLowerCase()%>">

<div id="container" class="content-wrapper">
	<div style="overflow: hidden;display: block;" >
		<taglib:insert parameter="HtmlBody" direct="false" />
	</div>
		
	<div id="loaderDiv">
	</div>

</div>

<script type="text/javascript">

<%
} catch (Exception e) {
	out.print(e);
}
%>
	
	/*------------------------------------------------------------------*/	
	
	function disableEnterKeyDown(event) {
		var keyCode = event.keyCode;
		var enter = 13;
		var backSpace = 8;
		if(keyCode == enter)	{
			//  fix can not enter in textarea
			//event.returnValue = false;
			try 
			{
				if(event.srcElement.type == 'textarea')
				{
					event.returnValue = true;
				}
				else if(event.srcElement.type == 'text' 
					&&  event.srcElement.name == 'searchTxt'
					&&  $(event.srcElement).parent().find('[name=BGo]').length > 0)
				{
					try 
					{
						clickBPreviousNext(window.form1,1);
					} 
					catch(e) {}
				}
				else
				{
					event.returnValue = false;
				}
			} 
			catch(e) 
			{
				event.returnValue = false;
			}
		}else if(keyCode == backSpace)	{
			if(event.srcElement.type != 'textarea')
			{
				event.keyCode=0;
			} 
			return event.keyCode; 
		}	
	}
	
	function textareaFixHeight() {
		//console.log("textarea stuff");
		if ($('div.textbox1search > div.componentDiv > textarea').length != 0) {
		var cla = $('div.textbox1search > div.componentDiv > textarea').closest("div").attr("class");
		var yy = $('div.'+cla).parent().attr("class");
		$('.'+yy).each(function(index, value) {  
			if($(this).find('div.componentDiv > textarea').length != 0){
				$(this).css({"height":"80px"});//console.log("textarea found");
				$(this).children('.boxsearch').css({"height":"80px"});
			}else{
			}
		});
		}

		if ($('div.textbox1 > div.componentDiv > textarea').length != 0) {
			$('.textbox1').each(function(index, value) {  
				if($(this).find('div.componentDiv > textarea').length != 0){
					$(this).css({"height":"80px"});
				}else{
				}
			});
		}
		if ($('div.textbox1 > div.textbox50right > div.componentDiv > textarea').length != 0) {
			$('.textbox1').each(function(index, value) {  
				if($(this).find('div.componentDiv > textarea').length != 0){
					$(this).css({"height":"80px"});
				}else{
				}
			});
		}
	}

	jQuery(document).ready(function() {
		textareaFixHeight();		
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		* Fix :: 01/09/2016 :: remove disableRightClick
		* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		//disableRightClick();
		document.body.onkeydown = function(){disableEnterKeyDown(event);}
		checkSession();
		postInitEAF();
	});
	
	function checkSession() {
		var uri = FRONTCONTEXT+"/CallSessionServlet";						 
		dataString ="";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   error: function(data){
		   },
		   success: function(data){					
	   		if (data == "None") {		   		
		   		timeoutPopup()
		   		//window.location.href = "/FrontWeb/logon_screen.jsp";
		   	}
		   }
		}); 	
	}
</script>
<!-- <link href="theme/select2.css" rel="stylesheet" />
<script type="text/javascript" src="javascript/json2.js"></script>
<script type="text/javascript" src="javascript/select2.js"></script>
 -->
 <script type="text/javascript">
$(function (){
	//$("select").select2({
	//	width: 'resolve'
	//});
	$('.alldot2').prev('input[type=text]').addClass('alldot2_adjustwidth');
	$('.alldot2').next('input[type=text]').addClass('alldot3_adjustwidth');
	
	
	$('.textinbox-boxbold4').each(function() {
      if(($(this).next('.alldot2').length)>=1){
        //$(this).css({"left":"120px"});
        $(this).next('.alldot2').css({"left":"265px !important"});
        $(this).next('.textinbox-boxbold5').css({"left":"280px !important"});
      }
    });


	$('textarea').each(function(index, value) {  
       $(this).parent().parent().css({"overflow":"hidden"});
       $(this).parent().parent().css({"min-height":"30px"});
        //$(this).parent().parent().parent().css({"height":"90px"});
     });	 

    $(document).on('click mouseover keyup','textarea',function(){
		$(this).parent().parent().css({"overflow":"visible"});
	});
    $(document).on('mouseout','textarea',function(){
		$(this).parent().parent().css({"overflow":"hidden"});
	});
    
	
/* 	
	$('textarea').each(function(index, value) {  
         $(this).parent().parent().addClass('textarea-high');
         $(this).parent().parent().siblings().addClass('textarea-high'); 
      });	  */

/*     	$('textarea').parent().parent().css({'height':'100px'});
    	$('textarea').parent().parent().siblings.css({'height':'100px'});
 */
	/* $('.componentDiv').each(function(index, value) {  
          var hmt = $('.textinbox-boxbold4').next('.alldot2').next('.textinbox-boxbold5').length;
          console.log(hmt);
        
         if(hmt >= 1){
           $('.alldot2').css({"left":"225px"});
           //$('.textinbox-boxbold4').css({"width":"300px"});
           $('.textinbox-boxbold5').css({"left":"246px"});
         }
      });	 */
	
	/*
	var lang = $('#lang').val();
	var isDateBuddist = false;
	if("en_us"!==lang){
		isDateBuddist = true;	
		var wdays = ['อา.','จ.','อ.','พ.','พฤ.','ศ.','ส.'];
		var wdayslong = ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์'];
		var monthslong = ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม'];
		var monthsshort = ['ม.ค.','ก.พ.','มี.ค.','เม.ย.','พ.ค.','มิ.ย.','ก.ค.','ส.ค.','ก.ย.','ต.ค.','พ.ย.','ธ.ค.'];
$('input[type=text]').val(function(index, value) {
			   if(isGoodDate(value)){
			      return doThai(value);
			   }
		});
		$( "div.fontdatatable1 > span" ).each(function( index ) {
		  value = $(this).text();
     	  if(isGoodDate(value)){
     		 $(this).html(doThai(value));
		  }
		});
	}
	*/
	/* $(".calendarOld_X,.calendarOld_TO_X").datepicker({
		dateFormat: 'dd/mm/yy',
		//showOn: "button",
        //buttonImageOnly: true,
		//buttonImage: '/MasterWeb/images/calendar_new.png',
		changeMonth:true,
		changeYear: true,
		yearRange: "-60:+27",
		isBuddhist: isDateBuddist,
		dayNames:wdayslong,
		dayNamesMin: wdays,
		monthNames: monthslong,
        monthNamesShort: monthsshort,
		onChangeMonthYear: function (year, month, inst) {
            var curDate = $(this).datepicker("getDate");
            if (curDate == null)
            return; 
            if (curDate.getYear() != year || curDate.getMonth() != month - 1) {
                curDate.setYear(year);
                curDate.setMonth(month - 1);
                $(this).datepicker("setDate", curDate);
            }
        }
	}).keyup(function(e) {
    	if(e.keyCode == 8 || e.keyCode == 46) {
        	$.datepicker._clearDate(this);
    	}
	});;	 */
});

function doThai(value) {
	if(isGoodDate(value)){
		 var tn = value.split("/");
		 var thaidate="";
   		 if(tn[2]<2400){
	       var thaiyear = parseInt(tn[2])+543;
	       thaidate = tn[0]+"/" + tn[1] +"/" + thaiyear;
         }
   	return thaidate;
   }
}

function doEnglish(value){
		 var tn = value.split("/");
		 var engdate="";
		 alert("engdate="+value);
   		 if(parseInt(tn[2])>2400){
	       var engyear = parseInt(tn[2])-543;
	       engdate = tn[0]+"/" + tn[1] +"/" + engyear;
         }
   	return engdate;
}

function isGoodDate(dt){
    var reGoodDate = '/^((0?[1-9]|[12][0-9]|3[01])[- /.](0?[1-9]|1[012])[- /.](19|20|25)?[0-9]{2})*$/';
    return reGoodDate.test(dt);
}

</script>
</body>
</html> 

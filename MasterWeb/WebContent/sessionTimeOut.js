 /*
 * FIX : 201707161311 : session timeout 
 */

var logoutHref = ".."+FRONTCONTEXT+"/logout.jsp";
var $growlUI;

function timeoutPopup() {
	$(document).ready( function() {
		$.blockUI( {
			message : null,
			fadeIn : 1000,
			timeout : 2000,
			onBlock : function() {
				//alert('Session has expired.');
				alert($.MasterWeb.message(ONEWEB_SYSTEM_MSG.SESSION_EXPIRED));
				
				if (window.opener) {
					//window.opener.parent.top.header.redirect(); // for DCS first phase
					//window.opener.parent.top.header.stopUpdateTime('LOGOUT');
					window.location.href=logoutHref;
					window.close();
				} else {
					//parent.top.header.redirect(); // for DCS first phase
					try {
						//parent.top.header.stopUpdateTime('LOGOUT');
						//window.location.href=logoutHref;
						top.logOut(true);
					} catch (e) {
						//window.location.href = "/FrontWeb/logout.jsp";
					}
				}
			}
		});
	});
}

function beforetimeout(time) {

	//var $growlUI = parent.$('div.growlUI')
	$growlUI = parent.$('div.growlUI');
	if($growlUI.length == 0) {
//		$(parent.document.body).append('<style type=\"text/css\">'+
//				//'div.growlUI { background: url(/DCSWeb/img/clock_error.png) no-repeat 5px 5px }'+
//				'div.growlUI h1, div.growlUI h2 { color: white; padding: 1px 1px 5px 75px; text-align: left }'+
//				'div.growlUI h3 { font-size: 13px }'+
//				"</style>"+
//				//'<div id"growlUIPopup" class="growlUI" style="display:none"> '+
//				'<div id"growlUIPopup" class="growlUI"> '+
//				'<h4>Session will expire in <span id="timer">60</span> seconds</h4><br> '+
//				'<div><input type=button value="Stay Logged In" class="btn btn-default" onclick="ajaxExtendTimeout()"></div> '+
//				'</div>'
//		);
//		$growlUI.hide();
//		$growlUI = parent.$('div.growlUI')
		
		var $test = '<style type=\"text/css\">'+
		//'div.growlUI { background: url(/DCSWeb/img/clock_error.png) no-repeat 5px 5px }'+
		'div.growlUI h1, div.growlUI h2 { color: white; padding: 1px 1px 5px 75px; text-align: left }'+
		'div.growlUI h3 { font-size: 13px }'+
		"</style>"+
		//'<div id"growlUIPopup" class="growlUI" style="display:none"> '+
		'<div id"growlUIPopup" class="growlUI"> '+
		//'<h4>Session will expire in <span id="timer">60</span> seconds</h4><br> '+
		'<h4>'+$.MasterWeb.message(ONEWEB_SYSTEM_MSG.BEFORE_SESSION_TIMEOUT, [60])+'</h4><br> '+
		//'<div><input type=button value="Stay Logged In" class="btn btn-default" onclick="ajaxExtendTimeout()"></div> '+
		'<div><input type=button value="'+$.MasterWeb.message(ONEWEB_SYSTEM_MSG.EXTEND_SESSION_TIMEOUT)+'" class="btn btn-default" onclick="ajaxExtendTimeout()"></div> '+
		'</div>';
		
		$(document).ready( function() {
			$.blockUI( {
				message : $test, //$('div.growlUI'),
				fadeIn : 700,
				fadeOut : 700,
				showOverlay : false,
				centerY : false,
				css : {
					width : '350px',
					top : '10px',
					left : '',
					right : '20px',
					border : 'none',
					padding : '5px',
					backgroundColor : '#000',
					'-webkit-border-radius' : '10px',
					'-moz-border-radius' : '10px',
					opacity : .6,
					color : '#fff'
				},
				onBlock : function() {
					count = 60;
					clearTimeout(timeid);
					countdown();
				}
			});
			// setTimeout($.unblockUI, 2000);
		});
	}
}

function closecountdown() {
	try {
		$.unblockUI();
		clearTimeout(timeid);
		count = 180;
	} catch (e) {
	}
}

var count = 60;
var timeid;
function countdown() {
	if (count > 0) {
		count = count - 1;
		$("#timer").html(count);
		timeid = setTimeout("countdown()", 1000);
	} else {
		clearTimeout(timeid);
		timeoutPopup();
	}
}
/**sessiontimeout.js**/
var beforesessionTimeOut;
var MaxInactiveInterval;
if(parent.$('#sessiontimeout')) {
	MaxInactiveInterval = 3000000;
	if(parent.$('#sessiontimeout').val()){
		MaxInactiveInterval = parent.$('#sessiontimeout').val() *1000;
	}
	//parent.header.sessiontTimeOut = setTimeout( "alert('Session has expired.');parent.header.redirect();", 10000 );
}else{
	// if( window.opener.parent&&window.opener.parent.header){
  if(!(window.opener.closed)&& window.opener.parent){
	 MaxInactiveInterval = window.opener.$('#sessiontimeout').val() *1000;
  }else{
	 MaxInactiveInterval = 3000000;
  }
  //window.opener.parent.header.sessiontTimeOut = setTimeout( "alert('Session has expired. popup');window.opener.parent.header.redirect();window.close();", 20000 );
}
 
//$(document).bind("ajaxSend", function(){
//	resetTimeout(beforesessionTimeOut);
//	beforesessionTimeOut = startTimeout("timeoutPopup();");
//});

var sessiontTimeOut;
//MaxInactiveInterval = 65000;
var beforeMaxInactiveInterval = MaxInactiveInterval - 60000;

function startTimeout(script){
	beforesessiontTimeOut = setTimeout( 'beforetimeout();', beforeMaxInactiveInterval);
	//sessiontTimeOut = setTimeout( script, MaxInactiveInterval );
	return beforesessiontTimeOut
}

function ajaxExtendTimeout() {
	jQuery.ajax({
		type: "GET",
		url: CONTEXTPATH + '/ajax/system/extendsession',
		success: function () {
			//resetTimeout(beforesessionTimeOut);
			//beforesessionTimeOut = startTimeout("timeoutPopup();");
			//$.unblockUI();
			
			$.unblockUI();
			beforeMaxInactiveInterval = MaxInactiveInterval - 60000;
			resetTimeout(beforesessionTimeOut);
			beforesessionTimeOut = startTimeout("timeoutPopup();");
			//var $growlUI = parent.$('#growlUIPopup');
			
//			alert($growlUI.length)
//			$growlUI.hide();
		}
	});
}

function resetTimeout(beforesessionTimeOut){
	clearTimeout(beforesessionTimeOut);
	clearTimeout(sessiontTimeOut);
	closecountdown();
	if(window.opener){
		try{
			window.opener.closecountdown();
		}catch(err){}
	}
}

$(document).ready( function() {
	resetTimeout(beforesessionTimeOut);
	beforesessionTimeOut = startTimeout("timeoutPopup();");
});

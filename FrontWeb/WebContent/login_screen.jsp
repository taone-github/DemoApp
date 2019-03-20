<!DOCTYPE html>
<%-- <%@page import="java.util.UUID"%> --%>
<%@ page contentType="text/html;charset=tis-620"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%>

<!-- <!DOCTYPE html> -->
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
<title>ONEWEB Login Form</title>
<script type="text/javascript" src="screen_template/frame/scripts/jquery-custom-b.js"></script>
<script>
//Prevent auto-execution of scripts when no explicit dataType was provided (See gh-2432)
jQuery.ajaxPrefilter( function( s ) {
    if ( s.crossDomain ) {
        s.contents.script = false;
    }
});
</script>

<script type="text/javascript" src="screen_template/frame/scripts/bootstrap/js/bootstrap.min.js"></script>


<!-- <link rel="stylesheet" href="screen_template/frame/scripts/bootstrap/css/bootstrap.min.css"/> -->
<link rel="stylesheet" href="screen_template/frame/scripts/font-awesome/css/font-awesome.min.css"/>
<link rel="stylesheet" href="css/login_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--[if lt IE 9]><script src="//MasterWeb/html5.js"></script><![endif]-->
<style>
input[type=submit]{
	font-size: 15px;
}
</style>
</head>
<body onkeydown="workKeyDown(event)">
	<form action="j_security_check" method="post" name="logonform" onsubmit="return false" style="display: none;">
		
		<article class="login">
			<figure class="logo_icon"></figure>
			<hgroup class="warptext_user">
				<!-- input type="text" name="userName" id="usernameTextEdit" class="textboxlogin" value="" placeholder="Username" -->
				<input type="text" name="j_username" id="usernameTextEdit" class="textboxlogin" value="" placeholder="Username" autocomplete="off">
			</hgroup>
			<hgroup class="textbox_password">
				<!-- iinput type="password" name="password" id="passwordTextEdit" class="textboxlogin" value="" placeholder="Password" autocomplete="off" -->
				<input type="password" name="j_password" id="passwordTextEdit" class="textboxlogin" value="" placeholder="Password" autocomplete="off">
			</hgroup>
			<a href="#" >
				<!-- button class="btn_login btn btn-primary btn-lg" name="commit" value="Login" onclick="launchApplication()" onmouseover="overButton(this)" onmouseout="outButton(this)">Login</button -->
				<button type="submit" class="btn_login btn-lg" 
				name="commit" value="Login" onclick="launchApplication()" 
				onmouseover="overButton(this)" onmouseout="outButton(this)"
				data-loading-text="<i class='fa fa-spinner fa-pulse fa-fw fa-spin'></i>&nbsp;&nbsp;Login"
				>
				
				Login</button>
			</a>
			<!-- Log In Error Message -->
			<c:if test="${param.jSecError == true}">
				<p>Your Username or Password is not correct. Please fill in again</p>
			</c:if>
			<c:if test="${err != null}">
				<p>${err}</p>
			</c:if>
			
			
			<hgroup class="copyright">
				<img class="logo_oneweblogin" src="images/oneweblogologin.png">
				<br><br>&copy; 2016 - All Rights Reserved by Avalant
			</hgroup>
		</article>
	</form>
	



	<script type="text/javascript">
		$(document).ready(function() {
			$('form[name=logonform]').fadeIn('slow');
			$('#usernameTextEdit').focus();
		});
		
		top.window.moveTo(0, 0);
		if (document.all) {
			top.window.resizeTo(screen.availWidth, screen.availHeight);
		} else if (document.layers || document.getElementById) {
			if (top.window.outerHeight < screen.availHeight
					|| top.window.outerWidth < screen.availWidth) {
				top.window.outerHeight = screen.availHeight;
				top.window.outerWidth = screen.availWidth;
			}
		}
		
		function launchApplication() {
			
			clearEscape('usernameTextEdit');
			
			clearEscape('passwordTextEdit');
			
			$('#usernameTextEdit').attr('disabled', 'disabled');
			$('#passwordTextEdit').attr('disabled', 'disabled');
			
			$('button[name=commit]').button('loading');
			
			$('form[name=logonform]').fadeTo( "fast" , 0.5, function() {
				//alert('before ajax')				
				   jQuery.ajax({
						type: "POST",
						data : {
							password : $('#passwordTextEdit').val()
						},
						url: 'IASOldLogonServlet',
						success: function(data) {
							
							setTimeout( function() {
								
								$('#usernameTextEdit').attr('disabled', false);
								$('#passwordTextEdit').attr('disabled', false);
								//alert('before submit')
								document.logonform.submit();
								
							}, 1000 );
							
						},
						error: function (jqXHR, exception) {
							
							$('#usernameTextEdit').attr('disabled', false);
							
							$('#passwordTextEdit').attr('disabled', false);
						
							if (jqXHR.status === 0) {
					            msg = 'Not connect.\n Verify Network.';
					        } else if (jqXHR.status == 404) {
					            msg = 'Requested page not found. [404]';
					        } else if (jqXHR.status == 500) {
					            msg = 'Uncaught Error [500]\n' + jqXHR.responseText;
					        } else if (exception === 'parsererror') {
					            msg = 'Requested JSON parse failed.';
					        } else if (exception === 'timeout') {
					            msg = 'Time out error.';
					        } else if (exception === 'abort') {
					            msg = 'Ajax request aborted.';
					        } else {
					            msg = 'Uncaught Error.\n' + jqXHR.responseText;
					        }
							
					        alert(msg);
						}
					});
					
			});
			
			return;
		}
		function workKeyDown(event) {
			var keyCode = event.keyCode;
			var enter = 13;
			if (keyCode == enter) {
				event.returnValue = false;
				launchApplication();
			}
		}

		function clearEscape(objid) {
			var str = $('#' + objid).val();
			str = str.replace(/%0D/gi, "");
			str = str.replace(/%0A/gi, "");
			$('#' + objid).val(str);
		}
	</script>
	<script src="js/general.js" type="text/javascript"></script>
</body>
</html>
<script>
if(window.name != 'asset_window') {
	var thePage = "login_screen.jsp";
	var sx=(screen.width-1440)/2;
	var sy=(screen.height-900)/2;
	application=window.open(thePage,'asset_window','width=1440,height=900,top='+sy+',left='+sx+',resizable=1,toolbar=0,scrollings=1,scrollbars=1,status=false');
	window.opener = self;
	document.body.innerHTML = '';
	document.body.style.backgroundColor = '#FFFFFF';
	document.body.style.backgroundImage = 'none';
	window.close();
}
</script>

<%
try { 
	request.getSession().invalidate();
	System.out.println("Session invalidated.");
} catch(Exception e) {}

try {
	request.logout();
	System.out.println("loged out.");
} catch(Exception e) {}
%>

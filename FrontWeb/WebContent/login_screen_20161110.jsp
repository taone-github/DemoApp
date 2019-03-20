<%@ page contentType="text/html;charset=tis-620"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>ONEWEB Login Form</title>
<link rel="stylesheet" href="css/login_style.css">

<!--[if lt IE 9]><script src="//MasterWeb/html5.js"></script><![endif]-->
<style>
input[type=submit]{
	font-size: 15px;
}
</style>
</head>
<body onkeydown="workKeyDown(event)">
	<div class="warplogin login">
		<form action="LogonServlet" method="post" name="logonform">
			<table width="100%" class="centered" border="0" cellspacing="0" cellpadding="0">
				<TR><TD>
					<input type="text" name="userName" id="usernameTextEdit" class="textboxlogin" value="" placeholder="Username">
				</TD></TR>
				<TR><TD>
					<input type="password" name="password" id="passwordTextEdit" class="textboxlogin" value="" placeholder="Password">
				</TD></TR>
				<TR><TD>
					<input type="submit" name="commit" value="Login" onclick="launchApplication()" onmouseover="overButton(this)" onmouseout="outButton(this)">
				</TD></TR>
				<TR>
					<td colspan="4" align="center"><font class="textError"><!-- Log In Error Message --><%=(request.getSession().getAttribute("err")!= null)?(String)request.getSession().getAttribute("err"):""%></font></td>
				</TR>				
	     	</table>
	 	</form>
		&copy; 2016 Avalant All right reserved 
	</div>
	



	<script type="text/javascript">
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
			//var thePage = "blank.jsp";
			//application=window.open(thePage,'appWindow','width='+screen.availWidth+',height='+screen.availHeight+',top=0,left=0,resizable=1,toolbar=0,scrollings=1,scrollbars=1,status=1');
			clearEscape('usernameTextEdit');
			clearEscape('passwordTextEdit');
			document.logonform.submit();
			//application.window.focus();
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
	<script src="screen_template/frame/scripts/jquery-1.9.1.js" type="text/javascript"></script>
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

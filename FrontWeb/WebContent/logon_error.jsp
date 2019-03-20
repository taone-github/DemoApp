<%@ page contentType="text/html;charset=tis-620"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html>
<title>TISCO Bank - Credit Bureau System</title>
<meta http-equiv="Content-Type" content="text/html;charset=Windows-874">
<head>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<script src="js/general.js" type="text/javascript"></script>
<script type="text/javascript">
top.window.moveTo(0,0);
if (document.all) {
top.window.resizeTo(screen.availWidth,screen.availHeight);
}
else if (document.layers||document.getElementById) {
if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
top.window.outerHeight = screen.availHeight;
top.window.outerWidth = screen.availWidth;
}
}
function launchApplication(){
document.logonform.submit();
}
function workKeyDown(event){
var keyCode = event.keyCode;
var enter = 13;
if(keyCode ==enter)	{
	event.returnValue = false;
	launchApplication();
}				
}
</script>
</head>
<body leftmargin="0" topmargin="0" background="" onkeydown="workKeyDown(event)">
<form action="LogonServlet" method="post" name="logonform">
<table class="list" width="100%" border="0" cellpadding="0"
	cellspacing="0" align="center">
	<tr>
		<td colspan="2"><img src="images/logon/c.gif" alt="" width="100%" height="1"></td>
	</tr>
	<tr>
		<td valign="top" width="80%"><img src="images/logon/logo.gif"  alt=""></td>
		<td align="right" valign="middle" >&nbsp;</td>
	</tr>
</table>
<table class="list" width="100%" border="0" cellpadding="0" cellspacing="0" align="center" background="images/logon/bg_submain.GIF">
	<tr>
		<td colspan="2"><img src="images/logon/c.gif" alt="" width="780" height="1"></td>
	</tr>
	<tr>
		<td bgcolor="" valign="top"><img src="images/logon/c.gif" alt="" width="100" height="1"></td>
		<td bgcolor="" align="right" valign="top">&nbsp;</td>
	</tr>
</table>
<table class="wholePage" border="0">
	<tr>
		<td class="centered">
		<div class="logon-container">
		<table class="centeredPanel" width="80%" border="0" cellpadding="0" cellspacing="0">
			<tr class="panelTitlebar" style="">
				<td class="panelText">&nbsp;<b>Application Log In</b></td>
			</tr>
			<tr class="list">
				<td class="bannerGreeting" align="center"><b> Welcome to Credit Bureau System</b></td>
			</tr>
			<tr>
				<td style="padding:10px; text-align: center">
				<table width="100%" class="centered" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="4" class="list" align="center"><img src="images/logon/c.gif" width="1" height="20" alt=""><b>กรุณาใส่ชื่อผู้ใช้บริการและรหัสผ่าน</b><br>Please fill in your username and password.</td>
					</tr>
					<tr>
						<td colspan="4"><img src="images/logon/c.gif" width="1" height="20" alt=""></td>
					</tr>
					<tr class="list" height="35">
						<td>&nbsp;</td>
						<td align="left"><label for="usernameTextEdit"> <b>ชื่อผู้ใช้บริการ : </b><br> Username : </label></td>
						<td><input type="text" name="userName" value="" style="10" class="textbox" id="usernameTextEdit" onfocus="overTextBox(this)" onblur="outTextBox(this)"></td>
						<td>&nbsp;</td>
					</tr>
					<tr class="list" height="35">
						<td>&nbsp;</td>
						<td align="left"><label for="passwordTextEdit"> <b>รหัสผ่าน : </b><br> Password : </label></td>
						<td><input type="password" name="password" value="" style="10" class="textbox" id="passwordTextEdit" onfocus="overTextBox(this)" onblur="outTextBox(this)"></td>
						<td>&nbsp;</td>
					</tr>
					<tr class="list" height="35">
						<td>&nbsp;</td>
						<td align="left"><label for="jobDateTextEdit"><b>วันที่ทำงาน : </b><br> Job Date : </label></td>
						<td colspan="2"><input type="text" name="job_date" value="<%=(new SimpleDateFormat("dd/MM/yyyy")).format(new Date())%>" size="11" maxlength="10" class="textbox" id="jobDateTextEdit" onfocus="overTextBox(this)" onblur="outTextBox(this)">&nbsp;(DD/MM/YYYY, e.g., 01/03/2007)</td>
					</tr>
					<tr height="35">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><input type="button" value="Submit" class="button" onclick="launchApplication()" onmouseover="overButton(this)" onmouseout="outButton(this)">&nbsp;&nbsp;
						<input type="reset" value=" Reset " class="button" onmouseover="overButton(this)" onmouseout="outButton(this)"></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4"><img src="images/logon/c.gif" width="1" height="1" alt=""></td>
					</tr>
					<tr height="35">
						<td colspan="4" align="center"><font class="textError">Unable to process login. Please check User Name and Password and try again</font></td>
					</tr>
					<tr>
						<td width="30%">&nbsp;</td>
						<td width="20%">&nbsp;</td>
						<td width="15%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
</form>
</body>
</html>

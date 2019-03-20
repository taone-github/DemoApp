<%@ page contentType="text/html;charset=tis-620"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>

<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%><html>
<title>Avalant OneWeb 3.0 System</title>
<meta content="text/html; charset=tis-620" http-equiv="Content-Type" />
<head>
<link rel="stylesheet" href="css/ProfesionalBlue_01/CSS/stylesheet.css" type="text/css">
<script src="js/general.js" type="text/javascript"></script>
<script src="screen_template/frame/scripts/jquery-1.3.2.js" type="text/javascript"></script>
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
//var thePage = "blank.jsp";
//application=window.open(thePage,'appWindow','width='+screen.availWidth+',height='+screen.availHeight+',top=0,left=0,resizable=1,toolbar=0,scrollings=1,scrollbars=1,status=1');
clearEscape('usernameTextEdit');
clearEscape('passwordTextEdit');
document.logonform.submit();
//application.window.focus();
}
function workKeyDown(event){
var keyCode = event.keyCode;
var enter = 13;
if(keyCode ==enter)	{
	event.returnValue = false;
	launchApplication();
}				
}

function clearEscape(objid){
	var str = jQuery('#'+objid).val();
	str = str.replace(/%0D/gi, ""); 
	str = str.replace(/%0A/gi, "");
	jQuery('#'+objid).val(str);
}

</script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(css/PMS/images/bg.gif);
}
.button_style_left{
	height:26px;
	float:left;
	width:5px;
	background-image:url('css/PMS/images/btn_left.png');
}
.button_style_right{
	height:26px;
	float:left;
	width:5px;
	background-image:url('css/PMS/images/btn_right.png');
}
.button_style{
	height:26px;
	min-width:80px;
	color:#4A2B16;
	display:block;
	float:left;
	cursor:pointer;
	font-family: 'Droid Sans', sans-serif;
	font-size: 9pt;
	line-height:23px;
	font-weight: bold;
	background-image:url(css/PMS/images/btn.png);
	border:0px;
	

}
</style>
</head>
<body leftmargin="0" topmargin="0" onkeydown="workKeyDown(event)">
<form action="LogonServlet" method="post" name="logonform">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr height="20px">
	<td>
		&nbsp;
	</td>
</tr>
<tr>
<td valign="middle" align="center">
<table width="80%" height="80%" border="0" cellspacing="0" cellpadding="0" style=background-color:white>
  <tr style="background-image:url(css/PMS/images/headLogin.png)">
    <td>&nbsp;</td>
  </tr>
  <tr style="background-image:url(css/PMS/images/headLogin.png)">
    <td align="center">&nbsp;</td>
  </tr>
  <tr style="background-image:url(css/PMS/images/headLogin.png)">
    <td align="center"><span><img src="css/PMS/images/logoLogin.png" width=560 height=80 /></span></td>
  </tr>
  <tr style="background-image:url(css/PMS/images/headLogin.png)">
    <td align="center">&nbsp;</td>
  </tr>
  <tr style="background-image:url(css/PMS/images/tabheadbg.png)">
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="600" border="0" align="center" cellpadding="3" cellspacing="1">
      <tr>
        <td align="right" width="150"><span>บัญชีผู้ใช้งาน :</span></td>
        <td>
		<input size=40 type="text" name="userName" value="" class="textbox" id="usernameTextEdit" onfocus="overTextBox(this)" onblur="outTextBox(this)">
		</td>
		</tr>
      <tr>
        <td>
        </td>
        </tr>
      <tr>
      	<td align="right" width="150"><span>รหัสผ่าน :</span></td>
        <td><input size=40 type="password" name="password" value="" class="textbox" id="passwordTextEdit" onfocus="overTextBox(this)" onblur="outTextBox(this)"></td>
</tr>
      <tr>
        <td colspan="2" align="center">
        	<SPAN style="width:200px;float:left">&nbsp</SPAN>
        	<SPAN class=button_style_left>&nbsp;</SPAN><input type="button" value="เข้าสู่ระบบ" class="button_style" onclick="launchApplication()"><SPAN class=button_style_right>&nbsp;</SPAN>
              <SPAN style="width:10px;float:left">&nbsp</SPAN>
             <SPAN class=button_style_left>&nbsp;</SPAN><input type="reset" value="ล้างค่า" class="button_style"><SPAN class=button_style_right>&nbsp;</SPAN>
         </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr height="35">
	<td colspan="4" align="center"><font style="color: red"><%=DisplayFormatUtil.displayHTML(request.getSession().getAttribute("err")) %></font></td>
  </tr>
</table>
<table width=100%>
	<tr>
    <td align="center"> 
    	<span style="color:#bcbcbc;text-shadow:#fff;text-align: center">สงวนลิขสิทธิ์ 2556 สำนักงานทรัพย์สินส่วนพระมหากษัตริย์</span>
    </td>
  </tr>
</table>
</td>
  </tr>
</table>
</form>
</body>
</html>

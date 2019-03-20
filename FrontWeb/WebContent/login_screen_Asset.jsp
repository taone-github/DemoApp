<%@ page contentType="text/html;charset=tis-620"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>

<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%><html>
<title>Avalant EAF3.0 System</title>
<meta content="text/html; charset=tis-620" http-equiv="Content-Type" />
<head>
<link rel="stylesheet" href="css/Asset/css/stylesheet.css"
	type="text/css">
<script src="js/general.js" type="text/javascript"></script>
<script src="screen_template/frame/scripts/jquery-1.3.2.js"
	type="text/javascript"></script>
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
	var str = $('#'+objid).val();
	str = str.replace(/%0D/gi, ""); 
	str = str.replace(/%0A/gi, "");
	$('#'+objid).val(str);
}

</script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #b0d030
}
</style>
</head>
<body leftmargin="0" topmargin="0" onkeydown="workKeyDown(event)">
<form action="LogonServlet" method="post" name="logonform">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center">
			<table width="210" border="0" align="center" cellpadding="3"
				cellspacing="1">
				<tr>
					<td>
					<span class="headerheightspace1"><img
					border="0" src="css/Asset/images/AssetLogo.png" width="124"
					height="28"></span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="210" border="0" align="center" cellpadding="3"
			cellspacing="1">
			<tr>
				<td><span class="text-topic-blue-bold2">Username</span></td>
			</tr>
			<tr>
				<td><input type="text" name="userName" value="" style=""
					class="textbox" id="usernameTextEdit" onfocus="overTextBox(this)"
					onblur="outTextBox(this)"></td>
			</tr>
			<tr>
				<td><span class="text-topic-blue-bold2">Password</span></td>
			</tr>
			<tr>
				<td><input type="password" name="password" value="" style=""
					class="textbox" id="passwordTextEdit" onfocus="overTextBox(this)"
					onblur="outTextBox(this)"></td>
			</tr>
			<tr>
				<td>
				<table width="104" border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td width="100">
						<table width="100" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><input type="button" value="Login" class="button_style"
									onclick="launchApplication()" onmouseover="overButton(this)"
									onmouseout="outButton(this)"></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
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
		<td colspan="4" align="center"><font style="color: red"><%=DisplayFormatUtil.displayHTML(request.getSession()
							.getAttribute("err"))%></font></td>
	</tr>
	<tr>
		<td class="bgfooterzone">
		<table width="900" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td height="10" colspan="5"></td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="123" class="text-topic-blue-bold2">Menu</td>
						<td width="236"><span class="text-topic-blue-bold2">Our
						solution </span></td>
						<td width="273"><span class="text-topic-blue-bold2">Industry</span></td>
						<td width="353"><span class="text-topic-blue-bold2">&copy;
						2011 Avalant Co.,Ltd.</span></td>
					</tr>
					<tr>
						<td height="5"></td>
						<td height="5"></td>
						<td height="5"></td>
						<td height="5"></td>
						<td height="5"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>
						<table width="123" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Home
								</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Calendar
								</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Document
								</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Blog</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Wiki
								</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Forum</a></td>
							</tr>
						</table>
						</td>
						<td>
						<table width="200" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Loan
								Origination for Banking </a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Leasing
								and Consumer Lending </a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Insurance
								Front-Office Solution</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Insurance
								Brokerage System</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Next
								Generation CRM</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Quality
								Management</a></td>
							</tr>
						</table>
						</td>
						<td valign="top">
						<table width="200" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Banking
								&amp; Financial Services</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Insurance</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Telecommunication</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Retail
								&amp; Distributors</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Manufacturing</a></td>
							</tr>
							<tr>
								<td height="15"><a href="#" class="textbottomblue">Real
								Estate &amp; Property</a></td>
							</tr>
						</table>
						</td>
						<td valign="top">
						<p class="addressfont">Head Office Location : <br>
						Avalant Company Limited <br>
						20 Bubhajit Bldg., 15-16 Fl., North Sathorn Road , <br>
						Silom, Bangrak, Bangkok 10500 <br>
						TEL: (66)-0-2633-9367-69 , (66)-0-2633-8170-75<br>
						FAX: (66)-0-2633-8174</p>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td valign="top">&nbsp;</td>
						<td valign="top">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>

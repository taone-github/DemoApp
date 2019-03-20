<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%--
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=WINDOWS-874">
<META name="GENERATOR" content="IBM WebSphere Studio">
<TITLE>Logon Processing...</TITLE>
</HEAD>
<BODY>
<%if( ((String)request.getSession().getAttribute("userName")!=null) && ((String)request.getSession().getAttribute("password")!=null) ){%>
<P>Logon Processing...</P>
<FORM METHOD=POST ACTION="j_security_check" name="j_security_form">
	<input type="hidden" name="action" value="NaosUserLogon">
	<input type="hidden" name="handleForm" value="N">
	<input type="hidden" name="j_username" value="<%=(String)request.getSession().getAttribute("userName")%>">
	<input type="hidden" name="j_password" value="<%=(String)request.getSession().getAttribute("password")%>">
</FORM>
<%}else{%>
 <br>
 This page has been expired. Please close this window and login again on new window.
 <a href="javascript:window.close();"><U> close window</U></a> 
<%}%>

</BODY>
</HTML>
<script>
//	alert(document.j_security_form.j_username.value);
//	alert(document.j_security_form.j_password.value);
<%if( ((String)request.getSession().getAttribute("userName")!=null) && ((String)request.getSession().getAttribute("password")!=null) ){%>
	document.j_security_form.submit();
<%}%>
</script>
--%>


<link rel="stylesheet" href="css/MainStyle.css" type="text/css" />
<script type="text/javascript">

function doLogin(){
 logonForm.ok.disabled=true;
 logonForm.submit();
}
</script>

<form action="FrontController" method="post" name="logonForm">
<input type="hidden" name="action" value="USER_LOGON"> 
    <input type="hidden" name="handleForm" value="N"> <br>
<br>
<br>
<br>
<br>
<%String logonError = "";
logonError = (String) session.getAttribute("loginerror");
if(request.getParameter("mgl") != null){
	logonError = "username ของคุณถูก login ใหม่จากที่อื่นแล้ว";
	
}
if (logonError != null && !logonError.equals("")) {
%> <font class=font5 color=#ff0000 size=3><%=logonError%></font> <br>
<%}
session.removeAttribute("loginerror");
%>
<table width="550" height="400" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="407" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="407" rowspan="2" align="center">
				<TABLE cellSpacing=0 cellPadding=0 width=407 border=0>
					<TR vAlign=bottom align=left>
						<TD background="images/Login.jpg" colSpan=5 height=88>
						<FONT
							class="bu2"><font color="#ffffff"> <B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please
						enter your ID and Password to sign in</b></font> <BR>
						<BR>
						
						<%--String errMsg = (String)session.getAttribute("loginerror");
						  if(errMsg!=null || !errMsg.equals("")){
						    out.println("<font class=\"bu2\"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+errMsg+"</b></font><br><br>");
						    //session.removeAttribute("loginerror");
						  }else{
						  	out.println("<font class=\"bu2\" color=\"#FFFFFF\"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please enter your ID and Password to sign in</b></font><br><br>");
						  }
						--%>
						</FONT></TD>
					</TR>
					<TR>
						<TD colspan="5" bgColor=#1E5482>&nbsp;</TD>
					</TR>
					<TR>
						<TD width=15 bgColor=#1E5482>&nbsp;</TD>
						<TD vAlign="middle" align=right width=108 bgColor=#1E5482><FONT
							class="bu2"><font color="#ffffff"><B>User ID &nbsp;</B></FONT></TD>
						<TD vAlign="middle" align=left width=162 bgColor=#1E5482><INPUT
							maxLength=50 size=18 name=j_username></TD>
						<TD width=110 bgColor=#1E5482>&nbsp;</TD>
						<TD width=15 bgColor=#1E5482>&nbsp;</TD>
					</TR>
					<TR>
						<TD width=15 bgColor=#1E5482 height=1></TD>
						<TD width=108 bgColor=#1E5482 height=1></TD>
						<TD width=162 bgColor=#1E5482 height=1></TD>
						<TD width=110 bgColor=#1E5482 height=1></TD>
						<TD width=15 bgColor=#1E5482 height=1></TD>
					</TR>
					<TR>
						<TD width=15 bgColor=#1E5482>&nbsp;</TD>
						<TD vAlign="middle" align=right width=108 bgColor=#1E5482><FONT
							class="bu2"><font color="#ffffff"><B>Password &nbsp; </B></FONT></TD>
						<TD vAlign="middle" align=left width=162 bgColor=#1E5482><INPUT
							type=password maxLength=50 size=18 name="j_password"></TD>
						<TD width=110 bgColor=#1E5482 valign="bottom"><input type="submit" value="<bkitaglib:message  key="SUBMIT" />" name = "ok" class="button_blue" onclick="doLogin()"></TD>
						<TD width=15 bgColor=#1E5482>&nbsp;</TD>
					</TR>
					<TR>
						<TD vAlign=top align=left width=15 bgColor=#1E5482 height=8>&nbsp;</TD>
						<TD width=108 bgColor=#1E5482 height=10>&nbsp;</TD>
						<TD width=162 bgColor=#1E5482 height=10><FONT class=sub>&nbsp;</FONT></TD>
						<TD width=110 bgColor=#1E5482 height=10>&nbsp;</TD>
						<TD vAlign=top align=right width=15 bgColor=#1E5482 height=10>&nbsp;</TD>
					</TR>
					<TR>
						<TD vAlign=top align=left width=2 bgcolor="#1E5482"></TD>
						<TD width=108 bgColor=#1E5482><IMG height=25 src="images/cl.gif"
							width=1></TD>
						<TD width=162 bgColor=#1E5482><IMG height=25 src="images/cl.gif"
							width=1></TD>
						<TD width=110 bgColor=#1E5482><IMG height=25 src="images/cl.gif"
							width=1></TD>
						<TD vAlign=top align=right width=15><IMG height=25
							src="images/Login_Bottom_Corner.gif" width=15>
						</TD>
					</TR>
				</TABLE>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<script type="text/javascript">document.logonForm.j_username.focus();</script>

</form>



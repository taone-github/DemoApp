
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/sessionTimeOut.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
function logOut(){
	if(confirm("Do you want to log out from this application?")){
		window.location.href="logout.jsp";
	}
}
</script>
<link href="screen_template/iframe/include/css/styles.css" type="text/css" rel="stylesheet" />
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 

<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="list">
	<tbody>
		<tr>
			<td colspan="5"><img height="1" width="100%" alt="" src="screen_template/iframe/images/c.gif" /></td>
		</tr>
		<tr>
			<td  colspan="4" valign="top" width="80%" ><img  src="images/logo.gif" alt="" /></td>
			<td valign="middle" align="right" >
			<table width="40%" cellspacing="0" cellpadding="1" border="0" class="text">
				<tbody>
					<tr>
					<td valign="bottom" align="right" class="textTop"><nobr>wasadmin</nobr></td>
						<!-- <td valign="bottom" align="right" class="textTop"><nobr>wasadmin</nobr></td> -->
						<td width="25" rowspan="2"><img hspace="3" height="25" width="25" align="middle" src="screen_template/iframe/images/login_icon.gif" alt="" /></td>
					</tr>
					<tr>
						<td valign="top" align="right" class="textTop"><nobr><%=SimpleDateFormat.getDateInstance(SimpleDateFormat.FULL,Locale.US).format(new Date())%></nobr></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>
<table width="100%" cellspacing="0" cellpadding="0" border="0" background="screen_template/iframe/images/bg_submain.gif" align="center" class="list">
	<tbody>
		<tr>
			<td colspan="3"><img height="1" width="780" alt="" src="screen_template/iframe/images/c.gif" /></td>
		</tr>
		<tr>
			<td width="1%" valign="top"><img height="1" width="2" alt="" src="screen_template/iframe/images/c.gif" /></td>
			<td width="25%" class="panelText">Job Date : <%=request.getSession().getAttribute("job_date")%></td>
			<td width="74%" valign="top" align="right">
			<table>
				<tbody>
					<tr>
						<td class="panelText">Head Office</td>
						<td valign="top"><img height="20" width="10" src="screen_template/iframe/images/iconsep.gif" alt="" /></td>
						<td valign="top"><a href="#"><img border="0" alt="Home" src="screen_template/iframe/images/home.gif" /></a>  
						<a href="javascript:logOut()"><img height="20" width="22" border="0" alt="Log Out" src="screen_template/iframe/images/signout.gif" /></a></td>
						<td valign="top"><img height="20" width="10" src="screen_template/iframe/images/iconsep.gif" alt="" /><img height="1" width="1" src="screen_template/iframe/images/c.gif" alt="" /></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>

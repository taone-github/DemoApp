
<html>
<head>

<link type="text/css" href="include/css/styles.css" rel="stylesheet" />
<script>
function toggleMenu() {
/*
	var uri = "<%=request.getContextPath()%>/CheckLeftMenuServlet";

	var dataString = "username=<%=(String)request.getSession().getAttribute("USERNAME_GEN_LEFT")%>";
		jQuery.ajax( {
			type :"POST",
			url :uri,
			data :dataString,
			async :false, // wait ultil complete
			success : function(data) {
				top.toggleMenu();
			}
	});
	*/
	top.toggleMenu();
}
// function logOut() {
// 	top.logOut();
// }
</script>
</head>
<body background="" topmargin="0" leftmargin="0">
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="centeredPanel">
	<tbody>
		<tr>
			<td><img height="1" width="1" alt="" src="images/c.gif" /></td>
		</tr>
		<tr>
			<td background="images/menu1.png" class="panelText">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="panelText">
				<tbody>
					<tr>
						<td width="80%">&nbsp;</td>
						<td width="20%" align="right"><a href="javascript:toggleMenu();"><img border="0" src="images/menu_close.gif" /></a></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>
</body>
</html>


<html>
<head>

<link href="include/css/styles.css" type="text/css" rel="stylesheet" />
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
function forceHide() {
	top.forceHide();
}

</script>
</head>
<body bgcolor="#b0c4de" onload="forceHide()" rightmargin="0" topmargin="0" leftmargin="0" bottommargin="0">
<div style="border: 0px solid rgb(102, 153, 204); width: 100%; height: 100%;" id="navMenuHidden" class="divNav">
<table height="100%" cellspacing="0" cellpadding="0" bgcolor="#b0c4de">
	<tbody>
		<tr>
			<td valign="top" align="center">
			<table width="100%" cellspacing="0" cellpadding="2">
				<tbody>
					<tr>
						<td width="100%" align="center"><a href="javascript:toggleMenu();"><img border="0" src="images/menu_expand.gif" /></a></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>
</div>
</body>
</html>

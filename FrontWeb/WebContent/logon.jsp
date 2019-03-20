<%@ page contentType="text/html;charset=tis-620"%>
<script>
	var thePage = "logout.jsp";
	var sx=(screen.width-1440)/2;
	var sy=(screen.height-900)/2;
	if(window.name=='asset_window'){
		document.location.href="LogonServlet";
	}else{
		application=window.open(thePage,'asset_window','width=1440,height=900,top='+sy+',left='+sx+',resizable=1,toolbar=0,scrollings=1,scrollbars=1,status=false');
		application.window.focus();
		window.opener = self;
		window.close();
		//document.location.href="LogonServlet?actionType=2";
		document.location.href="LogonServlet";
	}

</script>
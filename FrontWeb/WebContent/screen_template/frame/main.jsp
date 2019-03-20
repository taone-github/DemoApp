
<html>
<head>

<link rel="stylesheet" href="scripts/dist/css/AdminLTE.min.css"/>
<script type="text/javascript">
function createPath() {
	createPath("Home");
} 
</script>
<!-- <script src="scripts/jquery-2.1.4.js"></script> -->
<!-- <script src="scripts/jquery.blockUI.js"></script> -->
<!-- <script src="scripts/sessionTimeOut.js"></script> -->
<style>
.content-wrapper { background-color: #FFF}
</style>
</head>

<body class="content-wrapper">
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 
<div class="row form-horizontal">
	<div class="col-xs-5 col-sm-6 text-center">
		<img height="1" width="730" alt="" src="images/c.gif" />
	</div>
</div>
<br>
<div class="row form-horizontal">
	<div class="col-xs-5 col-sm-6 text-center">
		<img height="1" width="730" alt="" src="images/c.gif" />
	</div>
</div>
<div class="row form-horizontal">
<!-- 	<div class="col-xs-2 col-sm-2"><img height="1" width="730" alt="" src="images/c.gif" /> -->
<!-- 	</div> -->
	<div class="text-center">
		<img border="0" src="ProfesionalBlue/images/welcome.jpg" style="max-width:100%" height="auto">
		<!-- ProSilver	 -->
		<!-- PMS 
		<%
			java.util.HashMap roleImage = new java.util.HashMap();
			roleImage.put("RO002","RO002");
			roleImage.put("RO004","RO004");
			roleImage.put("RO006","RO006");
			roleImage.put("RO008","RO008");
			roleImage.put("RO010","RO010");
			roleImage.put("RO012","RO012");
			roleImage.put("RO014","RO014");
			roleImage.put("RO016","RO016");
			roleImage.put("RO018","RO018");
			roleImage.put("RO020","RO020");
			roleImage.put("RO021","RO021");
			roleImage.put("RO022","RO022");
			roleImage.put("RO023","RO023");
		if(!roleImage.containsKey((String)request.getSession().getAttribute("roleID"))){ 
		
		%>
		<img border="0" src="PMS/images/welcome_3.jpg"
			width="920" height="574">
		
		<%}else{ %>
		<img border="0" src="PMS/images/welcome_2.jpg"
			width="920" height="1390">
		<%} %>
		
		<!-- PMS -->
	</div>
	<div class="col-xs-2 col-sm-2"><img height="1" width="730" alt="" src="images/c.gif" />
	</div>
</div>
<div class="row form-horizontal">
	<div class="col-xs-6 col-sm-3 text-center">
		<img height="1" width="1" alt="" src="images/c.gif" />
	</div>
	<div class="col-xs-6 col-sm-3 text-center">
		<img height="1" width="1" alt="" src="images/c.gif" />
	</div>
	<div class="col-xs-6 col-sm-3 text-center">
		<img height="1" width="1" alt="" src="images/c.gif" />
	</div>
	<div class="col-xs-6 col-sm-3 text-center">
		<img height="1" width="1" alt="" src="images/c.gif" />
	</div>
</div>
</body>
</html>

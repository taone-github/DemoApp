<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="screen_template/frame/ERP/scripts/dtree/dtree_new.css" type="text/css">
<script src="screen_template/frame/ERP/scripts/dtree/dtree.js"></script>
<script src="screen_template/frame/scripts/jquery-2.1.4.js"></script>
<script type="text/javascript">
function logOut() {
	top.logOut();
}
</script>
</head>
<body background="" topmargin="0" leftmargin="0">
<!-- <table width="100%" cellspacing="0" cellpadding="0" border="0" class="centeredPanel"> -->
<!-- 	<tbody> -->
<!-- 		<tr> -->
<!-- 			<td><img height="1" width="1" alt="" src="../images/c.gif" /></td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<td background="images/menu1.png" class="panelText"> -->
<!-- 			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="panelText"> -->
<!-- 				<tbody> -->
<!-- 					<tr> -->
<!-- 						<td width="80%">&nbsp;</td> -->
<!-- 						<td width="20%" align="right"><a href="javascript:toggleMenu();"><img border="0" src="../images/menu_close.gif" /></a></td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</table> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</tbody> -->
<!-- </table> -->
<!-- <div class="navbar-default sidebar fixed" role="navigation"> -->
<!-- 	<div class="sidebar-nav navbar-collapse bgmenuleft"> -->
<!-- 		<ul class="nav" id="side-menu"> -->
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td height="550" valign="top" class="bgmenuleft">
		<!-- Menu -->
<script type="text/javascript">
<%@ include file="menuarrays.jsp"  %>
d = new dTree('d');
for(a=0;a<parseInt(arrayobj.length);a++){
	/**add(id, pid, name, url, title, target, icon, iconOpen, open)**/
	d.add(arrayobj[a][0],arrayobj[a][1],arrayobj[a][2],arrayobj[a][3],arrayobj[a][2],arrayobj[a][4],arrayobj[a][5]);
}
document.write(d);
var a_tags = document.getElementsByTagName("a"); 
for (var i = 0; i < a_tags.length; i++) { 
	a_tags[i].onclick = function(){top.ActivityTheme(this.innerHTML,'Menu');};
}

//Sam Add Tab by menu target
$(document).ready(function() {
	$("a").each(function(index){
    	if($(this).attr('target') == 'mainheader'){
    		$(this).click(function(){
    			top.showMainTab();
    			//ajaxAccessLog($(this).attr('href'));
    			//alert( $('this.dTreeNode').children().length());
    		});
    	}else if($(this).attr('target') == 'mainframe'){
    		$(this).click(function(){
    			top.hideMainTab();
    			//ajaxAccessLog($(this).attr('href'));
    		});
    	}
    });

	$('.dTreeNode').click(function(){
		var objA = 	$(this).children('a');
		var ahref = objA.attr('href');
		if(ahref.indexOf('javascript')){
//			alert('link ' +objA.attr('href'));
			$('.dTreeNode').removeClass('menu_selected');
			$(this).addClass('menu_selected');
			
		} 
		//alert('link ' +objA.attr('href'));	
	});	
});
</script>
		
			<!-- End Menu --></td>
			</tr>
</table>	
</body>
</html>

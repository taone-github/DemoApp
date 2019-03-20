<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="scripts/dtree/dtree.css" type="text/css">
<script language="JavaScript" src="scripts/dtree/dtree.js"></script>
<script language="JavaScript" src="../scripts/jquery-1.3.2.js"></script>
<script language="javascript" type="text/javascript">
// function logOut() {
// 	top.logOut();
// }
</script>
</head>
<body background="" topmargin="0" leftmargin="0">
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tbody>
		<tr>
			<td height="550" valign="top" class="bgmenuleft">
			<!-- Menu -->
<script type="text/javascript">
<%@ include file="menuarrays.jsp" %>
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
    		});
    	}else if($(this).attr('target') == 'mainframe'){
    		$(this).click(function(){
    			top.hideMainTab();
    			//ajaxAccessLog($(this).attr('href'));
    		});
    	}
    });
});
</script>
			</div>
			<!-- End Menu --></td>
		</tr>
	</tbody>
</table>
</body>
</html>

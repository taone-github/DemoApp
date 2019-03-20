<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>

<link type="text/css" href="scripts/dtree/dtree.css" rel="StyleSheet" />
<link type="text/css" href="include/css/styles.css" rel="stylesheet" />
<script src="scripts/dtree/dtree.js" type="text/javascript"></script>
<script language="JavaScript" src="scripts/jquery-1.3.2.js"></script>
<script language="javascript" type="text/javascript">
// function logOut() {
// 	top.logOut();
// }
</script>
</head>
<body background="" topmargin="0" leftmargin="0">
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="centeredPanel">
	<tbody>
		<tr>
			<td><img height="3" width="1" src="images/c.gif" alt="" /></td>
		</tr>
		<tr>
			<td height="550" valign="top"><!-- Menu -->
			<div id="dt_menu" class="dtree"><a href="javascript: d.openAll();">Expand</a> | <a href="javascript: d.closeAll();">Collapse</a>
<script type="text/javascript"><!--

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
    			ajaxAccessLog($(this).attr('href'));
    		});
    	}else if($(this).attr('target') == 'mainframe'){
    		$(this).click(function(){
    			top.hideMainTab();
    			ajaxAccessLog($(this).attr('href'));
    		});
    	}
    });
});

function ajaxAccessLog(menuUrl){
	//alert(menuUrl);
	
	for(a=0;a<parseInt(arrayobj.length);a++){
		if(arrayobj[a][3] == menuUrl){
			//alert(menuUrl);
			var menuName = arrayobj[a][2];
			//alert(menuName);
			var dataString = "menu_id="+arrayobj[a][0]+"&log_action=Access Menu " +menuName+ "&log_type=3&result=Success";
			var uti= "";
			$.ajax({
			   type: "POST",
			   url: "/FrontWeb/AccessLogServlet",
			   data: dataString,
			   success: function(){
			   		alert("log for menu : " + arrayobj[a][0] + " is success");
			   },
			   error: function(xhr, ajaxOptions, thrownError){
			   		alert(xhr+"/"+ajaxOptions+"/"+thrownError );
			   }
			});
			
		}
	}
	
}

//-->
</script>
			</div>
			<!-- End Menu --></td>
		</tr>
	</tbody>
</table>
</body>
</html>

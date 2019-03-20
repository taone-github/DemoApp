<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Vector"%>
<%@page import="com.front.model.menu.MenuM"%>
<html>
<head>
<!-- <link rel="stylesheet" href="screen_template/frame/ERP/scripts/dtree/dtree_new.css" type="text/css"> -->
<!-- <script src="screen_template/frame/ERP/scripts/dtree/dtree.js"></script> -->
<!-- <script src="screen_template/frame/scripts/jquery-2.1.4.js"></script> -->
	<script type="text/javascript" src="screen_template/frame/ERP/javascript/jquery-ui-1.9.1.js"></script>
<!-- <script type="text/javascript"> -->
<!--  function logOut() { -->
<!--  	top.logOut(); -->
<!--  } -->
<!-- </script> -->
</head>
<jsp:useBean id="menuHandlerManager" class="com.front.form.menu.MenuHandlerManager" scope="session" />
<%
/**[MenuID, MenuReference, MenuName, MenuAction, MenuTarget, icon]**/
Vector<MenuM> vecMenus = (Vector<MenuM>)request.getSession().getAttribute("vecMenus");
String userName = (String) request.getSession().getAttribute("userName");
ArrayList<MenuM> topLevelMenus = menuHandlerManager.getTopLevelMenus();
HashMap<String,ArrayList<MenuM>> subLevelMenus = menuHandlerManager.getSubMenus();
String currentMenuId = "";
%>
<input type="hidden" name="currentMenuId" value="<%=currentMenuId%>">
<body background="" topmargin="0" leftmargin="0">

<div class="navbar-default sidebar fixed" role="navigation">
	<div class="sidebar-nav navbar-collapse">
	
		<div id="side-menu" class="nav panel-group">
	<%
		String permChkStr3 = "5";//(String) request.getSession().getAttribute("permChkStr3");
		permChkStr3 = (permChkStr3 != null) ? permChkStr3 : "0";
		if(topLevelMenus != null && !topLevelMenus.isEmpty()) {
			for(MenuM topLevelMenu: topLevelMenus) {
				String topLevelMenuId = topLevelMenu.getMenuID();
				if("LABEL".equals(topLevelMenu.getMenuType())){
					String childPanelId = topLevelMenuId + "_child";
		%>		
<!-- 		    <div class="panel panel-default"> -->
		        <div class="panel-heading sidebar-title">
		            <a id='<%=topLevelMenuId %>' data-toggle="collapse" data-parent="#side-menu" href="#<%=childPanelId %>">
		                	<%=topLevelMenu.getMenuName() %></a>
		        </div>
		        <div id="<%=childPanelId%>" class="panel-collapse collapse">
		            <div class="panel-body">
		            	<% 
		            	if(subLevelMenus != null && !subLevelMenus.isEmpty()){
							ArrayList<MenuM> subMenus = subLevelMenus.get(topLevelMenuId);
							Collections.sort(subMenus) ;
							for(MenuM subMenu: subMenus){	
								String menuId = subMenu.getMenuID();
								if("LABEL".equals(subMenu.getMenuType())){
									String subChildPanelId = menuId + "_child";
		            	%>
<!-- 		            		<div class="panel panel-default"> -->
						        <div class="panel-heading sidebar-title">
						            <a id='<%=menuId %>' data-toggle="collapse" data-parent="#<%=childPanelId%>" href="#<%=subChildPanelId %>">
						                	<%=subMenu.getMenuName() %> </a>
						        </div>
						        <div id="<%=subChildPanelId%>" class="panel-collapse collapse">
						            <div class="panel-body">
						            <ul>
						            <%
									ArrayList<MenuM> subMenus2 = subLevelMenus.get(menuId);
						            if(subMenus2 != null && !subMenus2.isEmpty()) {
										Collections.sort(subMenus2) ;
										for(MenuM subMenu2: subMenus2){	
											String menuId2 = subMenu2.getMenuID();
											String style = (null != menuId2 && menuId2.equals(currentMenuId))?"active":"";
											String url = subMenu2.getMenuAction()+"&menuId=" + menuId2 + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
							            %>
							            	<li class="sidebar-title"><a id='<%= menuId2%>' href='<%=url%>' target='mainPage'>
							            		<%=subMenu2.getMenuName() %></a></li>
							            <%} 
							         } %>
						            </ul>
		                			</div>
		    					</div>
<!-- 		    				</div> -->
			    			<%	} else { 
			    				String style = (null != menuId && menuId.equals(currentMenuId))?"active":"";
								String url = subMenu.getMenuAction()+"&menuId=" + menuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
							%>
<!-- 			    			<div class="panel panel-default"> -->
						        <div class="panel-heading sidebar-title">
						            <a id='<%= menuId%>' href='<%=url%>' target='mainPage'><%=subMenu.getMenuName() %></a>
						        </div>
<!-- 						   </div> -->
			    			<%}
						}
					}%>
		            </div>
		        </div>
<!-- 		     </div> -->
	        <%} else { 
	        	String style = (null != topLevelMenuId && topLevelMenuId.equals(currentMenuId))?"active":"";
				String url = topLevelMenu.getMenuAction()+"&menuId=" + topLevelMenuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
	        %>
<!-- 	        <div class="panel panel-default"> -->
		        <div class="panel-heading sidebar-title">
		            <a id='<%= topLevelMenuId%>' href='<%=url%>' target='mainPage'>
						<%=topLevelMenu.getMenuName() %></a>
		        </div>
<!-- 		     </div> -->
		    <%} 
		   }
		} %>
		</div>
			
	</div>
</div>
<div class="sidebar-toggle-mini">
    <a>
        <span class="fa fa-chevron-right"></span>
    </a>
</div>
		
	<!-- End Menu -->
<script type="text/javascript">
	$(function(){
// 		var element = $('ul#side-menu a').filter(function() {
<%-- 	        return $(this).attr('id') == '<%= currentMenuId %>'; --%>
// 	    }).addClass('active').parent().parent().addClass('in').parent();
// 	    if (element.is('li')) {
// 	        element.addClass('active');
// 	    }
	    
	    $('.sidebar-toggle-mini a').click(function (e) {
	    	e.preventDefault();
	    	$(this).disableSelection();
	    	$('body').toggleClass('sb-l-m');
	    	if (webStorage.checkSupport()) {
	    		if ($('body').hasClass('sb-l-m')) {
	    			console.log('Sidebar Collaped!');
	    			webStorage.getSessStorage().sidebarCollapsed = true;
	    		} else {
	    			console.log('Sidebar Uncollaped!');
	    			webStorage.getSessStorage().sidebarCollapsed = false;
	    		}
	    	}
	    });
	});
</script>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Vector"%>
<%@page import="com.front.model.menu.MenuM"%>
<!DOCTYPE html>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1">
<script type="text/javascript" src="screen_template/frame/Responsive2016/javascript/jquery-ui-1.9.1.js"></script>
<script type="text/javascript">
function accessMenu(aObject){
	$(".treeview .active").removeClass("active");
	$(aObject).parent().addClass("active");
}
</script>
</head>
<jsp:useBean id="menuHandlerManager" class="com.front.form.menu.MenuHandlerManager" scope="session" />
<%
/**[MenuID, MenuReference, MenuName, MenuAction, MenuTarget, icon]**/
Vector<MenuM> vecMenus	= (Vector<MenuM>)request.getSession().getAttribute("vecMenus");
String userName 		= (String) request.getSession().getAttribute("userName");
String accessToken 		= (String) request.getSession().getAttribute("accessToken");
ArrayList<MenuM> topLevelMenus 					= menuHandlerManager.getTopLevelMenus();
HashMap<String,ArrayList<MenuM>> subLevelMenus 	= menuHandlerManager.getSubMenus();
String currentMenuId 							= (String) request.getSession().getAttribute("currentMenuId");
%>
<input type="hidden" name="currentMenuId" value="<%=currentMenuId%>">
<body background="" topmargin="0" leftmargin="0">
<section class="sidebar">
	<ul class="sidebar-menu">
	<%
		String permChkStr3 = "5";//(String) request.getSession().getAttribute("permChkStr3");
		permChkStr3 = (permChkStr3 != null) ? permChkStr3 : "0";
		if(topLevelMenus != null && !topLevelMenus.isEmpty()) {
			for(MenuM topLevelMenu: topLevelMenus) {
				String topLevelMenuId = topLevelMenu.getMenuID();
	%>
			<li class="treeview">
		<%
				if("LABEL".equals(topLevelMenu.getMenuType())){
		%>		
	              <a id='<%=topLevelMenuId %>' href="#" ">
	              	<div class="menu1-hide"><img class="icon-menu-lv1" src="<%=topLevelMenu.getIcon() %>"></img></div> 
	              	<span class='wordwrap'><%=topLevelMenu.getMenuName() %></span>
	              	<i class="fa fa-angle-left pull-right"></i>
	              </a>
	              <ul class="treeview-menu">
	            	<% 
	            	if(subLevelMenus != null && !subLevelMenus.isEmpty()){
						ArrayList<MenuM> subMenus = subLevelMenus.get(topLevelMenuId);
						Collections.sort(subMenus) ;
						for(MenuM subMenu: subMenus){	
							String menuId = subMenu.getMenuID();
					%>
						<li>
						<%
							if("LABEL".equals(subMenu.getMenuType())){
								String subChildPanelId = menuId + "_child";
	            	%>
								<a id='<%=menuId %>' href="#" ">
									<img class="icon-menu" src="<%=subMenu.getIcon() %>"></img>
									<span class='wordwrap-lv2'><%=subMenu.getMenuName() %></span>
									<i class="fa fa-angle-left pull-right"></i>
								</a>
								
								<ul class="treeview-menu addmenulv3-color">
					            <%
								ArrayList<MenuM> subMenus2 = subLevelMenus.get(menuId);
					            if(subMenus2 != null && !subMenus2.isEmpty()) {
									Collections.sort(subMenus2) ;
									for(MenuM subMenu2: subMenus2){	
										String menuId2 = subMenu2.getMenuID();
										String style = (null != menuId2 && menuId2.equals(currentMenuId))?"active":"";										
										String url = subMenu2.getMenuAction()+"&menuId=" + menuId2 + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3 + "&permChkStr4=" + accessToken;
										
						            %>
						            	<li><a id='<%= menuId2%>' href='<%=url%>' onclick="accessMenu(this);showLoader()" target='mainPage' ">
						            			<i class="fa fa-angle-right" ></i>
						            			<span class='wordwrap-lv3'><%=subMenu2.getMenuName() %></span> 
						            		</a>
					            		</li>
						            <%} 
								} %>
							    </ul>
		    			<%	} else { 
		    				String style = (null != menuId && menuId.equals(currentMenuId))?"active":"";
							String url = subMenu.getMenuAction()+"&menuId=" + menuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3 + "&permChkStr4=" + accessToken;
						%>
							  	<a id='<%= menuId%>' href='<%=url%>' onclick="accessMenu(this);showLoader()" target='mainPage' >
							  		<img class="icon-menu" src="<%=subMenu.getIcon() %>"></img>
							  		<span class='wordwrap-lv2'><%=subMenu.getMenuName() %></span>
						  		</a>
				    	<%	} %>
				    	</li>
					<%	}
					}%>
				</ul>
	       	<%	} else { 
	        	String style = (null != topLevelMenuId && topLevelMenuId.equals(currentMenuId))?"active":"";
				String url = topLevelMenu.getMenuAction()+"&menuId=" + topLevelMenuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3 + "&permChkStr4=" + accessToken;
	        %>
	        		<a id='<%=topLevelMenuId %>' href='<%=url%>' target='mainPage' onclick="accessMenu(this);showLoader()" ">
	        			<div class="menu1-hide"><img class="icon-menu-lv1" src="<%=topLevelMenu.getIcon() %>"></img></div>
		              	<span class='wordwrap'><%=topLevelMenu.getMenuName() %></span>
		            </a>
		    <%} %>
		    </li>
		<%  }
		} %>
		
	<!-- End Menu -->
	</ul>
</section>
</body>
</html>

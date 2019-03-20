<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Vector"%>
<%@page import="com.front.model.menu.MenuM"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="screen_template/frame/Responsive2016/javascript/jquery-ui-1.9.1.js"></script>
</head>
<jsp:useBean id="menuHandlerManager" class="com.front.form.menu.MenuHandlerManager" scope="session" />
<%
/**[MenuID, MenuReference, MenuName, MenuAction, MenuTarget, icon]**/
Vector<MenuM> vecMenus 			= (Vector<MenuM>)request.getSession().getAttribute("vecMenus");
String userName 				= (String) request.getSession().getAttribute("userName");
ArrayList<MenuM> topLevelMenus 	= menuHandlerManager.getTopLevelMenus();
HashMap<String,ArrayList<MenuM>> subLevelMenus = menuHandlerManager.getSubMenus();
String currentMenuId 			= (String) request.getSession().getAttribute("currentMenuId");
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
				<!-- Menu lv1 -->
	              <a id='<%=topLevelMenuId %>' href="#"><img class="icon-menu" src="<%=topLevelMenu.getIcon() %>"></img> 
	              	<span><div class='wordwrap wordwrap-text-lv1'><%=topLevelMenu.getMenuName() %></div> </span><i class="fa fa-angle-left pull-right"></i>
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
	            			 <!-- Menu lv2 -->
								<a id='<%=menuId %>' href="#"><div class='wordwrap-lv2'><%=subMenu.getMenuName() %></div><i class="fa fa-angle-left pull-right"></i></a>
								<ul class="treeview-menu addmenulv3-color">
					            <%
								ArrayList<MenuM> subMenus2 = subLevelMenus.get(menuId);
					            if(subMenus2 != null && !subMenus2.isEmpty()) {
									Collections.sort(subMenus2) ;
									for(MenuM subMenu2: subMenus2){	
										String menuId2 = subMenu2.getMenuID();
										
										/* add Menu lv3*/
										if("LABEL".equals(subMenu2.getMenuType())){
											String subChildPanelId2 = menuId2 + "_child";
									%>
										 <!-- Menu lv3 -->
										 <a id='<%=menuId2 %>' href="#"><div class='wordwrap-lv3'><%=subMenu2.getMenuName() %></div><i class="fa fa-angle-left pull-right"></i></a>
										 <ul class="treeview-menu addmenulv3-color">
									<%
											ArrayList<MenuM> subMenus3 = subLevelMenus.get(menuId2);
											if(subMenus3 != null && !subMenus3.isEmpty()) {
												Collections.sort(subMenus3) ;
												for(MenuM subMenu3: subMenus3){
													String menuId3 = subMenu3.getMenuID();
													String style = (null != menuId3 && menuId3.equals(currentMenuId))?"active":"";
													String url = subMenu3.getMenuAction()+"&menuId=" + menuId3 + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
												
													System.out.println("### getMenuName3 >>"+subMenu3.getMenuName());
									            %>
									            <!-- Menu lv4 -->
									            	<li><a id='<%= menuId3%>' href='<%=url%>' target='mainPage'><i class="fa fa-angle-right" onclick=showLoader()></i>
									            		<div class='wordwrap-lv3'><%=subMenu3.getMenuName() %></div></a></li>
								    	        <%}
											} %>
									      </ul>											
									<%	} else {
											String style = (null != menuId2 && menuId2.equals(currentMenuId))?"active":"";
											String url = subMenu2.getMenuAction()+"&menuId=" + menuId2 + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
									%>
											<a id='<%= menuId2%>' href='<%=url%>' target='mainPage' onclick=showLoader()>
											<div class='wordwrap-lv3'><%=subMenu2.getMenuName() %></div></a>
									<%  } %>
						            <%} /* for subMenu2 */
								} /* for subMenu2 empty*/ %>
							    </ul>
		    			<%	} else { 
		    				String style = (null != menuId && menuId.equals(currentMenuId))?"active":"";
							String url = subMenu.getMenuAction()+"&menuId=" + menuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
							
						%>
							  	<a id='<%= menuId%>' href='<%=url%>' target='mainPage' onclick=showLoader()><div class='wordwrap-lv2'><%=subMenu.getMenuName() %></div></a>
				    	<%	} %>
				    	</li>
					<%	}
					}%>
				</ul>
	       	<%	} else { 
	        	String style = (null != topLevelMenuId && topLevelMenuId.equals(currentMenuId))?"active":"";
				String url = topLevelMenu.getMenuAction()+"&menuId=" + topLevelMenuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
	        %>
	        		<a id='<%=topLevelMenuId %>' href='<%=url%>' target='mainPage'  onclick=showLoader()><img class="icon-menu" src="<%=topLevelMenu.getIcon() %>"></img> 
		              	<span><div class='wordwrap'><%=topLevelMenu.getMenuName() %></div></span>
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
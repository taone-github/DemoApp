<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.master.constant.ConstantSystem"%>
<%@page import="com.front.model.menu.MenuM"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="menuHandlerManager" class="com.front.form.menu.MenuHandlerManager" scope="session" />
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();

	ArrayList<MenuM> topLevelMenus = menuHandlerManager.getTopLevelMenus();
	
	if(!StringUtils.isEmpty(ConstantSystem.get(ConstantSystem.DEFAULT_PAGE_URL))) {
		request.setAttribute("_DEFAULT_PAGE_URL", ConstantSystem.get(ConstantSystem.DEFAULT_PAGE_URL));
	} else {
		request.setAttribute("_DEFAULT_PAGE_URL", request.getContextPath() + "/screen_template/frame/main.jsp");
	}
	
%>
<div class="wrapbigmenu" id="mobileMenu">
	<%
	if(topLevelMenus != null && !topLevelMenus.isEmpty()) {
	%>
	<div class="row row-menu">
	<%
		int count = 0;
		int maxcount = 3;
		for(MenuM topLevelMenu: topLevelMenus) {
	%>
			
	<!--row1-->
	 	 <a href="javascript:void(0)" data-toggle="control-sidebar" data-menu-id="<%=topLevelMenu.getMenuID()%>">
		 	<div class="menuscale" >
		 		<img src="<%=topLevelMenu.getIcon()%>" class="img-circle" alt="Responsive image">
		 		<h4><%=topLevelMenu.getMenuName() %></h4>
		 	</div>
		 </a>
	<%	
			count++;
			if(count >= maxcount) {
				count = 0;
		%>
		</div>
			<div class="row row-menu">
		<%	}
		}
		%>
	</div>
		<%	
	}	
	%>
</div>
<section class="appSection" id="appContent">
	<jsp:include page="pageloader.jsp" flush="true"></jsp:include>
	<iframe src="${ _DEFAULT_PAGE_URL }" name="mainPage" id="mainPage" width="100%" frameborder="0"></iframe>
	
</section>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.TabDisplay" %>
<%
	TabDisplay tabDisplay = new TabDisplay(request);
	if(tabDisplay.haveGeneralTab()){
	//Display general Tab
%>

<!------------------------------------------- generalTab.jsp --------------------------------------------->

<div class="padding-zero bgtabrightmenu content">
		<div class="tabend"></div>
		<!-- For support span <div class="taballs"></div> -->
<%//Start paint previousTab %>
<ul class="nav nav-tabs">			
<%=tabDisplay.previousGeneralTabHTMLResponsive()%>
<%//End prevoiusTab %>
<%//Start this general Tab  %>
<%=tabDisplay.currentGeneralTabHTMLResponsive()%> 
</ul>
<div class="panel-headline-maintab"></div>

<%//End this general Tab %>
</div>
<%//Start Button Under GeneralTab %>
<div class="padding-zero content subContent">
	<div class="panel-subheading">
		<div class="actionplace wrap-pagebtn" id="<%=tabDisplay.getEntityID()%>Bt">
			<%
				String buttonTag = com.master.button.DisplayButton.displayResponsiveDivButton(request,tabDisplay.getEntityID(),tabDisplay.getButtonAction());
			%>
			<%=buttonTag%>
		</div>
		<div class="bgaction1"></div>
		<div class="bgaction3"></div>
	</div>
	<div class="oneWebErrorConsole alert bg-danger"></div>
</div>
<%//End Button Under GeneralTab %>

<%//Start Module in General %>
<div id="gridModuleContainer" class="gridModuleContainer left-white-10px <%=tabDisplay.getCurrentGeneralTab()%>_grid">
	<div class="padding-zero content "><!-- subContent -->
		<!-- 	<div class="content-left"></div> -->
		<div class="padding-zero content-all panel-body">
			<jsp:include flush="true" page="../gridModuleManager.jsp">
			<jsp:param name="CURRENT_TAB" value="<%=tabDisplay.getCurrentGeneralTab()%>"></jsp:param>
			</jsp:include>
		</div>
		<!-- 	<div class="content-right"></div> -->
	</div>
</div>
<!-- <br> -->
<%//End Module in General %>
<script>

</script>
<%}%>
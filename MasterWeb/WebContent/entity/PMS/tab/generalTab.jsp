<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.TabDisplay" %>
<%
	TabDisplay tabDisplay = new TabDisplay(request);
	if(tabDisplay.haveGeneralTab()){
	//Display general Tab
%>

<div class="bgtabrightmenu">
		<div class="tabend"></div>
		<!-- For support span <div class="taballs"></div> -->
<%//Start paint previousTab %>
<%=tabDisplay.previousGeneralTabHTML()%>
<%//End prevoiusTab %>
<%//Start this general Tab  %>
<%=tabDisplay.currentGeneralTabHTML()%>
<%//End this general Tab %>
</div>

<%//Start Button Under GeneralTab %>
<div class="bgactionbar">
	<div class="bgaction2">
		<div class="actionplace" id="<%=tabDisplay.getEntityID()%>Bt">
			<%
				String buttonTag = com.master.button.DisplayButton.displayDivButton(request,tabDisplay.getEntityID(),tabDisplay.getButtonAction());
			%>
			<%=buttonTag%>
		</div>
		<div class="bgaction1"></div>
		<div class="bgaction3"></div>
	</div>
</div>
<%//End Button Under GeneralTab %>
<%//Start Module in General %>
<div id="gridModuleContainer" class="gridModuleContainer <%=tabDisplay.getCurrentGeneralTab()%>_grid">
<div class="content-center">
	<div class="content-left"></div>
	<div class="content-all">
		<jsp:include flush="true" page="../gridModuleManager.jsp">
		<jsp:param name="CURRENT_TAB" value="<%=tabDisplay.getCurrentGeneralTab()%>"></jsp:param>
		</jsp:include>
	</div>
	<div class="content-right"></div>
</div>
</div>
<%//End Module in General %>
<%}%>
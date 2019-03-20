<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.TabDisplay" %>

<%
	TabDisplay tabDisplay = new TabDisplay(request);
	boolean haveGeneralTab = tabDisplay.haveGeneralTab();
	request.setAttribute("_haveTab", tabDisplay.haveTab());
	request.setAttribute("_haveGeneralTab", haveGeneralTab);
	request.setAttribute("_currentTab", tabDisplay.getCurrentTab());
	request.setAttribute("_entityID", tabDisplay.getEntityID());

	if (tabDisplay.haveTab()) {
	//Display Normal Tab
%>
<div class="downtab100percent">
	<ul class="nav nav-pills">
	<%=tabDisplay.tabHTMLResponsive()%>
	</ul>
</div>
<%} %>
<%//Start Button Casne No GeneralTab %>
<%
	if(!haveGeneralTab){
%>
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
<%}//End Button Casne No GeneralTab %>
<%//Start Module
	com.master.util.Log4jUtil.log("CurrentTab>>>>>>>>>>>>"+tabDisplay.getCurrentTab());
	if(null != tabDisplay.getCurrentTab()){
%>
<div id="moduleContainer" class="moduleContainer <%=tabDisplay.getCurrentTab()%>_container">
	<jsp:include flush="true" page="moduleManager.jsp">
	<jsp:param name="CURRENT_TAB" value="<%=tabDisplay.getCurrentTab()%>"></jsp:param>
	</jsp:include>
</div>
<%}//End Module%>


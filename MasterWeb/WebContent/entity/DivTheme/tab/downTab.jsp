<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.TabDisplay" %>
<div class="miniBlock">
<%
	TabDisplay tabDisplay = new TabDisplay(request);
	boolean haveGeneralTab = tabDisplay.haveGeneralTab();
	if (tabDisplay.haveTab()) {
	//Display Normal Tab
%>
<div class="downtab100percent">
<%=tabDisplay.tabHTML()%>
</div>
<%} %>
<%//Start Button Casne No GeneralTab %>
<%
	if(!haveGeneralTab){
%>
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
<%}//End Button Casne No GeneralTab %>
<%//Start Module
	if(null != tabDisplay.getCurrentTab()){
%>
<div id="moduleContainer" class="moduleContainer <%=tabDisplay.getCurrentTab()%>_container">
	<jsp:include flush="true" page="../moduleManager.jsp">
	<jsp:param name="CURRENT_TAB" value="<%=tabDisplay.getCurrentTab()%>"></jsp:param>
	</jsp:include>
</div>
<%}//End Module%>

</div>
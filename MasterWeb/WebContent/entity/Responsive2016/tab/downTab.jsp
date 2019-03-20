<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.avalant.display.TabDisplay" %>

<!------------------------------------------- 
start downTab
--------------------------------------------->

<%
	TabDisplay tabDisplay = new TabDisplay(request);
	boolean haveGeneralTab = tabDisplay.haveGeneralTab();
	request.setAttribute("_haveTab", tabDisplay.haveTab());
	request.setAttribute("_haveGeneralTab", haveGeneralTab);
	request.setAttribute("_currentTab", tabDisplay.getCurrentTab());
	request.setAttribute("_entityID", tabDisplay.getEntityID());
%>

<div class="miniBlock">
	<c:if test="${ _haveTab }">
		<div class="downtab100percent">
			<ul class="nav nav-pills">
				<%=tabDisplay.tabHTMLResponsive()%> 
			</ul>
		</div>
	</c:if>
	
	<%//Start Button Casne No GeneralTab %>
	
	<c:if test="${ not _haveGeneralTab }">
		<div class="panel-subheading">
			<div class="actionplace wrap-pagebtn" id="${ _entityID }Bt">
			<%
				String buttonTag = com.master.button.DisplayButton.displayResponsiveDivButton(request,tabDisplay.getEntityID(),tabDisplay.getButtonAction());
			%>
			<%=buttonTag%>
			</div>
			<div class="bgaction1"></div>
			<div class="bgaction3"></div>
		</div>
	</c:if>
	
	<c:if test="${ _currentTab ne null }">
		<div id="moduleContainer" class="moduleContainer ${ _currentTab }_container">
			<jsp:include flush="true" page="../moduleManager.jsp">
				<jsp:param name="CURRENT_TAB" value="${ _currentTab }"></jsp:param>
			</jsp:include>
		</div>
	</c:if>

</div>
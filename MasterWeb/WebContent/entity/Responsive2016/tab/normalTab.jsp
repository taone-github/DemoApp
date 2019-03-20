<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.avalant.display.TabDisplay" %>

<%
	TabDisplay tabDisplay = new TabDisplay(request);
	
	request.setAttribute("tabDisplay", tabDisplay);
	request.setAttribute("haveGeneralTab", tabDisplay.haveGeneralTab());
	request.setAttribute("haveTab", tabDisplay.haveTab());
	request.setAttribute("entityID", tabDisplay.getEntityID());
	request.setAttribute("buttonTag", com.master.button.DisplayButton.displayResponsiveDivButton(request,tabDisplay.getEntityID(),tabDisplay.getButtonAction()));
	request.setAttribute("currentTab", tabDisplay.getCurrentTab());
%>
<!------------------------------------------- 
start normalTab
--------------------------------------------->

<c:if test="${haveTab == true}">
<div class="padding-zero bgtabrightmenu content">
	<div class="tabend"></div>
	<ul class="nav nav-tabs">			
		<%=tabDisplay.tabHTMLResponsive()%> 
	</ul>
	<div class="panel-headline-maintab"></div>
</div>
</c:if>

<div class="padding-zero content subContent">
	<div class="panel-subheading">
		<div class="actionplace wrap-pagebtn" id='<c:out value="${ entityID }" />Bt' >
			${ buttonTag }
		</div>
		<div class="bgaction1"></div>
		<div class="bgaction3"></div>
	</div>
	<div class="oneWebErrorConsole alert alert-warning alert-dismissible"></div>
</div>


<div id="gridModuleContainer" class="gridModuleContainer left-white-10px ${ tabDisplay.currentGeneralTab }_grid">
	<div class="content-center-normalTab panel">
		<div class="content-left"></div>
		<div class="padding-zero content-all panel-body">
		
			<c:if test="${ currentTab != null }">
				<div id="moduleContainer" class="moduleContainer ${ currentTab }_container">
					<jsp:include flush="true" page="../moduleManager.jsp"> 
						<jsp:param name="CURRENT_TAB" value="${ currentTab }"></jsp:param>
					</jsp:include>
				</div>
			</c:if>
				
		</div>
		<div class="content-right"></div>
	</div>
</div>
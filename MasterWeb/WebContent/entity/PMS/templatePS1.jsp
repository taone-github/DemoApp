<%@ page contentType="text/html;charset=UTF-8"%>
<form name = "masterForm" action="FrontController" method="post">
<input type = "hidden"  name="action" value ="">
<input type = "hidden"  name="handleForm" value ="">
<input type = "hidden"  name="sessionForm" value ="">
<input type = "hidden" name="currentTab" value="">
<input type = "hidden" name="goEntity" value="">
<input type = "hidden" name="goEntityTab" value="">
<input type = "hidden" name="keyForSearch" value="">
<input type = "hidden" name="goEntityKey" value="">
<input type = "hidden" name="goEntityField" value="">
<input type = "hidden" name="nextTab" value="">
<input type = "hidden" name="nextEntity" value="">
<input type = "hidden" name="backEntityTab" value="">
<input type = "hidden" name="interfaceParam" value="">
<input type = "hidden" name="saveDraftFlag" value="">
<input type = "hidden" name="saveToManyFlag" value="">
<!-- PMS_ACTION -->
<input type = "hidden" name="PMS_ACTION" id="PMS_ACTION" value="">
<input type = "hidden" name="PMS_USER_SESSION" id="PMS_USER_SESSION" value="<%=request.getSession().getAttribute("userName")%>">
<input type = "hidden" name="PMS_DEPARTMENT_SESSION" id="PMS_DEPARTMENT_SESSION" value="<%=request.getSession().getAttribute(com.master.util.MasterConstant.OneWebExternal)%>">
<div class="rightcontent">
	<div class="spacetop"><!-- Top 10 px --></div>
	<div class="left-white-10px"><!-- left 10 px -->
	<%
		com.avalant.display.TabDisplay tabDisplay = new com.avalant.display.TabDisplay(request);
		boolean haveGeneralTab = tabDisplay.haveGeneralTab();
		if(haveGeneralTab){
	%>
	<!-- 2 Layer Tab -->
	<jsp:include flush="true" page="tab/generalTab.jsp" />
		<div class="grey-block"><!-- Grey background -->
			<div class="left-line"></div><!-- left line -->
			<jsp:include flush="true" page="tab/downTab.jsp" />
		</div>
	<!-- End 2 Layer Tab -->
	<%}else{ %>
	<jsp:include flush="true" page="tab/normalTab.jsp" />
	<%} %>
	</div>
</div>
</form>
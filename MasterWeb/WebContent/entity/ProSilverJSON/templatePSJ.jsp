<%@ page contentType="text/html;charset=UTF-8"%>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
	com.master.form.EntityFormHandler form = (com.master.form.EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new com.master.form.EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
%>
<form name = "masterForm" action="FrontController" method="post">
<input type = "hidden"  name="action" value ="">
<input type = "hidden"  name="handleForm" value ="">
<input type = "hidden"  name="sessionForm" value ="">
<input type = "hidden" name="currentTab" value="<%=form.getCurrentTab()%>">
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
<input type = "hidden" name="newVersionData" value="">
<%
	//Workflow Integrate
	if(form.getEntityM().isRequireWFFlag() && form.getCurrentMode().equals(com.master.util.MasterConstant.PROCESS_MODE_UPDATE)){
	//this field only use on UPDATE
 %>
<input type="hidden" name="wfJobId" value="<%=request.getSession().getAttribute("wfJobId")%>">
<input type="hidden" name="wfPtid" value="<%=request.getSession().getAttribute("wfPtid")%>">
<input type="hidden" name="wfAction" id="wfAction" >
<div id="wfAction_dialog">
<%com.avalant.display.WfActionDisplay wfad = new com.avalant.display.WfActionDisplay(); %>
<%=wfad.getListAction((String)request.getSession().getAttribute("wfJobId")) %>
</div>
<script type="text/javascript">
$('#wfAction_dialog').dialog({
	width: 400,
	autoOpen: false,
	height:'auto',
	title: 'Workflow Action'
});
</script>
<%	}//End workflow %>


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
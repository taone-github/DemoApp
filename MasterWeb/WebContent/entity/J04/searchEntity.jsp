<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.model.PopupPropM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.dao.MasterDAOFactory" %>
<%@ page import="com.master.dao.MasterDAO" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}		
	com.master.util.Log4jUtil.log("form.getMainModuleID()==>"+form.getMainModuleID());
	String moduleSession = form.getMainModuleID() +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	if (MasterForm == null) {
		MasterForm = new MasterFormHandler();
		request.getSession().setAttribute(moduleSession,MasterForm);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(moduleSession);
%>


<%@page import="com.master.model.ModuleActionM"%><form name ="masterForm" action="FrontController"  method="post" >
<input type ="hidden" name = "action" value="searchEntity">
<input type ="hidden" name = "handleForm" value = "Y">

<div id="topAreaSearchEntity"></div>

<table width="98%" border="0" cellpadding="1" cellspacing="0" align="center"><tr><td>
<div id="<%=entityID %>Error" ></div>
<div id="<%=entityID %>_searchCriteria" class="searchCriteriaContainer">
 
 </div>
<style>
<%=MasterUtil.generateCustomStyle(null, form, MasterForm, MasterForm.getProcessMode()) %>
</style>
 
 <table width="100%" border="0" cellpadding="1" cellspacing="0" align="center">
	<tr>
		<td align="left">
			<table width="100%" border="0" cellpadding="1" cellspacing="0" align="center">
			<tr><td align="left">
			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_SEARCH"/>
			</jsp:include>
			</td>
			<td width="90%">
			
			</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td> 
			<div id="<%=entityID %>_resultSearchContainer" class="resultSearchContainer" style="float: left;">
<%
com.master.model.EntityM entityM =  form.getEntityM();
ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
if(entityM.isRequireWFFlag() && entityM.isWfWQ()){ 
%>
    	<jsp:include flush="true" page="/manual/bpm/jsp/002/bpmSearchResult.jsp"/>
<%} else if (moduleActionM != null && null != moduleActionM.getSearchFilePath() && !"".equals(moduleActionM.getSearchFilePath())) {
	String searchFilePath = moduleActionM.getSearchFilePath();
	com.master.util.Log4jUtil.log("searchFilePath -> " + searchFilePath);
	String manualUrlPath = searchFilePath.substring(searchFilePath.indexOf("/", 1));
	pageContext.setAttribute("manualUrlPath", manualUrlPath);
	%><jsp:include flush="true" page="<%=manualUrlPath%>"/><%
} else {%>	
    	<jsp:include flush="true" page="resultSearch.jsp"/>
<%}%>    	
			</div>
		</td>
	</tr>
</table>
</td></tr></table>
</form>
<script>
<% com.avalant.display.SearchDisplayJSON sdj = new com.avalant.display.SearchDisplayJSON(); %>
$(document).ready(function() {
	var jsonCriteria = <%=sdj.getSearchCriteriaBoxJSON(request)%>;
	rederCriteria(jsonCriteria);
});
</script>
<%@page import="com.avalant.rules.j2ee.AccessControlM"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.model.ModuleActionM"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.master.model.ModuleM"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager"%>
<%@page import="com.master.form.EntityFormHandler"%>

<%	
	Logger logger = Logger.getLogger(this.getClass());
	String moduleID = (String)request.getParameter("module");
	String entityID = (String)request.getSession().getAttribute("entityID");
	logger.debug("moduleID >> "+moduleID);
	logger.debug("entityID >> "+entityID);
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");	
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(entitySession);
	
	HashMap moduleHashMap =  form.getModuleHashMap();
	String processMode = form.getCurrentMode();
	
	logger.debug("processMode >> "+processMode);
	
	ModuleM moduleM = (ModuleM)moduleHashMap.get(moduleID);
	
	request.getSession().setAttribute("module",moduleM.getModuleID());	 	 	 	 
	MasterFormHandler moduleForm = (MasterFormHandler)request.getSession().getAttribute(moduleM.getModuleID()+"_session");
	if (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(form.getCurrentMode())){ 
	 	moduleForm.setUnEditManyFlag(moduleForm.getModuleM().isViewModeFlag());
	 	if (!moduleForm.getModuleM().isViewModeFlag()) {
	 		moduleForm.setUnEditManyFlag(form.getEntityM().isViewModeFlag());	
	 	}
	}
	
	
	/*
	* 23-06-2014
	* plug with access control V.1.0
	* also display view mode on insert page
	*/
	if (!moduleForm.getModuleM().isViewModeFlag()) {
		moduleForm.setUnEditManyFlag(form.getEntityM().isAclFlag() && AccessControlM.ACCESS_MODE.VIEW.equals(form.getEntityM().getAclMode()));
	}
	
	
	String htmlModuleDivID = moduleM.getModuleID() + "_" + MasterConstant.NAMING.MODULE_SECTION;	
%>
<input type ="hidden" name = "<%=moduleM.getModuleID()%>_tableHeadNameFocus" value = "">
<input type ="hidden" name = "<%=moduleM.getModuleID()%>_tableHeadColFocus" value = "">
<div id="<%=htmlModuleDivID%>" class="boxbold3">
	<div class="padding-module" style="border-color:FFFFF;">
	<div class="panel-subheading02 padding-module">
		<div class="subheading"><%=MasterUtil.displayModuleName(moduleForm.getModuleM(), request)%></div>
	</div>
<!-- 	<div class="content-header"></div> -->
	<br>
	<table align="center" width="100%"><tbody><tr><td align="left"><div id="<%=moduleM.getModuleID()%>Error"></div></td></tr></tbody></table>
	<div id="<%=moduleM.getModuleID()%>MG">
		<%
// 			ModuleActionM moduleActionM = MasterUtil.getModuleActionFromModuleActions(moduleM.getModuleActions(),processMode);			
		%>
		<jsp:include flush="true" page="manyRelation.jsp"/> 
	</div>
	</div>
	<br>
</div>
<script type="text/javascript">
	$(document).ready( function() {
		postInitEAF();
	});
</script>
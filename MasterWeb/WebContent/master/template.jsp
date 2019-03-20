<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.model.ModuleM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.form.EntityFormHandler" %>

<% 
	String module = (String)request.getSession().getAttribute("module");
	System.out.println("module===>"+module);
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	if (MasterForm == null) {
		MasterForm = new MasterFormHandler();
		request.getSession().setAttribute(moduleSession,MasterForm);
	}
	ModuleM	moduleM = (ModuleM)MasterForm.getModuleM();

	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	String templateCode = form.getEntityM().getTemplateCode();
	String themeCode = form.getEntityM().getThemeCode();
	if(templateCode.equals("PB1")){
		templateCode = "ProfesionalBlue_01";
	}else if(templateCode.equals("PS1")){
		templateCode = "ProSilver";
	}
	String masterTemplateJSP = templateCode + "/masterTemplate.jsp";
	String searchMasterJSP = templateCode + "/searchMaster.jsp";
	
%>	

<jsp:include flush="true" page="../theme/theme.jsp">
<jsp:param name="themeCode" value="<%=themeCode%>"/>
</jsp:include> 

<% 	
	String processMode = MasterForm.getProcessMode();		 		
	com.master.model.ModuleActionM moduleActionM =  MasterUtil.getModuleActionFromModuleActions(moduleM.getModuleActions(),processMode);
	if (!"".equalsIgnoreCase(templateCode) && null != templateCode) {
		if ((processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_INSERT)) 
		|| (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_UPDATE))) {
%>
			<jsp:include flush="true" page="<%=masterTemplateJSP%>"/>
<%
		} else if((processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_SEARCH))) {
%>
			<jsp:include flush="true" page="<%=searchMasterJSP%>"/>
<%
		}
	}
%>
	
<%/* include eventScript that contain the javascript function */%>
<jsp:include flush="true" page="eventScript.jsp"/>

<%if (moduleActionM.getScriptFile() != null && !"".equals(moduleActionM.getScriptFile())) { %>
	<script type="text/javascript" src="<%=moduleActionM.getScriptFile()%>"></script>
<%} %>

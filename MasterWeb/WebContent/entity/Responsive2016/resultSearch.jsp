<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@ page import="com.master.model.ModuleActionM" %>
<%@page import="com.master.model.EntityM"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
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

	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	
	EntityM entityM  = form.getEntityM();
	
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
%>
<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">
<input type ="hidden" name = "clearCheckboxSession" value = "N"> 
<div class="table-responsive" >
<%
	boolean resultTemplate = com.avalant.feature.ExtendFeature.getInstance().useFeature("FT013_resultSearchByTemplate");
	if(resultTemplate && moduleActionM != null && null != moduleActionM.getResultTemplate() && !"".equals(moduleActionM.getResultTemplate()) ){
		out.print(com.avalant.display.SearchResultDisplay.getInstance().resultHTMLByTemplate(request));
}else{
%>
	<jsp:include flush="true" page="search/resultDefault.jsp"/> 
<%
} 
%>

</div>
<jsp:include flush="true" page="search/pagging.jsp"/>
<%
	
	if (moduleActionM != null){
		if (null != moduleActionM.getFilePath() && !"".equals(moduleActionM.getFilePath())) {
			String filePath = moduleActionM.getFilePath();
			System.out.println("filePath -> " + filePath);
			
			String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
			String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
			System.out.println("manualContextPath -> " + manualContextPath);
			System.out.println("manualUrlPath -> " + manualUrlPath);
			
			pageContext.setAttribute("manualContextPath", manualContextPath);
			pageContext.setAttribute("manualUrlPath", manualUrlPath);
%>
			<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>
<% 					
		}
	}
%>

<%
	/* javascript for dependency component */
	String strJavaScript = "";
	Vector vResult = MasterForm.getVMasterModelMs();	 
	Vector vAllDependencys = new Vector();
	for (int s=0;s < vResult.size();s++) {
		ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(s);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}
	}		
	
	strJavaScript += com.avalant.display.FT003_ProSilverObjUtil.generateJavaScript(vAllDependencys,request,false,false,false);
%>

<%=strJavaScript%>

<%
if (null != moduleActionM.getScriptFile() && !"".equals(moduleActionM.getScriptFile())) {
%>

	<script type="text/javascript" src="<%=moduleActionM.getScriptFile().trim()%>?v=<%=Math.random()%>"></script>	

<%
}
%>
<style type="text/css">

</style>
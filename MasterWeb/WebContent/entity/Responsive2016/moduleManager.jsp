<%@page import="com.avalant.rules.j2ee.AccessControlM"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.model.TabMouleM" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.model.TabM" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.model.ModuleM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.model.ModuleActionM" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.eaf40.model.MatrixModuleM" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% 
	String preHtmlTemplate = "";
	String postHtmlTemplate = "";//"<table><tbody><tr><td align=\"center\" colspan=\"2\">MID_00041</td></tr><tr><td>MID_00042</td><td>MID_00082</td></tr><tr><td>MID_00043</td><td>MID_00122</td></tr></tbody></table>";

	String strJavaScript = (String)request.getSession().getAttribute("endPageJavascript");
	
	if (strJavaScript == null) {
		strJavaScript = "";
	}

	String entityID = (String)request.getSession().getAttribute("entityID");
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
%>

<% 	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	HashMap hTabs = form.getTabHasMap();
	String currentTab = (String)request.getParameter("CURRENT_TAB");
	
	
	com.avalant.display.TabDisplay tabDisplay = new com.avalant.display.TabDisplay(request);
	boolean haveGeneralTab = tabDisplay.haveGeneralTab();
%>

<div id="<%=entityID%>Error">
<%if (form.hasErrors() && !haveGeneralTab) {%>
	<div class="row form-horizontal">
		<div class="col-xs-12 col-sm-12">
<%
		Vector v = form.getFormErrors();
		for (int s = 0; s < v.size(); s++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
		}
%>
		</div>
	</div>
<%} %>
</div>

<% 
if(!"".equalsIgnoreCase(currentTab) && null != currentTab){	  	 
	 TabM tabM = (TabM)hTabs.get(currentTab);
	 System.out.println("tabM===>"+tabM);  
	 System.out.println("currentTab===>"+currentTab);  
	 if(tabM != null){
	 System.out.println("tabM not null");  
	 
	 postHtmlTemplate = tabM.getHtmlTemplate();
	 Vector vTabModuleMs = tabM.getTabModuleMs();
	 HashMap moduleHashMap =  form.getModuleHashMap();
	 String processMode = form.getCurrentMode();

	if(vTabModuleMs.size() > 0){
	 for(int i = 0;i < vTabModuleMs.size();i++) {
	 	 TabMouleM tabModuleM = (TabMouleM)vTabModuleMs.get(i);
	 	 String moduleID = "";
	 	 ArrayList moduleAction = new ArrayList();
	 	 
	 	 if(moduleHashMap.get(tabModuleM.getModuleID()) instanceof ModuleM){
	 		ModuleM moduleM = (ModuleM)moduleHashMap.get(tabModuleM.getModuleID());
	 		moduleID = moduleM.getModuleID();
	 		moduleAction = moduleM.getModuleActions();
	 	 }else if(moduleHashMap.get(tabModuleM.getModuleID()) instanceof MatrixModuleM){
	 		MatrixModuleM mtxModuleM = (MatrixModuleM)moduleHashMap.get(tabModuleM.getModuleID());
	 		moduleID = mtxModuleM.getModuleID();
	 	 }
	 	 	 	 

 	 	 System.out.println("tabModuleM.getRelationType() -> " + tabModuleM.getRelationType());
 	 	 // start - apply tabModule manual template to screen
 	 	 if(null != postHtmlTemplate && !"".equals(postHtmlTemplate)){
	 	 	 String[] htmlTemplateArray = postHtmlTemplate.split(tabModuleM.getModuleID());
	 	 	 preHtmlTemplate = htmlTemplateArray[0];
	 	 	 postHtmlTemplate = htmlTemplateArray[1];
	 	 	 System.out.println("---");
	 	 	 System.out.println("tabModuleM.getModuleID() -> " + tabModuleM.getModuleID());
	 	 	 System.out.println("htmlTemplateArray[0] -> " + htmlTemplateArray[0]);
	 	 	 System.out.println("htmlTemplateArray[1] -> " + htmlTemplateArray[1]);
	 	 	 System.out.println("---");
 	 	 }
 	 	 // end - apply tabModule manual template to screen
 	 	 
	 	 request.getSession().setAttribute("module",moduleID);	 	 	 	 
		 MasterFormHandler moduleForm = (MasterFormHandler)request.getSession().getAttribute(tabModuleM.getModuleID()+"_session");
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
		//out.print("<p>en:"+form.getEntityM().isViewModeFlag()+"</p>");
		//out.print("<p>M"+moduleForm.getModuleM().getModuleID()+"</p>");
		//out.print("<p>V"+moduleForm.getModuleM().isViewModeFlag()+"</p>");
		//out.print("<p>en V"+form.getEntityM().getAclMode()+"</p>");
		//out.print("<p>M V"+moduleForm.getModuleM().getAclMode()+"</p>");
		if (!moduleForm.getModuleM().isViewModeFlag()) {
			if(form.getEntityM().isAclFlag()) {
				if(AccessControlM.ACCESS_MODE.VIEW.equals(form.getEntityM().getAclMode())) moduleForm.setUnEditManyFlag(true);
				else moduleForm.setUnEditManyFlag(false);
			}
			if(moduleForm.getModuleM().isAclFlag()) {
				if(AccessControlM.ACCESS_MODE.VIEW.equals(moduleForm.getModuleM().getAclMode())) moduleForm.setUnEditManyFlag(true);
				else moduleForm.setUnEditManyFlag(false);
			}
		}
		
		String htmlModuleDivID = moduleID + "_" + MasterConstant.NAMING.MODULE_SECTION;
%>
<script type="text/javascript">
$(document).ready( function() {
	try{
		initPicObj<%=moduleID%>("<%=tabModuleM.getRelationType().toLowerCase()%>");
	}catch(e){}

});
</script>
<%//hidden field here for manyRelation table sorting %>
<input type ="hidden" name = "<%=moduleID%>_tableHeadNameFocus" value = "">
<input type ="hidden" name = "<%=moduleID%>_tableHeadColFocus" value = "">

<%
	if(null != preHtmlTemplate && !"".equals(preHtmlTemplate)){
		out.println(preHtmlTemplate);
	}
	
	boolean isGeneralTab =false;
	if(tabM.isGeneralTabFlag()){
		isGeneralTab = true;
	}
%>

<%if(isGeneralTab){ %>
<li id="<%=htmlModuleDivID %>_li">
<%} %>
		<div id="<%=htmlModuleDivID %>" class="moduleDiv" <%=(moduleForm.getModuleM().isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleForm.getModuleM().getAclMode()) ? "style='display:none;'" : "") %>>
			<div class="padding-module">
<!-- 			<div class="panel-subheading02"> -->
<%-- 				<div class="subheading"><%=MasterUtil.displayModuleName(moduleForm.getModuleM(), request)%></div> --%>
<!-- 			</div> -->
			<div class="<%=moduleForm.getModuleM().getModuleID()%>-content-header"></div>
			
			<% 
			/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			* FIX : 201612191556
			* apply AdminLTE theme for responsive2016
			* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
			%>
			<!-- <br> -->
			
			
			<div class="row form-horizontal">
				<div class="col-xs-12 col-sm-12">
				<div id="<%=moduleForm.getModuleM().getModuleID()%>Error">
<%
		boolean errorConsole = com.avalant.feature.ExtendFeature.getInstance().useFeature("ONEWEB_ERROR_CONSOLE");
		if (moduleForm.hasErrors() && !errorConsole) {
			Vector v = moduleForm.getFormErrors();
			for (int f = 0; f < v.size(); f++) {
				out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(f) + "</span><br>");
			}
		}
%>
				</div>
				</div>
			</div>
		<div id ='<%=moduleID%>MG' style="z-index:100;position:static;">	    

<%
		/*-- start get manual jsp path --*/
		ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(moduleAction,processMode);
		System.out.println("moduleM.getModuleID() : "+moduleID+ " | moduleActionM -> " + moduleActionM);
		if(null!=moduleActionM){
			System.out.println("getModuleID -> " + moduleActionM.getModuleID());
			System.out.println("getClassAction -> " + moduleActionM.getClassAction());
			System.out.println("filePath -> " + moduleActionM.getFilePath());
	 	}
	 	 if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
	 	 	if (moduleActionM != null && (moduleActionM.getFilePath() != null  && !"".equals(moduleActionM.getFilePath()))) {
	 	 		String filePath = moduleActionM.getFilePath();
				System.out.println("filePath -> " + filePath);
				
				String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
				String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
				System.out.println("manualContextPath -> " + manualContextPath);
				System.out.println("manualUrlPath -> " + manualUrlPath);
				
				pageContext.setAttribute("manualContextPath", manualContextPath);
				pageContext.setAttribute("manualUrlPath", manualUrlPath);	 	 		
				if (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_INSERT) || (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_UPDATE))) {
						if (moduleActionM.isInnerIncludeFlag()) {
%>
							<jsp:include flush="true" page="<%=manualUrlPath%>"/>
<% 						
						} else {
%>
							<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>
<%		
						}	
				}		
	 	 	} else  { 
%>
	 	 		<jsp:include flush="true" page="oneRelation.jsp"/> 	 		 
<% 	 	 
	 	 	}
	 	 } else if ((MasterConstant.ENTITY_RELATION_TYPE_MANY.equalsIgnoreCase(tabModuleM.getRelationType()))){ 
%>
	 	 		<jsp:include flush="true" page="manyRelation.jsp"/> 
<% 	 	 	 	 	
	 	 } else if (MasterConstant.ENTITY_RELATION_TYPE_LIST.equalsIgnoreCase(tabModuleM.getRelationType())){
%>	 		 
	 	 		<jsp:include flush="true" page="manyRelation.jsp"/>
<% 	 	 		
	 	 } else if ((MasterConstant.ENTITY_RELATION_TYPE_ATTACHED.equalsIgnoreCase(tabModuleM.getRelationType())))  { 
%>	 	 
	 	  		<jsp:include flush="true" page="attachmentFile.jsp"/> 
<% 	 	 
	 	 } else if ((MasterConstant.ENTITY_RELATION_TYPE_MATRIX.equalsIgnoreCase(tabModuleM.getRelationType()))) {
%>
	 			<jsp:include flush="true" page="matrixRelation.jsp"/>
<%	 			
	 	 }
%>
		</div>
<% 	 	 
	Vector vResult = moduleForm.getVMasterModelMs();	 
	Vector vAllDependencys = new Vector();
	for (int s=0;s < vResult.size();s++) {
		Object dataField = vResult.get(s);
		
		if(dataField instanceof ModuleFieldM){
			ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(s);
			if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
				vAllDependencys.addElement(prmModuleFieldM);
			}
		}
	}		
	
	if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
		strJavaScript += com.avalant.display.FT003_ProSilverObjUtil.generateJavaScript(vAllDependencys,request,false,false,false);
	}
%>

<% 	 	 
		if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
			if (moduleActionM.getScriptFile() != null && !"".equals(moduleActionM.getScriptFile())) {				
%>
				<script type="text/javascript" src="<%=moduleActionM.getScriptFile()%>"></script>
<% 	 	 	 	
			}
		}
%>
			</div>
		</div> <% /*-- end div class="moduleDiv" --*/ %>
<%if(isGeneralTab){ %>
</li>
<%} %>
<% 	 	
	 } /*-- end for --*/
%>
<%
	if(null != postHtmlTemplate && !"".equals(postHtmlTemplate)){
		out.print(postHtmlTemplate);
	}
%>
<%
		} /*-- end if --*/
	}
}
%>


<%
	// For switch tab to dependency feature can do.
	if (strJavaScript != null) {
		out.print(strJavaScript);
	}	
	//---------------------------------------------
	

	//if(!"".equalsIgnoreCase(strJavaScript)) {
	//	request.getSession().setAttribute("endPageJavascript", strJavaScript);
	//}
%>
<script type="text/javascript">
$(document).ready( function() {
	postInitEAF();
});
</script>
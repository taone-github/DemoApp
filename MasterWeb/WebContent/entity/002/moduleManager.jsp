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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% 
	String strJavaScript = "";
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
%>

<div id="<%=entityID%>Error">
<%if (form.hasErrors()) {%>
	<table cellspacing="0" cellpadding="0" align ="center" width="100%" >
		<tr>
			<td>
<%
		Vector v = form.getFormErrors();
		for (int s = 0; s < v.size(); s++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
		}
%>
			</td>
		</tr>
	</table>
<%} %>
</div>

<% 
if(!"".equalsIgnoreCase(currentTab) && null != currentTab){	  	 
	 TabM tabM = (TabM)hTabs.get(currentTab);
	 System.out.println("tabM===>"+tabM);  
	 Vector vTabModuleMs = tabM.getTabModuleMs();
	 HashMap moduleHashMap =  form.getModuleHashMap();
	 String processMode = form.getCurrentMode();

	if(vTabModuleMs.size() > 0){
	 for(int i = 0;i < vTabModuleMs.size();i++) {
	 	 TabMouleM tabModuleM = (TabMouleM)vTabModuleMs.get(i);
	 	 ModuleM moduleM = (ModuleM)moduleHashMap.get(tabModuleM.getModuleID());	 	 
 	 	 
	 	 request.getSession().setAttribute("module",moduleM.getModuleID());	 	 	 	 
		 MasterFormHandler moduleForm = (MasterFormHandler)request.getSession().getAttribute(tabModuleM.getModuleID()+"_session");
		 if (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(form.getCurrentMode())){ 
		 	moduleForm.setUnEditManyFlag(moduleForm.getModuleM().isViewModeFlag());
		 	if (!moduleForm.getModuleM().isViewModeFlag()) {
		 		moduleForm.setUnEditManyFlag(form.getEntityM().isViewModeFlag());	
		 	}
		 }
		 String htmlModuleDivID = moduleM.getModuleID() + "_" + MasterConstant.NAMING.MODULE_SECTION;
%>

<%//hidden field here for manyRelation table sorting %>
<input type ="hidden" name = "<%=moduleM.getModuleID()%>_tableHeadNameFocus" value = "">
<input type ="hidden" name = "<%=moduleM.getModuleID()%>_tableHeadColFocus" value = "">

<%if(tabM.isGeneralTabFlag()){ %>
<li id="<%=htmlModuleDivID %>_li">
<%} %>
		<div id="<%=htmlModuleDivID %>" class="moduleDiv">
			<table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF2F8">
				<tr> 
					<td width="10" background="<%=request.getContextPath()%>/theme/<%=form.getEntityM().getThemeCode()%>/images/bg_topic.gif">&nbsp;</td>
					<td width="10">&nbsp;</td>
					<td><font class="bubold2"><%=moduleForm.getModuleM().getModuleName()%></font></td>
				</tr>
			</table>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td background="<%=request.getContextPath()%>/theme/002/images/dot_her.gif"><img src="<%=request.getContextPath()%>/theme/<%=form.getEntityM().getThemeCode()%>/images/cl.gif" width="3" height="1"></td>
				</tr>
			</table>
			<table align = "center"  width="100%"  >
				<tr>
					<td align = "left"><div id="<%=moduleForm.getModuleM().getModuleID()%>Error">
<%
			if (moduleForm.hasErrors()) {
				Vector v = moduleForm.getFormErrors();
				for (int f = 0; f < v.size(); f++) {
					out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(f) + "</span><br>");
				}
			} 
%>
					</div></td>
				</tr>
			</table>
		<div id ='<%=moduleM.getModuleID()%>MG' >	    

<%
		/*-- start get manual jsp path --*/
		ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(moduleM.getModuleActions(),processMode);
	 	 
	 	 if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
	 	 	if (moduleActionM != null && (moduleActionM.getFilePath() != null  && !"".equals(moduleActionM.getFilePath()))) {
				if (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_INSERT) || (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_UPDATE))) {
		 	 		String filePath = moduleActionM.getFilePath();
					System.out.println("filePath -> " + filePath);
					
					String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
					String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
					System.out.println("manualContextPath -> " + manualContextPath);
					System.out.println("manualUrlPath -> " + manualUrlPath);
					
					pageContext.setAttribute("manualContextPath", manualContextPath);
					pageContext.setAttribute("manualUrlPath", manualUrlPath);

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
	 	 }
%>
		</div>
<% 	 	 
	Vector vResult = moduleForm.getVMasterModelMs();	 
	Vector vAllDependencys = new Vector();
	for (int s=0;s < vResult.size();s++) {
		ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(s);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}
	}		
	
	if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
		strJavaScript += MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
	}
%>

<% 	 	 
		if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
			if (moduleActionM.getScriptFile() != null && !"".equals(moduleActionM.getScriptFile())) {				
%>
				<SCRIPT language="JavaScript" src="<%=moduleActionM.getScriptFile()%>"></SCRIPT>
<% 	 	 
	 	
			}
		}
%>
		</div> <% /*-- end div class="moduleDiv" --*/ %>
<%if(tabM.isGeneralTabFlag()){ %>
</li>
<%} %>
<% 	 	
	 } /*-- end for --*/
	} /*-- end if --*/
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

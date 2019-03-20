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
	System.out.println("entitySession==>"+entitySession);
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
	System.out.println("form==>"+form);
	System.out.println("entityTabs==>"+entityTabs);
	HashMap hTabs = form.getTabHasMap();
	String currentTab = (String)request.getParameter("CURRENT_TAB");
%>

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

<% 
	 System.out.println("hTabs===>"+hTabs);  
	 System.out.println("form.getCurrentTab()===>"+form.getCurrentTab());  	 
	 TabM tabM = (TabM)hTabs.get(currentTab);
	 System.out.println("tabM===>"+tabM);  
	 Vector vTabModuleMs = tabM.getTabModuleMs();
	 HashMap moduleHashMap =  form.getModuleHashMap();
	 String processMode = form.getCurrentMode();
	 
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

<li>
	<div id="<%=htmlModuleDivID %>" class="moduleDiv">
		<table cellspacing="0" cellpadding="0" align ="center" width="100%" >
			<tr>
				<td >
					<table width="100%">  
						<tr>
							<td class="subformline" valign="bottom" nowrap>
								<div class="moduleIcon"></div><%=moduleForm.getModuleM().getModuleName()%>
							</td>
						</tr>
					</table>
					<table align = "center"  width="100%"  >
						<tr>
							<td align = "left">
<%
			if (moduleForm.hasErrors()) {
				Vector v = moduleForm.getFormErrors();
				for (int f = 0; f < v.size(); f++) {
					out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(f) + "</span><br>");
				}
			} 
%>
							</td>
						</tr>
					</table>    

<% 			
	 	 ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(moduleM.getModuleActions(),processMode);
	 	 if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
	 	 	if (moduleActionM != null && (moduleActionM.getFilePath() != null  && !"".equals(moduleActionM.getFilePath()))) {
	 	 		String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	 	 		String pathFile = hostPrefix + moduleActionM.getFilePath();
				System.out.println("pathFile (url) -> " + pathFile);
				pageContext.setAttribute("FULL_URL", pathFile);
				
				if (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_INSERT))  {
%>
					<c:import url="${FULL_URL}" charEncoding="UTF-8"/>
<%		
				} else if((processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_UPDATE))) {
%>
					<c:import url="${FULL_URL}" charEncoding="UTF-8"/>
<% 					
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
	 	 		<jsp:include flush="true" page="listManyRelation.jsp"/>
<% 	 	 		
	 	 } else if ((MasterConstant.ENTITY_RELATION_TYPE_ATTACHED.equalsIgnoreCase(tabModuleM.getRelationType())))  { 
%>	 	 
	 	  		<jsp:include flush="true" page="attachmentFile.jsp"/> 
<% 	 	 
	 	 }
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
		System.out.println("entity/002/template02.jsp");
		strJavaScript += MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
	}
%>

<% 	 	 
		if (moduleActionM.getScriptFile() != null && !"".equals(moduleActionM.getScriptFile())) {
			System.out.println("moduleActionM.getScriptFile() -> " + moduleActionM.getScriptFile());
%>
			<SCRIPT language="JavaScript" src="<%=moduleActionM.getScriptFile()%>"></SCRIPT>
<% 	 	 
	 	}
%>
				</td>
			</tr>
		</table>
	</div> <% /*-- end div class="moduleDiv" --*/ %>
</li>
<% 	 	
	 } /*-- end for --*/
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

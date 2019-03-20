<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.model.EntityTabM" %>
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
<form name = "masterForm" action="FrontController" method="post">
<input type = "hidden"  name="action" value ="">
<input type = "hidden"  name="handleForm" value ="">
<input type = "hidden"  name="sessionForm" value ="">
<input type = "hidden" name="currentTab" value="<%=form.getCurrentTab()%>">
<input type = "hidden" name="goEntity" value="">
<input type = "hidden" name="goEntityKey" value="">
<input type = "hidden" name="goEntityField" value="">
<input type = "hidden" name="nextTab" value="">
<input type = "hidden" name="nextEntity" value="">




<table cellspacing="0" cellpadding="0" align ="center" width="100%">

<tr>
<td align="right">
<% 
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	System.out.println("form==>"+form);
	System.out.println("entityTabs==>"+entityTabs);
	HashMap hTabs = form.getTabHasMap();
	for(int i=0;i<entityTabs.size();i++) {
		EntityTabM entityTabM = (EntityTabM)entityTabs.get(i);
		TabM tabM =  (TabM)hTabs.get(entityTabM.getTabID());

%> 	
	<a href="javascript:void(0);<%=entityID%>SwitchTab('<%=tabM.getTabID()%>')"><%=tabM.getTabName()%></a>&nbsp;		
<% 	
	}
%>
</td>
</tr>
<tr>
<td>
<%
	 if (form.hasErrors()) {
		Vector v = form.getFormErrors();
		for (int s = 0; s < v.size(); s++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
		}
	 }
%>	  
</td>
</tr>

<% 
	 System.out.println("hTabs===>"+hTabs);  
	 System.out.println("form.getCurrentTab()===>"+form.getCurrentTab());  	 
	 TabM tabM = (TabM)hTabs.get(form.getCurrentTab());
	 System.out.println("tabM===>"+tabM);  
	 Vector vTabModuleMs = tabM.getTabModuleMs();
	 HashMap moduleHashMap =  form.getModuleHashMap();
	 String processMode = form.getCurrentMode();
	 for(int i = 0;i < vTabModuleMs.size();i++) {
%>
	<tr>
	<td>
<% 	 
	 	 TabMouleM tabModuleM = (TabMouleM)vTabModuleMs.get(i);
	 	 ModuleM moduleM = (ModuleM)moduleHashMap.get(tabModuleM.getModuleID());	 	 
	 	 request.getSession().setAttribute("module",moduleM.getModuleID());	 	 	 	 
		 MasterFormHandler moduleForm = (MasterFormHandler)request.getSession().getAttribute(tabModuleM.getModuleID()+"_session"); 
		 if (moduleForm.hasErrors()) {
			Vector v = moduleForm.getFormErrors();
			for (int s = 0; s < v.size(); s++) {
				out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
			}
		 } 
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
					<c:import url="${FULL_URL}" charEncoding="utf-8"/>
						
<%		
				} else if((processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_UPDATE))) {
%>
					<c:import url="${FULL_URL}" charEncoding="utf-8"/>
<% 					
				}					 
	 	 	} else  { 
%>
	 	 		<jsp:include flush="true" page="oneRelation.jsp"/>
<% 	 	 
	 	 	}	  	 	 
	 	 } else if (MasterConstant.ENTITY_RELATION_TYPE_LIST.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 {
%>	 		 
	 	 		<jsp:include flush="true" page="listManyRelation.jsp"/>
<% 
	 	 } else {
%>
	 	 		<jsp:include flush="true" page="manyRelation.jsp"/> 
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
			String strJavaScript = MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);	
%>		
	<%=strJavaScript%>	 	 
		 	 
<% 	 	 
	 	 
		if (moduleActionM.getScriptFile() != null && !"".equals(moduleActionM.getScriptFile())) {
%>
			<SCRIPT language="JavaScript" src="<%=moduleActionM.getScriptFile()%>"></SCRIPT>
<% 	 	 
	 	}
%>
	</td>
	</tr>
<% 	 	
	 }
%>	


</table>
<TABLE width="100%" align="center"  cellpadding="0" cellspacing="0" >
		<tr>
		<td width="90%">
		</td>
		<td align="right" width="10%">
<% 
	if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) {
%>  			  			
  			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_INSERT"/>
			</jsp:include>
<% 
	} else {
%>			
  			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_UPDATE"/>
			</jsp:include>

<% 
	}
%>	
		</td>
		</tr>
	
	</TABLE>
</form>
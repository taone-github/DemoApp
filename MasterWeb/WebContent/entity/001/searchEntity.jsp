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
	System.out.println("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}		
	System.out.println("form.getMainModuleID()==>"+form.getMainModuleID());
	String moduleSession = form.getMainModuleID() +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	System.out.println("Search MasterForm.getVShowColumnsSearch()==>"+MasterForm.getVShowColumnsSearch());
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


<%@page import="com.master.model.ModuleActionM"%><form name ="masterForm" action="FrontController" >
<input type ="hidden" name = "action" value="searchMaster">
<input type ="hidden" name = "handleForm" value = "Y">
<table width="90%" border="0" align="center" >

<% 
	Vector vSearchCriteria = MasterForm.getVMasterModelMs();	
	HashMap hAllObj = MasterForm.getHAllobjects();
	HashMap hShowRecords = MasterForm.getHSearchCriteriaData();
	for (int i=0;i < vSearchCriteria.size();i++) {
	ModuleFieldM prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i);
	HashMap hFieldProps = (HashMap)hAllObj.get(prmModuleFieldM.getObjType());
	Object obj = hFieldProps.get(prmModuleFieldM.getMfID());
	MasterUtil util =  MasterUtil.getInstance();	
	Object valueData= null;
	if (hShowRecords != null) {
		Object objDataValue = hShowRecords.get(prmModuleFieldM.getFieldID());
		if (objDataValue != null) {
			valueData = objDataValue;
		}
	}	
	String tagShow = util.displayManualTag(request,entityID, prmModuleFieldM.getFieldID(), MasterForm);
	System.out.println("tagShow===>"+tagShow);
	if (i%2 == 0) { 	 
%>     
  <tr>
<% 
	}
%>  
    <td class="<%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_label">
    	<%=MasterUtil.displayFieldName(prmModuleFieldM,request)%>
    </td>
    <td class="<%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input">
    	<%=tagShow%>
    </td>
    
<% 
	if (i%2 != 0) { 	 
%>
  </tr>
 <%
 	} 
  }
 %> 
 <tr>
    <td ></td>
    <td ></td>
    <td >
    <jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
	<jsp:param name="module" value="<%=entityID%>"/>
	<jsp:param name="action" value="ENTITY_SEARCH"/>
	</jsp:include>  
    
    </td>
    <td ></td>
  </tr> 
<style>
<%=MasterUtil.generateCustomStyle(null, form, MasterForm, MasterForm.getProcessMode()) %>
</style>
  <tr>
    <td colspan="4" align="left"> 
    	<% 
    	com.master.model.EntityM entityM =  form.getEntityM();
    	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
		if (moduleActionM != null && null != moduleActionM.getSearchFilePath() && !"".equals(moduleActionM.getSearchFilePath())) {
    		String searchFilePath = moduleActionM.getSearchFilePath();
    		System.out.println("searchFilePath -> " + searchFilePath);
    		String manualUrlPath = searchFilePath.substring(searchFilePath.indexOf("/", 1));
    		pageContext.setAttribute("manualUrlPath", manualUrlPath);
    		%><jsp:include flush="true" page="<%=manualUrlPath%>"/><%
    	} else {
    		%><jsp:include flush="true" page="resultSearch.jsp"/><%
    	}
    	%>
    </td>
  </tr>
</table>
</form>



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
<input type ="hidden" name = "action" value="searchMaster">
<input type ="hidden" name = "handleForm" value = "Y">

<div id="topAreaSearchEntity"></div>

<table width="98%" border="0" cellpadding="1" cellspacing="0" align="center"><tr><td>
<div id="<%=entityID %>Error" ></div>
<div id="<%=entityID %>_searchCriteria" class="searchCriteriaContainer">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
<% 
	Vector vSearchCriteria = MasterForm.getVMasterModelMs();
	int visibleElementNum = vSearchCriteria.size();
	int colNum = 1;
	int previousElementGroup = 0;
	int nextFieldGroup = 0;
	String lastRowColSpan = "";
	
	for (int i=0;i < visibleElementNum; i++) {
		ModuleFieldM prmModuleFieldM;
		if(i+1 != visibleElementNum){
			prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i+1);
			nextFieldGroup = prmModuleFieldM.getFieldGroup();
		}else{
			nextFieldGroup = 0;
		}
		
		prmModuleFieldM = new ModuleFieldM();
		prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i);
		
		/* start pair of naming convention */
		String labelNamed = prmModuleFieldM.getModuleID() + "_" + prmModuleFieldM.getFieldID() + "_" + MasterConstant.NAMING.LABEL_FIELD;
		String htmlComponentNamed = prmModuleFieldM.getModuleID() + "_" + prmModuleFieldM.getFieldID() + "_" + MasterConstant.NAMING.INPUT_FIELD;
		/* end pair of naming convention */
		
		String tagShow = MasterUtil.displayManualTag(request, entityID, prmModuleFieldM.getFieldID(), MasterForm);
		
		if (MasterConstant.HIDDEN.equalsIgnoreCase(prmModuleFieldM.getObjType()) ) {
%>
			<%=tagShow%>
<%
		}else{
			if(colNum == 1 || previousElementGroup != prmModuleFieldM.getFieldGroup()){
%>
			<tr>
<%
			}
			
			if(nextFieldGroup != prmModuleFieldM.getFieldGroup() && colNum != prmModuleFieldM.getColumnCount()){
				int spanValue = 1 + 3*(prmModuleFieldM.getColumnCount() - colNum);
				lastRowColSpan = " colspan=\"" + Integer.toString(spanValue) + "\" ";
			}else{
				lastRowColSpan = "";
			}
%>
		<td class="td_OneRelation <%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_label">
	    	<div class="componentNameDiv" id="<%=labelNamed %>" >
	    		<NOBR><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%></NOBR>
	    	</div>
	    </td>
	    <td class="td_OneRelation">
			<div class="componentSpacerDiv">&nbsp;</div>
		</td>
	    <td class="td_OneRelation <%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input" <%=lastRowColSpan %> >
			<div class="componentDiv" id="<%=htmlComponentNamed %>" ><%=tagShow%></div>
		</td>
<%
			previousElementGroup = prmModuleFieldM.getFieldGroup();
			colNum++;
			if((colNum-1) == prmModuleFieldM.getColumnCount() || !"".equalsIgnoreCase(lastRowColSpan)){
%>
			</tr>
<%
				previousElementGroup = 0;
				colNum = 1;
			}
		}
	} //for loop
%>
 </table>
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
<%}else if (moduleActionM != null && null != moduleActionM.getSearchFilePath() && !"".equals(moduleActionM.getSearchFilePath())) {
	String searchFilePath = moduleActionM.getSearchFilePath();
	System.out.println("searchFilePath -> " + searchFilePath);
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

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@page import="com.master.form.EntityFormHandler"%>

<%

	String entityID = (String)request.getSession().getAttribute("entityID");
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	EntityFormHandler entityForm = (EntityFormHandler)request.getSession().getAttribute(entityID+"_session");
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
	
	Vector vResult = MasterForm.getVMasterModelMs();

%>
<% 
	int col = MasterForm.getModuleM().getColumnCount();
	String tableWidth = "90%";
	if(col == 1){
		tableWidth = "30%";
	}else if(col == 2){
		tableWidth = "50%";
	}else if(col == 3){
		tableWidth = "70%";
	}
%>
<table class="tableForm" align="center"  width="<%=tableWidth%>" cellpadding="0" cellspacing="0" border="0">

<%	
	Vector vAllDependencys = new Vector();
	int visibleElementNum = vResult.size();
	int colNum = 1;
	int previousElementGroup = 0;
	int nextFieldGroup = 0;
	String lastRowColSpan = "";
	
	for(int i=0; i<visibleElementNum; i++){
		ModuleFieldM prmModuleFieldM;
		if(i+1 != visibleElementNum){
			prmModuleFieldM = (ModuleFieldM)vResult.get(i+1);
			nextFieldGroup = prmModuleFieldM.getFieldGroup();
		}else{
			nextFieldGroup = 0;
		}
		
		prmModuleFieldM = new ModuleFieldM();
		prmModuleFieldM = (ModuleFieldM)vResult.get(i);
		
		/* start pair of naming convention */
		String labelNamed = prmModuleFieldM.getModuleID() + "_" + prmModuleFieldM.getFieldID() + "_" + MasterConstant.NAMING.LABEL_FIELD;
		String htmlComponentNamed = prmModuleFieldM.getModuleID() + "_" + prmModuleFieldM.getFieldID() + "_" + MasterConstant.NAMING.INPUT_FIELD;
		/* end pair of naming convention */
		
		String tagShow = MasterUtil.displayManualTag(request, entityID, prmModuleFieldM.getFieldID(), MasterForm);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}
		
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
			
			if(nextFieldGroup != prmModuleFieldM.getFieldGroup() && colNum != MasterForm.getModuleM().getColumnCount()){
				int spanValue = 1 + 3*(MasterForm.getModuleM().getColumnCount() - colNum);
				lastRowColSpan = " colspan=\"" + Integer.toString(spanValue) + "\" ";
			}else{
				lastRowColSpan = "";
			}
			
			//Sam hidden mandate * from View mode
			boolean viewFlag = entityForm.getEntityM().isViewModeFlag();
			if (!viewFlag) {
				viewFlag = MasterForm.getModuleM().isViewModeFlag();
			}								
			if (!viewFlag) {
				viewFlag = prmModuleFieldM.isViewFlag();
			}
%>
				<td class="td_OneRelation <%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_label" >
					<div class="componentNameDiv" id="<%=labelNamed %>" >
						<NOBR>
							<%=MasterUtil.displayFieldName(prmModuleFieldM,request)%>
							<%//Sam add hide mandate on UPDATE mode only 
							  if((!viewFlag && MasterConstant.PROCESS_MODE_UPDATE.equals(entityForm.getCurrentMode()))
							   || MasterConstant.PROCESS_MODE_INSERT.equals(entityForm.getCurrentMode())){ %>
							<%=MasterUtil.displayManDate(prmModuleFieldM)%>
							<%} %>
						</NOBR>
					</div>
				</td>
				<td class="td_OneRelation" width ="1%">
					<div class="componentSpacerDiv">&nbsp;</div>
				</td>
				<td class="td_OneRelation <%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input" <%=lastRowColSpan %>>
					<div class="componentDiv" id="<%=htmlComponentNamed %>" ><%=tagShow%></div>
				</td>
<%
			previousElementGroup = prmModuleFieldM.getFieldGroup();
			colNum++;
			if((colNum-1) == MasterForm.getModuleM().getColumnCount() || !"".equalsIgnoreCase(lastRowColSpan)){
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
<div align ="right">
			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
				<jsp:param name="module" value="<%=module%>"/>
				<jsp:param name="action" value="ENTITY_MODULE"/>
			</jsp:include>
</div>

<style>
<%=MasterUtil.generateCustomStyle(null, entityForm, MasterForm, entityForm.getCurrentMode()) %>
</style>

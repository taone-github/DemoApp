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
	HashMap hAllObj = MasterForm.getHAllobjects();
	HashMap storeHashMap =  MasterForm.getStoreHashMap();
	ArrayList aValues =  new ArrayList(storeHashMap.values());
	HashMap hShowRecords = null;
	if (aValues.size() != 0) {
		hShowRecords = (HashMap)aValues.get(0);
	}
%>


<table class = "tableForm" align = "center"  width="90%" border="0">

<% 
	MasterUtil util =  MasterUtil.getInstance();	
	Vector vAllDependencys = new Vector();
	int visibleElementNum = vResult.size();
	int colNum = 1;
	int previousElementGroup = 0;
	int nextFieldGroup = 0;
	String lastRowColSpan = "";
	
	for (int i=0;i < visibleElementNum; i++) {
		ModuleFieldM prmModuleFieldM;
		if(i+1 != visibleElementNum){
			prmModuleFieldM = (ModuleFieldM)vResult.get(i+1);
			nextFieldGroup = prmModuleFieldM.getFieldGroup();
		}else{
			nextFieldGroup = 0;
		}
		
		prmModuleFieldM = new ModuleFieldM();
		prmModuleFieldM = (ModuleFieldM)vResult.get(i);
		HashMap hFieldProps = (HashMap)hAllObj.get(prmModuleFieldM.getObjType());
		System.out.println(" hFieldProps "+hFieldProps);	
		Object obj = hFieldProps.get(prmModuleFieldM.getMfID());
		System.out.println(" obj = "+obj);	
		Object valueData= null;
		if (hShowRecords != null) {
			Object objDataValue = hShowRecords.get(prmModuleFieldM.getFieldID());
			
			if (objDataValue != null) {
				valueData = objDataValue;
			}
		}
		
		String tagShow = util.displayManualTag(request,entityID, prmModuleFieldM.getFieldID(), MasterForm);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}

		if (MasterConstant.HIDDEN.equalsIgnoreCase(prmModuleFieldM.getObjType()) ) {
%>
			<%=tagShow%>
<%
		}else{
			if(colNum == 1){
%>
			<tr>
<%
			}
%>
<%
			if(previousElementGroup != prmModuleFieldM.getFieldGroup()){
				colNum = 1;
%>
			</tr>
<%
			}
			
			if(nextFieldGroup != prmModuleFieldM.getFieldGroup() && colNum != MasterForm.getModuleM().getColumnCount()){
				int spanValue = 1 + 3*(MasterForm.getModuleM().getColumnCount() - colNum);
				lastRowColSpan = " colspan=\"" + Integer.toString(spanValue) + "\" ";
			}else{
				lastRowColSpan = "";
			}
%>
			<td valign="top" align="right" class="<%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_label"><NOBR>&nbsp;<%=MasterUtil.displayFieldName(prmModuleFieldM,request)%><%=MasterUtil.displayManDate(prmModuleFieldM)%>&nbsp;</NOBR></td>
			<td width="5px">&nbsp;</td>
			<td valign="top" align="left"  class="<%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input">&nbsp;<%=tagShow%>&nbsp;</td>
<%
			previousElementGroup = prmModuleFieldM.getFieldGroup();
			colNum++;
			if((colNum-1) == MasterForm.getModuleM().getColumnCount()){
%>
			</tr>		
<%
				colNum = 1;
			}
		}
	} //for loop	
%>	 
</table>
<style>
<%=MasterUtil.generateCustomStyle(null, entityForm, MasterForm, entityForm.getCurrentMode()) %>
</style>
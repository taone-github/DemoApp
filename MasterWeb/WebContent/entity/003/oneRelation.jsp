<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>


<%

	String entityID = (String)request.getSession().getAttribute("entityID");
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
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
 
<div id="contentTableHeader">

<table  align = "center" width="100%"  cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td align="right">
			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=module%>"></jsp:param>
			<jsp:param name="action" value="ENTITY_MODULE"></jsp:param>
			</jsp:include>
		</TD>
	</tr>
</table>

<table align = "center"  width="100%"  cellpadding="0" cellspacing="0" border="0" >

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
		
		String tagShow = MasterUtil.displayManualTag(request,entityID, prmModuleFieldM.getFieldID(),MasterForm);
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
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td class="title <%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input" valign="top" align="left" <%=lastRowColSpan %>>
				<div class="componentDiv displayFieldName">
				<%=MasterUtil.displayFieldName(prmModuleFieldM,request)%><%=MasterUtil.displayManDate(prmModuleFieldM)%>
				</div>
				<%=tagShow%>
			</td>
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
</div>

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
	HashMap hAllObj = MasterForm.getHAllobjects();
	HashMap storeHashMap =  MasterForm.getStoreHashMap();
	ArrayList aValues =  new ArrayList(storeHashMap.values());
	HashMap hShowRecords = null;
	if (aValues.size() != 0) {
		hShowRecords = (HashMap)aValues.get(0);
	}
%>

<form name = "masterForm" action="FrontController" method="post">
<input type ="hidden" name = "action" value="">
<input type ="hidden" name = "handleForm" value = "">


<div id="tabmodule">
<table cellpadding="0" cellspacing="0" width="100%" border="0">
<% 
	if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(MasterForm.getProcessMode())) {
%>	 
<tr>
<td width="90%">&nbsp;</td>
<td  align="left"  width="5%">
		<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
		<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"></jsp:param>
		<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_INSERT%>"></jsp:param>
		</jsp:include>
</td>
</tr>
<% 
	} else if (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(MasterForm.getProcessMode())) { 
%>
<tr>
<td width="90%">&nbsp;</td>
<td  align="left"  width="5%">
		<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
		<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"></jsp:param>
		<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_UPDATE%>"></jsp:param>
		</jsp:include>
</td>
</tr>
<% 
	} 
%>
</table>

<div id="tabmoduleline">	
	<table width="100%">  
          <tr>
             <td class="subformline" valign="bottom" nowrap>
             	<div class="moduleIcon"></div><%=MasterForm.getModuleM().getModuleName()%>
              </td>
           </tr>
	</table>
</div>


<table align = "center"  width="100%"  cellpadding="0" cellspacing="0"  border="0">
<tr>
<td align = "left">
<%
	if (MasterForm.hasErrors()) {
		Vector v = MasterForm.getFormErrors();
		for (int i = 0; i < v.size(); i++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(i) + "</span><br>");
		}
	} 
%>
&nbsp;
</td>
</tr>
</table>
</div>
<div id="contentTableHeader">
<table align="center" width="90%" cellpadding="0" cellspacing="0" border="0">

<% 
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
		
		String tagShow = MasterUtil.displayManualTag(request, entityID, prmModuleFieldM.getFieldID(), MasterForm);
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
			<td></td>
			<td></td>
			<td class="title" valign="top" align="left" <%=lastRowColSpan %>>
				<div style=" margin-bottom:3px;">
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
</form>
<%

		String strJavaScript = MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
%>	
<%=strJavaScript%>
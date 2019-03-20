<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>

<%
	System.out.println("--- Responsive2016 masterTemplate.jsp ---");
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

<form name = "masterForm" action="FrontController" method="post">
<input type ="hidden" name = "action" value="">
<input type ="hidden" name = "handleForm" value = "">

	<table width="100%" cellpadding="0" cellspacing="0" >
		<tr>
			<td class="moduleHeader" valign="bottom" nowrap>
				<div class="moduleIcon"></div><font class="bubold2"><%=MasterUtil.displayModuleName(MasterForm.getModuleM(), request)%></font>
			</td>
		</tr>
	</table>
<div id = "<%=module%>Error">
<%if (MasterForm.hasErrors()) { %>
	<table align = "center"  width="100%"  cellpadding="0" cellspacing="0" >
		<tr>
			<td align = "left">
<%
		Vector v = MasterForm.getFormErrors();		
		for (int i = 0; i < v.size(); i++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(i) + "</span><br>");
		}
%>
			</td>
		</tr>
	</table>
<%} %>
</div>
<br>
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
			System.out.println("previousElementGroup : " + previousElementGroup);
			System.out.println("field group : " + prmModuleFieldM.getFieldGroup());
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
%>
				<td class="td_OneRelation">
					&nbsp;
				</td>
				<td class="td_OneRelation">
					<div class="componentSpacerDiv">&nbsp;</div>
				</td>
				<td class="td_OneRelation">
					<div class="componentNameDiv" id="<%=labelNamed %>" >
						<span class="nowrap"><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%><%=MasterUtil.displayManDate(prmModuleFieldM)%></span>
					</div>
				</td>
				<td class="td_OneRelation" <%=lastRowColSpan %> >
					<div class="componentDiv" id="<%=htmlComponentNamed %>" >
						<%=tagShow%>
					</div>
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
	<table cellpadding="0" cellspacing="0" width="100%">
<% 
	if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(MasterForm.getProcessMode())) {
%>	 
		<tr>
			<td width="90%">&nbsp;</td>
			<td  align="left"  width="5%">
				<jsp:include flush="true" page="/buttonManager/buttonManagerRes2016.jsp">
				<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
				<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_INSERT%>"/>
				</jsp:include>
			</td>
		</tr>
<% 
	} else if (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(MasterForm.getProcessMode())) { 
%>
		<tr>
		<td width="90%">&nbsp;</td>
			<td align="left"  width="5%">
				<jsp:include flush="true" page="/buttonManager/buttonManagerRes2016.jsp">
				<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
				<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_UPDATE%>"/>
				</jsp:include>
			</td>
		</tr>
<% 
	} 
%>
	</table>
</form>
<%
	String strJavaScript = com.avalant.display.FT003_ProSilverObjUtil.generateJavaScript(vAllDependencys,request,false,false,false);
%>	
<%=strJavaScript%>
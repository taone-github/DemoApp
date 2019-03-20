<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
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
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	EntityFormHandler entityForm = (EntityFormHandler)request.getSession().getAttribute(entityID+"_session");	
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


<table align="center" width="90%" cellpadding="0" cellspacing="0" border="0">
<tr>

<td valign="bottom"  align ="right"><img src="./theme/005/images/line_top_left.gif" width="24" height="25"></td>
<td width="5%">
<div id ="processPicID" name ="processPicName">
<%
String mode = "";
String pic = "";
if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(MasterForm.getProcessMode())) { 
	mode = "&nbsp;Add Page";
	pic = "table_add.gif";	
} else if (entityForm.getEntityM().isViewModeFlag() && MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(entityForm.getCurrentMode())) {
	
	mode = "&nbsp;View Page";
	pic = "table_view.gif";
} else if (MasterForm.getModuleM().isViewModeFlag() && MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(MasterForm.getProcessMode())) {
	
	mode = "&nbsp;View Page";
	pic = "table_view.gif";	
} else {
	mode = "&nbsp;Edit Page";
	pic = "table_edit.gif";
}
%>
<img src="./theme/005/images/<%=pic%>" width="24" height="25">
</div>
</td>
<td class="blueheader" width="15%" ><span id ="processLabelID" name ="processLabelName"><%=mode%></span></td>
<td  valign="bottom"  ><img src="./theme/005/images/line_top.gif" width="100%" height="25"></td>
<td  valign="bottom" colspan="5" ><img src="./theme/005/images/line_top.gif" width="100%" height="25"></td>
<td valign = "bottom"><img src="./theme/005/images/line_top_right.gif" width="24" height="25"></td>
</tr>


<tr>
<td background="./theme/005/images/line_left.gif" width="25"  ></td>
<td valign="top" colspan="8">

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
	<br>
<%} %>
</div>






<table border="0" cellpadding="0" cellspacing="0" width="100%" >

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
%>
				<td valign="top" align="right" class="text"><NOBR>&nbsp; <span id ="<%=prmModuleFieldM.getFieldID()%>Div"><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%><%=MasterUtil.displayManDate(prmModuleFieldM)%></span>&nbsp;</NOBR></td>
				<td width="5px" class="text">&nbsp;</td>
				<td valign="top" align="left" class="text">&nbsp;
				<span id=<%=prmModuleFieldM.getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_InputField>
					<%=tagShow%>
				</span>
				
				&nbsp;</td>
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
<br>

</td>
<td background="./theme/005/images/line_right.gif" width="25" ></td>
</tr>


<tr>
 <td valign="top" align="right">
<img src="./theme/005/images/line_bot_left.gif" width="24" height="25">
 </td>
 <td   valign="top" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
 <td  valign="top" width="35%"  colspan ="2">
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
 <td  valign="top" width="2%">
<img src="./theme/005/images/line_bot_v.gif" width="24" height="25">
</td>
 <td  valign="top" align="center" width="6%">
	<table cellpadding="0" cellspacing="0" width="100%">
<% 
	if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(MasterForm.getProcessMode())) {
%>	 
		<tr>
			<td width="90%">&nbsp;</td>
			<td  align="left"  width="5%">
				<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
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
				<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
				<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
				<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_UPDATE%>"/>
				</jsp:include>
			</td>
		</tr>
<% 
	} 
%>
	</table>
			
</td>
 <td  valign="top" width="2%">
<img src="./theme/005/images/line_bot_v.gif" width="24" height="25">
</td>

<td  valign="top" colspan ="2"  >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
<td valign="top">
<img src="./theme/005/images/line_bot_right.gif" width="24" height="25">
</td>
 </tr>







</table>









</form>
<%
	String strJavaScript = MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
%>	
<%=strJavaScript%>

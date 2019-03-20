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
<input type ="hidden" name = "action" value="searchEntity">
<input type ="hidden" name = "handleForm" value = "Y">

<div id="topAreaSearchEntity"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr><td>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			  <tr><td colspan="7"><img src="images/c.gif" alt="" width="730" height="5"></td></tr>
			  <tr>
			  	<td >&nbsp;</TD>
				<td class="headerTitle" valign="middle"><%=form.getEntityM().getEntityName()%></TD>
				<td colspan="5" align="right">
				<div id ="buttonAllModeID" name ="buttonAllModeName">
				<TABLE border="0">
				<TR>
					<TD><div id ="addButtonID" name ="addButtonName"><img src="./theme/005/images/b_add2_d.gif" border="0" alt="Add"></div></TD>
					<TD><div id ="editButtonID" name ="editButtonName"><img src="./theme/005/images/b_edit2_d.gif" alt="Edit"></div></TD>
					<TD><div id ="deleteButtonID" name ="deleteButtonName"><img src="./theme/005/images/b_delete2_d.gif" alt="Delete"></div></TD>
					<TD><img src="./theme/005/images/c.gif" width="10" height="1"></TD>
					<TD><div id ="searchButtonID" name ="searchButtonName"><img src="./theme/005/images/b_search2.gif" border="0" alt="Search"></div></TD>
					<TD><div id ="exitButtonID" name ="exitButtonName"><img src="./theme/005/images/b_exit2.gif" alt="Exit" border="0" ></div></TD>
					<TD>&nbsp;</TD>
				</TR>
				</TABLE>
				</div>
				</td>
			  </tr>
			  <tr>
				<td width="10"><img src="./theme/005/images/c.gif" width="10" height="1"></td>
				<td width="500"><img src="./theme/005/images/c.gif" width="500" height="1"></td>
				<td width="55"><img src="./theme/005/images/c.gif" width="55" height="1"></td>
				<td width="425"><img src="./theme/005/images/c.gif" width="100%" height="1"></td>
				<td width="32"><img src="./theme/005/images/c.gif" width="32" height="1"></td>
				<td width="70"><img src="./theme/005/images/c.gif" width="70" height="1"></td>
				<td width="38" ><img src="./theme/005/images/c.gif" width="38" height="1"></td>
			  </tr>
			</table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="bottom"  align ="right"><img src="./theme/005/images/line_top_left.gif" width="24" height="25"></td>
<td width="5%">
<div id ="processPicID" name ="processPicName">
<img src="./theme/005/images/table_search.gif" width="24" height="25">
</div>
</td>
<td class="blueheader" width="20%" ><span id ="processLabelID" name ="processLabelName">Search&nbsp;Criteria</span></td>
<td  valign="bottom" colspan="5" ><img src="./theme/005/images/line_top.gif" width="100%" height="25"></td>
<td valign = "bottom"><img src="./theme/005/images/line_top_right.gif" width="24" height="25"></td>
</tr>
<tr>
<td background="./theme/005/images/line_left.gif" ></td>
<td colspan="7">
<br>
<table align="center"  width="100%"  cellpadding="0" cellspacing="0" border="0">
<tr>
<td>
<div id="<%=entityID %>Error" ></div>
<div id="<%=entityID %>_searchCriteria" class="searchCriteriaContainer">
<% 
	int col = 0;
	try{
		ModuleFieldM mf = (ModuleFieldM)MasterForm.getVMasterModelMs().get(0);
		col = mf.getColumnCount();
	}catch(Exception e){
		col = 0;
	}
	String tableWidth = "100%";
	if(col == 1){
		tableWidth = "30%";
	}else if(col == 2){
		tableWidth = "50%";
	}
	else if(col == 3){
		tableWidth = "70%";
	}
%>
<table width="<%=tableWidth%>" border="0" cellpadding="0" cellspacing="0" align="center">
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
 </td>
 </tr>
 </table>
 </td>
<td background="./theme/005/images/line_right.gif"></td>
 </tr>
 <tr>
 <td valign="top" align="right">
<img src="./theme/005/images/line_bot_left.gif" width="24" height="25">
 </td>
 <td colspan="2" valign="top" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
 <td  valign="top" width="25%" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
 <td  valign="top" width="2%">
<img src="./theme/005/images/line_bot_v.gif" width="24" height="25">
</td>
 <td  valign="top" align="center" width="6%">
			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_SEARCH"/>
			</jsp:include>
</td>
<td  valign="top" width="2%">
<img src="./theme/005/images/line_bot_v.gif" width="24" height="25">
</td>

<td  valign="top" width ="40%" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
<td valign="top">
<img src="./theme/005/images/line_bot_right.gif" width="24" height="25">
</td>
 </tr>
 </table>
 
<style>
<%=MasterUtil.generateCustomStyle(null, form, MasterForm, MasterForm.getProcessMode()) %>
</style>
 
 <table width="100%" border="0" cellpadding="1" cellspacing="0" align="center">
	<tr>
		<td align="left">
		<br>
		</td>
	</tr>
	<tr>
		<td> 
			<div id="<%=entityID %>_resultSearchContainer" class="resultSearchContainer">
<%
com.master.model.EntityM entityM =  form.getEntityM();	
ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
if(entityM.isRequireWFFlag() && entityM.isWfWQ()){ 
%>
	<jsp:include flush="true" page="/manual/bpm/jsp/005/bpmSearchResult.jsp"/>
<%} else if (moduleActionM != null && null != moduleActionM.getSearchFilePath() && !"".equals(moduleActionM.getSearchFilePath())) {
	String searchFilePath = moduleActionM.getSearchFilePath();
	System.out.println("searchFilePath -> " + searchFilePath);
	String manualUrlPath = searchFilePath.substring(searchFilePath.indexOf("/", 1));
	pageContext.setAttribute("manualUrlPath", manualUrlPath);
	%><jsp:include flush="true" page="<%=manualUrlPath%>"/><%
} else {
	String result = com.avalant.display.OverrideJSP.getInstance().getFilePath("005","RESULT_SEARCH");
%>	
	<jsp:include flush="true" page="<%=result%>"/>
<%}%>  
			</div>
		</td>
	</tr>
</table>
</td></tr></table>
</form>
<form name="extendForm" id="extendForm" action="">
</form>
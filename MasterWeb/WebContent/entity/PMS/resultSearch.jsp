<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@ page import="com.master.model.ModuleActionM" %>
<%@page import="com.master.model.EntityM"%>
<%@page import="com.master.util.CheckBoxUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
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

	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
%>
<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">
<input type ="hidden" name = "clearCheckboxSession" value = "N"> 
<div class="tablearea" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr><!-- Header -->
<%  EntityM entityM  = form.getEntityM(); 	
	if (entityM.isShowCheckBox() || entityM.isShowRadio() ) {
%>
	<td class="headtable2">&nbsp;</td>
<% 
	}
%>
	<td class="headtable2"><div class="fontheadtable1"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></div></td>
<%for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i); %>

    <td class="headtable1 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header">
    	<div class="orderColumnDiv" id = "orderColumnDivID" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
    			<div class="fontheadtable1"><%=MasterUtil.displayFieldName(moduleM,request)%></div>
    			</td>
    			<td class="orderDivArea">
<% 
				if (MasterForm.getAllSearchResultData() > 0) {
%>											
										<div  id ="orderASCDivID_<%=i %>" class="orderASCDiv" onclick="sortTableAjax('orderASCDivID','<%=i %>','<%=moduleM.getFieldID() %>', 'ASC', '<%=entityID %>_resultSearchContainer');"></div>
										<div  id ="orderDESCDivID_<%=i %>" class="orderDESCDiv" onclick="sortTableAjax('orderDESCDivID','<%=i %>','<%=moduleM.getFieldID() %>', 'DESC', '<%=entityID %>_resultSearchContainer');"></div>
<% 
				}
%>												
				</td>
			</tr>
		</table>
		</div>
    </td>
<%}%>
</tr><!-- End Header -->

<% 
//Case No Data
int allColumn = 0;
if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
	allColumn++;	
}
allColumn = allColumn + vShowColumns.size()+1;
%>					
<%if(vShowSearchRecs.size() == 0){%>
<tr class="ROW" onmouseover="this.className='ROW_HOVER'" onmouseout="this.className='ROW'">
	<td align="center" colspan="<%=allColumn%>">
<% 						
	if (form.isClickSearch()) {
%>
		<span class="fontdatatable1"><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_NO_DATA_FOUND") %></span>
<% 
	} else {
%>
		<span class="fontdatatable1"><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH") %></span>
<% 
	}
%>
	</td>
</tr>
<%} %>

<%
	//Case have result
	for (int i=0;i < vShowSearchRecs.size();i++) {
	HashMap hReturnData = (HashMap)vShowSearchRecs.get(i);
	com.master.util.Log4jUtil.log("hReturnData==>"+hReturnData);	
	HashMap hKeyRecords = (HashMap)hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH); 
	com.master.util.Log4jUtil.log("hKeyRecords==>"+hKeyRecords);	
	Vector vKeys = new Vector(hKeyRecords.keySet()); 
	String keyForSearch = ""; 
	for (int j = 0;j < vKeys.size();j++) {
		String fieldID = (String)vKeys.get(j);
		String valueKey = (String)hKeyRecords.get(fieldID);
		keyForSearch = keyForSearch + fieldID + "="+ valueKey;
		if (j < (vKeys.size()-1)) {
			keyForSearch = keyForSearch + "&";
		} 
	}
	if (MasterForm.isSearchForUpdate()) {
%>
			<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='ROW'" : "this.className='ROW_ALT'"%>">
<%
	} else {
%>
			<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>">
<% 
	}
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		String objType = "checkbox";
		if (entityM.isShowRadio()) objType="radio";
		//Sam fix checkbox add script
		//26/12/2011
		String checked ="";
		if(CheckBoxUtil.isChecked(form.getMainModuleID(),keyForSearch,request)){
			checked = "checked";
		}
%>     
		    <td  width ="4%"  align="center" height="19" class="datatable2"><input type = "<%=objType%>" name = "deleteRow" value ="<%=keyForSearch%>" onclick="changeCheckBox(this)" <%=checked%>></td>
<% 
	}
%>
			<td width ="4%" align ="center"  height="19" class="datatable2" ><div class="fontdatatable1"><%=(i+1)%></div></td>
<% 
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	}	
	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData,MasterForm.getHAllobjects());
		String tagStr = "";
		if (strSearchResult == null || strSearchResult.trim().equalsIgnoreCase("")) {
			strSearchResult = "&nbsp;";
		}
		if (MasterForm.isSearchForUpdate()) {			
			//tagStr = "<a href=\"#\""+onclickEvent+">"+strSearchResult+"</a>";
			tagStr = "<span style=\"cursor: hand\" "+onclickEvent+">"+strSearchResult+"</span>";
		}else {
			tagStr = "<span>"+strSearchResult+"</span>";
		}
		//Sam add for alignment
		String align = "center";
		if ((moduleM.getAlignment() != null && !"".equals(moduleM.getAlignment()))) { 
			align = moduleM.getAlignment();
		}
%>		
		<td align="<%=align%>"  class="datatable2 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col">
			<div id="<%=moduleM.getFieldID()%>_<%=i%>" class="fontdatatable1"><%=tagStr%></div>
		</td>					 
<%			
	}	
%>
	</tr>
<%	
}
%>
</table>
</div>
<jsp:include flush="true" page="search/pagging.jsp"/>
<%
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
	if (moduleActionM != null){
		if (null != moduleActionM.getFilePath() && !"".equals(moduleActionM.getFilePath())) {
			String filePath = moduleActionM.getFilePath();
			com.master.util.Log4jUtil.log("filePath -> " + filePath);
			
			String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
			String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
			com.master.util.Log4jUtil.log("manualContextPath -> " + manualContextPath);
			com.master.util.Log4jUtil.log("manualUrlPath -> " + manualUrlPath);
			
			pageContext.setAttribute("manualContextPath", manualContextPath);
			pageContext.setAttribute("manualUrlPath", manualUrlPath);
%>
			<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>
<% 					
		}
	}
%>

<%
	/* javascript for dependency component */
	String strJavaScript = "";
	Vector vResult = MasterForm.getVMasterModelMs();	 
	Vector vAllDependencys = new Vector();
	for (int s=0;s < vResult.size();s++) {
		ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(s);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}
	}		
	
	strJavaScript += com.avalant.display.FT003_ProSilverObjUtil.generateJavaScript(vAllDependencys,request,false,false,false);
%>

<%=strJavaScript%>

<%
if (null != moduleActionM.getScriptFile() && !"".equals(moduleActionM.getScriptFile())) {
%>

	<SCRIPT language="JavaScript" src="<%=moduleActionM.getScriptFile()%>"></SCRIPT>

<%
}
%>
<style>
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, MasterForm.getProcessMode()) %>
</style>
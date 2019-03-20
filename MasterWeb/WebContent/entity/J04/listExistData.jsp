<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@page import="com.master.model.EntityM"%>
<%@page import="com.master.model.DuplicationFuncM"%>
<%@page import="com.master.model.ModuleActionM"%>
<%@page import="java.util.ArrayList"%>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
	
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
%>



<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">

<%
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();	
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
%>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center" class="manyRowDiv" style="width: 100%; height: 233px;">
				<table width="100%" cellpadding="1" cellspacing="0" align="center">
					<thead>
					<tr  height="19">
<%      
	int totalWidth = 0;
    EntityM entityM  = form.getEntityM(); 	
	if (entityM.isShowCheckBox()) {
		totalWidth = 92/vShowColumns.size();
%>     
						<th width = "4%" align="center" height="19" class="TableHeaderList">&nbsp;</th>
<% 
	} else {
		totalWidth = 96/vShowColumns.size();
	}
%>
						<th width = "4%"  align="center" height="19" class="TableHeaderList"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></th>
<%

	for (int i= 0;i < vShowColumns.size();i++) {
		DuplicationFuncM  prmDuplicationFuncM = (DuplicationFuncM)vShowColumns.get(i);	
%>      
						<th width ="<%=totalWidth%>%" align="center" class="TableHeaderList"><%=MasterUtil.displayFieldName(prmDuplicationFuncM,request)%> </th>
<% 
	} 
%>
					</tr>
					</thead>
					<tbody>
<%if(vShowSearchRecs.size() == 0){%>
						<tr class="ROW" onmouseover="this.className='ROW_HOVER'" onmouseout="this.className='ROW'">
							<td align="center" colspan="<%=(vShowColumns.size()+3)%>" >
								<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH") %></span>
							</td>
						</tr>
<%} %>

<% 
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
						<tr>
<% 
} 
	if (entityM.isShowCheckBox()) {
%>     
							<td  width ="4%"  align="center" height="19" class="bu2"><input type = "checkbox" name = "checkRow" value ="<%=i%>"></td>
<% 
	}
%>
							<td width ="4%" align ="center"  height="19" class="bu2" ><%=(i+1)%></td>
<% 
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"forCloneData('"+keyForSearch+"')\"";
	}	
	for (int j= 0;j < vShowColumns.size();j++) {
		DuplicationFuncM  prmDuplicationFuncM = (DuplicationFuncM)vShowColumns.get(j);	
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(prmDuplicationFuncM,hReturnData,MasterForm.getHAllobjects());
		if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
%>
							<td  <%=onclickEvent%> width ="<%=totalWidth%>%" align="center" class="bu2"><%=strSearchResult%></td>
<%	
		} else {
%>
							<td  <%=onclickEvent%> width ="<%=totalWidth%>%" align="center" class="bu2">&nbsp;</td>
<%	
		}
	}
 
%>
						</tr>
<%	
}
%>
					</tbody>
				</table>
			</div>
		</td>
	</tr>
	<tr>
<%   
 	if (entityM.isShowCheckBox()) { 
%>
		<td>&nbsp;</td>
<% 
 	}
%>
		<td colspan="4" align="right">
<% 
	if (vShowSearchRecs.size() > 0) {
	if (MasterForm.getPage() != 1) {
%>    
			<input type="button" name ="previous" value="<" onclick ="changePageAndSize('<%=(MasterForm.getPage()-1)%>')">
<% 
	} else {
%>    
			<input type="button" name ="previous" value="<"  disabled="disabled">
<% 
	}
%>    
        
			<select name="selectPerPage"  onchange="changePageAndSize('1')"> 
<% 	
	Vector v = new Vector(LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().keySet());
	for(int i =0;i< v.size();i++) {
		if (MasterForm.getVolumePerPage() == Integer.parseInt((String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1)))) {
%>     
     			<option value ="<%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" selected ><%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<% 
		} else {
%>
	    		<option value ="<%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" ><%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<%	
		}
	}
%>     
     
			</select> 
<% 
	int allPage =  MasterForm.getAllSearchResultData() / MasterForm.getVolumePerPage();
	if (allPage*MasterForm.getVolumePerPage()  < MasterForm.getAllSearchResultData()) {
		allPage++;
	}
	if (allPage != MasterForm.getPage())	{	
%>    
		<input type="button" name ="next" value=">" onclick ="changePageAndSize('<%=(MasterForm.getPage()+1)%>')"> 
<% 
	} else {
%>
    	<input type="button" name ="next" value=">"  disabled="disabled"> 
<% 
	}
%>

		<%=MasterForm.getPage() %>/<%=allPage%>
<%	
	}	
%>        
		</td>
	</tr>
</TABLE>


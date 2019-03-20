<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager"%>
<%@page import="java.util.Vector"%>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%>
<%@page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil"%>
<%@page import="com.oneweb.j2ee.system.LoadXML"%>
<%@page import="com.master.model.HistoryDataM"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.master.util.MasterUtil"%>

<% 	
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entityIDSession = entityID+"_session";	
								
	EntityFormHandler entityForm = (EntityFormHandler)request.getSession().getAttribute(entityIDSession);
	if (entityForm == null) {
		entityForm = new EntityFormHandler();
		request.getSession().setAttribute(entityIDSession,entityForm);
	}
	
	String moduleSession = entityForm.getMainModuleID() +"_session";
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

<%
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
%>


<%@page import="com.master.util.MasterConstant"%>
<form name ="masterForm" action="FrontController" >
<input type ="hidden" name = "action" value="">
<input type ="hidden" name = "handleForm" value = "N">
<input type ="hidden" name = "entityIDForList" value = "<%=entityID%>">
<input type ="hidden" name = "moduleIDForAction" value = "<%=entityForm.getMainModuleID()%>">
<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">

<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center"> 
	<tr>
		<td valign="top"><br></td>
	</tr>
	<tr>
		<td valign="top">
			<table width="100%" cellpadding="1" cellspacing="0" align="center">
				<thead>
				<tr  height="19">     
					<th width = "20%"  align="center" height="19" class="TableHeaderList">Update Date</th>  
					<th width = "10%"  align="center" height="19" class="TableHeaderList">Group</th> 
					<th width = "10%"  align="center" height="19" class="TableHeaderList">Field</th> 
					<th width = "25%"  align="center" height="19" class="TableHeaderList">Old Value</th> 
					<th width = ""  align="center" height="19" class="TableHeaderList">New Value</th> 
					<th width = "10%"  align="center" height="19" class="TableHeaderList">Update By</th> 
				</tr>
				</thead>
				<tbody>
				<%if(vShowSearchRecs.size()==0){ %>
				<tr>
					<td align="center" colspan="6" >
						<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_NO_DATA_FOUND") %></span>
					</td>
				</tr>
				<%} %>
				<%
				  HistoryDataM historyDataM = null;
				  for (int i=0;i < vShowSearchRecs.size();i++) { 
					  historyDataM = (HistoryDataM)vShowSearchRecs.get(i) ;
				%>
				<tr class="ROW"  onmouseover="this.className='ROW_HOVER'" onmouseout="this.className='ROW'">
<% 
		String createDate = DisplayFormatUtil.DateToString(historyDataM.getCreateDate(), "dd/MM/yyyy HH:mm");
		StringTokenizer token = new  StringTokenizer(createDate," ");
		
		String updateDate = token.nextToken();
		if (entityForm.getEntityM().isHisBuddhistFlag()) {
			updateDate = MasterUtil.getInstance().checkConvertBCDate(updateDate,true);
		}
		updateDate = updateDate+" "+token.nextToken();
%>					
					<td align="center" class="bu2"><%=updateDate%></td>
					<td align="center" class="bu2"><%=DisplayFormatUtil.displayHTML(historyDataM.getModuleName())%></td>
					<td align="center" class="bu2"><%=DisplayFormatUtil.displayHTML(historyDataM.getFieldName())%></td>
					<td align="center" class="bu2"><%=DisplayFormatUtil.displayHTML(historyDataM.getOldValue())%></td>
					<td align="center" class="bu2"><%=DisplayFormatUtil.displayHTML(historyDataM.getNewValue())%></td>
					<td align="center" class="bu2"><%=DisplayFormatUtil.displayHTML(historyDataM.getCreateBy())%></td>
				</tr>
				<%}%>
				</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top"><br></td>
	</tr>
	<tr>
		<td align="right">
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
	if (allPage != MasterForm.getPage()){	
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
	<tr>
		<td valign="top"><br></td>
	</tr>
	<tr>
		<td align="center">
			<input type ="button" name ="close" value ="Close" class="button_style"  onclick = "closeWindow()">
		</td>
	</tr> 
</table>
</form>
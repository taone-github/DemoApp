<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@page import="com.master.model.EntityM"%>
<%@page import="com.master.model.ModuleActionM"%>

<% 
	String moduleIDForAction = (String)request.getSession().getAttribute("moduleIDForAction");
	MasterFormHandler mainForm = (MasterFormHandler)request.getSession().getAttribute(moduleIDForAction+"_session");
	String entityID = (String)request.getSession().getAttribute("entityIDForList");
	String entitySession = entityID +"_session";
	System.out.println("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}		
	String moduleSession = form.getMainModuleID() +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	System.out.println("MasterForm==>"+MasterForm);
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


<input type ="hidden" name = "entityIDForList" value = "<%=entityID%>">
<input type ="hidden" name = "moduleIDForAction" value = "<%=moduleIDForAction%>">
<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">

<%
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	System.out.println("vShowColumns==>"+vShowColumns);
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();

	HashMap keyofRec = new HashMap();
	StringBuffer stringBlock = new StringBuffer();
	if(vShowSearchRecs != null && vShowSearchRecs.size() > 0){
		for (int i=0;i < 1;i++) {	
			HashMap hReturnData = (HashMap)vShowSearchRecs.get(i);
			System.out.println("hReturnData==>"+hReturnData);	
			HashMap hKeyRecords = (HashMap)hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH); 
			System.out.println("hKeyRecords==>"+hKeyRecords);	
			Vector vKeys = new Vector(hKeyRecords.keySet()); 
			String keyForSearch = ""; 
			for (int j = 0;j < vKeys.size();j++) {
				String fieldID = (String)vKeys.get(j);
				keyofRec.put(fieldID,fieldID); 
			}
		}
	}
	
	Vector storeActionLists  = mainForm.getStoreActionList();
	if(storeActionLists != null && storeActionLists.size() > 0){
		for (int i= 0;i < storeActionLists.size();i++) {
			HashMap hStoreActions = (HashMap)storeActionLists.get(i);
			Vector vKeysAction = new Vector(hStoreActions.keySet());
			stringBlock.append("|");
			for (int j=0; j < vKeysAction.size();j++) {
				String key = (String)vKeysAction.get(j);
				HashMap hTables = (HashMap)hStoreActions.get(key);									  		
		  		HashMap hReturnData = (HashMap)hTables.get(mainForm.getModuleM().getTableName());
		  		ArrayList tempLoopKey = new ArrayList(keyofRec.keySet());
		  		for (int b =0; b < tempLoopKey.size();b++) {
		  			String tempKey = (String)tempLoopKey.get(b);	  			
		  			stringBlock.append(tempKey+"="+(String)hReturnData.get(tempKey));
		  			if (b < (tempLoopKey.size()-1)) {
		  				stringBlock.append("&");
		  			}
		  		}
			}
		}
	}
	
	
	//Sam add general tab
	String listOnTab = (String)request.getSession().getAttribute(MasterConstant.EAF_SESSION.LIST_MANY_TAB);
	String addRecordStr = "addRecord";
	if(null!=listOnTab){
	 	addRecordStr = "addRecordOnTab";
	}
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center" class="manyRowDiv" style="width: 100%; height: 233px;">
				<table width="100%" cellpadding="1" cellspacing="0" align="center">
					<thead>
					<tr  height="19">     
						<th width = "4%"  align="center" height="19" class="TableHeaderList">
<%
	if (form.getEntityM().isCopyAllList()) {
%>						
						<input type="button" name="selectAll" value="+" class="button_style_1" onclick="<%=addRecordStr%>('All','<%= form.getMainModuleID()%>','<%=MasterForm.getVShowSearchRecord().size()%>')" >
<% 
	}
%>						
						</th>       
<%
	int totalWidth = 96/vShowColumns.size();
	System.out.println("totalWidth==>"+totalWidth);

	for (int i= 0;i < vShowColumns.size();i++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);
		System.out.println("moduleM==>"+moduleM);	
%>      
						<th align="center" class="TableHeaderList <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header"><%=MasterUtil.displayFieldName(moduleM,request)%> </th>
<%
	}
%>
					</tr>
					</thead>
					<tbody>
<%if(vShowSearchRecs.size()==0){ %>
					<tr colspan="<%=vShowSearchRecs.size()+1%>">
						<td align="center" colspan="<%=(vShowColumns.size()+1)%>" >
							<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_NO_DATA_FOUND") %></span>
						</td>
					</tr>
<%} %>
<% 
System.out.println("vShowSearchRecs -> " + vShowSearchRecs.size());
for (int i=0;i < vShowSearchRecs.size();i++) {
	HashMap hReturnData = (HashMap)vShowSearchRecs.get(i);
	System.out.println("hReturnData==>"+hReturnData);	
	HashMap hKeyRecords = (HashMap)hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH); 
	System.out.println("hKeyRecords==>"+hKeyRecords);	
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
					<tr class="ROW"  onmouseover="this.className='ROW_HOVER'" onmouseout="this.className='ROW'">
<%
	} else {
%>
					<tr>
<% 
} 
%>
						<td width ="4%" align ="center"  height="19" class="bu2" >
<% 
	System.out.println(" LIST MANY stringBlock :"+stringBlock);
	System.out.println(" LIST MANY keyForSearch :"+keyForSearch);
	if (!MasterUtil.checkBlockbuttonList(stringBlock,keyForSearch)) {
%>	
							<span id = "select_<%=i%>">
								<input type="button" name="select" value="+" class="button_style_1" onclick="<%=addRecordStr%>('<%=i%>','<%= form.getMainModuleID()%>','<%=MasterForm.getVShowSearchRecord().size()%>')" >
							</span>
						</td>
<% 
	}
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	}

	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData,MasterForm.getHAllobjects());
		if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
%>
						<td  <%=onclickEvent%> align="center" class="bu2 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col"><%=strSearchResult%></td>
<%	
		} else {
%>
						<td  <%=onclickEvent%> align="center" class="bu2 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col">&nbsp;</td>
<%	
		}
	}
%>	
					</tr>
<%	
}	/*-- end for --*/
%>
					</tbody>
				</table>
				&nbsp;
			</div>
		</td>
	</tr>
	<tr>
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
		<td colspan="4" align="center">
			<%//Sam add general tab
			if(null!=listOnTab){
			%>
			<input type ="button" name ="close" value ="Cancel" class="button_style_1"  onclick = "cancelEntity()">
			<%}else{ %>
			<input type ="button" name ="close" value ="Close" class="button_style_1"  onclick = "closeWindow()">
			<%} %>
		</td>
	</tr> 
</table>
<SCRIPT language="JavaScript">
</script>
<% 
	EntityM entityM = form.getEntityM();
	ArrayList entityActions = entityM.getEntityActions();
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityActions,MasterConstant.MULTI_SELECTION);
	if (moduleActionM.getScriptFile()!= null && !"".equals(moduleActionM.getScriptFile())) {
%>	
		<SCRIPT language="JavaScript" src="<%=moduleActionM.getScriptFile()%>"></SCRIPT>	
<% 		
	}
%>

<style>
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, MasterForm.getProcessMode()) %>
</style>

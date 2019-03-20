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

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	System.out.println("entitySession==>"+entitySession);
	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	EntityM entityM  = form.getEntityM(); 
	
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

	<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
	<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
	<input type ="hidden" name = "loadUpdateValue" value = "">
	<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
	<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">
	<input type ="hidden" name = "clearCheckboxSession" value = "N"> 
<%
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	System.out.println("vShowColumns==>"+vShowColumns);
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
%>	
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center"  id ="manyRowDivID" class="manyRowDiv">
				<table width="100%" cellpadding="1" cellspacing="0" align="center">
					<thead>
						<tr height="19">     
<%      
	int totalWidth = 0;
    
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		totalWidth = 92/vShowColumns.size();
%>     
							<th width = "4%" align="center" height="19" class="TableHeaderList">&nbsp;</td>
<% 
	} else {
		totalWidth = 96/vShowColumns.size();
	}
%>
							<th width = "4%"  align="center" height="19" class="TableHeaderList"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></td>       
<%


for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i);
%>      
							<th class="TableHeaderList <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header">
								<div class="orderColumnDiv" id = "orderColumnDivID" >
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<div class="TableHeaderList"><%=MasterUtil.displayFieldName(moduleM,request)%></div>
											</td>
											<td class="orderDivArea">
<% 
						if (MasterForm.getAllSearchResultData() > 0) {
							//Case Sorting by Date
							String searchByField = moduleM.getFieldID();
							if ( moduleM.getFieldID().toUpperCase().indexOf("DATE__DESC") != -1){
							  searchByField = 	searchByField.substring( 0 , searchByField.length() - 6); //TRIM __DESC
							}
							

%>											
												<div  id ="orderASCDivID_<%=i %>" class="orderASCDiv" onclick="sortTableAjax('orderASCDivID','<%=i %>','<%=searchByField%>', 'ASC', '<%=entityID %>_resultSearchContainer');"></div>
												<div  id ="orderDESCDivID_<%=i %>" class="orderDESCDiv" onclick="sortTableAjax('orderDESCDivID','<%=i %>','<%=searchByField%>', 'DESC', '<%=entityID %>_resultSearchContainer');"></div>
<% 
						}
%>
											</td>
										</tr>
									</table>
								</div>
							</th>
<% 
 }
%>
						</tr>
					</thead>
				
					<tbody>
<% 
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
								<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_NO_DATA_FOUND") %></span>
<% 
							} else {
%>
								<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH") %></span>
<% 
							}
%>
							</td>
						</tr>
<%} %>

<% 
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
		<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='ROW'" : "this.className='ROW_ALT'"%>">
<%
	} else {
%>
		<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>">
<% 
	}
	
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		String objType = "checkbox";
		if (entityM.isShowRadio()) objType = "radio";
%>     
							<td  width ="4%"  align="center" height="19" class="bu2"><input type = "<%=objType%>" name = "checkRow" value ="<%=keyForSearch%>"></td>
<% 
	}
%>
							<td width ="4%" align ="center"  height="19" class="bu2" ><%=((MasterForm.getPage() - 1) * MasterForm.getVolumePerPage() + i + 1)%></td>
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
			tagStr = "<a href=\"#\""+onclickEvent+">"+strSearchResult+"</a>";
		}else {
			tagStr = "<span>"+strSearchResult+"</span>";
		}
%>		
		<td align="center" class="bu2 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col"><div id="<%=moduleM.getFieldID()%>_<%=i%>"><%=tagStr%></div></td>					 
<%			
	}	
%>
						</tr>
<%	
}
%>
					</tbody>
				</table>
				<div id ="finalDIVID" class="finalDIV" ></div>
			</div>
		</td>
	</tr>  
	<tr>
<%   
 	if (entityM.isShowCheckBox()|| entityM.isShowRadio()) { 
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
</table>

<%
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
	if (moduleActionM != null){
		if (null != moduleActionM.getFilePath() && !"".equals(moduleActionM.getFilePath())) {
			String filePath = moduleActionM.getFilePath();
			System.out.println("filePath -> " + filePath);
			
			String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
			String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
			System.out.println("manualContextPath -> " + manualContextPath);
			System.out.println("manualUrlPath -> " + manualUrlPath);
			
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
	
	strJavaScript += MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
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

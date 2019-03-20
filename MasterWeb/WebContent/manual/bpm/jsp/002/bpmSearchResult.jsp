<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
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

<%@ page import="com.ava.bpm.model.base.WfProcessAttributeM"%>
<%@ page import="com.ava.bpm.model.base.WfWorkQueueM"%>
<%@ page import="com.ava.bpm.proxy.util.WfUtil"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
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

<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">
<%
//	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
//	System.out.println("vShowColumns==>"+vShowColumns);
//	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();

//temp wf
//	Vector vShowColumns = new Vector();
//	vShowColumns.add("column_1");
//	vShowColumns.add("column_2");
//	vShowColumns.add("column_3");
//	Vector vShowSearchRecs = new Vector();
//	vShowSearchRecs.add("row_1");
//	vShowSearchRecs.add("row_2");
//	vShowSearchRecs.add("row_3");
//	vShowSearchRecs.add("row_4");
// end temp wf

// wf
	EntityM entityM =  form.getEntityM();
	String ptid=entityM.getDefaultPTID();

	Object wqObj = request.getSession().getAttribute("wfWorkQueueList");
	ArrayList wfWorkQueueList=null;
	if(wqObj != null){
		wfWorkQueueList = (ArrayList)wqObj;
	}else{
		wfWorkQueueList = new ArrayList();
	}
	System.out.println("wfSearchResult.wfWorkQueueList..."+(wfWorkQueueList==null?"is null":"size :"+wfWorkQueueList.size()));
	WfUtil wfUtil = new WfUtil();
	String attributeName =null;
	WfProcessAttributeM attributeM = null;
	Vector processAttrToShowVt = wfUtil.getProcessAttrToShow(ptid);
	Vector keyNameVt = wfUtil.getKeyName(ptid);

	Vector processAttrVt = wfUtil.getProcessAttributeByPtid(ptid);
	for(int i=0;i<processAttrVt.size();i++){
		attributeM = (WfProcessAttributeM)processAttrVt.get(i);
		System.out.println(i+".getSearchField"+attributeM.getSearchField());
		System.out.println(i+".isSearchKeyFlag"+attributeM.isSearchKeyFlag());
		System.out.println(i+".isDisplay"+attributeM.isDisplayFlag());
	}
// end wf
%>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center" class="manyRowDiv">
				<table width="100%" cellpadding="1" cellspacing="1" align="center">
					<thead>
						<tr height="19">     
<%      
	int totalWidth = 0;
	if (entityM.isShowCheckBox()) {
		totalWidth = 92/processAttrToShowVt.size();
%>     
							<th width = "4%" align="center" height="19" class="TableHeaderList">&nbsp;</td>
<% 
	} else {
		totalWidth = 96/processAttrToShowVt.size();
	}
%>
							<th width = "4%"  align="center" height="19" class="TableHeaderList">No</td>       
<%


//for (int i= 0;i < vShowColumns.size();i++) {
//	ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i);

//wf
String displayCaption = null;
for(int i=0;i<processAttrToShowVt.size();i++){
	attributeM=(WfProcessAttributeM)processAttrToShowVt.get(i);
//end wf
%>      
							<th width ="<%=totalWidth%>%" align="center" class="TableHeaderList">
					       		<%//=MasterUtil.displayFieldName(moduleM,request)%>
					       		<%=attributeM.getDisplayCaption()%>
								<div class="orderColumnDiv">
									<div class="orderASCDiv" onclick="sortTableAjax('<%//=moduleM.getFieldID() %>', 'ASC', 'resultSearchContainer');"></div>
					        		<div class="orderDESCDiv" onclick="sortTableAjax('<%//=moduleM.getFieldID() %>', 'DESC', 'resultSearchContainer');"></div>
								</div>
							</th>
<% 
 }
%>
						</tr>
					</thead>
				
					<tbody>
<%if(wfWorkQueueList.size() == 0){%>
						<tr class="ROW" onmouseover="this.className='ROW_HOVER'" onmouseout="this.className='ROW'">
							<td align="center" colspan="<%=processAttrToShowVt.size()+1 %>">
								<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH") %></span>
							</td>
						</tr>
<%} %>

<% 
//for (int i=0;i < vShowSearchRecs.size();i++) {
//	HashMap hReturnData = (HashMap)vShowSearchRecs.get(i);
//	System.out.println("hReturnData==>"+hReturnData);	
//	HashMap hKeyRecords = (HashMap)hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH); 
//	System.out.println("hKeyRecords==>"+hKeyRecords);	
//	Vector vKeys = new Vector(hKeyRecords.keySet()); 
//	String keyForSearch = ""; 
//	for (int j = 0;j < vKeys.size();j++) {
//		String fieldID = (String)vKeys.get(j);
//		String valueKey = (String)hKeyRecords.get(fieldID);
//		keyForSearch = keyForSearch + fieldID + "="+ valueKey;
//		if (j < (vKeys.size()-1)) {
//			keyForSearch = keyForSearch + "&";
//		} 
//	}

//wf
String keyForSearch = null; 
String strSearchResult=null;
WfWorkQueueM workqueueM = null;
HashMap wqAttrHm=null;
StringBuffer keyForSearchBuffer =null;
for(int i=0;i<wfWorkQueueList.size();i++){ // display search result record
	workqueueM = (WfWorkQueueM)wfWorkQueueList.get(i);
	wqAttrHm = workqueueM.getWqAttrHm();

	System.out.println("wfSearchResult.workqueueM :"+workqueueM.toString());
	System.out.println("wfSearchResult.wqAttrHm :"+wqAttrHm);
	//gen key
	keyForSearchBuffer = new StringBuffer();
	for(int k=0;k<keyNameVt.size();k++){
		keyForSearchBuffer.append(keyNameVt.get(k)+"=");
		keyForSearchBuffer.append(wqAttrHm.get(keyNameVt.get(k))+"&");
	}
	keyForSearchBuffer.append("wfJobId="+workqueueM.getJobId());
	keyForSearchBuffer.append("&wfPtid="+workqueueM.getPtid());
	keyForSearch = keyForSearchBuffer.toString();
//end wf

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
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	}	
//	for (int j= 0;j < vShowColumns.size();j++) {
//		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
//		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData);

// wf
	for(int j=0;j<processAttrToShowVt.size();j++){
		attributeM=(WfProcessAttributeM)processAttrToShowVt.get(j);
		attributeName = attributeM.getAttrName();
		strSearchResult = (String)wqAttrHm.get(attributeName);
		System.out.println("wfSearchResult...attributeName:"+attributeName+" strSearchResult:"+strSearchResult);
// end wf
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
	if (wfWorkQueueList.size() > 0) {
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
//	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
//	if (moduleActionM != null){
//		if (null != moduleActionM.getFilePath() && !"".equals(moduleActionM.getFilePath())) {
//			String filePath = moduleActionM.getFilePath();
//			System.out.println("filePath -> " + filePath);
			
//			String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
//			String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
//			System.out.println("manualContextPath -> " + manualContextPath);
//			System.out.println("manualUrlPath -> " + manualUrlPath);
			
//			pageContext.setAttribute("manualContextPath", manualContextPath);
//			pageContext.setAttribute("manualUrlPath", manualUrlPath);

	
//		<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>
%>
		
<% 					
//		}

//		if (null != moduleActionM.getScriptFile() && !"".equals(moduleActionM.getScriptFile())) {
//			System.out.println("moduleActionM.getScriptFile() -> " + moduleActionM.getScriptFile());
%>
			<SCRIPT language="JavaScript" src="<%//=moduleActionM.getScriptFile()%>"></SCRIPT>
<%
//		}
//	}
%>

<%
	/* javascript for dependency component */
	String strJavaScript = "";
//	Vector vResult = MasterForm.getVMasterModelMs();	 
//	Vector vAllDependencys = new Vector();
//	for (int s=0;s < vResult.size();s++) {
//		ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(s);
//		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
//			vAllDependencys.addElement(prmModuleFieldM);
//		}
//	}		
	
//	strJavaScript += MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
%>

<%=strJavaScript%>
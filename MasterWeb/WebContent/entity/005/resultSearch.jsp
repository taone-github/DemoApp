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
<%
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	System.out.println("vShowColumns==>"+vShowColumns);
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
%>
<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">
<input type ="hidden" name = "selectPerPage" value = "<%=MasterForm.getVolumePerPage()%>"> 
<input type ="hidden" name = "clearCheckboxSession" value = "N"> 
<% // ----------- comment by worrachet 2012-05-09 for fix pagging display when click cancel from update screen -------------
 //if (vShowSearchRecs.size() > 0 && (form.isClickSearch() || "Y".equals(form.getEntityM().getDefaultSearchFlag()))) { 
 if (vShowSearchRecs.size() > 0) { 
	int startRec =((MasterForm.getPage()-1)*MasterForm.getVolumePerPage())+1;
	int finishRec = startRec + vShowSearchRecs.size()-1;	 
	int allPage =  MasterForm.getAllSearchResultData() / MasterForm.getVolumePerPage();
	int lastPage = (MasterForm.getAllSearchResultData()/MasterForm.getVolumePerPage());
	if ((MasterForm.getAllSearchResultData()%MasterForm.getVolumePerPage())>0)  {
		lastPage++;
	}
	
	
	String strFirstPage ="";
	
	if (MasterForm.getPage()==1) {
		strFirstPage = "<strong><font class=\"text\">1</font></strong>";	
	} else {
		strFirstPage = "<a href=\"#\" onclick =\"changePageAndSize('1')\"><font class=\"text\">1</font></a>";
	}
	
	
	
	String strLastPage = "";
	if (lastPage > 1) {
		if (lastPage == MasterForm.getPage()){
			strLastPage = "<strong><font class=\"text\">"+Integer.toString(lastPage)+"</font></strong>";
		} else {
			strLastPage = "<a href=\"#\" onclick =\"changePageAndSize('"+Integer.toString(lastPage)+"')\"><font class=\"text\">"+Integer.toString(lastPage)+"</font></a>";
		}	
	} else {
		strLastPage	 = "";	
	}
	
	int lengthPage = 5; 
	String strScript = "";
	String strScriptBack = "";	
	String strFirst =  "<a href=\"#\" onclick =\"changePageAndSize('1')\"><font class=\"text\">First</font></a>";
	String strLast =  "<a href=\"#\" onclick =\"changePageAndSize('"+lastPage+"')\"><font class=\"text\">Last</font></a>";
	
	if (allPage*MasterForm.getVolumePerPage()  < MasterForm.getAllSearchResultData()) { 
		allPage++;
	}
	if (allPage != MasterForm.getPage())	{	
		strScript = "<a href=\"#\" onclick =\"changePageAndSize('"+(MasterForm.getPage()+1)+"')\"><font class=\"text\">Next</font></a>";
	} else {
		strScript = "Next";
	}
	
	if (MasterForm.getPage() != 1) {    
		strScriptBack = "<a href=\"#\" onclick =\"changePageAndSize('"+(MasterForm.getPage()-1)+"')\"><font class=\"text\">Prev</font></a>";			
	} else {	    
		strScriptBack = "Prev";	 
	}
	
	String showPage = MasterUtil.getInstance().displayPage(lengthPage,MasterForm.getPage(),lastPage);
	
	
%>
<table border="0" cellspacing=1 cellpadding=1 width="100%" >
    <tr >
      <td class="text"><span class="pagebanner"><%=MasterForm.getAllSearchResultData()%> items found, displaying <%=startRec%> to <%=finishRec%></span><span class="pagelinks">[<%=strFirst%> / <%=strScriptBack%>&nbsp;<strong><%=strFirstPage%><%=showPage%><%=strLastPage%></strong>&nbsp; <%=strScript%> / <%=strLast%>]</span> </td>
    </tr>
</table>
<% } %> 
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center" id="manyRowDivID" class="manyRowDiv">
				<table width="100%" cellpadding="1" cellspacing="1" align="center">
					<thead>
						<tr height="19">     
<%      
	int totalWidth = 0;
    EntityM entityM  = form.getEntityM(); 	
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		totalWidth = 92/vShowColumns.size();
%>     
						
<% 
	} else {
		totalWidth = 96/vShowColumns.size();
	}
	if (vShowSearchRecs.size() > 0 || form.isClickSearch()) {
		
		if (entityM.isShowCheckBox()|| entityM.isShowRadio()) {
			String objType = "checkbox";
			if (entityM.isShowRadio()) objType = "radio";
			//Sam fix checkbox add script
			//27/12/2011
			String checked ="";
			if(CheckBoxUtil.isAllChecked(form.getMainModuleID(),request)){
				checked = "checked";
			}
%>
						
				<!--<th width = "3%" class="tableHeader"><input type = "<%=objType%>" name = "deleteAll" value ="deleteAllValue" onclick="checkAllList()" <%=checked%> <%=(vShowSearchRecs.size() > 0) ? "" : "disabled" %>></th> -->
				    <th width = "3%" class="tableHeader"><input type = "<%=objType%>" name = "deleteAll" value ="deleteAllValue" onclick="checkAllList()" <%=(vShowSearchRecs.size() > 0) ? "" : "disabled" %> ></th>   
<% 
		}
%>							
				<th width = "4%"  align="center" height="19" class="tableHeader"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></td>       
<%

		for (int i= 0;i < vShowColumns.size();i++) {
			ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i);
			String alignment = moduleM.getAlignment();
			if  (alignment == null || ("".equals(alignment))) {
				alignment = "center";
			}
			
%>      
							<th align="<%=alignment%>" class="tableHeader <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header">
					       		<div class="orderColumnDiv" id = "orderColumnDivID" >
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<div class="tableHeader"><%=MasterUtil.displayFieldName(moduleM,request)%></div>
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
							</th>
<% 
 		}
	}
%>
						</tr>
					</thead>
				
					<tbody>

<% 
if (vShowSearchRecs.size()==0  && form.isClickSearch() ) {
%>
<tr class="ROW">
<% 
int allColumn = 0; 
if (entityM.isShowCheckBox()|| entityM.isShowRadio()) {
	allColumn++;	
}
allColumn = allColumn + vShowColumns.size()+1;
%>
<td colspan = "<%=allColumn%>" align ="center">
	<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_NO_DATA_FOUND") %></span>
</td>
</tr>
<% 	
}


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
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
%>
						<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='ROW'" : "this.className='ROW_ALT'"%>">
<%
	} else {
%>
						<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>">
<% 
} 
	if (entityM.isShowCheckBox()|| entityM.isShowRadio()) {
		String objType = "checkbox"; 
		if (entityM.isShowRadio()) objType = "radio";
		//Sam fix checkbox add script
		//26/12/2011
		String checked ="";
		if(CheckBoxUtil.isChecked(form.getMainModuleID(),keyForSearch,request)){
			checked = "checked";
		}
%>     
							<td width ="3%"  align="center" ><input type = "<%=objType%>" name = "deleteRow" value ="<%=keyForSearch%>" onclick="document.masterForm.deleteAll.checked=false;changeCheckBox(this)" <%=checked%>> </td>
							<!--<td width ="3%"  align="center" ><input type = "<%=objType%>" name = "deleteRow" value ="<%=keyForSearch%>" onclick="checkList()"> </td> -->
<% 
	}
	
	int lineNumber = ((MasterForm.getVolumePerPage() * MasterForm.getPage()) - MasterForm.getVolumePerPage()) + (i+1);
%>
<!--							<td width ="4%" align ="center"  height="19" class="bu2" ><%=(i+1)%></td>-->
								<td width ="4%" align ="center"  height="19" class="bu2" ><%=lineNumber%></td>
<% 
	//String onclickEvent = "";
	//if (MasterForm.isSearchForUpdate()) {
	//	onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	//}	
	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData,MasterForm.getHAllobjects());
		String tagStr = "";
		String alignment = moduleM.getAlignment();
		if  (alignment == null || ("".equals(alignment))) {
			alignment = "center";
		}
		if (strSearchResult == null || strSearchResult.trim().equalsIgnoreCase("")) {
			strSearchResult = "&nbsp;";
		}
		if (MasterForm.isSearchForUpdate()) {			
			tagStr = "<a href=\"#\""+onclickEvent+">"+strSearchResult+"</a>";
		}else {
			tagStr = "<span>"+strSearchResult+"</span>";
		}
%>		
		<td align="<%=alignment%>" class="bu2 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col"><div id="<%=moduleM.getFieldID()%>_<%=i%>"><%=tagStr%></div></td>					 
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
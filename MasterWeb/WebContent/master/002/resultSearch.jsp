<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil"%>

<% 
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
   <tr valign="bottom">
    <td  align="left"  valign="bottom" > 
    <jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
	<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
	<jsp:param name="action" value="SUB_SEARCH"/>
	</jsp:include>  
    </td >
    <td colspan="3"  width="95%" >
          
    </td>
  </tr> 
  <tr>
    <td colspan="4" valign="top">
      <table width="100%" border="0" cellpadding="1" cellspacing="1" align="center">
      <tr class="h3Row">
     <td width = "3%" class="TableHeaderList"><input type = "checkbox" name = "deleteAll" value ="deleteAllValue" onclick="checkAllList()" ></td>   
     <td width = "4%" class="TableHeaderList"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></td>       
<%
int totalWidth = 93/vShowColumns.size();
for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);
%>      
        <td width ="<%=totalWidth%>%" class="TableHeaderList" ><%=MasterUtil.displayFieldName(moduleM,request)%> </td>
<% 
 }
%>
      </tr>
      </table>
	<div align="center" class="manyRowDiv" style="width: 100%; height: 233px;">     
      <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

<% 
for (int i=0;i < vShowSearchRecs.size();i++) {
	HashMap hReturnData = (HashMap)vShowSearchRecs.get(i);
	HashMap hKeyRecords = (HashMap)hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH); 
	Vector vKeys = new Vector(hKeyRecords.keySet()); 
	String keyForSearch = ""; 
	for (int j = 0;j < vKeys.size();j++) {
		String fieldID = (String)vKeys.get(j);
		String valueKey = (String)hKeyRecords.get(fieldID);
		keyForSearch = keyForSearch + fieldID + "="+ valueKey;
		if (j < (vKeys.size()-1)) {
			keyForSearch = keyForSearch + "|";
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
%>
	<td width ="3%"   ><input type = "checkbox" name = "deleteRow" value ="<%=keyForSearch%>"> </td>
	<td width ="4%"  align ="center" ><%=(i+1)%></td>
<% 
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	}
	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData,MasterForm.getHAllobjects());
		if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
%>
			<td  align="center" <%=onclickEvent%> width ="<%=totalWidth%>%" class="listViewPaginationTdS2"><%=strSearchResult%></td>
<%	
		} else {
%>
			<td  align="center" <%=onclickEvent%>  width ="<%=totalWidth%>%" class="listViewPaginationTdS2">&nbsp;</td>
<%	
		}
	}
%>
</tr>
<%	
}
%>
      
    </table></div></td>
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

<%	
	Vector vResult = MasterForm.getVMasterModelMs();	 
	Vector vAllDependencys = new Vector();
	for (int i=0;i < vResult.size();i++) {
		ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(i);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}
	}
	

		String strJavaScript = MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
%>	
<%=strJavaScript%>

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
<%@page import="com.master.model.EntityM"%>


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
	<input type ="hidden" name = "clearCheckboxSession" value = "N"> 
<%
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	System.out.println("vShowColumns==>"+vShowColumns);
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
%>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
  <tr>
    <td colspan="4" valign="top">
    

<table width="100%" border="0"><tr><td>
<div id="totalRecord">
<!-- div start totalRecord-->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<%if (vShowSearchRecs.size() > 0){%> 
 <tr><td width="161">Total Records found :
 <%  
   if (vShowSearchRecs.size() > 0) {
	%>
	
<!-- Total page -->	
	<%=vShowSearchRecs.size()%></td> <td width="240">&nbsp;</td>
<!-- end Total page -->	
<% 
	int allPage =  MasterForm.getAllSearchResultData() / MasterForm.getVolumePerPage();
	if (allPage*MasterForm.getVolumePerPage()  < MasterForm.getAllSearchResultData()) {
		allPage++;
	}%>
	
	<td width="75"><div align="right">page <%=MasterForm.getPage() %> of<%=allPage%> </div></td>
<!-- previous page -->
<td width="8"><div align="center">|</div></td>
<td width="30"><div align="center">
<%	
	if (MasterForm.getPage() != 1) {

%>   
		<img src="<%=request.getContextPath()%>/theme/003/images/3974_16.jpg" alt="previous" width="19" height="16" onclick ="changePageAndSize('<%=(MasterForm.getPage()-1)%>')"/> 
    	
<% 
	} else {
%>    
		<img src="<%=request.getContextPath()%>/theme/003/images/3974_16.jpg" alt="previous2" width="19" height="16"/>
<% 
	}
%>    
</div></td>
<!-- end previous page --> 

<!-- now page -->
<td width="19"><div align="center"><%=MasterForm.getPage() %></div></td>
<!-- end now page -->

<!-- next page -->
<td width="20"><div align="center">
<%
	if (allPage != MasterForm.getPage())	{	
%>    
    <img src="<%=request.getContextPath()%>/theme/003/images/3976_16.jpg" alt="next" width="19" height="16" onclick ="changePageAndSize('<%=(MasterForm.getPage()+1)%>')" />
  
<% 
	} else {
%>
    <img src="<%=request.getContextPath()%>/theme/003/images/3976_16.jpg" alt="next2" width="19" height="16"  />
<% 
	}
%>
</div></td> 
 
<%	
	}	
%>    
<!-- end next page -->



                 
                           
<!-- dropdown list -->  
<td width="9"><div align="center">|</div></td> 
<td width="31"><div align="right"> view </div></td>                        
  <td width="60"><div align="center"> <select name="selectPerPage"  onchange="changePageAndSize('1')"> 
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
     
    </select></div> </td>
    
<!-- end dropdownlist -->
                            <td width="69">per page  </td>
                          
                          </td>
                          </tr><%} %>
                        </table>
				 </div>
<!--div end TotalRecord--> 			 
<!--div start Headerlist-->  
    <div id="Headerlist">
      <table width="100%" cellpadding="0" cellspacing="0" align="center">
      
      <tr  class="title" height="19">   
<%      
	int totalWidth = 0;
    EntityM entityM  = form.getEntityM(); 	
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		totalWidth = 92/vShowColumns.size();
%>     
	  <td  width = "4%" align="center" height="19">&nbsp;</td>
<% 
	} else {
		totalWidth = 96/vShowColumns.size();
	}
%>  
      <td  width = "4%"  align="center" height="19">No</td>       
<%

System.out.println("totalWidth003==>"+totalWidth);

for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);
System.out.println("moduleM003==>"+moduleM);	
%>      
        <td class="<%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header"><%=MasterUtil.displayFieldName(moduleM,request)%> </td>
<% 
 }
%>
      </tr>
     
     
      </table></div>
      
      <!--div end contentTable-->


<div align="center" style="SCROLLBAR-FACE-COLOR: #d0d0d0; SCROLLBAR-HIGHLIGHT-COLOR: #d0d0d0;overflow: auto; SCROLLBAR-SHADOW-COLOR: #CCCCCC; COLOR: #d0d0d0; SCROLLBAR-3DLIGHT-COLOR: #FAFAFA; SCROLLBAR-ARROW-COLOR: black; SCROLLBAR-DARKSHADOW-COLOR: #CCCCCC; width: 100%; height: 233px;">     

<div id="contentResult">
<table width="100%" cellpadding="0" cellspacing="0" align="center" class="contentResult">
<%if(vShowSearchRecs.size() == 0){%>
	<tr class="ROW1" onmouseover="mouseOver(this)" onmouseout="mouseOut1(this)">
		<td align="center">
			<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH") %></span>
		</td>
	</tr>
<%} %>
<% 
for (int i=0;i < vShowSearchRecs.size();i++) {
    System.out.println("vShowSearchRecs>>>>>>"+vShowSearchRecs.size());
	HashMap hReturnData = (HashMap)vShowSearchRecs.get(i);
	System.out.println("hReturnData003==>"+hReturnData);	
	HashMap hKeyRecords = (HashMap)hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH); 
	System.out.println("hKeyRecords003==>"+hKeyRecords);	
	Vector vKeys = new Vector(hKeyRecords.keySet()); 
	String keyForSearch = ""; 
	for (int j = 0;j < vKeys.size();j++) {
	System.out.println("vKeys>>>"+vKeys.size());
		String fieldID = (String)vKeys.get(j);
		String valueKey = (String)hKeyRecords.get(fieldID);
		keyForSearch = keyForSearch + fieldID + "="+ valueKey;
		if (j < (vKeys.size()-1)) {
			keyForSearch = keyForSearch + "&";
		} 
	}
	
	if (MasterForm.isSearchForUpdate()) {
	
%> 
	<tr class="<%=((i%2)==0)? "ROW1" : "ROW" %>"  onmouseover="mouseOver(this)"; onmouseout="<%=((i%2)==0)? "mouseOut1(this)" : "mouseOut2(this)" %>">
	
<%   
	} else {
%>
	<tr>
<% 
} 
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
			String objType ="checkbox";
			if (entityM.isShowRadio()) objType ="radio";
%>     
			  <td  width ="4%"  align="center" height="19" class="bu2"><input type = "<%=objType%>" name = "checkRow" value ="<%=keyForSearch%>"></td>
		<% 
			}
		%>
	<td class="rowResult" width ="4%" align ="center"  height="19"><%=(i+1)%></td>
<% 
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"')\"";
	}
System.out.println("hReturnData003==>"+hReturnData);	
	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData,MasterForm.getHAllobjects());
		if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
%>
			<td  <%=onclickEvent%> class="<%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col"><%=strSearchResult%></td>
<%	
		} else {
%>
			<td  <%=onclickEvent%> class="<%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col">&nbsp;</td>
<%	
		}
	}
%>
</tr>
<%	
}
%>
     
    </table></div></td>
    <td>
   </td>
    </tr></table>
    
    </td>
  </tr>
  
  
</TABLE>

 <style>
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, MasterForm.getProcessMode()) %>
</style>
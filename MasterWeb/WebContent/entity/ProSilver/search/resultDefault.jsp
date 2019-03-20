<%@page import="com.avalant.feature.FT031_HideCheckboxMany"%>
<%@page import="com.avalant.feature.FT027_HighlightRow"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.avalant.feature.v2.FT024_AccessControl"%>
<%@page import="com.avalant.rules.j2ee.AccessControlM"%>
<%@page import="com.master.model.EntityM"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.util.CheckBoxUtil"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.util.MasterConstant"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr><!-- Header -->
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
	
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	
	EntityM entityM  = form.getEntityM();
	if (entityM.isShowCheckBox() || entityM.isShowRadio() ) {
	   if(vShowSearchRecs.size() == 0){
%>
	<td class="headtable2" align="center">&nbsp;</td>
<% 
		}else{
%>
	<td class="headtable2" align="center"><input type = "checkbox" name = "checkRow" value ="" onclick="checkedAllData(this)"></td>
<%		
		}
	}
%>
	<td class="headtable2"><div class="fontheadtable1"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></div></td>
<%
/*
 * 23-06-2014 plug with access control V.1.0
 */
int countNoAccess = 0;
/*
* 09-09-2014 FT027_HighlightRow
*/
Vector vHighlightFieldID = new Vector();

/*
* 01-10-2015 FT031_HideCheckboxMany
*/
Vector vHideCBFieldID = new Vector();
int skipColumCount = 0;

for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i); 
	
	/*
	 * 23-06-2014 plug with access control V.1.0
	 */
	if(moduleM.isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleM.getAclMode())) {
		FT024_AccessControl.debug("# skip column:" + moduleM.getFieldID() + " by access control");
		countNoAccess++;
		continue;
	}
	/*
	* 09-09-2014 FT027_HighlightRow
	*/
	if(moduleM.isHighlight()) {
		vHighlightFieldID.add(moduleM.getFieldID());
		//continue;
	}
	/*
	* 01-10-2015 FT031_HideCheckboxMany
	*/
	if(moduleM.isHideCB()) {
		vHideCBFieldID.add(moduleM.getFieldID());
		//continue;
	}
	if(moduleM.isHighlight() || moduleM.isHideCB()) {
		skipColumCount++;
		continue;
	}
	%>

	

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
	<%
	/*
	* 09-09-2014 FT027_HighlightRow
	* -(vHighlightFieldID.size()>0 ? 1 : 0)
	* 
	* 01-10-2015 FT031_HideCheckboxMany
	*/
	%>
<%-- 	<td align="center" colspan="<%=allColumn-1-countNoAccess-(vHighlightFieldID.size()>0 ? 1 : 0) %>"> --%>
		<td align="center" colspan="<%=allColumn-1-countNoAccess-skipColumCount %>">
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
	
	/*
	* 09-09-2014 FT027_HighlightRow
	*/
	String highlightClassName = "";
	if(vHighlightFieldID != null) {
		for(int a=0; a<vHighlightFieldID.size(); a++) {
			if("Y".equals((String)hReturnData.get((String)vHighlightFieldID.get(a)))) {
				highlightClassName = FT027_HighlightRow.CSS_CLASS_NAME;
			}
		}
	}
	
	/*
	* 01-10-2015 FT031_HideCheckboxMany
	*/
	String hideCBStr = "";
	String hideCBClassName = "";
	if(vHideCBFieldID != null) {
		for(int a=0; a<vHideCBFieldID.size(); a++) {
			if("Y".equals((String)hReturnData.get((String)vHideCBFieldID.get(a)))) {
				hideCBStr = FT031_HideCheckboxMany.HIDE_CB_STYLE;
				hideCBClassName = FT031_HideCheckboxMany.CSS_CLASS_NAME;
			}
		}
	}
	
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
			<% 
			/*
			* 09-09-2014 FT027_HighlightRow
			*/ 
			%>
			<tr class="<%=highlightClassName %> <%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='<%=highlightClassName %> ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='"+highlightClassName+" ROW'" : "this.className='"+highlightClassName+" ROW_ALT'"%>">
<%
	} else {
%>
			<tr class="<%=highlightClassName %> <%=((i%2)==0)? "ROW" : "ROW_ALT" %>">
<% 
	}
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		String objType = "checkbox";
		if (entityM.isShowRadio()) objType="radio";
%>     
<%-- 		    <td  width ="4%"  align="center" height="19" class="datatable2"><input type = "<%=objType%>" name = "checkRow" value ="<%=keyForSearch%>" onclick="changeCheckBox(this)"></td> --%>
			<td  width ="4%"  align="center" height="19" class="datatable2"><input <%=!"".equals(hideCBClassName) ? "class='"+hideCBClassName+"' style='"+hideCBStr+"'" : "" %> type = "<%=objType%>" name = "checkRow" value ="<%=keyForSearch%>" onclick="changeCheckBox(this)"></td>
<% 
	}
%>
			<td width ="4%" align ="center"  height="19" class="datatable2" ><div class="fontheadtable1"><%=(i+1)%></div></td>
<% 
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	}	
	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		
		/*
		 * 23-06-2014 plug with access control V.1.0
		 */
		if(moduleM.isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleM.getAclMode())) {
			FT024_AccessControl.debug("# skip column:" + moduleM.getFieldID() + " by access control");
			continue;
		}
		
		/*
		* 09-09-2014 FT027_HighlightRow
		*/
		if(moduleM.isHighlight()) {
			continue;
		}
		
		/*
		* 01-10-2015 FT031_HideCheckboxMany
		*/
		if(moduleM.isHideCB()) {
			continue;
		}
		
		String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleM,hReturnData,MasterForm.getHAllobjects());
		String tagStr = "";
		if (strSearchResult == null || strSearchResult.trim().equalsIgnoreCase("")) {
			strSearchResult = "&nbsp;";
		}
		if (MasterForm.isSearchForUpdate()) {			
			//tagStr = "<a href=\"#\""+onclickEvent+">"+strSearchResult+"</a>";
			tagStr = "<span style=\"cursor: hand\" "+onclickEvent+" title=\""+strSearchResult+"\">"+strSearchResult+"</span>";
		}else {
			tagStr = "<span title=\""+strSearchResult+"\">"+strSearchResult+"</span>";
		}
		//Sam add for alignment
		String align = "center";
		if ((moduleM.getAlignment() != null && !"".equals(moduleM.getAlignment()))) { 
			align = moduleM.getAlignment();
		}
		String objProperty = moduleM.getObjProperty();
		if(MasterConstant.MONEY_FORMAT.equalsIgnoreCase(objProperty)){
			align = "right";
		}
%>		
		<td align="<%=align%>"  class="datatable2 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col"  <%=(align!=null&&!"".equals(align) ? "style=\"text-align: "+align+"\"" : "") %>>
			<div id="<%=moduleM.getFieldID()%>_<%=i%>"  <%=(align!=null&&!"".equals(align) ? "style=\"text-align: "+align+"\"" : "") %> class="fontdatatable1"><%=tagStr%></div>
		</td>					 
<%			
	}	
%>
	</tr>
<%	
}
%>
</table>
<%@page import="com.master.model.EntityM"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.util.MasterConstant"%>
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
	}
 
//Case No Data
int allColumn = 0;
if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
	allColumn++;	
}
allColumn = allColumn + vShowColumns.size()+1;
%>					
<%if(vShowSearchRecs.size() == 0){%>
<div id="noData" >
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
</div>
<%} %>

<%
//Case have result
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
%>
<%
	//Each Row
	if(i%3==0){
%>
	<div style="WIDTH: 100%; OVERFLOW: hidden" >
<%	}%>
	<!-- Each result -->
	<div class="boxResultView">
		<div class="textbox1search" >
			<div class="boxsearch" >
				<div class="componentNameDiv">
<%
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		String objType = "checkbox";
		if (entityM.isShowRadio()) objType="radio";
%>     
		    <input type = "<%=objType%>" name = "checkRow" value ="<%=keyForSearch%>">
<% 
	}		
%>
				<%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %>
				</div>
			</div>
			<div  class="componentDiv textinbox-boxbold">
					<div class="fontdatatable1"><%=(i+1)%></div>
			</div>
		</div>
<% 
	String onclickEvent = "";
	if (MasterForm.isSearchForUpdate()) {
		onclickEvent = "onclick=\"loadForUpdate('"+keyForSearch+"','"+i+"')\"";
	}	
	for (int j= 0;j < vShowColumns.size();j++) {
		ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(j);	
		String headerColumn = MasterUtil.displayFieldName(moduleM,request);
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
		<div class="textbox1search" >
			<div class="boxsearch" >
				<div class="componentNameDiv"><%=headerColumn%></div>
			</div>
			<div align="<%=align%>"  class="componentDiv <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_col textinbox-boxbold">
					<div id="<%=moduleM.getFieldID()%>_<%=i%>" class="fontdatatable1"><%=tagStr%></div>
			</div>
		</div>
<%			
	}
%>
	</div>
	<div class=spaceboxbold></div>
<%
	//End Each Row
	if(i%3==2){
%>
	</div><!-- End row -->
	<div style="height:10px;float:left;width:100%">&nbsp;</div>
<%	}%>

<%	
}
%>

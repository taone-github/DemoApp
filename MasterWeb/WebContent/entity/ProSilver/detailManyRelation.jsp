<%@page import="com.avalant.feature.FT031_HideCheckboxMany"%>
<%@page import="com.avalant.feature.FT027_HighlightRow"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.avalant.rules.j2ee.AccessControlM"%>
<%@page import="com.avalant.feature.FT022_UploadFile"%>
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
<%@ page import="com.master.model.PopupPropM" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.model.EntityTabM" %>
<%@ page import="com.master.model.TabM" %>
<%@ page import="com.master.model.TabMouleM" %>
<%@ page import="com.master.dao.MasterDAO" %>
<%@ page import="com.master.dao.MasterDAOFactory" %>
<%@ page import="com.master.model.ListPropM" %>
<%@ page import="com.master.model.RadioPropM" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@page import="com.master.model.ModuleActionM"%>

<jsp:include flush="true" page="../manyRelationEventScript.jsp"/>

<% 
	System.out.println("detailManyRelation.jsp");
	boolean hideEdit = false;
	boolean unEditInLine = false;
	String module = (String)request.getSession().getAttribute("module");
	
	/* Fix wrong module ID when call ${module}CreateRow() function */
 	if(request.getParameter("requestModule") != null) {
 		module = request.getParameter("requestModule");
 	}
 	/* Fix for always show edit button */
 	String isAlwaysShowEditBtn = request.getParameter("isAlwaysShowEditBtn");
	
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
	
	/**************************************************************/
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID + "_session";
	System.out.println("entitySession ==> " + entitySession);
	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	System.out.println("form==> " + form);
	System.out.println("entityTabs==> " + entityTabs);
	
	/* set nextEntity & nextTab if MORE_CHILD_FLAG = 'Y' */
	boolean moreChildFlag = false;
	String nextEntityID = "";
	String nextTabID = "";
	
	/* set default H & W */
	String moduleHeight = "100";
	String moduleWidth = "100";
	
	/* start get H & W from database */
	HashMap hTabs = form.getTabHasMap();
	if(0 != entityTabs.size()){
		System.out.println("entityTabs.size() -> " + entityTabs.size());
		for(int i=0; i<entityTabs.size(); i++) {
			EntityTabM entityTabM = (EntityTabM)entityTabs.get(i);
			TabM tabM = (TabM) hTabs.get(entityTabM.getTabID());
			
			System.out.println("getTabID[" + i + "] -> " + tabM.getTabID());
			Vector tabModuleMs = tabM.getTabModuleMs();
			if(0 != tabModuleMs.size()){
				System.out.println("tabModuleMs.size() -> " + tabModuleMs.size());
				for(int j=0; j<tabModuleMs.size(); j++){
					TabMouleM tabModuleM = (TabMouleM) tabModuleMs.get(j);
					System.out.println("tabModuleM.getModuleID()===>"+tabModuleM.getModuleID());
					System.out.println("module===>"+module);				
					if(MasterConstant.ENTITY_RELATION_TYPE_MANY.equalsIgnoreCase(tabModuleM.getRelationType())   
						||MasterConstant.ENTITY_RELATION_TYPE_LIST.equalsIgnoreCase(tabModuleM.getRelationType())) {
						if(tabModuleM.getModuleID().equalsIgnoreCase(module)){
							hideEdit = tabModuleM.isHideEditFlag();
							unEditInLine = tabModuleM.isUnEditInLine();
							if(!"".equalsIgnoreCase(Integer.toString(tabModuleM.getHeight())) && null != Integer.toString(tabModuleM.getHeight()) && !"0".equalsIgnoreCase(Integer.toString(tabModuleM.getHeight()))){
								moduleHeight = Integer.toString(tabModuleM.getHeight());
							}
							if(!"".equalsIgnoreCase(Integer.toString(tabModuleM.getWidth())) && null != Integer.toString(tabModuleM.getWidth()) && !"0".equalsIgnoreCase(Integer.toString(tabModuleM.getWidth()))){
								moduleWidth = Integer.toString(tabModuleM.getWidth());
							}
							if(tabModuleM.isMoreChildFlag()){
								nextEntityID = tabModuleM.getNextEntityID();
								nextTabID = tabModuleM.getNextTabID();
								moreChildFlag = true;
							}
						}
					}
				}
			}
		}
	}
	/* end get H & W from database */
	/**************************************************************/
%>
<%
	//Sam force no checkbox on this theme
	//MasterForm.setUnEditManyFlag(true);
	//System.out.println(" SAM force this theme no checkbox many");
	
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	HashMap hAllObj =  MasterForm.getHAllobjects();

	int totalWidth = 93/vShowColumns.size();
	Vector vStoreActions  = (Vector)MasterForm.getStoreActionList();
	System.out.println("mould vShowColumns.size() ===> " + vShowColumns.size());
	System.out.println("vStoreActions ===> " + vStoreActions);
	Vector vModelMs = (Vector)MasterForm.getVMasterModelMs();
	StringBuffer hiddenField = new StringBuffer();
%>

<%if(MasterForm.getModuleM().isInsertOnTableFlag()){ %>
<jsp:include flush="true" page="many/insertFieldMany.jsp"/>
<%} %>

<input type ="hidden" name = "<%=MasterForm.getModuleM().getModuleID()%>_orderBy" id = "<%=MasterForm.getModuleM().getModuleID()%>_orderBy" value = "">
<input type ="hidden" name = "<%=MasterForm.getModuleM().getModuleID()%>_orderByType" id = "<%=MasterForm.getModuleM().getModuleID()%>_orderByType" value = "">

<%
	Vector vFilters = MasterForm.getFilterFields();	
	if (vFilters.size() >0  && MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(form.getCurrentMode()) ) {		
%>
<table class="tableForm" align="center" width="90%" cellpadding="0" cellspacing="0" border="0">
<% 
	for (int u =0; u < vFilters.size();u++) {
		ModuleFieldM filterFieldM = (ModuleFieldM)vFilters.get(u);
		String labelNamed = filterFieldM.getModuleID() + "_" + filterFieldM.getFieldID() + "_" + MasterConstant.NAMING.LABEL_FIELD;
		String tagShow = MasterUtil.displayFilterTag(request, entityID, filterFieldM.getFieldID(), MasterForm);
%>
<% 
		if (((u%3) == 0) || (u ==0)) {		
%>				
				<tr>				
<% 
		}
%>				
				<td class="td_OneRelation">
					&nbsp;
				</td>
				<td class="td_OneRelation">
					<div class="componentSpacerDiv">&nbsp;</div>
				</td>
				<td class="td_OneRelation"  >
					<div class="componentNameDiv" id="<%=labelNamed %>" >
					<NOBR><%=MasterUtil.displayFieldName(filterFieldM,request)%></NOBR>
					</div>
					<div class="componentDiv" id="<%=filterFieldM.getModuleID()%>_<%=filterFieldM.getFieldID()%>_filter" >
						<%=tagShow%>
					</div>
				</td>
<% 
		if (((u%3) == 2) || ((u+1)==vFilters.size()) ) {		
%>				
				</tr>
<% 
		}
%>						
<%		
	}
%>		
</table>
<% 
	}
%>	
<% if (!MasterForm.isUnEditManyFlag()) { %>
<div id="module-many-button" style="width:100%" class="module-many-button"> 
<%
	String buttonTag = com.master.button.DisplayButton.displayDivButton(request,MasterForm.getModuleM().getModuleID(),"SUB_SEARCH");
%>
<%=buttonTag%>
</div>
<% } %>
<div id="many_<%=MasterForm.getModuleM().getModuleID()%>_dialog" class="manyDialog">
<%=MasterForm.getModuleM().getModuleName()%> Dialog Div.
</div>
<script type="text/javascript">
$(document).ready( function() {
	$('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').dialog({
		width: 790,
		autoOpen: false,
		height: 500,
		modal: true,
		title: '<%=MasterForm.getModuleM().getModuleName()%>',
		close: function(ev, ui) {
		   $('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').html('');
		   $("body").css("overflow", "auto");
		  }
	});
	<%boolean oldDate = com.avalant.feature.ExtendFeature.getInstance().useFeature("OLD_DATE");
		if(oldDate){
	%>
	$('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').bind('dialogclose', function(event) {
	     try{
	     	hideCalendar();
	     }catch(e){}
	 });
});
<%}%>
</script>


<div id="module-many-pagging" style="float:right; margin-top:-25px; width:50%;">
<% 
		/*if (MasterForm.getModuleM().isPagingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) { */
		if (MasterForm.getModuleM().isPagingFlag()  && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) { 
%>
<jsp:include flush="true" page="paggingMany.jsp"/>
<% 
	}
%>
</div>
<% 
	/*if (MasterForm.getModuleM().isOrderingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) { */
	if (MasterForm.getModuleM().isOrderingFlag() && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) {	
%>
<jsp:include flush="true" page="../orderingManyEventScript.jsp"/>
<% 
	} // height: <%=moduleHeight% > px;
%>

	<div id="<%=module%>Many" align="center" class="tablearea" >  
			<table width="100%" cellpadding="0" cellspacing="0" align="center" >
				<tbody>
				<tr>
<%if((vStoreActions.size()>0  && (!MasterForm.isUnEditManyFlag())))  { %>
					
					<td width = "3%" height="19" class="datatable2" align="center"><input type = "checkbox" name = "<%=module %>checkAll" onclick = "selectedAllCheckBox('<%=module %>')" /></td>
<%} %>     
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
	ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);
	
	/*
	* 23-06-2014 plug with access control V.1.0
	* count no access column and skip this field
	*/
	if(moduleM.isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleM.getAclMode())) {
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
<%
			if (MasterForm.getModuleM().isOrderingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
					MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) {
%>
						<div class="orderColumnDiv" id = "orderColumnDivID" >
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<div class="fontheadtable1"><%=MasterUtil.displayFieldName(moduleM,request)%></div>
									</td>
									<td class="orderDivArea">
<% 
				if (vStoreActions.size() > 0) {
%>											
										<div  id ="orderASCDivID_<%=i %>" class="orderASCDiv" onclick="<%=module%>ManyOrder('<%=moduleM.getFieldID() %>', 'ASC');"></div>
										<div  id ="orderDESCDivID_<%=i %>" class="orderDESCDiv" onclick="<%=module%>ManyOrder('<%=moduleM.getFieldID() %>', 'DESC');"></div>
<% 
				}
%>												
									</td>
								</tr>
							</table>
						</div>
<%
			}else{
%>
						<div class="fontheadtable1"><%=MasterUtil.displayFieldName(moduleM,request)%></div>
<%
			}
%>						
					</td>
<% 
 }
%>
<%if(vStoreActions.size()>0 && ((((!MasterForm.isUnEditManyFlag()) && (!hideEdit)) && (!unEditInLine)) || "Y".equals(isAlwaysShowEditBtn)) ){ %>
					<td class="headtable1 <%=MasterForm.getModuleM().getModuleID()%>_edit_button_header"><div style="display: block; width: 30px" ></div></td>
<%} %>
				</tr>
				
<%if(vStoreActions.size()==0){ %>
				<tr class="gumaygrey2" onmouseover="this.className='gumaygrey2'" onmouseout="this.className='gumaygrey2'">
					<%
					/*
					* 09-09-2014 FT027_HighlightRow
					* -(vHighlightFieldID.size()>0 ? 1 : 0)
					*/
					%>
<%-- 					<td align="center" colspan="<%=vShowColumns.size()+1-countNoAccess-(vHighlightFieldID.size()>0 ? 1 : 0) %>"> --%>
					<td align="center" colspan="<%=vShowColumns.size()+1-countNoAccess-skipColumCount %>">
						<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_ADD") %></span>
					</td>
				</tr>
<% } %>
<%
			//FT001_DESCDLB Sam feature show desc for DLB
			/*
			* FIX : FT001_DESCDLB Sam feature show desc for DLB
			* FIX : 31-10-2014 : dependency
			*/
			//HashMap desDLBHash = com.master.util.DynamicListUtil.getInstance().getDesDLBHash(vShowColumns,entityID,request,MasterForm);
			//System.out.println("desDLBHash : " + desDLBHash);
			//End FT001_DESCDLB
			
			for (int i= 0;i < vStoreActions.size();i++) {
				String keyForSearch = "";
				HashMap hStoreActions = (HashMap)vStoreActions.get(i);
				Vector vKeysAction = new Vector(hStoreActions.keySet());
				boolean moreChildEditBtn = false;
				hiddenField.append("<input type =\"hidden\" name=\""+module+"_ROW_STATUS\" value =\""+(String)vKeysAction.get(0)+"\" >");
				
				/*
				* 09-09-2014 FT027_HighlightRow
				*/
				String highlightClassName = "";
				if(vHighlightFieldID != null) {
					HashMap hDataRec = EAFManualUtil.getDataHashMapFromSession(module, request, i);
					for(int a=0; a<vHighlightFieldID.size(); a++) {
						if("Y".equals((String)hDataRec.get((String)vHighlightFieldID.get(a)))) {
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
					HashMap hDataRec = EAFManualUtil.getDataHashMapFromSession(module, request, i);
					for(int a=0; a<vHideCBFieldID.size(); a++) {
						if("Y".equals((String)hDataRec.get((String)vHideCBFieldID.get(a)))) {
							hideCBStr = FT031_HideCheckboxMany.HIDE_CB_STYLE;
							hideCBClassName = FT031_HideCheckboxMany.CSS_CLASS_NAME;
						}
					}
				}
				
				
%>
				<% /*
				* 09-09-2014 FT027_HighlightRow
				*/ %>
				<tr class="<%=highlightClassName %> <%=((i%2)==0)? "gumaygrey2" : "gumaygrey2" %>" onmouseover="this.className='"+highlightClassName+" gumaygrey2'" onmouseout="<%=((i%2)==0)? "this.className='"+highlightClassName+" gumaygrey2'" : "this.className='"+highlightClassName+" gumaygrey2'"%>">
<% if (!MasterForm.isUnEditManyFlag()) {%>					
<%-- 					<td width ="3%" class="datatable2"><input type = "checkbox" name = "<%=module%>deleteRow" value ="<%=i%>"></td> --%>
						<td width ="3%" class="datatable2"><input type="checkbox" <%=!"".equals(hideCBClassName) ? "class='"+hideCBClassName+"' style='"+hideCBStr+"'" : "" %> name = "<%=module%>deleteRow" value ="<%=i%>"></td>
<% } %>					
<% 					
				for (int j=0; j < vKeysAction.size();j++) {
					String key = (String)vKeysAction.get(j);
					HashMap hTables = (HashMap)hStoreActions.get(key);	
			  		HashMap hReturnData = (HashMap)hTables.get(MasterForm.getModuleM().getTableName());
			  		HashMap hFieldProperty = new HashMap();
			  		
			  		/* start prepare key to update for MORE_CHILD_FlAG */
			  		HashMap hKeyForSearch = (HashMap) hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH);
			  		if(moreChildFlag && null!=hKeyForSearch){
			  			moreChildEditBtn = true;
				  		Vector vKeyForSearch = new Vector(hKeyForSearch.keySet());
			  			for(int m=0; m<vKeyForSearch.size(); m++){
			  				String fieldID = (String)vKeyForSearch.get(m);
			  				String valueKey = (String)hKeyForSearch.get(fieldID);
			  				keyForSearch += fieldID + "="+ valueKey;
			  				if (m < (vKeyForSearch.size()-1)) {
			  					keyForSearch += "&";
			  				}
			  			}
			  			System.out.println("### keyForSearch -> " + keyForSearch);
			  		}
		  			/* end prepare key to update for MORE_CHILD_FlAG */			  		
			  		
			  		/*-- start draw hidden field to contain value that be prompted to be updated --*/
					for (int k =0;k < vModelMs.size();k++ ) {
			  			ModuleFieldM  moduleFieldM = (ModuleFieldM)vModelMs.get(k);
			  			
			  			/* set fieldProperty to hashMap (used for JNUM, JMON, ...) */
			  			if(null != moduleFieldM.getObjProperty() && !"".equalsIgnoreCase(moduleFieldM.getObjProperty()) && !hFieldProperty.containsKey(moduleFieldM.getMfID())){
			  				hFieldProperty.put(moduleFieldM.getMfID(), moduleFieldM.getObjProperty());
			  			}
			  			
			  			if (!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) && !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType())) {
				  			String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,hReturnData,MasterForm.getHAllobjects());
				  			if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
				  				/* case -> have value in hiddenField as a temporary */
				  				/*
				  				* 19-02-2015
				  				* CPB : Defect ST000000000888
				  				*/
								//hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\""+strSearchResult+"\"> ");		  			
								hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\""+strSearchResult+"\"> ");		  			
				  			} else {
				  				/* case -> dont have value in hiddenField as a temporary */
								/*
				  				* 19-02-2015
				  				* CPB : Defect ST000000000888
				  				*/
								//hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\"\">");
								hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\"\">");
				  			}
			  			}
			  		}
					/*-- end draw hidden field to contain value that be prompted to be updated --*/
					
			  		for (int k =0;k < vShowColumns.size();k++ ) {
			  			ModuleFieldM  moduleFieldM = (ModuleFieldM)vShowColumns.get(k);
			  			String alignment = moduleFieldM.getAlignment();
			  			if  (alignment == null || ("".equals(alignment))) {
							alignment = "";
						}
						String objProperty = moduleFieldM.getObjProperty();
						if(MasterConstant.MONEY_FORMAT.equalsIgnoreCase(objProperty)){
							alignment = "right";
						}
						
						/*
						* FIX : 31-10-2014 : dependency
						*/
						HashMap desDLBHash = com.master.util.DynamicListUtil.getInstance().getDesDLBHash(vShowColumns, moduleFieldM, hTables,entityID,request,MasterForm);
			  			
						/*
						 * 23-06-2014 plug with access control V.1.0
						 * skip this field
						 */
						if(moduleFieldM.isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleFieldM.getAclMode())) {
							continue;
						}
			  			
			  			/*
						* 09-09-2014 FT027_HighlightRow
						*/
						if(moduleFieldM.isHighlight()) {
							continue;
						}
						
						/*
						* 01-10-2015 FT031_HideCheckboxMany
						*/
						if(moduleFieldM.isHideCB()) {
							continue;
						}
			  			
			  			String strSearchResult = "";
			  			if (!MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType())) {
			  				strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,hReturnData,MasterForm.getHAllobjects());

							// PCMS
					  		if(k==0 && ("ROWNUM".equals(moduleFieldM.getFieldID()) || "SEQ".equals(moduleFieldM.getFieldID()))) {
					  			strSearchResult = String.valueOf(i+1);
					  		}
			  			}
						
						//FT001_DESCDLB Sam feature show desc for DLB
			  			if (MasterConstant.DYNAMICLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) || MasterConstant.LISTBOX.equalsIgnoreCase(moduleFieldM.getObjType())) {
			  				strSearchResult = com.master.util.DynamicListUtil.getInstance().getDynamicDescByValue(moduleFieldM,strSearchResult,desDLBHash);
			  			}
			  			//End FT001_DESCDLB
			  			
			  			/* start pair of naming convention */
			  			String labelNamed = moduleFieldM.getModuleID() + "_" + moduleFieldM.getFieldID() + "_" + i + MasterConstant.NAMING.DISPLAY_FIELD;
						String htmlComponentNamed = moduleFieldM.getModuleID() + "_" + moduleFieldM.getFieldID() + "_" + i + MasterConstant.NAMING.EDITABLE_FIELD;
						/* end pair of naming convention */
						
						String classEditable = "";
						String linkTD = "";
						String linkEditInLine = "onclick=\"drawElementAjax('"+htmlComponentNamed +"','"+labelNamed +"','"+i+"', '"+moduleFieldM.getObjType()+"', '"+moduleFieldM.getModuleID()+"', '"+moduleFieldM.getFieldID()+"')\"";
												
						if (unEditInLine) {
							linkTD = "onClick=\"loadUpdateMany('"+module+"','"+i+"')\"";
							linkEditInLine = "";
						}
						
						if(linkEditInLine.indexOf("drawElementAjax") != -1) {
							classEditable = "eaf-inline-editable";
						}
						
						String nextEntityButton = "";
						//if(!MasterForm.isUnEditManyFlag() && !MasterUtil.empty(moduleFieldM.getNextEntityID())) {
						//	nextEntityButton = "<div class=\"addicon-many\" style=\"position:absolute; margin:-2px 5px 5px 5px\" name=\""+module+moduleFieldM.getMfID()+"ButtonRowET\" onClick=\"clickEditNextEntity('"+moduleFieldM.getNextEntityID()+"', '"+moduleFieldM.getNextTabID()+"', '"+module+"', "+i+")\" title='Edit'></div>";
						//}
						
						
			  			if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
			  					String buttonPopup = "";
			  					if (MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())) {
			  						HashMap hFieldProps = (HashMap)hAllObj.get(moduleFieldM.getObjType());
									PopupPropM prmPopupM = (PopupPropM)hFieldProps.get(moduleFieldM.getMfID());			  						 
			  						if (prmPopupM.getMapEntity() != null && !prmPopupM.getMapEntity().equalsIgnoreCase("") && (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(MasterForm.getProcessMode()))) {
			  							buttonPopup = "<input type=\"button\" name=\"go\" value=\"G\" onclick=\"saveEntityForGoEntityFromList('"+prmPopupM.getMapEntity()+"','"+strSearchResult+"','"+prmPopupM.getMapColumn()+"')\" >";
									}																																																		
								} 
				  				if (MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())) {
									if (strSearchResult != null && !"".equals(strSearchResult)) {
										String fieldID = moduleFieldM.getFieldID().replaceAll("__DESC", "");										
										HashMap hPopup = (HashMap)hAllObj.get(MasterConstant.POPUP);
										
										PopupPropM prmPopupM= (PopupPropM)hPopup.get(fieldID);																			
										if (prmPopupM != null ) {
											if (prmPopupM.getMapEntity() != null && !prmPopupM.getMapEntity().equalsIgnoreCase("") && (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(MasterForm.getProcessMode())) ) {
												String code = (String)hReturnData.get(fieldID);
												buttonPopup = "<input type=\"button\" name=\"go\" value=\"G\" onclick=\"saveEntityForGoEntityFromList('"+prmPopupM.getMapEntity()+"','"+code+"','"+prmPopupM.getMapColumn()+"')\" >";
											}
										}															
									}
				  				}			  					
			  					//strSearchResult = MasterUtil.generateDataFormatInManyRow(strSearchResult, moduleFieldM.getMfID(), hFieldProperty);
%>
							<%/* case -> have value in this td <-> display in the result dataTable */%>
							<td align="<%=alignment%>" class="datatable-many <%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" <%=linkTD%>>
								<%=nextEntityButton %>
								<%if(!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.ATTACHMENTLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.HIDDEN.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())
										// 000138
										&& !MasterConstant.UPLOAD.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterForm.isUnEditManyFlag()  && !hideEdit ){ %>
									<div id="<%=labelNamed %>" class="showElement <%=classEditable%>" <%=linkEditInLine%>  style="float: <%=alignment%>">										
											<% 
											/*
											* 25-09-2015
											* Fix alignment feature and Edit-in-Line feature style
											*/
											%>
<%-- 										<span title="<%=strSearchResult%>"><%=strSearchResult%></span>&nbsp;<%=buttonPopup%> --%>
											<span title="<%=strSearchResult%>" style="float: <%=alignment%>"><%=strSearchResult%></span>&nbsp;<%=buttonPopup%>
										<%if(MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())){ %>
											<input name="<%=MasterConstant.NAMING.POP_UP_MF_ID %>" type="hidden" value="<%=moduleFieldM.getMfID() %>"/>
										<%} %>
									</div>
									<div id="<%=htmlComponentNamed %>" class="hideElement"></div>
								<%
								/* start - 000138 */
								} else if(MasterConstant.UPLOAD.equalsIgnoreCase(moduleFieldM.getObjType())) { %>
									<%
									FT022_UploadFile ft022_UploadFile = new FT022_UploadFile();
									String linkToFile = ft022_UploadFile.generateLinkToFile(strSearchResult ,MasterForm, moduleFieldM.getMfID());
									%>
									<div id="<%=labelNamed %>" class="showElement">
										<span title="<%=strSearchResult%>"><%=linkToFile%></span>
									</div>	
								<%
								} else if(MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())) {
									FT022_UploadFile ft022_UploadFile = new FT022_UploadFile();
									String tagNoObj = ft022_UploadFile.checkGeneratePreviewButtonForMany(MasterForm, moduleFieldM, strSearchResult, hReturnData);
									%>
									<div id="<%=labelNamed %>" class="showElement"  style="float: <%=alignment%>">
										<span title="<%=strSearchResult%>"><%=tagNoObj%></span>&nbsp;<%=buttonPopup%>
									</div>
									<%
								/* end - 000138 */
								}else{ %>
									<div id="<%=labelNamed %>" class="showElement">
										<span title="<%=strSearchResult%>"><%=strSearchResult%></span>&nbsp;<%=buttonPopup%>
									</div>
								<%} %>
							</td>
<% 			  						  					
			  			} else {
%>
							<%/* case -> dont have value in this td <-> display in the result dataTable */%>
			  				<td align="<%=alignment%>" class="datatable-many <%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" <%=linkTD%> >
			  					<%=nextEntityButton %>
			  					<%if(!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
			  							&& !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.ATTACHMENTLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.HIDDEN.equalsIgnoreCase(moduleFieldM.getObjType()) 
										// 000138
										&& !MasterConstant.UPLOAD.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterForm.isUnEditManyFlag() && !hideEdit){ %>
				  					<div id="<%=labelNamed %>" class="showElement <%=classEditable%>" <%=linkEditInLine%> <% %> style="float: <%=alignment%>">
				  						<% 
										/*
										* 25-09-2015
										* Fix alignment feature and Edit-in-Line feature style
										*/
										%>
				  						<span style="float: <%=alignment%>">&nbsp;</span>&nbsp;
				  						<%if(MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())){ %>
											<input name="<%=MasterConstant.NAMING.POP_UP_MF_ID %>" type="hidden" value="<%=moduleFieldM.getMfID() %>"/>
										<%} %>
									</div>
									<div id="<%=htmlComponentNamed %>" class="hideElement"></div>
				  				<%}else{ %>
					  				<div id="<%=labelNamed %>" class="showElement">
										<span>&nbsp;</span>
									</div>
				  				<%} %>
			  				</td>
<% 
			  			}
			  		}
			  	}
%>
<% if (((!MasterForm.isUnEditManyFlag() && (!hideEdit)) && (!unEditInLine)) || "Y".equals(isAlwaysShowEditBtn)) {%>	 					
					<td class="datatable2 <%=MasterForm.getModuleM().getModuleID()%>_edit_button_col">
						<div id="<%=MasterForm.getModuleM().getModuleID() + "_BUTTON_EDIT_"+i%>" class="showElement">
		<%if(moreChildFlag){
			if(moreChildEditBtn || "Y".equals(isAlwaysShowEditBtn)){
		%>
							<div class="addicon-many" name="<%=module%><%=module%>ButtonRowET" onClick="saveEntityForUpdateChildEntity('<%=nextEntityID%>','<%=nextTabID%>','<%=keyForSearch%>')" ></div>
			<%}else{%>
						<div class="showElement"></div>
		<%	}
		}else{%>
							<div class="addicon-many" name="<%=module%>ButtonRow" onClick="loadUpdateMany('<%=module%>','<%=i%>')" ></div>
		<%}%>
						</div>					
					</td>
<% } %>					
				</tr>
<% 
			}
%>			
			</tbody>
			</table>
			<div id="totalManyID" class="totalManyClass" ></div>
			<%=hiddenField.toString()%>
			</div>

<%
	/*-- start get manual js path --*/
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(MasterForm.getModuleM().getModuleActions(),form.getCurrentMode());
	if (moduleActionM.getManyScriptFile() != null && !"".equals(moduleActionM.getManyScriptFile())) {
%>
		<script type="text/javascript" src="<%=moduleActionM.getManyScriptFile()%>"></script>
<%
	}
%>
<script type="text/javascript">
function selectedAllCheckBox(moduleID){

	/*
	* 01-10-2015 FT031_HideCheckboxMany
	*/
	//if($("[name='"+moduleID+"checkAll']").is(":checked")){
	//	$("[name='"+moduleID+"deleteRow']").attr('checked',true);
	//}
	//else{
	//	$("[name='"+moduleID+"deleteRow']").attr('checked',false);
	//}
	
	var isChecked = $("[name='"+moduleID+"checkAll']").is(":checked");
	$("[name='"+moduleID+"deleteRow']").each(function () {
		if(!$(this).attr('disabled') && !$(this).hasClass('search-tr-hide-cb')) {
			$(this).attr('checked', isChecked);
		}
	});
}
</script>
<style>
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, form.getCurrentMode()) %>
</style>
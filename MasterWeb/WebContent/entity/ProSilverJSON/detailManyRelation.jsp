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
	com.master.util.Log4jUtil.log("detailManyRelation.jsp");
	boolean hideEdit = false;
	boolean unEditInLine = false;
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
	
	/**************************************************************/
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID + "_session";
	com.master.util.Log4jUtil.log("entitySession ==> " + entitySession);
	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	com.master.util.Log4jUtil.log("form==> " + form);
	com.master.util.Log4jUtil.log("entityTabs==> " + entityTabs);
	
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
		com.master.util.Log4jUtil.log("entityTabs.size() -> " + entityTabs.size());
		for(int i=0; i<entityTabs.size(); i++) {
			EntityTabM entityTabM = (EntityTabM)entityTabs.get(i);
			TabM tabM = (TabM) hTabs.get(entityTabM.getTabID());
			
			com.master.util.Log4jUtil.log("getTabID[" + i + "] -> " + tabM.getTabID());
			Vector tabModuleMs = tabM.getTabModuleMs();
			if(0 != tabModuleMs.size()){
				com.master.util.Log4jUtil.log("tabModuleMs.size() -> " + tabModuleMs.size());
				for(int j=0; j<tabModuleMs.size(); j++){
					TabMouleM tabModuleM = (TabMouleM) tabModuleMs.get(j);
					com.master.util.Log4jUtil.log("tabModuleM.getModuleID()===>"+tabModuleM.getModuleID());
					com.master.util.Log4jUtil.log("module===>"+module);				
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
	//com.master.util.Log4jUtil.log(" SAM force this theme no checkbox many");
	
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	HashMap hAllObj =  MasterForm.getHAllobjects();

	int totalWidth = 93/vShowColumns.size();
	Vector vStoreActions  = (Vector)MasterForm.getStoreActionList();
	com.master.util.Log4jUtil.log("vStoreActions ===> " + vStoreActions);
	Vector vModelMs = (Vector)MasterForm.getVMasterModelMs();
	StringBuffer hiddenField = new StringBuffer();
%>

<%if(MasterForm.getModuleM().isInsertOnTableFlag()){ %>
<jsp:include flush="true" page="many/insertFieldMany.jsp"/>
<%} %>

<input type ="hidden" name = "<%=MasterForm.getModuleM().getModuleID()%>_orderBy" value = "">
<input type ="hidden" name = "<%=MasterForm.getModuleM().getModuleID()%>_orderByType" value = "">


<jsp:include flush="true" page="many/filterMany.jsp"/>

<% if (!MasterForm.isUnEditManyFlag()) {%>
<div id="module-many-button" style="width:100%" class="module-many-button" >
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
		width: 750,
		autoOpen: false,
		height: 500,
		title: '<%=MasterForm.getModuleM().getModuleName()%>'
	});
	<%boolean oldDate = com.avalant.feature.ExtendFeature.getInstance().useFeature("OLD_DATE");
		if(oldDate){
	%>
	$('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').bind('dialogclose', function(event) {
	     try{
	     	hideCalendar();
	     }catch(e){}
	 });
	 <%}%>
});
</script>


<div id="module-many-pagging">
<% 
	if (MasterForm.getModuleM().isPagingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) { 
%>
<jsp:include flush="true" page="paggingMany.jsp"/>
<% 
	}
%>
</div>
<% 
	if (MasterForm.getModuleM().isOrderingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
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
					
					<td width = "3%" height="19" class="headtable1" ></td>
<%} %>     
<%
for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);

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
<%if(vStoreActions.size()>0 && ((!MasterForm.isUnEditManyFlag()) && (!hideEdit)) && (!unEditInLine) ){ %>
					<td class="headtable1"><div style="display: block; width: 30px" ></div></td>
<%} %>
				</tr>
				
<%if(vStoreActions.size()==0){ %>
				<tr class="gumaygrey2" onmouseover="this.className='gumaygrey2'" onmouseout="this.className='gumaygrey2'">
					<td align="center" colspan="<%=vShowColumns.size()+1 %>">
						<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_ADD") %></span>
					</td>
				</tr>
<%} %>
<%
			//FT001_DESCDLB Sam feature show desc for DLB
			HashMap desDLBHash = com.master.util.DynamicListUtil.getInstance().getDesDLBHash(vShowColumns,entityID,request,MasterForm);
			//com.master.util.Log4jUtil.log("desDLBHash : " + desDLBHash);
			//End FT001_DESCDLB
			
			for (int i= 0;i < vStoreActions.size();i++) {
				String keyForSearch = "";
				HashMap hStoreActions = (HashMap)vStoreActions.get(i);
				Vector vKeysAction = new Vector(hStoreActions.keySet());
				boolean moreChildEditBtn = false;
				hiddenField.append("<input type =\"hidden\" name=\""+module+"_ROW_STATUS\" value =\""+(String)vKeysAction.get(0)+"\" >");
%>
				<tr class="<%=((i%2)==0)? "gumaygrey2" : "gumaygrey2" %>" onmouseover="this.className='gumaygrey2'" onmouseout="<%=((i%2)==0)? "this.className='gumaygrey2'" : "this.className='gumaygrey2'"%>">
<% if (!MasterForm.isUnEditManyFlag()) {%>					
					<td width ="3%" class="datatable2"><input type = "checkbox" name = "<%=module%>deleteRow" value ="<%=i%>"></td>
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
			  			com.master.util.Log4jUtil.log("### keyForSearch -> " + keyForSearch);
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
				  				hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\""+strSearchResult+"\"> ");		  			
				  			} else {
				  				/* case -> dont have value in hiddenField as a temporary */
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
			  			
			  			String strSearchResult = "";
			  			if (!MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType())) {
			  				strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,hReturnData,MasterForm.getHAllobjects());
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
						
						String linkTD = "";
						String linkEditInLine = "onclick=\"drawElementAjax('"+htmlComponentNamed +"','"+labelNamed +"','"+i+"', '"+moduleFieldM.getObjType()+"', '"+moduleFieldM.getModuleID()+"', '"+moduleFieldM.getFieldID()+"')\"";
												
						if (unEditInLine) {
							linkTD = "onClick=\"loadUpdateMany('"+module+"','"+i+"')\"";
							linkEditInLine = "";
						}
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
			  					strSearchResult = MasterUtil.generateDataFormatInManyRow(strSearchResult, moduleFieldM.getMfID(), hFieldProperty);
%>
							<%/* case -> have value in this td <-> display in the result dataTable */%>
							<td align="<%=alignment%>" class="datatable-many <%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" <%=linkTD%>>
								<%if(!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.ATTACHMENTLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.HIDDEN.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterForm.isUnEditManyFlag()  && !hideEdit ){ %>
									<div id="<%=labelNamed %>" class="showElement" <%=linkEditInLine%>>										
										<span title="<%=strSearchResult%>"><%=strSearchResult%></span>&nbsp;<%=buttonPopup%>
										<%if(MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())){ %>
											<input name="<%=MasterConstant.NAMING.POP_UP_MF_ID %>" type="hidden" value="<%=moduleFieldM.getMfID() %>"/>
										<%} %>
									</div>
									<div id="<%=htmlComponentNamed %>" class="hideElement"></div>
									
								<%}else{ %>
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
			  					<%if(!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
			  							&& !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.ATTACHMENTLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.HIDDEN.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterForm.isUnEditManyFlag() && !hideEdit){ %>
				  					<div id="<%=labelNamed %>" class="showElement" <%=linkEditInLine%> >
				  						<span>&nbsp;</span>&nbsp;
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
<% if ((!MasterForm.isUnEditManyFlag() && (!hideEdit)) && (!unEditInLine)) {%>	 					
					<td class="datatable2">
						<div id="<%=MasterForm.getModuleM().getModuleID() + "_BUTTON_EDIT_"+i%>" class="showElement">
		<%if(moreChildFlag){
			if(moreChildEditBtn){
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


<style type="text/css">
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, form.getCurrentMode()) %>
</style>
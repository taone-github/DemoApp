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
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	HashMap hAllObj =  MasterForm.getHAllobjects();

	int totalWidth = 93/vShowColumns.size();
	Vector vStoreActions  = (Vector)MasterForm.getStoreActionList();
	System.out.println("vStoreActions ===> " + vStoreActions);
	Vector vModelMs = (Vector)MasterForm.getVMasterModelMs();
	StringBuffer hiddenField = new StringBuffer();
%>

<input type ="hidden" name = "<%=MasterForm.getModuleM().getModuleID()%>_orderBy" value = "">
<input type ="hidden" name = "<%=MasterForm.getModuleM().getModuleID()%>_orderByType" value = "">

<TABLE width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr> 
<%
	Vector vFilters = MasterForm.getFilterFields();	
	if (vFilters.size() >0  && MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(form.getCurrentMode()) ) {		
%>
	<tr>
	<td colspan="4">
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
	</td>
	</tr>
<tr><td colspan="4">&nbsp;</td></tr>	
<% 
	}
%>	
	<tr>
		<td align="left" > 
<% if (!MasterForm.isUnEditManyFlag()) { %>				
			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
			<jsp:param name="action" value="SUB_SEARCH"/>
			</jsp:include>
<% } %>			
		</td>
		<td colspan="3" width ="95%">
<% 
	if (MasterForm.getModuleM().isPagingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) { 
%>
<jsp:include flush="true" page="paggingMany.jsp"/>
<% 
	}
%>

<% 
	if (MasterForm.getModuleM().isOrderingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
		MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) { 
%>
<jsp:include flush="true" page="../orderingManyEventScript.jsp"/>
<% 
	}
%>

		</td>
	</tr>	
	<tr height="19">
		<td colspan="4" valign="top">
			<div id="<%=module%>Many" align="center" class="manyRowDiv" style="width: <%=moduleWidth%>%; height: <%=moduleHeight%>px;">  
			<table width="100%" cellpadding="1" cellspacing="0" align="center" >
				<thead>
				<tr>
<%if((vStoreActions.size()>0  && (!MasterForm.isUnEditManyFlag())))  { %>
					
					<th width = "3%" height="19" class="TableHeaderList"></th>
<%} %>
					<th width = "4%" height="19" class="TableHeaderList"><%=MessageResourceUtil.getTextDescription(request, "WORDING.ITEM_NO") %></th>       
<%
for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);

%>      
					<th class="TableHeaderList <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header" >
<%
			if (MasterForm.getModuleM().isOrderingFlag() && MasterForm.getModuleM().isViewModeFlag() && 
					MasterConstant.PROCESS_MODE_UPDATE.equals(form.getCurrentMode())) {
%>
						<div class="orderColumnDiv" id = "orderColumnDivID" >
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<div class="TableHeaderList"><%=MasterUtil.displayFieldName(moduleM,request)%></div>
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
						<%=MasterUtil.displayFieldName(moduleM,request)%>
<%
			}
%>						
					</th>
<% 
 }
%>
<%if(vStoreActions.size()>0 && ((!MasterForm.isUnEditManyFlag()) && (!hideEdit)) && (!unEditInLine) ){ %>
					<th class="TableHeaderList"><div style="display: block; width: 30px" ></div></th>
<%} %>
				</tr>
				</thead>
				<tbody>
				
<%if(vStoreActions.size()==0){ %>
				<tr class="ROW" onmouseover="this.className='ROW_HOVER'" onmouseout="this.className='ROW'">
					<td align="center" colspan="<%=vShowColumns.size()+1 %>">
						<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_ADD") %></span>
					</td>
				</tr>
<%} %>
<%
			for (int i= 0;i < vStoreActions.size();i++) {
				String keyForSearch = "";
				HashMap hStoreActions = (HashMap)vStoreActions.get(i);
				Vector vKeysAction = new Vector(hStoreActions.keySet());
				hiddenField.append("<input type =\"hidden\" name=\""+module+"_ROW_STATUS\" value =\""+(String)vKeysAction.get(0)+"\" >");
%>
				<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='ROW'" : "this.className='ROW_ALT'"%>">
<% if (!MasterForm.isUnEditManyFlag()) { %>					
					<td width ="3%" ><input type = "checkbox" name = "<%=module%>deleteRow" value ="<%=i%>"> </td>
<% } %>					
					<td width ="4%" height="19" align ="center" ><%=(i+1)%></td>
<% 					
				for (int j=0; j < vKeysAction.size();j++) {
					String key = (String)vKeysAction.get(j);
					HashMap hTables = (HashMap)hStoreActions.get(key);	
			  		HashMap hReturnData = (HashMap)hTables.get(MasterForm.getModuleM().getTableName());
			  		HashMap hFieldProperty = new HashMap();
			  		
			  		/* start prepare key to update for MORE_CHILD_FlAG */
			  		if(moreChildFlag){
				  		HashMap hKeyForSearch = (HashMap) hReturnData.get(MasterConstant.HASHMAP_KEY_FOR_SEARCH);
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
			  						
%>
							<%/* case -> have value in this td <-> display in the result dataTable */%>
							<td align="<%=alignment%>" class="<%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" <%=linkTD%>>
								<%if(!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.ATTACHMENTLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.HIDDEN.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterForm.isUnEditManyFlag()  && !hideEdit ){ %>
									<div id="<%=labelNamed %>" class="showElement" <%=linkEditInLine%>>										
										<a href="javascript:void(0)"><%=MasterUtil.generateDataFormatInManyRow(strSearchResult, moduleFieldM.getMfID(), hFieldProperty)%></a>&nbsp;<%=buttonPopup%>
										<%if(MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())){ %>
											<input name="<%=MasterConstant.NAMING.POP_UP_MF_ID %>" type="hidden" value="<%=moduleFieldM.getMfID() %>"/>
										<%} %>
									</div>
									<div id="<%=htmlComponentNamed %>" class="hideElement"></div>
									
								<%}else{ %>
									<div id="<%=labelNamed %>" class="showElement">
										<a href="javascript:void(0)" ><%=MasterUtil.generateDataFormatInManyRow(strSearchResult, moduleFieldM.getMfID(), hFieldProperty)%></a>&nbsp;<%=buttonPopup%>
									</div>
								<%} %>
							</td>
<% 			  						  					
			  			} else {
%>
							<%/* case -> dont have value in this td <-> display in the result dataTable */%>
			  				<td align="<%=alignment%>" class="<%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" <%=linkTD%> >
			  					<%if(!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
			  							&& !MasterConstant.MULTISELLIST.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.ATTACHMENTLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.HIDDEN.equalsIgnoreCase(moduleFieldM.getObjType()) 
										&& !MasterConstant.NOT_OBJECT.equalsIgnoreCase(moduleFieldM.getObjType())
										&& !MasterForm.isUnEditManyFlag() && !hideEdit){ %>
				  					<div id="<%=labelNamed %>" class="showElement" <%=linkEditInLine%> >
				  						<a href="javascript:void(0)">&nbsp;</a>&nbsp;
				  						<%if(MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())){ %>
											<input name="<%=MasterConstant.NAMING.POP_UP_MF_ID %>" type="hidden" value="<%=moduleFieldM.getMfID() %>"/>
										<%} %>
									</div>
									<div id="<%=htmlComponentNamed %>" class="hideElement"></div>
				  				<%}else{ %>
					  				<div id="<%=labelNamed %>" class="showElement">
										<a href="javascript:void(0)" >&nbsp;</a>
									</div>
				  				<%} %>
			  				</td>
<% 
			  			}
			  		}
			  	}
%>
<% if ((!MasterForm.isUnEditManyFlag() && (!hideEdit)) && (!unEditInLine)) {%>	 					
					<td>
						<div id="<%=MasterForm.getModuleM().getModuleID() + "_BUTTON_EDIT_"+i%>" class="showElement">
		<%if(moreChildFlag){%>
							<input class="simpleButton" type="button" value="ET" name="<%=module%>ButtonRowET" onClick="saveEntityForUpdateChildEntity('<%=nextEntityID%>','<%=nextTabID%>','<%=keyForSearch%>')"/>
			<%}else{%>
							<input class="simpleButton" type="button" value="Edit" name="<%=module%>ButtonRow" onClick="loadUpdateMany('<%=module%>','<%=i%>')"/>
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
			<div id= "totalManyID" class ="totalManyClass" ></div>
			<%=hiddenField.toString()%>
			
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="4"><div class="componentSpacerDiv">&nbsp;</div></td>
	</tr>
</TABLE>
<%
	/*-- start get manual js path --*/
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(MasterForm.getModuleM().getModuleActions(),form.getCurrentMode());
	if (moduleActionM.getManyScriptFile() != null && !"".equals(moduleActionM.getManyScriptFile())) {
%>
		<SCRIPT language="JavaScript" src="<%=moduleActionM.getManyScriptFile()%>"></SCRIPT>
<%
	}
%>


<style>
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, form.getCurrentMode()) %>
</style>

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
						if(MasterConstant.ENTITY_RELATION_TYPE_MANY.equalsIgnoreCase(tabModuleM.getRelationType())){
							if (tabModuleM.getModuleID().equalsIgnoreCase(module)) {
							System.out.println("getHeight[" + j + "] -> " + tabModuleM.getHeight());
							System.out.println("getWidth[" + j + "] -> " + tabModuleM.getWidth());
							moduleHeight = Integer.toString(tabModuleM.getHeight());
							moduleWidth = Integer.toString(tabModuleM.getWidth());
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
%>

<TABLE width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
    <td colspan="4">&nbsp;</td>
   </tr>
   <tr>
    <td align="left" > 
	<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
	<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
	<jsp:param name="action" value="SUB_SEARCH"/>
	</jsp:include>        
    </td>
    <td colspan="3" width ="95%">
    </td>
  </tr> 
  <tr>
    <td colspan="4" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr class="h3Row">
     <td width = "3%"></td>   
     <td width = "4%">No</td>       
<%
int totalWidth = 93/vShowColumns.size();
Vector  vStoreActions  = (Vector)MasterForm.getStoreActionList();
Vector vModelMs = (Vector)MasterForm.getVMasterModelMs();
StringBuffer hiddenField = new StringBuffer();
for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vShowColumns.get(i);

%>      
        <td class="<%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header"><%=MasterUtil.displayFieldName(moduleM,request)%></td>
<% 
 }
%>
      </tr>
      </table>
	<div id="<%=module%>Many" align="center" style="SCROLLBAR-FACE-COLOR: #d0d0d0; SCROLLBAR-HIGHLIGHT-COLOR: #d0d0d0;overflow: auto; SCROLLBAR-SHADOW-COLOR: #CCCCCC; COLOR: #d0d0d0; SCROLLBAR-3DLIGHT-COLOR: #FAFAFA; SCROLLBAR-ARROW-COLOR: black; SCROLLBAR-DARKSHADOW-COLOR: #CCCCCC; width: <%=moduleWidth%>%; height: <%=moduleHeight%>px;">     	
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
<% 			

			for (int i= 0;i < vStoreActions.size();i++) {
				HashMap hStoreActions = (HashMap)vStoreActions.get(i);
				Vector vKeysAction = new Vector(hStoreActions.keySet());
				hiddenField.append("<input type =\"hidden\" name=\""+module+"_ROW_STATUS\" value =\""+(String)vKeysAction.get(0)+"\" >");
%>							
				<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='ROW'" : "this.className='ROW_ALT'"%>">
				<td width ="3%" ><input type = "checkbox" name = "<%=module%>deleteRow" value ="<%=i%>"> </td>
				<td width ="4%" class="listViewPaginationTdS2" align ="center" ><%=(i+1)%></td>
<% 					
				for (int j=0; j < vKeysAction.size();j++) {
					String key = (String)vKeysAction.get(j);
					HashMap hTables = (HashMap)hStoreActions.get(key);								
			  		
			  		HashMap hReturnData = (HashMap)hTables.get(MasterForm.getModuleM().getTableName());
			  		for (int k =0;k < vShowColumns.size();k++ ) {
			  			ModuleFieldM  moduleFieldM = (ModuleFieldM)vShowColumns.get(k);
			  			String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,hReturnData,MasterForm.getHAllobjects());
			  			if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
		  					String buttonPopup = "";
		  					if (MasterConstant.POPUP.equalsIgnoreCase(moduleFieldM.getObjType())) {
		  						//MasterDAO dao = MasterDAOFactory.getMasterDAO();
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
			  				}			  			%>			  			
			  				<td align="center" class="bu2 <%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" ><a  href="javascript:void(0)" onclick="loadUpdateMany('<%=module%>','<%=i%>')" > <%=strSearchResult%></a>&nbsp;<%=buttonPopup%> </td>				
<% 
			  			} else {
%>
			  				<td align="center" class="bu2 <%=moduleFieldM.getModuleID()%>_<%=moduleFieldM.getFieldID()%>_col" ><a  href="javascript:void(0)" onclick="loadUpdateMany('<%=module%>','<%=i%>')" >&nbsp;</a></td>
<% 
			  			}
			  		}			  		
		  			for (int k =0;k < vModelMs.size();k++ ) {
			  			ModuleFieldM  moduleFieldM = (ModuleFieldM)vModelMs.get(k);
			  			if (!MasterConstant.CHECKBOX.equalsIgnoreCase(moduleFieldM.getObjType())) {
				  			String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,hReturnData,MasterForm.getHAllobjects());
				  			if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
				  				hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\""+strSearchResult+"\"> ");		  			
				  			} else {
								hiddenField.append("<input type=\"hidden\" name =\""+moduleFieldM.getModuleID()+"_"+moduleFieldM.getFieldID()+"\" value =\"\">");
				  			}	
			  			}	
			  		}			  		
			  			
			  	}
%>			  	
				</tr>			
<% 
			} 		
%>			  			  				        
			</table>
			<%=hiddenField.toString()%>
	
	</div>
</td>
  </tr>
</TABLE>
<script language="javascript">
	<%/* start manyRelation function */%>
	function <%=module%>Delete() {
		var num = 0;
		var allList ='';
		try {
			if (document.masterForm.<%=module%>deleteRow.checked == true ) {
				allList = 'deleteRow='+ document.masterForm.<%=module%>deleteRow.value+'&';
			}
			num = document.masterForm.<%=module%>deleteRow.length;
			for (i=0;i < num ;i++) {
				 if (document.masterForm.<%=module%>deleteRow[i].checked == true ) {
				 	allList = allList+'deleteRow=' + document.masterForm.<%=module%>deleteRow[i].value+'&';
				 }
			}
		} catch(e){}		
		if (allList != '') {
			ajax("<%=request.getContextPath()%>/ProcessManyRowServlet?module=<%=module%>&"+allList+"process=<%=com.master.util.MasterConstant.PROCESS_MODE_INSERT%>",<%=module%>CreateRow); 
		}
	}
	    	
	function <%=module%>CreateRow(data) {
		try {
			objMany = window.masterForm.document.getElementById("<%=module%>Many");
			objMany.innerHTML = data;
		} catch(e) {
			alert(e);
		}
	}
		
	<%/* end manyRelation function */%>
	</script>
	
<style>
<%=MasterUtil.generateCustomStyle(vShowColumns, form, MasterForm, MasterForm.getProcessMode()) %>
</style>

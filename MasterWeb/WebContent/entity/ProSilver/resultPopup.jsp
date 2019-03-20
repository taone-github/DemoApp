<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
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
<%@page import="com.master.model.ModuleActionM"%>
<%@ page import="com.master.util.MasterConstant"%>
<jsp:useBean id="hDependency" scope="session" class="java.util.HashMap" />
<% 
	String moduleIDForAction = (String)request.getSession().getAttribute("moduleIDForAction");
	String rowID = (String)request.getSession().getAttribute("rowID");
	String objName = (String)request.getSession().getAttribute("objName");
	
	MasterFormHandler mainForm = (MasterFormHandler)request.getSession().getAttribute(moduleIDForAction+"_session");
	String entityID = (String)request.getSession().getAttribute("entityIDForList");
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
		request.getSession().setAttribute(moduleSession, MasterForm);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(moduleSession);
	
	String popupFlag = (String) request.getSession().getAttribute("popupFlag");
	String mfIDForAction = (String) request.getSession().getAttribute("mfIDForAction");
	String fieldIDForAction = (String) request.getSession().getAttribute("fieldIDForAction");
	
%>

<%@page import="com.master.model.PopupPropM"%>
<%@page import="com.master.util.ObjectCloner"%>
<%@page import="com.master.model.PopupColNameM"%>
<input type ="hidden" name = "popupFlag" value = "<%=popupFlag%>">
<input type ="hidden" name = "mfID" value = "<%=mfIDForAction%>">
<input type ="hidden" name = "fieldID" value = "<%=fieldIDForAction%>">
<input type ="hidden" name = "entityIDForList" value = "<%=entityID%>">
<input type ="hidden" name = "moduleIDForAction" value = "<%=moduleIDForAction%>">
<input type ="hidden" name = "page" value = "<%=MasterForm.getPage()%>">
<input type ="hidden" name = "volumePerPage" value = "<%=MasterForm.getVolumePerPage()%>">
<input type ="hidden" name = "loadUpdateValue" value = "">
<input type ="hidden" name = "orderBy" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderBy())%>">
<input type ="hidden" name = "orderByType" value = "<%=DisplayFormatUtil.displayHTML(MasterForm.getSearchOrderByType())%>">
<input type ="hidden" name = "rowID" value = "<%=rowID %>">
<input type ="hidden" name = "objName" value = "<%=objName %>">

<%
//---- dependecy field ------ 
String strDependency = "";
Vector vDependency = new Vector(hDependency.keySet());
for (int j=0; j < vDependency.size();j++) {
	String strValue = (String) hDependency.get(vDependency.get(j));
	if (strValue== null) strValue ="";
	strDependency = strDependency +"<input type=\"hidden\" name=\""+vDependency.get(j)+"\" value=\""+DisplayFormatUtil.forHTML(strValue)+"\" >";
}
%>
<%=strDependency%>


<%
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	String objName_DESC = objName + "_DESC";
	if(null != rowID && !"".equalsIgnoreCase(rowID)){
		objName = objName + "[" + rowID + "]";
		objName_DESC = objName_DESC + "[" + rowID + "]";
	}
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center" class="manyRowDiv" style="width: 100%; height: 233px;">
				<table width="100%" cellpadding="1" cellspacing="1" align="center">
					<thead>
					<tr  height="19"> 
					<% 
						HashMap hAllObj = (HashMap)mainForm.getHAllobjects();
						HashMap hFieldProps = (HashMap)hAllObj.get(MasterConstant.POPUP);
						PopupPropM popupPropM = (PopupPropM)ObjectCloner.deepCopy(hFieldProps.get(mfIDForAction));
						Vector vPopColumns = popupPropM.getVPopupColMs(); 	
						for (int i=0;i < vPopColumns.size();i++) {	
							PopupColNameM popupColNameM = (PopupColNameM)vPopColumns.get(i);
							%>
							<th align="center" height="19" class="tableHeader <%=MasterForm.getModuleM().getModuleID()%>_<%=popupColNameM.getMfID()%>_header"><%=popupColNameM.getShowName()%> </th>
							<%
						}
					%>
					</tr>
					</thead>
					<tbody>
					
					<%if(vShowSearchRecs.size()==0){ %>
					<tr colspan="<%=vShowSearchRecs.size()+1%>">
						<td align="center" colspan="<%=(vPopColumns.size()+1)%>" >
							<span><%=MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_NO_DATA_FOUND") %></span>
						</td>
					</tr>
					<%} %>
					
					<%
					for (int j=0;j < vShowSearchRecs.size();j++) {
						HashMap hReturnData = (HashMap)vShowSearchRecs.get(j);
						%>
						<tr class="<%=((j%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'"; onmouseout="this.className='<%=((j%2)==0)? "ROW" : "ROW_ALT" %>'";>
						<%
						
						for (int k=0;k < vPopColumns.size();k++) {	
							PopupColNameM popupColNameM = (PopupColNameM)vPopColumns.get(k);
							String strSearchResult = "&nbsp;";
							if (hReturnData.get(popupColNameM.getColName()) != null ) {
								strSearchResult = DisplayFormatUtil.addSlashAtFrontOfSpecialChar(MasterUtil.getInstance().replaceSingleCode((String)hReturnData.get(popupColNameM.getColName())));
							}
							if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
							%>
								<td align="center" class="bu2 <%=MasterForm.getModuleM().getModuleID()%>_<%=popupColNameM.getMfID()%>_col"><a href="Javascript:selectitem<%=j%>();"><%=strSearchResult%></a></td>
							<%	
							} else {
							%>
								<td align="center" class="bu2 <%=MasterForm.getModuleM().getModuleID()%>_<%=popupColNameM.getMfID()%>_col">&nbsp;</td>
							<%	
							}
						}
						
						String mapColumn = popupPropM.getMapColumn();
						if (popupPropM.getMapColumn().indexOf(".")!=-1) {
							mapColumn = popupPropM.getMapColumn().substring(popupPropM.getMapColumn().indexOf(".")+1,popupPropM.getMapColumn().length());
						}	
						mapColumn = mapColumn.toUpperCase();
						%>
						</tr>
						<script type="text/javascript">
							function selectitem<%=j%>() { try {
								window.opener.document.masterForm.<%=objName%>.value = '<%=DisplayFormatUtil.displayHTML((String)hReturnData.get(mapColumn))%>';
								window.opener.document.masterForm.<%=objName_DESC%>.value = "<%=DisplayFormatUtil.displayHTML((String)hReturnData.get(popupPropM.getMapDescription().toUpperCase()))%>";
								if(!window.opener.document.masterForm.<%=objName_DESC%>.disabled){
									window.opener.document.masterForm.<%=objName_DESC%>.focus();
								}
								if(window.opener.<%=moduleIDForAction%>dependencyaction<%=fieldIDForAction%>){
									window.opener.<%=moduleIDForAction%>dependencyaction<%=fieldIDForAction%>();
								}
								try {
									window.opener.<%=moduleIDForAction%>PopupManualJS(); 
								} catch(e) { }
								try {
									eval('window.opener.<%=objName %>PopupManualJS()');
								} catch(e) { }							
								window.close(); } catch(e) {alert(e.description);}
							}
						</script>
						<%
					}
					%>
					</tbody>
				</table>
				&nbsp;
			</div>
		</td>
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
				if (allPage != MasterForm.getPage()){	
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
	<tr>
		<td colspan="4" align="center">
			<input type ="button" name ="close" value ="Close" class="button_style_1"  onclick = "closeWindow()">
		</td>
	</tr> 
</table>
</table>

<% 
	EntityM entityM = form.getEntityM();
	ArrayList entityActions = entityM.getEntityActions();
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityActions,MasterConstant.MULTI_SELECTION);
	if (moduleActionM.getScriptFile()!= null && !"".equals(moduleActionM.getScriptFile())) {
%>	
		<script type="text/javascript" src="<%=moduleActionM.getScriptFile()%>"></script>	
<% 		
	}
%>

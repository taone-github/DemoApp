<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.master.model.TabM" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.model.EntityTabM" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.master.util.MasterConstant"%>

<% 
	String popupFlag = (String) request.getSession().getAttribute("popupFlag");
	String entityID = (String)request.getSession().getAttribute("entityIDForList");
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}		
	com.master.util.Log4jUtil.log("form.getMainModuleID()==>"+form.getMainModuleID());
	String moduleSession = form.getMainModuleID() +"_session";
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

<form name ="masterForm" action="FrontController" method="post">
<input type ="hidden" name = "action" value="searchMaster">
<input type ="hidden" name = "handleForm" value = "Y">
<input type = "hidden"  name="sessionForm" value ="">
<table width="100%" border="0" align="center" >
<tr>
<TD colspan="4">
&nbsp;
</TD>
</tr> 
<% 	
	//Sam add general tab
	String listOnTab = (String)request.getSession().getAttribute(MasterConstant.EAF_SESSION.LIST_MANY_TAB);
	if(null!=listOnTab){
		com.master.util.Log4jUtil.log(" ----------- Sam check ListMany ------------ : " + listOnTab);
		Vector entityTabs =  form.getEntityM().getEntityTabs();
		com.master.util.Log4jUtil.log("form==>"+form);
		com.master.util.Log4jUtil.log("entityTabs==>"+entityTabs);
		HashMap hTabs = form.getTabHasMap();
		com.master.util.Log4jUtil.log("hTabs -> " + hTabs);
		ArrayList generalTabList = MasterUtil.getGeneralTab(entityTabs, hTabs);
		String currentGeneralTab = "";
		
		Vector previousGeneralTabList = (Vector) request.getSession().getAttribute("generalTabList_session");
		com.master.util.Log4jUtil.log("previousGeneralTabList -> " + previousGeneralTabList);
%>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" width="100%" align="right">
				<tr>
					<td>
<%	if((null != previousGeneralTabList && previousGeneralTabList.size() > 0) && (null == generalTabList || generalTabList.size() == 0)){%>
						<div id="GeneralNavigator" class="general_Nav">
						
<%	}else{%>
						<div id="subNavigator" class="child_Nav">
<%	}%>
							<ul>
<%
			/* start launch list of general tab */
			if((null != previousGeneralTabList && previousGeneralTabList.size() > 0) && (null == generalTabList || generalTabList.size() == 0)){
				for(int i=0; i<previousGeneralTabList.size(); i++){
					TabM previousGeneralTabM = new TabM();
					previousGeneralTabM = (TabM) previousGeneralTabList.get(i);
					com.master.util.Log4jUtil.log("getTabID -> " + previousGeneralTabM.getTabID());
					com.master.util.Log4jUtil.log("getTabName -> " + previousGeneralTabM.getTabName());
%>
								<li class="current blur" id="<%=previousGeneralTabM.getTabID()%>">
									<a href="#"><span><%=MasterUtil.displayTabName(previousGeneralTabM,request)%></span></a>
								</li>
<%
				}
			}
			/* end launch list of general tab */
%>
<% 
		for(int i=0;i<entityTabs.size();i++) {
			EntityTabM entityTabM = (EntityTabM)entityTabs.get(i);
			TabM tabM =  (TabM)hTabs.get(entityTabM.getTabID());
			if(!tabM.isGeneralTabFlag()){
				if (tabM.getTabID().equalsIgnoreCase(form.getCurrentTab())) {
%> 	
								<li class="current" id="<%=tabM.getTabID()%>">
									<a href="javascript:void(0); setCurrentTab('<%=tabM.getTabID()%>'); switchTabAjax('<%=tabM.getTabID()%>', 'moduleContainer')"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</li>
<% 	
				} else {
%>
								<li id="<%=tabM.getTabID()%>">
									<a href="javascript:void(0); setCurrentTab('<%=tabM.getTabID()%>'); switchTabAjax('<%=tabM.getTabID()%>', 'moduleContainer')"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</li>
<% 		
				}
			}
		}/*-- end for --*/
%>
							</ul>
						</div>	
					</td>
				</tr>
			</table>
		</td>
	</tr>
<%}//End sam %>	
<% 
	Vector vSearchCriteria = MasterForm.getVMasterModelMs();	
	for (int i=0;i < vSearchCriteria.size();i++) {
	ModuleFieldM prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i);

	String tagShow = MasterUtil.displayManualTag(request, entityID, prmModuleFieldM.getFieldID(), MasterForm);
	com.master.util.Log4jUtil.log("tagShow===>"+tagShow);
	if (i%2 == 0) { 	 
%>    
  <tr>
<% 
	}
%>  
    <td align="right" class="<%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_label"><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%></td>       
    <td align="left" class="<%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input"><%=tagShow%></td>

<% 
	if (i%2 != 0) { 	 
%>
  </tr>
 <%
 	} 
  }
 %> 
 <tr> 
    <td align="left">
    <jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
	<jsp:param name="module" value="<%=entityID%>"/>
	<jsp:param name="action" value="ENTITY_SEARCH"/>
	</jsp:include>    
    </td>
    <td ></td>
    <td >       
    </td>
    <td ></td>
  </tr> 
  <tr>
    <td colspan="4" align="left"> 
    	<% if("Y".equalsIgnoreCase(popupFlag)) { %>
    	<jsp:include flush="true" page="resultPopup.jsp"/>
    <% } else { %>
    	<jsp:include flush="true" page="resultListMany.jsp"/>
    <% } %>
    </td>
  </tr>
</table>
</form>

<style>
<%=MasterUtil.generateCustomStyle(null, form, MasterForm, MasterForm.getProcessMode()) %>
</style>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.model.EntityTabM" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.model.TabM" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="java.util.ArrayList"%>

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	FormHandleManager formHandleManager = (FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(entitySession);
%>
<form name = "masterForm" action="FrontController" method="post">
<input type = "hidden"  name="action" value ="">
<input type = "hidden"  name="handleForm" value ="">
<input type = "hidden"  name="sessionForm" value ="">
<input type = "hidden" name="currentTab" value="">
<input type = "hidden" name="goEntity" value="">
<input type = "hidden" name="goEntityTab" value="">
<input type = "hidden" name="keyForSearch" value="">
<input type = "hidden" name="goEntityKey" value="">
<input type = "hidden" name="goEntityField" value="">
<input type = "hidden" name="nextTab" value="">
<input type = "hidden" name="nextEntity" value="">
<input type = "hidden" name="backEntityTab" value="">
<input type = "hidden" name="interfaceParam" value="">
<input type = "hidden" name="saveDraftFlag" value="">
<input type = "hidden" name="saveToManyFlag" value="">
<input type = "hidden" name="moduleIDForAction" value="">

<%
	//For Workflow attribute
	if(form.getEntityM().isRequireWFFlag()){
		//this field only use on UPDATE
 %>
<input type = "hidden" name="wfJobId" value="<%=request.getSession().getAttribute("wfJobId")%>">
<input type = "hidden" name="wfPtid" value="<%=request.getSession().getAttribute("wfPtid")%>">
<%	}//End workflow %>

<% 	
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

<table cellspacing="0" cellpadding="0" align ="center" width="100%">
<%
	if(generalTabList.size() > 0){
%>
	<tr>
		<td align="right" colspan="10" >
			<table cellpadding="0" cellspacing="0" width="100%" align="right">
				<tr>
					<td>
						<div id="GeneralNavigator" class="general_Nav">
							<ul>
<%
			/* start launch list of general tab */
			if(null != previousGeneralTabList && previousGeneralTabList.size() > 0){
				for(int i=0; i<previousGeneralTabList.size(); i++){
					TabM previousGeneralTabM = new TabM();
					previousGeneralTabM = (TabM) previousGeneralTabList.get(i);
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
		for(int i=0;i<generalTabList.size();i++) {
			EntityTabM entityTabM = (EntityTabM)generalTabList.get(i);
			TabM tabM =  (TabM)hTabs.get(entityTabM.getTabID());
			currentGeneralTab = tabM.getTabID();
			if (tabM.isGeneralTabFlag() || tabM.getTabID().equalsIgnoreCase(form.getCurrentTab())) {
%> 
								<li class="current" id="<%=tabM.getTabID()%>">
									<a href="#"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</li>
<% 	
			} else {
%>
								<li id="<%=tabM.getTabID()%>">
									<a href="#"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</li>
<%
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
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="1" cellspacing="0" align="center">
		<tr><td align="left">
		
		
		 <div id="<%=entityID%>Bt">
<% 
		if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) {
%>  			  			
  			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_INSERT"/>
			</jsp:include>
<%
		} else {
%>
  			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_UPDATE"/>
			</jsp:include>
<% 
		}
%>			
		</div>
		</td>
		<td width ="90%">		
		</td>		
		</tr>
		</table>		
		</td>
	</tr>
	<tr>
		<td>
<%/*---------------------------------------------------------------------------*/ %>
		<div id="gridModuleContainer" class="gridModuleContainer <%=currentGeneralTab%>_grid">
		<jsp:include flush="true" page="moduleManager.jsp">
		<jsp:param name="CURRENT_TAB" value="<%=currentGeneralTab%>"></jsp:param>
		</jsp:include>
		</div>
<%/*---------------------------------------------------------------------------*/ %>
		</td>
	</tr>
<%
	}/*-- end if(generalTabList.size() > 0) --*/
	if (!form.getEntityM().isHideTab()) {
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
<%	} %>	
<%
	if(generalTabList.size() == 0){
%>
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="1" cellspacing="0" align="center">
		<tr><td align="left">
		
		
		 <div id="<%=entityID%>Bt">
<% 
		if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) {
%>  			  			
  			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_INSERT"/>
			</jsp:include>
<%
		} else {
%>
  			<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_UPDATE"/>
			</jsp:include>
<% 
		}
%>			
		</div>
		</td>
		<td width ="90%">		
		</td>		
		</tr>
		</table>	
		</td>
	</tr>
<%
	}/*-- end if(generalTabList.size() == 0) --*/
%>

<%if(null != form.getCurrentTab()){ %>
	<tr>
		<td>
<%/*---------------------------------------------------------------------------*/ %>
			<div id="moduleContainer" class="moduleContainer <%=form.getCurrentTab()%>_container">
				<jsp:include flush="true" page="moduleManager.jsp">
				<jsp:param name="CURRENT_TAB" value="<%=form.getCurrentTab()%>"></jsp:param>
				</jsp:include>
			</div>
<%/*---------------------------------------------------------------------------*/ %>
		</td>
	</tr>
<%} %>
	
</table>
</form>
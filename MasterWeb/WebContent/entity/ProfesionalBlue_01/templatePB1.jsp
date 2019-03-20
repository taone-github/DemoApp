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
	System.out.println("entitySession==>"+entitySession);
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
<input type = "hidden" name="currentTab" value="<%=form.getCurrentTab()%>">
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
<% 	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	System.out.println("form==>"+form);
	System.out.println("entityTabs==>"+entityTabs);
	HashMap hTabs = form.getTabHasMap();
	System.out.println("hTabs -> " + hTabs);
	ArrayList generalTabList = MasterUtil.getGeneralTab(entityTabs, hTabs);
	String currentGeneralTab = "";
	
	Vector previousGeneralTabList = (Vector) request.getSession().getAttribute("generalTabList_session");
	System.out.println("previousGeneralTabList -> " + previousGeneralTabList);
%>

<table cellspacing="0" cellpadding="0" align ="center" width="100%">
<tr>
	<td class="bgmenuright" vAlign="top">
	<table cellspacing="0" cellpadding="0" align ="center" width="100%">
<%
	if(generalTabList.size() > 0){
%>
	<tr>
		<td width="16">
		</td>
		<td colspan="10" >
			<table cellpadding="0" cellspacing="0" width="98%" align="left" style="border-left: 1px solid #cccccc;">
				<tbody>
				<tr>
					<td class="sidebar4bg1">
						<div id="GeneralNavigator">
							<table>
								<tr>
<%
			/* start launch list of general tab */
			if(null != previousGeneralTabList && previousGeneralTabList.size() > 0){
				for(int i=0; i<previousGeneralTabList.size(); i++){
					TabM previousGeneralTabM = new TabM();
					previousGeneralTabM = (TabM) previousGeneralTabList.get(i);
%>
								<td id="<%=previousGeneralTabM.getTabID()%>">
									<a class="actionbar_2" href="#"><span><%=MasterUtil.displayTabName(previousGeneralTabM,request)%></span></a>
								</td>
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
								<td id="<%=tabM.getTabID()%>">
									<a class="actionbar_2" href="#"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</td>
<% 	
			} else {
%>
								<td id="<%=tabM.getTabID()%>">
									<a class="actionbar_8"  href="#"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</td>
<%
			}
		}/*-- end for --*/
%>
							</tr>
							</table>
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td width="16">
		</td>
		<td>
		<table border="0" cellpadding="1" cellspacing="0" width="98%" align="left" style="border-left: 1px solid #cccccc;">
		<tr><td>
		
		
		 <div id="<%=entityID%>Bt">
<% 
		if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) {
%>  			  			
  			<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_INSERT"/>
			<jsp:param name="align" value="right"/>
			</jsp:include>
<%
		} else {
%>
  			<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_UPDATE"/>
			<jsp:param name="align" value="right"/>
			</jsp:include>
<% 
		}
%>			
		</div>
		</td>
		</tr>
		</table>		
		</td>
	</tr>
	<tr>
		<td width="16">
		</td>
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
		<td width="16">
		</td>
		<td>
			<table cellpadding="0" cellspacing="0" width="98%" align="left" style="border-left: 1px solid #cccccc;">
				<tbody>
				<tr>
					
<%	if((null != previousGeneralTabList && previousGeneralTabList.size() > 0) && (null == generalTabList || generalTabList.size() == 0)){%>
				<td class="sidebar4bg1">
						<div id="GeneralNavigator">
						
<%	}else{%>
				<td class="subTab">
						<div id="subNavigator">
<%	}%>
							<table>
								<tr>
<%
			String selectTabClass = "tab01";
			String normalTabClass = "tab02";
			if(generalTabList.size() == 0){
				selectTabClass = "actionbar_2";
				normalTabClass = "actionbar_8";
			}
			
			/* start launch list of general tab */
			if((null != previousGeneralTabList && previousGeneralTabList.size() > 0) && (null == generalTabList || generalTabList.size() == 0)){
				for(int i=0; i<previousGeneralTabList.size(); i++){
					TabM previousGeneralTabM = new TabM();
					previousGeneralTabM = (TabM) previousGeneralTabList.get(i);
					System.out.println("getTabID -> " + previousGeneralTabM.getTabID());
					System.out.println("getTabName -> " + previousGeneralTabM.getTabName());
%>
								<td id="<%=previousGeneralTabM.getTabID()%>">
									<a class="<%=selectTabClass%>" href="#"><span><%=MasterUtil.displayTabName(previousGeneralTabM,request)%></span></a>
								</td>
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
								<td id="<%=tabM.getTabID()%>">
									<a class="<%=selectTabClass%>"  href="javascript:void(0); setCurrentTabPB1('<%=tabM.getTabID()%>'); switchTabAjax('<%=tabM.getTabID()%>', 'moduleContainer')"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</td>
<% 	
				} else {
%>
								<td id="<%=tabM.getTabID()%>" >
									<a class="<%=normalTabClass%>"  href="javascript:void(0); setCurrentTabPB1('<%=tabM.getTabID()%>'); switchTabAjax('<%=tabM.getTabID()%>', 'moduleContainer')"><span><%=MasterUtil.displayTabName(tabM,request)%></span></a>
								</td>
<% 		
				}
			}
		}/*-- end for --*/
%>
							</tr> 
							</table>
						</div>	
					</td>
				</tr>
				</tbody>
			</table>
		</td>
	</tr>
<%	} %>	
<%
	if(generalTabList.size() == 0){
%>
	<tr>
		<td width="16" >
		</td>
		<td>
		<table border="0" cellpadding="1" cellspacing="0" width="98%" align="left" style="border-left: 1px solid #cccccc;">
		<tr><td>
		 <div id="<%=entityID%>Bt">
<% 
		if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) {
%>  			  			
  			<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_INSERT"/>
			<jsp:param name="align" value="right"/>
			</jsp:include>
<%
		} else {
%>
  			<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
			<jsp:param name="module" value="<%=entityID%>"/>
			<jsp:param name="action" value="ENTITY_UPDATE"/>
			<jsp:param name="align" value="right"/>
			</jsp:include>
<% 
		}
%>			
		</div>
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
		<td width="16">
		</td>
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
</td>
</tr>
</table>
<br><br><br>
<div id="entity_footer" ><jsp:include page='footer.jsp'/></div>
</form>
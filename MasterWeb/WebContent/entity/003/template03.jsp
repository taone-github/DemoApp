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
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");	
		
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
<input type = "hidden" name="goEntityKey" value="">
<input type = "hidden" name="goEntityField" value="">
<input type = "hidden" name="nextTab" value="">
<input type = "hidden" name="nextEntity" value="">

<% 	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	System.out.println("form==>"+form);
	System.out.println("entityTabs==>"+entityTabs);
	HashMap hTabs = form.getTabHasMap();
	ArrayList generalTabList = MasterUtil.getGeneralTab(entityTabs, hTabs);
	String currentGeneralTab = "";
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
						<div id="subNavigator">
							<ul>
<% 
		for(int i=0;i<generalTabList.size();i++) {
			EntityTabM entityTabM = (EntityTabM)generalTabList.get(i);
			TabM tabM =  (TabM)hTabs.get(entityTabM.getTabID());
			currentGeneralTab = tabM.getTabID();
			if (tabM.isGeneralTabFlag() || tabM.getTabID().equalsIgnoreCase(form.getCurrentTab())) {
%> 
								<li class="current" id="<%=tabM.getTabID()%>">
									<a href="#"><span><%=tabM.getTabName()%></span></a>
								</li>
<% 	
			} else {
%>
								<li id="<%=tabM.getTabID()%>">
									<a href="#"><span><%=tabM.getTabName()%></span></a>
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
		</td>
	</tr>
	<tr>
		<td>
<%/*---------------------------------------------------------------------------*/ %>
		<div id="gridModuleContainer">
		<jsp:include flush="true" page="moduleManager.jsp">
		<jsp:param name="CURRENT_TAB" value="<%=currentGeneralTab%>"></jsp:param>
		</jsp:include>
		</div>
<%/*---------------------------------------------------------------------------*/ %>
		</td>
	</tr>
<%
	}/*-- end if(generalTabList.size() > 0) --*/
%>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" width="100%" align="right">
				<tr>
					<td>
						<div id="subNavigator">
							<ul>
<% 
		for(int i=0;i<entityTabs.size();i++) {
			EntityTabM entityTabM = (EntityTabM)entityTabs.get(i);
			TabM tabM =  (TabM)hTabs.get(entityTabM.getTabID());
			if(!tabM.isGeneralTabFlag()){
				if (tabM.getTabID().equalsIgnoreCase(form.getCurrentTab())) {
%> 	
								<li class="current" id="<%=tabM.getTabID()%>">
									<a href="javascript:void(0); setCurrentTab('<%=tabM.getTabID()%>'); switchTabAjax('<%=tabM.getTabID()%>', 'moduleContainer')"><span><%=tabM.getTabName()%></span></a>
								</li>
<% 	
				} else {
%>
								<li id="<%=tabM.getTabID()%>">
									<a href="javascript:void(0); setCurrentTab('<%=tabM.getTabID()%>'); switchTabAjax('<%=tabM.getTabID()%>', 'moduleContainer')"><span><%=tabM.getTabName()%></span></a>
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
<%
	if(generalTabList.size() == 0){
%>
	<tr>
		<td>
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
		</td>
	</tr>
<%
	}/*-- end if(generalTabList.size() == 0) --*/
%>
	<tr>
		<td>
<%/*---------------------------------------------------------------------------*/ %>
			<div id="moduleContainer">
				<jsp:include flush="true" page="moduleManager.jsp">
				<jsp:param name="CURRENT_TAB" value="<%=form.getCurrentTab()%>"></jsp:param>
				</jsp:include>
			</div>
<%/*---------------------------------------------------------------------------*/ %>
		</td>
	</tr>
</table>
</form>
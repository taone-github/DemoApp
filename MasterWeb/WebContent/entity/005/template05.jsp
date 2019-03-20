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
<input type = "hidden" name="currentMode" value="<%=form.getCurrentMode()%>">
<input type = "hidden" name="currentEntity" value="<%=entityID%>">

<% 	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	System.out.println("form==>"+form);
	System.out.println("entityTabs==>"+entityTabs);
	HashMap hTabs = form.getTabHasMap();
	ArrayList generalTabList = MasterUtil.getGeneralTab(entityTabs, hTabs);
	String currentGeneralTab = "";
%>

<table class ="centeredPanel" cellspacing="0" cellpadding="0" align ="center" width="100%" height="100%">
<tr>
<td valign="top" >
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			  <tr><td colspan="7"><img src="images/c.gif" alt="" width="730" height="5"></td></tr>
			  <tr>
			  	<td >&nbsp;</TD>
				<td class="headerTitle" valign="middle"><%=form.getEntityM().getEntityName()%></TD>
				<td colspan="5" align="right">
				<div id ="buttonAllModeID" name ="buttonAllModeName">
				<TABLE border="0">
				<TR>
					<TD><div id ="addButtonID" name ="addButtonName"><img src="./theme/005/images/b_add2_d.gif" border="0" alt="Add" name="addButtonID" ></div></TD>
					<TD><div id ="editButtonID" name ="editButtonName"><img src="./theme/005/images/b_edit2_d.gif" name="editButtonID" ></div></TD>
					<TD><div id ="deleteButtonID" name ="deleteButtonName"><img src="./theme/005/images/b_delete2_d.gif" name="deleteButtonID"></div></TD>
					<TD><img src="./theme/005/images/c.gif" width="10" height="1"></TD>
					<TD><div id ="searchButtonID" name ="searchButtonName"><img src="./theme/005/images/b_search2.gif" border="0" alt="Search" name="searchButtonID"></div></TD>
					<TD><div id ="exitButtonID" name ="exitButtonName"><img src="./theme/005/images/b_exit2.gif" alt="Exit" border="0" name="exitButtonID"></div></TD>
					<TD>&nbsp;</TD>
				</TR>
				</TABLE>
				</div>
				</td>
			  </tr>
			  <tr>
				<td width="10"><img src="./theme/005/images/c.gif" width="10" height="1"></td>
				<td width="500"><img src="./theme/005/images/c.gif" width="500" height="1"></td>
				<td width="55"><img src="./theme/005/images/c.gif" width="55" height="1"></td>
				<td width="425"><img src="./theme/005/images/c.gif" width="100%" height="1"></td>
				<td width="32"><img src="./theme/005/images/c.gif" width="32" height="1"></td>
				<td width="70"><img src="./theme/005/images/c.gif" width="70" height="1"></td>
				<td width="38" ><img src="./theme/005/images/c.gif" width="38" height="1"></td>
			  </tr>
			</table>

</td>
</tr>
<% 
	if (!form.getEntityM().isHideTab()) {
%>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" width="100%" align="right">
				<tr>
					<td>
						<div id="subNavigator" class="child_Nav">
							<ul>
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
<% 
	}
%>	



<tr>
<td valign="top">
<table border="0" cellpadding="0" cellspacing="0" width="100%" >
<tr>

<td valign="bottom"  align ="left" width="25"><img src="./theme/005/images/line_top_left.gif" width="25" height="25"></td>
<td width="5%">
<div id ="processPicID" name ="processPicName">
<%
String mode = "";
String pic = "";
if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) { 
	mode = "&nbsp;Add Page";
	pic = "table_add.gif";	
} else if (form.getEntityM().isViewModeFlag() && MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(form.getCurrentMode())) {
	mode = "&nbsp;View Page";
	pic = "table_view.gif";
} else {
	mode = "&nbsp;Edit Page";
	pic = "table_edit.gif";
}
%>
<img src="./theme/005/images/<%=pic%>" width="24" height="25">
</div>
</td>
<td class="blueheader" width="15%" ><span id ="processLabelID" name ="processLabelName"><%=mode%></span></td>
<td  valign="bottom" colspan="5" ><img src="./theme/005/images/line_top.gif" width="100%" height="25"></td>
<td valign = "bottom"><img src="./theme/005/images/line_top_right.gif" width="24" height="25"></td>
</tr>

<tr>
<td align="left" background="./theme/005/images/line_left.gif"  ></td>
<td colspan="7">
<table cellpadding="0" cellspacing="0" width="100%" >

<%
	if(generalTabList.size() > 0){
%>
	<tr>
		<td align="right" colspan="10" >
			<table cellpadding="0" cellspacing="0" width="100%" align="right">
				<tr>
					<td>
						<div id="subNavigator" class="general_Nav">
							<ul>
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

	if(null != form.getCurrentTab()){ %>
	<tr>
		<td>
		<br>
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
<td background="./theme/005/images/line_right.gif" ></td>
</tr>
 
 <tr>
 <td valign="top" align="left">
<img src="./theme/005/images/line_bot_left.gif" width="25" height="25">
 </td>
 <td colspan="2" valign="top" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
 <td  valign="top" width="25%" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
 <td  valign="top" width="2%">
<img src="./theme/005/images/line_bot_v.gif" width="24" height="25">
</td>
 <td  valign="top" align="center" width="6%">
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
 <td  valign="top" width="2%">
<img src="./theme/005/images/line_bot_v.gif" width="24" height="25">
</td>

<td  valign="top" width ="40%" >
<img src="./theme/005/images/line_bot.gif" width="100%" height="25">
</td>
<td valign="top">
<img src="./theme/005/images/line_bot_right.gif" width="24" height="25">
</td>
 </tr>

</table>
</td>
</tr>	
</table>
</form>
<form name="extendForm" id="extendForm" action="">
</form>
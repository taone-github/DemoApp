<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.profile.model.MasterUserM"%>
<%@page import="com.master.model.ConstantSystemM"%>
<%@page import="com.master.constant.ConstantSystem"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@page import="com.master.model.ModuleActionM"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.master.util.userDetails.UserManagement"%>
<%@page import="com.avalant.display.OverrideJSP" %>
<% 
	MasterUserM masterUserM = (MasterUserM)request.getSession().getAttribute("MasterUserDetails");
	String entityID = (String)request.getSession().getAttribute("entityID");	
	if (!UserManagement.getInstance().checkHaveEntityWithRoles(entityID,masterUserM)) {
		return;
	} 

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


<div id ="<%=entityID%>Div" class="searchScreen">
<jsp:include flush="true" page="searchTemplatePreEventScript.jsp"/>
<% 
	String templateCode = form.getEntityM().getTemplateCode();	
	String searchEntityJSP = templateCode + "/searchEntity.jsp";
	if(templateCode.equals("PB1")){
		searchEntityJSP = "ProfesionalBlue_01/searchEntity.jsp";
	}else if(templateCode.equals("PS1")){
		searchEntityJSP = "ProSilver/searchEntity.jsp";
		//searchEntityJSP = "ProSilver/" + OverrideJSP.getInstance().getFilePath("PS1","SEARCH_ENTITY");
	}
%>

<%if (null != templateCode && !"".equalsIgnoreCase(templateCode)){ %>
		<jsp:include flush="true" page="<%=searchEntityJSP%>" />
<%}else{ %>
		<jsp:include flush="true" page="002/searchEntity.jsp" />
<%} %>

<%/*-- start include eventScript that contain the javascript function --*/%>
	<jsp:include flush="true" page="searchTemplateEventScript.jsp"/>
	<jsp:include flush="true" page="ajaxEventScript.jsp">
		<jsp:param name="templateCode" value="<%=templateCode%>"/>
	</jsp:include>
<%/*-- end include eventScript that contain the javascript function --*/%>

<%// Decorate Elements %>
<div id="_messageBlock"
	 style="display: none; position: absolute; left: 50%; top: 50%; z-index: 256; color: #c0c0c0;">
	<div id="_messageBlock_background"
		 style="position: absolute; background: #ffffff; opacity: 0.67; filter: alpha(opacity=67);"></div>
	<div id="_messageBlock_message"
		 style="position: relative; z-index: 257; border: 1px solid #000000; padding: 0.5em 2em; font-size: 2em;"></div>
</div>
<!-- <img id="waiting" src="./images/loader/pleaseWaitImage.gif" width="50" height="50" style="display:none" /> -->

<%
	/* start responseMessage to user */
	String responseMessage = (String) request.getSession().getAttribute("responseMessage");
	System.out.println("responseMessage -> " + responseMessage);
	if(!"".equalsIgnoreCase(responseMessage) && null != responseMessage){
%>
		<script type="text/javascript">
			displayResponseMessage("<%=responseMessage%>");
			jQuery("#_messageBlock").hide();
			var fadeInMessage = setTimeout(fadeInMessage, 200);
			var fadeOutMessage = setTimeout(fadeOutMessage, 1500);
		</script>
<%
			request.getSession().removeAttribute("responseMessage");
	}
	/* end responseMessage to user */
%>


</div>
<script type="text/javascript">
	/* add hi-light to textbox when focus*/
	textBoxFocusInvoker();
</script>
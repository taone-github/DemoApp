<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>

<% 
	System.out.println("List MANYYYYY Template");
	String entityID = (String)request.getSession().getAttribute("entityIDForList");
	String entitySession = entityID +"_session";
	System.out.println("entitySession List ====> "+entitySession);
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
	String themeCode = form.getEntityM().getThemeCode();		
%>	
<jsp:include flush="true" page="../theme/theme.jsp">
<jsp:param name="themeCode" value="<%=themeCode%>"/>
</jsp:include> 
		
<%
	String templateCode = form.getEntityM().getTemplateCode();
	String listManyJSP = templateCode + "/listMany.jsp";
	if(templateCode.equals("PB1")){
		listManyJSP = "ProfesionalBlue_01/listMany.jsp";
	}else if(templateCode.equals("PS1")){
		listManyJSP = "ProSilver/listMany.jsp";
	}
	
	if (!"".equalsIgnoreCase(templateCode) && null != templateCode) {		
%>
		<jsp:include flush="true" page="<%=listManyJSP %>"/>
<%
	} else {
%>
		<jsp:include flush="true" page="002/listMany.jsp"/>
<%
	}
%>

<%/*-- start include eventScript that contain the javascript function --*/%>
	<jsp:include flush="true" page="listManyTemplateEventScript.jsp"/>
<%/*-- end include eventScript that contain the javascript function --*/%>


<%//Sam add 12/03/2012 %>
<%// Decorate Elements %>
<div id="_messageBlock"
	 style="display: none; position: absolute; left: 50%; top: 50%; z-index: 256; color: #c0c0c0;">
	<div id="_messageBlock_background"
		 style="position: absolute; background: #ffffff; opacity: 0.80; filter: alpha(opacity=80);"></div>
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
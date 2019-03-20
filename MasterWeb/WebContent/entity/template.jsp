<%@page import="com.avalant.feature.FT033_JSRules"%>
<%@page import="com.avalant.feature.FT022_UploadFile"%>
<%@page import="com.master.util.userDetails.UserManagement"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@page import="com.master.model.EntityM"%>
<%@page import="com.profile.model.MasterUserM"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.model.ModuleActionM"%>
<%@page import="com.master.model.ConstantSystemM"%>
<%@page import="com.master.constant.ConstantSystem"%>

<% 
	MasterUserM masterUserM = (MasterUserM)request.getSession().getAttribute("MasterUserDetails");
	String entityID = (String)request.getSession().getAttribute("entityID");	
	com.master.util.Log4jUtil.log("<===JAP===>EntityID:"+entityID);
	com.master.util.Log4jUtil.log("<===JAP===>check:"+Boolean.toString(!UserManagement.getInstance().checkHaveEntityWithRoles(entityID,masterUserM)));
	if (!UserManagement.getInstance().checkHaveEntityWithRoles(entityID,masterUserM)) {
		return;
	} 
	
	
	
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
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

<div id ="<%=entityID%>Div" class="insertScreen">
				
<% 	
	
	String templateCode = form.getEntityM().getTemplateCode();		
	com.master.util.Log4jUtil.log("<===JAP===>start set templete"+templateCode);
%>
	<jsp:include flush="true" page="templateEventScript.jsp"/>
	<jsp:include flush="true" page="ajaxEventScript.jsp">
		<jsp:param name="templateCode" value="<%=templateCode%>"/>
	</jsp:include>
<%
	if ("001".equalsIgnoreCase(templateCode)) {
%>
		<jsp:include flush="true" page="001/template01.jsp"/> 		
<%
	} else if ("002".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="002/template02.jsp"/>
<%
	} else if ("003".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="003/template03.jsp"/>
<%
	} else if ("004".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="004/template04.jsp"/>
<%
	}else if ("005".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="005/template05.jsp"/>
<%
	}else if ("006".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="006/template06.jsp"/>				
<%
	}else if ("007".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="007/template07.jsp"/>
<%
	}else if ("PB1".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="ProfesionalBlue_01/templatePB1.jsp"/>
<%
	}else if ("PS1".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="ProSilver/templatePS1.jsp"/>
<%
	}else if ("Responsive2016".equalsIgnoreCase(templateCode)) { 
%>
		<jsp:include flush="true" page="Responsive2016/templateResponsive2016.jsp"/>
<%
	}else {
%>
		<jsp:include flush="true" page="002/template02.jsp"/> 	
<%
	}
%>
</div>
<%
	
	/* case: passing post parameter via interface */
	String defaultInsertFlag = form.getEntityM().getDefaultInsertFlag();
	if(null != defaultInsertFlag && !"".equalsIgnoreCase(defaultInsertFlag) && "Y".equalsIgnoreCase(defaultInsertFlag)){
%>
		<jsp:include flush="true" page="interface.jsp"/>
<%
	}
%>

<%/*-- start include eventScript that contain the javascript function --*/
	com.master.util.Log4jUtil.log("<===JAP===>include");
%>
	
<%/*-- end include eventScript that contain the javascript function --*/%>

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
	com.master.util.Log4jUtil.log("responseMessage -> " + responseMessage);
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


<%
	/* start generate javascript at the end of page (must be placed here to invoke the function suddenly) */
	String endPageJavascript = (String) request.getSession().getAttribute("endPageJavascript");
	if(null != endPageJavascript && !"".equalsIgnoreCase(endPageJavascript)){
		out.print(endPageJavascript);
		request.getSession().removeAttribute("endPageJavascript");
	}
	/* end generate javascript at the end of page (must be placed here to invoke the function suddenly) */
%>

<% 
	EntityM entityM = form.getEntityM();
	ArrayList entityActions = entityM.getEntityActions();
	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityActions,form.getCurrentMode());
	if (moduleActionM.getScriptFile()!= null && !"".equals(moduleActionM.getScriptFile())) {
%>	
		<script type="text/javascript" src="<%=moduleActionM.getScriptFile().trim()%>?v=<%=Math.random()%>"></script>	
<% 		
	}
%>


<% 
/*
* 000138
*
* 10-09-2014
* FIX: send HttpRequest when call generateInitTag to get message error from properties file
*/
FT022_UploadFile ft022_UploadFile = new FT022_UploadFile();
out.print(ft022_UploadFile.generateInitTag(entityID, request));
%>


<% 
/*
* 07-01-2016
* FIX: FT033_JSRules
*/
if(FT033_JSRules.getInstance().isFeatureUse() && entityM.getJsRules() != null && entityM.getJsRules().size() > 0) {
%>
<script type="text/javascript">
jQuery(document).ready(function() {
	<% for(int i=0;i<entityM.getJsRules().size();i++) { 
		out.print(entityM.getJsRules().get(i));
	 } %>
});
</script>
<%
}
%>


<script type="text/javascript">
	/* add hi-light to textbox when focus*/
	textBoxFocusInvoker();
</script>

<%

/*
*
* TEST 
*
*
*
*
*
*/
%>
<!-- <input type="button" value="New" onclick="openTabEntity()"> -->
<!-- <input type="button" value="Save&Close" onclick="saveAndClose()"> -->
<script>
function openTabEntity() {
	var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.master.servlet.SwithTabEntityServlet&_method=NEW&entityID=EN_338782714969094&tabID=TAB_ID_9016440938&newRequestFlag=Y&forwardFlag=Y";
	
	uri += sweepAjaxForm('masterForm');
	
	jQuery.ajax({
	   	type: "POST",
	   	url: uri,
	   	data: dataString,
	   	success: function(data){
			window.location.href = "/MasterWeb/index.jsp"
		}
	});
}

function clickGeneralTab(idx) {
	var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.master.servlet.SwithTabEntityServlet&_method=SWITCH&entityID=EN_338782714969094&tabID=TAB_ID_9016440938&newRequestFlag=Y&forwardFlag=Y&index="+idx;
	
	uri += sweepAjaxForm('masterForm');
	
	jQuery.ajax({
	   	type: "POST",
	   	url: uri,
	   	data: dataString,
	   	success: function(data){
			window.location.href = "/MasterWeb/index.jsp"
		}
	});
}

function saveAndClose() {
	var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.master.servlet.SwithTabEntityServlet&_method=SAVE_AND_CLOSE&entityID=EN_338782714969094&tabID=TAB_ID_9016440938&newRequestFlag=Y&forwardFlag=Y";
	
	uri += sweepAjaxForm('masterForm');
	
	jQuery.ajax({
	   	type: "POST",
	   	url: uri,
	   	data: dataString,
	   	success: function(data){
			window.location.href = "/MasterWeb/index.jsp"
		}
	});
}
</script>

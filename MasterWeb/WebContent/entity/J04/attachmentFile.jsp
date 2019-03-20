<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>


<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	com.master.util.Log4jUtil.log("========Attached=========");
	com.master.util.Log4jUtil.log("moduleSession"+moduleSession);
	
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

	HashMap hAllObj =  MasterForm.getHAllobjects();
	Vector  vStoreActions  = (Vector)MasterForm.getStoreActionList();
	com.master.util.Log4jUtil.log("vStoreActions===>"+vStoreActions);		
	Vector vModelMs = (Vector)MasterForm.getVMasterModelMs();
	String sourceAttached =	MasterUtil.getSourceAttachment(MasterForm.getModuleM(),vStoreActions,vModelMs,hAllObj,MasterForm.getProcessMode());										 		
%>

<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td class="td_AttachmentFile">
			<%=sourceAttached%>
			<!-- Sam add import button -->
			<input type="button" value="import" onclick="importCSV();"/>
		</td>
	</tr>
</table>


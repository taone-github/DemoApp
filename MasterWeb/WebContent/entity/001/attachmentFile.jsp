<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.master.model.PopupPropM" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.master.model.AttachmentListPropM" %>


<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	System.out.println("========Attached=========");
	System.out.println("moduleSession"+moduleSession);
	
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
<%
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	HashMap hAllObj =  MasterForm.getHAllobjects();
%>
<TABLE width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
   <tr>
    <td colspan="4"></td>
  </tr> 
  <tr height="19">
    <td colspan="4" valign="top" align="center">  
<%			
			Vector  vStoreActions  = (Vector)MasterForm.getStoreActionList();
			System.out.println("vStoreActions===>"+vStoreActions);		
			Vector vModelMs = (Vector)MasterForm.getVMasterModelMs();
			String sourceAttached =	MasterUtil.getSourceAttachment(MasterForm.getModuleM(),vStoreActions,vModelMs,hAllObj,MasterForm.getProcessMode());										 		
%>			  		
	  				       		
	  <%=sourceAttached%>				       							
	</td>
  </tr>
</TABLE>


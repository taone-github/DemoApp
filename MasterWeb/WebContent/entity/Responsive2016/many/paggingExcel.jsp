<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);

	com.master.util.Log4jUtil.log("moduleSession>>"+moduleSession);
	com.master.util.Log4jUtil.log("getAllSearchResultData>>"+MasterForm.getAllSearchResultData());
	if (MasterForm == null) {
		MasterForm = new MasterFormHandler();
		request.getSession().setAttribute(moduleSession,MasterForm);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");	
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(moduleSession);
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	
%>
<div class="tablearea" style="width:100%">
<%
	if (MasterForm.getModuleM().isPagingFlag()) {
%>
			
<br>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td class="text-pagging" width ="60%"> 
		Total Records found :&nbsp;<b><%=MasterForm.getAllSearchResultData()%> </b>
		</td>
		<td class="text-pagging" align="right">
<% 		
		int allPage =  MasterForm.getAllSearchResultData() / MasterForm.getVolumePerPage();
		if (allPage*MasterForm.getVolumePerPage()  < MasterForm.getAllSearchResultData()) {
			allPage++;
		}
%>
		Page <b><%=MasterForm.getPage()%></b> of <b><%=allPage%></b>
		</td>
		<td class="text-pagging" align="right">
<% 		
		if (MasterForm.getPage() != 1) {
%>    
			|&nbsp;<input type="button" name ="previous" value="|<" onclick ="changePageExcel('<%=(MasterForm.getPage()-1)%>')">
<% 
		} else {
%>    
			|&nbsp;<input type="button" name ="previous" value="|<"  disabled="disabled">
<% 
		}
%>
			&nbsp;<b><%=MasterForm.getPage()%></b> &nbsp;
<% 
		if (allPage != MasterForm.getPage())	{	
%>
			<input type="button" name ="next" value=">|" onclick ="changePageExcel('<%=(MasterForm.getPage()+1)%>')">&nbsp;| 
<% 
		} else {
%>
			<input type="button" name ="next" value=">|"  disabled="disabled">&nbsp;| 
<% 
		}
%>						
		</td>
		<td class="text-pagging" align="right" ><b>
		View&nbsp; 
			<select name="selectPerPageExcel" id="selectPerPageExcel" onchange="changePageExcel('1')"> 
<% 	
		Vector v = new Vector(LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().keySet());
		for(int i =0;i< v.size();i++) {
			if (MasterForm.getVolumePerPage() == Integer.parseInt((String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1)))) {
%>     
				<option value ="<%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" selected ><%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<% 
			} else {
%>
				<option value ="<%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" ><%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<%	
			}
		}
%>
			</select>&nbsp;per page </b>			 		
		</td>
	</tr>
</TABLE>		
<%
	}
%>		
<br>
</div>
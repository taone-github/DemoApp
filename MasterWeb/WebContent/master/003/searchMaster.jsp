<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>

<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
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

<form name ="masterForm" action="FrontController" >
<input type ="hidden" name = "action" value="searchMaster">
<input type ="hidden" name = "handleForm" value = "Y">
	<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF2F8">
          <tr> 
            <td width="10" background="<%=request.getContextPath()%>/theme/002/images/bg_topic.gif">&nbsp;</td>
            <td width="10">&nbsp;</td>
            <td><font class="bubold2"><%=MasterForm.getModuleM().getModuleName()%></font></td>
          </tr>
  </table>
<table width="95%" border="0" align="center" >

<% 
	Vector vSearchCriteria = MasterForm.getVMasterModelMs();	
	HashMap hAllObj = MasterForm.getHAllobjects();
	HashMap hShowRecords = MasterForm.getHSearchCriteriaData();
	for (int i=0;i < vSearchCriteria.size();i++) {
	ModuleFieldM prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i);
	HashMap hFieldProps = (HashMap)hAllObj.get(prmModuleFieldM.getObjType());
	Object obj = hFieldProps.get(prmModuleFieldM.getMfID());	
	Object valueData= null;
	if (hShowRecords != null) {
		Object objDataValue = hShowRecords.get(prmModuleFieldM.getFieldID());
		if (objDataValue != null) {
			valueData = objDataValue;
		}
	}	
	String tagShow = MasterUtil.displayManualTag(request, entityID, prmModuleFieldM.getFieldID(), MasterForm);
	System.out.println("tagShow===>"+tagShow);
	if (i%2 == 0) { 	 
%>     
  <tr>
<% 
	}
%>  
    <td width="24%" align="right"><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%></td>
    <td width="2%"></td>
    <td width="24%" align="left" ><%=tagShow%></td>
<% 
	if (i%2 != 0) { 	 
%>
  </tr>
 <%
 	} 
  }
 %> 
 <tr>
    <td >
	<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
	<jsp:param name="module" value="<%=MasterForm.getModuleM().getModuleID()%>"/>
	<jsp:param name="action" value="<%=MasterConstant.PROCESS_MODE_SEARCH%>"/>
	</jsp:include>          
    </td>
    <td colspan="5"></td>

  </tr> 
  <tr>
    <td colspan="6" align="left"> 
    	<jsp:include flush="true" page="resultSearch.jsp"/>
    </td>
  </tr>
</table>
</form>
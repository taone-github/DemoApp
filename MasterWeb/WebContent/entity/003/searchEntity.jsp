<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.master.model.ColumnStructureM" %>
<%@ page import="com.master.model.PopupPropM" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.dao.MasterDAOFactory" %>
<%@ page import="com.master.dao.MasterDAO" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>


<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	System.out.println("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}		
	System.out.println("form.getMainModuleID() ==> "+form.getMainModuleID());
	System.out.println("###$$$ form.getCurrentTab() ==> "+form.getCurrentTab());
	String moduleSession = form.getMainModuleID() +"_session";
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


<%@page import="com.master.model.ModuleActionM"%>
<%@page import="com.master.model.EntityM"%><form name ="masterForm" action="FrontController" >
<input type ="hidden" name = "action" value="searchMaster">
<input type ="hidden" name = "handleForm" value = "Y">

<!-- Header -->
<div id="Header">
	<table cellspacing="0" cellpadding="0" width="98%" align="center">
		<tr>
<!--Tab menu -->
			<td align="left" colspan="2" valign="top">
				<div id="tabmenu">
					<TABLE cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="100%" align="left" nowrap>
								<div id="subNavigator">
									<ul>
										<li class="current">
											<a href="javascript:void(0);"><span class="active">Search</span></a>
										</li>  
									</ul>
								</div>
							  </td>
						</tr>
					</table>
				</div>
<!--end Tab menu -->
			</td>
		</tr>
<!-- Tab subMenu -->
		<tr>
			<td class="navigator" align="left"><%=form.getEntityM().getEntityName() %>&nbsp;&gt;&nbsp; </td>
	  		<td align="right" valign="top">
				<table align="right" cellpadding="0" cellspacing="0" border="0"> 
					<tr align="right" valign="top">
		    			<td align="right" valign="top">
		  					<jsp:include flush="true" page="/buttonManager/buttonManager.jsp">
							<jsp:param name="module" value="<%=entityID%>"></jsp:param>
							<jsp:param name="action" value="ENTITY_SEARCH"></jsp:param>
							</jsp:include>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!-- end Tab subMenu -->
</div>
<!-- end Header -->

<table width="100%" border="0" align="center">
<tr>
<td>
<div id="contentTableHeader">
<table align="center" border="0"><tr><td>

<% 
	Vector vSearchCriteria = MasterForm.getVMasterModelMs();	
	HashMap hAllObj = MasterForm.getHAllobjects();
	HashMap hShowRecords = MasterForm.getHSearchCriteriaData();
	for (int i=0;i < vSearchCriteria.size();i++) {
	ModuleFieldM prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i);
	HashMap hFieldProps = (HashMap)hAllObj.get(prmModuleFieldM.getObjType());
	Object obj = hFieldProps.get(prmModuleFieldM.getMfID());
	MasterUtil util =  MasterUtil.getInstance();	
	Object valueData= null;
	if (hShowRecords != null) {
		Object objDataValue = hShowRecords.get(prmModuleFieldM.getFieldID());
		if (objDataValue != null) {
			valueData = objDataValue;
		}
	}	
	String tagShow = MasterUtil.displayManualTag(request,entityID, prmModuleFieldM.getFieldID(),MasterForm);
	System.out.println("tagShow===>"+tagShow);
	if (i%2 == 0) { 	 
%>    
  <tr>
<% 
	}
%>  
    <td class="title <%=MasterForm.getModuleM().getModuleID()%>_<%=prmModuleFieldM.getFieldID()%>_input"><div class="componentDiv"><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%>       
    </div><%=tagShow%></td><td>&nbsp;</td>

<% 
	if (i%2 != 0) { 	 
%>
  </tr>
 <%
 	} 
  }
 %> 


</td></tr></table></div>

<style>
<%=MasterUtil.generateCustomStyle(null, form, MasterForm, MasterForm.getProcessMode()) %>
</style>

</td></tr>

 

 
    
    </tr>
    
    <tr><td class="underline" colspan="5" align="right" >&nbsp;</td></tr>
  <tr >
  
    <td colspan="4" align="left"> 
    	<% 
    	com.master.model.EntityM entityM =  form.getEntityM();
    	ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
		if (moduleActionM != null && null != moduleActionM.getSearchFilePath() && !"".equals(moduleActionM.getSearchFilePath())) {
    		String searchFilePath = moduleActionM.getSearchFilePath();
    		System.out.println("searchFilePath -> " + searchFilePath);
    		String manualUrlPath = searchFilePath.substring(searchFilePath.indexOf("/", 1));
    		pageContext.setAttribute("manualUrlPath", manualUrlPath);
    		%><jsp:include flush="true" page="<%=manualUrlPath%>"/><%
    	} else {
    		%><jsp:include flush="true" page="resultSearch.jsp"/><%
    	}
    	%>
    </td>
  </tr>
</table>
</form>



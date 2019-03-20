<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
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

	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();

	
	if (vShowSearchRecs.size() > 0) {
%>
<div class="page-hidden panel-pagination">
<%
	if (vShowSearchRecs.size() > 0) {
%>
			
<br>
<div class="row">
	<div class="col-md-6 col-sm-6 col-xs-12">
		<div class="totalpagepadding text-left">
			Total Records found : <strong><%=MasterForm.getAllSearchResultData()%> </strong>
		</div>
	</div>
	<div class="col-md-6 col-sm-6 col-xs-12">
		<nav class="pagealign text-right">
			<ul class="pagination pagging-style">
			<% 		
				int allPage =  MasterForm.getAllSearchResultData() / MasterForm.getVolumePerPage();
				if (allPage*MasterForm.getVolumePerPage()  < MasterForm.getAllSearchResultData()) {
					allPage++;
				}
			%>
				<li>
				<% 		
					if (MasterForm.getPage() != 1) {
				%>   
					<% 
					/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
					* FIX : 201612191556
					* apply AdminLTE theme for responsive2016
					* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
					%>
					<!--<a aria-label="previous" href="#" onclick ="changePageAndSize('<%=(MasterForm.getPage()-1)%>')"> -->
					<a aria-label="previous" href="javascript:void(0)" onclick ="changePageAndSize('<%=(MasterForm.getPage()-1)%>')">
						<span aria-hidden="true">«</span>
					</a>
				<% 
					} else {
				%>    
					<span aria-hidden="true">«</span>
				<% 
					}
				%>	
				</li>
				<% 
				/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				* FIX : 201612191556
				* apply AdminLTE theme for responsive2016
				* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
				%>
				<!-- <li><a href="#"><%=MasterForm.getPage()%></a></li> -->
				<li><a href="javascript:void(0)"><%=MasterForm.getPage()%></a></li>
				<li>
				<% 
					if (allPage != MasterForm.getPage())	{	
				%>
					<% 
					/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
					* FIX : 201612191556
					* apply AdminLTE theme for responsive2016
					* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
					%>
				  	<!-- <a aria-label="next" href="#" onclick ="changePageAndSize('<%=(MasterForm.getPage()+1)%>')">-->
				  	<a aria-label="next" href="javascript:void(0)" onclick ="changePageAndSize('<%=(MasterForm.getPage()+1)%>')">
						<span aria-hidden="true">»</span>
				  	</a>
				 <% 
					} else {
				%>
					<span aria-hidden="true">»</span>
				<% 
					}
				%>	
				</li>
				<li class="pagepadding">Page <%=MasterForm.getPage()%> of <%=allPage%></li>
				<li class="pagepadding">View</li>
				<li><select name="selectPerPage"  onchange="changePageAndSize('1')"> 
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
					</select>
					
					
					
				</li>
				<li class="pagepadding">per page</li>
				
				
<!-- 				<li><select name="dDown"> -->
<%-- 				<%	for (int i= 0;i < vShowColumns.size();i++) { --%>
<!-- 				ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i);  -->
<%-- 					 %> --%>
<%-- 					<option value ="<%=MasterUtil.displayFieldName(moduleM,request)%>"><%=MasterUtil.displayFieldName(moduleM,request)%> --%>
	        
<!-- 					</option> -->
			
		
					
<%-- 					<%} %> --%>
<!-- 					</select>	 -->
<!-- 				</li> -->
				
				
				
			</ul>
		</nav>
	</div>
</div>		
<%
	}
%>		
<br>
</div>
<%
	}
%>
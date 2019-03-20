<%@page import="com.master.util.MasterUtil"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.ModuleOneDisplay" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%
	ModuleOneDisplay mdoDis = new ModuleOneDisplay(request);
//## P-subhead
    String module = (String)request.getSession().getAttribute("module");
	if(request.getParameter("requestModule") != null) {
 		module = request.getParameter("requestModule");
 	}
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	String isToggleMD = "";
	String collapseModule = "";
%>
<%if(!mdoDis.isGrid()){ %>
<% 
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 201612191556
* apply AdminLTE theme for responsive2016
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 20170808 : (MSIG) add toggle module
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */


if("Y".equals(MasterForm.getModuleM().getIsCollapseMD())){

	isToggleMD = " onclick=\"toggle"+module+"()\" ";
	if(null!=request.getSession().getAttribute(module+"CollapseMD")){
		collapseModule = (String)request.getSession().getAttribute(module+"CollapseMD");
	}else if("Y".equals(MasterForm.getModuleM().getDfCollapseMD())){
		collapseModule = "Y";
	}
		
}
%>
<!-- div class="boxboldbelow"  -->
<div class="boxboldbelow box-body" >
	<div class="panel-subheading02" style="width:600px;" <%=isToggleMD%>>
			<% if("Y".equals(MasterForm.getModuleM().getIsCollapseMD())){ %>
				<div id='<%=mdoDis.getModule()%>-arrow' style='float:left;font-size:1.5em;margin-top:0.1em;padding-right:0.15em' class='fa fa-minus'></div>
			<% } %>
				<div class="subheading" ><%=MasterUtil.displayModuleName(MasterForm.getModuleM(), request)%></div>
			</div>
			<div class="<%=module%>-content-header"></div>
			<!-- End P-Subhead -->
<%}%>
<%=mdoDis.oneModuleFieldHTMLResponsive()%>
<%if(!mdoDis.isGrid()){ %>
</div>
<%} %>
<div id="one_module_dialog">
Dialog Div.
</div>
<%if(false){ %>
<div id="buttonCriteria">
	<jsp:include flush="true" page="/buttonManager/buttonManagerRes2016.jsp">
		<jsp:param name="module" value="<%=mdoDis.getModule()%>"/>
		<jsp:param name="action" value="ENTITY_MODULE"/>
	</jsp:include>
</div>
<%} %>
<style>
<%=mdoDis.getCustomStyle()%>
</style>

<script type="text/javascript">
$(document).ready( function() {
	$('#one_module_dialog').dialog({
		autoOpen: false,
		height: 500,
		width: 750,
		modal: true,
		title: 'Popup'
	});
});
function toggle<%=module%>(){
	$("#<%=module%>-content").slideToggle(function(){

		if($("#<%=module%>-content").is(':hidden')){
			$("#<%=module%>-arrow").attr('class','fa fa-plus');
			setSession<%=module%>Collapse("Y");
		}else{
			$("#<%=module%>-arrow").attr('class','fa fa-minus');
			setSession<%=module%>Collapse("N");
		}	
	});
	
}
function setSession<%=module%>Collapse(flag){

	var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.display.many.ModuleManySession&moduleID=<%=module%>&collapseFlag="+flag;
		jQuery.ajax({
		type: "POST",
		url: uri,
		async: false,
		success: function(data){
			//console.log("collapse ===>"+data)
		}
	});
	
}
<% if("Y".equals(collapseModule)){ 
	//default collapse module
%>
toggle<%=module%>();
<% } %>
</script>

<%@ page import="com.master.form.MasterFormHandler" %>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page import="com.master.util.MasterConstant"%>
<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);		
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID + "_session";
	System.out.println("entitySession ==> " + entitySession);	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
%>

<script language="javascript">
function <%=module%>PGAndS(indexPage) {
	var page = 0;
	if (indexPage == 0) {
		page = 1;
	} else {
		page = parseInt(document.masterForm.<%=module%>page.value) + parseInt(indexPage);
	}

	//use value in masterForm JAVA model
	document.getElementById("<%=module%>_orderBy").value = "";
	document.getElementById("<%=module%>_orderByType").value = "";
	
	//ajaxEventScript		
	changeManyPerPage(page,document.masterForm.<%=module%>VolPerPG.value,'<%=module%>','<%=module%>MG');
}

function <%=module%>changePageAndSize(page) {
	//use value in masterForm JAVA model
	document.getElementById("<%=module%>_orderBy").value = "";
	document.getElementById("<%=module%>_orderByType").value = "";
	
	//ajaxEventScript		
	changeManyPerPage(page,'<%=MasterForm.getVolumePerPage()%>','<%=module%>','<%=module%>MG');
}
</script>
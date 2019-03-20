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

<script type="text/javascript">
function <%=module%>ManyOrder(tableHeadName, currentColNum, orderBy, orderByType) {
//	var page = 0;
//	if (indexPage == 0) {
		page = 1;
//	} else {
//		page = parseInt(document.masterForm.<%=module%>page.value) +parseInt(indexPage);
//	}

	if(null != orderBy && "" != orderBy && null != orderByType && "" != orderByType){
		document.getElementById("<%=module%>_orderBy").value = orderBy;
		document.getElementById("<%=module%>_orderByType").value = orderByType;
	}

	if(null != tableHeadName && "" != tableHeadName){
		document.getElementById("<%=module%>_tableHeadNameFocus").value = tableHeadName;
		document.getElementById("<%=module%>_tableHeadColFocus").value = currentColNum;
	}
	
	//ajaxEventScript
	changeManyPerPage(page,'ALL','<%=module%>','<%=module%>MG');
}
</script>
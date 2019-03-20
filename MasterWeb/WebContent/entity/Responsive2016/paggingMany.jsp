<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%
	String module = (String) request.getSession().getAttribute("module");
	MasterFormHandler masterForm = EAFManualUtil.getModuleForm(request, module);
	EntityFormHandler form = EAFManualUtil.getEntityForm(request);
	
	/*
	set masterForm.getVolumePerPage() = 10 for protect devide by zero exception
	*/
	if(masterForm.getVolumePerPage() == 0) {
		masterForm.setVolumePerPage(10);
	}
	int allPage =  masterForm.getAllSearchResultData() / masterForm.getVolumePerPage();
	if (allPage*masterForm.getVolumePerPage()  < masterForm.getAllSearchResultData()) {
		allPage++;
	}
	
	pageContext.setAttribute("masterForm", masterForm);
%>
<style>
.pagination .dropdown .dropdown-menu {
	min-width: 86px;
}
#module-many-button {
	
}
#module-many-pagging {
    position: relative;
    right: 0px;
    top: 0px;
    float: right;
}
#module-many-button .btn-default:last-child {
	margin-right: 0px;
}
</style>

<ul class="pagination pagination-sm no-margin pull-right navbar-nav navbar-rightXXX">
<% 
if (masterForm.getPage() != 1) {
	%>
	<li><a href="javascript:void(0)" name ="<%=module%>first"  onclick="changeManyPerPage('1','<%=masterForm.getVolumePerPage()%>','<%=module%>','<%=module%>MG')"><<</a></li>
	<li><a href="javascript:void(0)" name ="<%=module%>pre"  onclick="<%=module%>PGAndS(-1)">«</a></li>
	<%
} else {
	%>
	<li><a href="javascript:void(0)" name ="<%=module%>pre"  disabled="disabled" style="cursor: not-allowed;">«</a></li>
	<% 
}

%>

<li><a href="javascript:void(0)" style="cursor: default;"><%=masterForm.getPage()%>/<%=allPage%></a></li>


	<% 
		if (allPage != masterForm.getPage())	{	
%>
			<li><a href="javascript:void(0)" name ="<%=module%>next"  onclick="<%=module%>PGAndS(1)">»</a></li>
<%
		} else {
%>
			<li><a href="javascript:void(0)" name ="<%=module%>next"  disabled="disabled" style="cursor: not-allowed;">»</a></li>
<% 
		}
%>

<li class="dropdown">

<input type="hidden" name="<%=module%>VolPerPG" value="<%=masterForm.getVolumePerPage() %>">
<input type="hidden" name="<%=module%>page" value="<%=masterForm.getPage()%>">

<a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Display <%=masterForm.getVolumePerPage() %><b class="caret"></b></a>
<ul class="dropdown-menu" >

<%

int[] volumes ={10,20};
String selected ="";
System.out.println("volumes.length===>"+volumes.length);
for (int i=0; i < volumes.length;i++) {
	int volume = volumes[i];
	%>
	<li><a href="javascript:$('[name=<%=module%>VolPerPG]').val(<%=volume %>);<%=module%>PGAndS(0);"><%=volume %></a></li>
	<%
}
%>	
</ul>
</li>

</ul>

<jsp:include flush="true" page="../paggingManyEventScript.jsp"/>
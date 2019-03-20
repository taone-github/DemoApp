<%@ page import="com.master.form.MasterFormHandler" %>
<%@page import="com.master.form.EntityFormHandler"%>

<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler masterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);		
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID + "_session";
	System.out.println("entitySession ==> " + entitySession);	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);	
%>

<table width = "100%" cellpadding="0" cellspacing="0">
<tr>
<td align="right">
<input type="hidden" name ="<%=module%>page" value="<%=masterForm.getPage()%>">
<% 
	if (masterForm.getPage() != 1) {
%>
<input type="button" name ="<%=module%>pre"  value="<" onclick="<%=module%>PGAndS(-1)" >
<% 
	} else {
%>
<input type="button" name ="<%=module%>pre"  value="<" disabled="disabled" >
<% 
	}
%>
<select name="<%=module%>VolPerPG"  onchange="<%=module%>PGAndS(0)">
<% 
    int[] volumes ={10,20};
	String selected ="";
	System.out.println("volumes.length===>"+volumes.length);
	for (int i=0; i < volumes.length;i++) {
		selected ="";
		int volume = volumes[i];
		System.out.println("volume===>"+volume);
		if (volume == masterForm.getVolumePerPage()) {
			selected = "selected";
		}
%>
	
<option value ="<%=volume%>" <%=selected%>><%=volume%></option>
<%
	}
%>
</select>
<% 
		int allPage =  masterForm.getAllSearchResultData() / masterForm.getVolumePerPage();
		if (allPage*masterForm.getVolumePerPage()  < masterForm.getAllSearchResultData()) {
			allPage++;
		}
		if (allPage != masterForm.getPage())	{	
%>
			<input type="button" name ="<%=module%>next" value=">" onclick="<%=module%>PGAndS(1)" >
<%
		} else {
%>
			<input type="button" name ="<%=module%>next" value=">" disabled="disabled"  >
<% 
		}
%>
<%=masterForm.getPage()%>/<%=allPage%>
</td>
</tr>
</table>

<jsp:include flush="true" page="../paggingManyEventScript.jsp"/>

<%@ page import="com.master.form.MasterFormHandler" %>
<%@page import="com.master.form.EntityFormHandler"%>
<%@ page import="com.master.util.MasterUtil" %>
<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler masterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);		
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID + "_session";
	System.out.println("entitySession ==> " + entitySession);	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	
	//Sam change pagging Many 
	boolean oldPagging = false;
	if(oldPagging){	
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
		if (allPage > 1 && allPage != masterForm.getPage())	{	
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

<!-- Sam new paging(like search result) -->
<% 
}else{	
	int startRec =((masterForm.getPage()-1)*masterForm.getVolumePerPage())+1;
	int finishRec = startRec + masterForm.getVolumePerPage()-1;
	if(finishRec > masterForm.getAllSearchResultData()){
		finishRec = masterForm.getAllSearchResultData();
	}
	int allPage =  masterForm.getAllSearchResultData() / masterForm.getVolumePerPage();
	int lastPage = (masterForm.getAllSearchResultData()/masterForm.getVolumePerPage());
	if ((masterForm.getAllSearchResultData()%masterForm.getVolumePerPage())>0)  {
		lastPage++;
	}
	
	
	String strFirstPage ="";
	
	if (masterForm.getPage()==1) {
		strFirstPage = "<strong><font class=\"text\">1</font></strong>";	
	} else {
		strFirstPage = "<a href=\"#\" onclick =\""+module+"changePageAndSize('1')\"><font class=\"text\">1</font></a>";
	}
	
	
	
	String strLastPage = "";
	if (lastPage > 1) {
		if (lastPage == masterForm.getPage()){
			strLastPage = "<strong><font class=\"text\">"+Integer.toString(lastPage)+"</font></strong>";
		} else {
			strLastPage = "<a href=\"#\" onclick =\""+module+"changePageAndSize('"+Integer.toString(lastPage)+"')\"><font class=\"text\">"+Integer.toString(lastPage)+"</font></a>";
		}	
	} else {
		strLastPage	 = "";	
	}
	
	int lengthPage = 5; 
	String strScript = "";
	String strScriptBack = "";	
	String strFirst =  "<a href=\"#\" onclick =\""+module+"changePageAndSize('1')\"><font class=\"text\">First</font></a>";
	String strLast =  "<a href=\"#\" onclick =\""+module+"changePageAndSize('"+lastPage+"')\"><font class=\"text\">Last</font></a>";
	
	if (allPage*masterForm.getVolumePerPage()  < masterForm.getAllSearchResultData()) { 
		allPage++;
	}
	if (allPage != masterForm.getPage())	{	
		strScript = "<a href=\"#\" onclick =\""+module+"changePageAndSize('"+(masterForm.getPage()+1)+"')\"><font class=\"text\">Next</font></a>";
	} else {
		strScript = "Next";
	}
	
	if (masterForm.getPage() != 1) {    
		strScriptBack = "<a href=\"#\" onclick =\""+module+"changePageAndSize('"+(masterForm.getPage()-1)+"')\"><font class=\"text\">Prev</font></a>";			
	} else {	    
		strScriptBack = "Prev";	 
	}
	
	String showPage = MasterUtil.getInstance().displayPage(lengthPage,masterForm.getPage(),lastPage);
	
	
%>
	
<table border="0" cellspacing=1 cellpadding=1 width="100%" >
    <tr >
      <td class="text"><span class="pagebanner"><%=masterForm.getAllSearchResultData()%> items found, displaying <%=startRec%> to <%=finishRec%></span><span class="pagelinks">[<%=strFirst%> / <%=strScriptBack%>&nbsp;<strong><%=strFirstPage%><%=showPage%><%=strLastPage%></strong>&nbsp; <%=strScript%> / <%=strLast%>]</span> </td>
    </tr>
</table>
<%} %>
<jsp:include flush="true" page="../paggingManyEventScript.jsp"/>

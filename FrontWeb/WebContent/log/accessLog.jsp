<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Locale"%>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.oneweb.j2ee.system.LoadXML"%>
<%@page import="com.front.utility.accesslog.AccessLogManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.front.constant.FrontMenuConstant"%>
<jsp:useBean id="logForm" scope="session" class="com.front.view.form.accesslog.LogFormHandler"/>
<jsp:setProperty name="formHandlerManager" property="currentFormHandler" value="logForm"/>
<link rel="stylesheet" href="css/log/styles.css" type="text/css">
<script language="JavaScript" src="js/popcalendar.js"type="text/javascript"></script>
<script language="JavaScript" src="js/keypress.js"type="text/javascript"></script>
<script language="JavaScript" src="js/logscript.js"type="text/javascript"></script>
<script language="JavaScript" src="js/general.js"type="text/javascript"></script>
<script language="JavaScript" src="js/validData.js"type="text/javascript"></script>
<script type="text/javascript">

document.body.onbeforeprint = function(){
	document.getElementById('sCriteria').style.display = "none";
	document.getElementById('resultTable').cellpadding = "0";
	document.getElementById('resultTable').cellspacing = "0";
	document.getElementById('resultTable').border = "1";
	document.getElementById('resultTable').bordercolor="#FFFFFF";
	
}
document.body.onafterprint = function(){
	document.getElementById('sCriteria').style.display = "block";
	document.getElementById('resultTable').border = "0";
	document.getElementById('resultTable').cellpadding = 1;
	document.getElementById('resultTable').cellspacing = 1;
}
</script>
<%
int lastPage = (logForm.getTotalResult()%logForm.getPageSize()==0)?logForm.getTotalResult()/logForm.getPageSize():logForm.getTotalResult()/logForm.getPageSize()+1 ; 
%>
<form action="FrontController" method="post" name="form">
<input type="hidden" name="action" value="<%=logForm.getAction()%>">
<input type="hidden" name="s" value="<%=logForm.getAction() %>">
<input type="hidden" name="handleForm" value="Y">
<input type="hidden" name="userName" value="">
<input type="hidden" name="pageNo" id="pageNo" value="<%=logForm.getCurrentPage() %>">
<input type="hidden" name="itemsPerPage" value="<%=logForm.getPageSize() %>">
<div id="sCriteria">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
		<td class="headerTitle" valign="middle"><%=logForm.getTitle() %></td>
	</tr>
</table>


<TABLE cellSpacing=0 cellPadding=0 width="90%" align=center border=0 align="center">
<tr>
				<td valign="bottom" width="24"><img src="images/log/line_top_left.gif" width="24" height="25"></td>				 
				<td class=blueheader><img src="images/log/table_search.gif" width="24" height="25">Search Criteria</td>
				<td valign="bottom" colspan="4"><img src="images/log/line_top.gif" width="100%" height="25"></td>				
				<td  valign="bottom" width="24"><img src="images/log/line_top_right.gif" width="24" height="25"></td>
				</tr>
  <tr>
  <td background="images/log/line_left.gif"> &nbsp;</td>
  <td colspan="5">&nbsp;</td>
  <td background="images/log/line_right.gif"> &nbsp;</td>
  </tr>
  <tr>
  <td background="images/log/line_left.gif"> &nbsp;</td>
  <td colspan="5"><!-- Detail -->
		<table border="0" class="text" cellpadding="1" cellspacing="1">
			<tr>
				<td width="100"><div align="left">Username </div></td>
				<td width="150"><input type="text" name="userNameTextbox" id="userNameTextbox" class="textbox" onFocus="overTextBox(this);" onBlur="outTextBox(this)" value="<%=logForm.getUsername() %>"/></td>
				<td width="100"><div align="left"><%=logForm.getCriterialName1() %></div></td>
				<td width="150"><select name="criterialSelectBox1" id="criterialSelectBox1" class="selectstyle" onchange="javascript:changeCriterialSelectBox1();">
					<option value="">All</option>
					<%Object[] key1 = logForm.getCriterialList1().keySet().toArray();
					Object[] value1 = logForm.getCriterialList1().values().toArray();
					Arrays.sort(value1);
					for(int j=0;j<value1.length;j++){
					for(int i=0;i<key1.length;i++){ 
					if(value1[j].equals(logForm.getCriterialList1().get(key1[i]))){%>
					<option value="<%=key1[i]%>" <%=key1[i].toString().equals(logForm.getCriterialValue1())?"SELECTED":"" %>><%=logForm.getCriterialList1().get(key1[i]) %></option>
					<%} } }%>
				</select></td>
			</tr>
			<%if(logForm.getCriterialName2()!=null && logForm.getCriterialName3()!=null){ %>
			<tr>
				<td ><div align="left"><%=logForm.getCriterialName2() %></div></td>
				<td><input type="text" name="criterialTextbox2" id="criterialTextbox2" class="textbox" onFocus="overTextBox(this);" onBlur="outTextBox(this)" value="<%=logForm.getCriterialValue2() %>"/></td>
				<td ><div align="left"><%=logForm.getCriterialName3() %></div></td>
				<td ><select name="criterialSelectBox3" id="criterialSelectBox3" class="selectstyle">
					<option value="">All</option>
					<%Object[] key3 = logForm.getCriterialList3().keySet().toArray();
					Object[] value3 = logForm.getCriterialList3().values().toArray();
					Arrays.sort(value3);
					for(int j=0;j<value3.length;j++){
					for(int i=0;i<key3.length;i++){ 
					if(value3[j].equals(logForm.getCriterialList3().get(key3[i]))){%>
					<option value="<%=key3[i] %>" <%=key3[i].toString().equals(logForm.getCriterialValue3())?"SELECTED":"" %>><%=logForm.getCriterialList3().get(key3[i]) %></option>
					<%} } }%>
				</select></td>
			</tr>
			<%} %>
			<%if(logForm.getCriterialName2()==null && logForm.getCriterialName3()!=null){ %>
			<tr>
				<td></td>
				<td></td>
				<td><div align="left"><%=logForm.getCriterialName3() %></div></td>
				<td ><select name="criterialSelectBox3" id="criterialSelectBox3" class="selectstyle">
					<option value="">All</option>
					<%Object[] key3 = logForm.getCriterialList3().keySet().toArray();
					Object[] value3 = logForm.getCriterialList3().values().toArray();
					Arrays.sort(value3);
					for(int j=0;j<value3.length;j++){
					for(int i=0;i<key3.length;i++){ 
					if(value3[j].equals(logForm.getCriterialList3().get(key3[i]))){%>
					<option value="<%=key3[i] %>" <%=key3[i].toString().equals(logForm.getCriterialValue3())?"SELECTED":"" %>><%=logForm.getCriterialList3().get(key3[i]) %></option>
					<%} } }%>
				</select></td>
			</tr>
			<%} %>
			<tr>
				<td class="text"><div align="left">Date :</div></td>
				<td>From <input type="text" name="fromDateTextbox" id="fromDateTextbox" class="textbox" maxlength="10" size="10" onFocus="overTextBox(this);" onblur="javascript:outTextBox(this);checkDate(this);checkEndMoreThanStart('fromDateTextbox','fromDateTextbox','toDateTextbox');" onkeypress="javascript:keyPressInteger(); addSlashFormat('fromDateTextbox');return func_Num_Date(this, event);" value="<%=logForm.getFromDate()==null?"":new SimpleDateFormat("dd/MM/yyyy",Locale.US).format(logForm.getFromDate()) %>" /> <img style="cursor:hand" src="images/log/calendar.gif" onclick="popUpCalendar(this,fromDateTextbox,'dd/mm/yyyy')" alt="" /></td>
				<td colspan="2">To <input type="text" name="toDateTextbox" id="toDateTextbox" class="textbox"  maxlength="10" size="10" onFocus="overTextBox(this);" onblur="javascript:outTextBox(this);checkDate(this);checkEndMoreThanStart('toDateTextbox','fromDateTextbox','toDateTextbox');" onkeypress="javascript:keyPressInteger();addSlashFormat('toDateTextbox');return func_Num_Date(this, event);" value="<%=logForm.getToDate()==null?"":new SimpleDateFormat("dd/MM/yyyy",Locale.US).format(logForm.getToDate()) %>" /> <img style="cursor:hand" src="images/log/calendar.gif" onclick="popUpCalendar(this,toDateTextbox,'dd/mm/yyyy')" alt="" /></td>
			</tr>
			
		</table>
		<!-- End Detail --></td>		
		<td background="images/log/line_right.gif">&nbsp;</td>
		</tr>
		<tr>
		  <td background="images/log/line_left.gif"> &nbsp;</td>
		  <td colspan="5">&nbsp;</td>
		  <td background="images/log/line_right.gif"> &nbsp;</td>
		  </tr>
			 <tr>
				<td width="24"><img src="images/log/line_bot_left.gif" width="24" height="25"></td>
				<td valign="middle" width="35%"><img src="images/log/line_bot.gif" width="100%" height="25"></td>
				<td ><img src="images/log/line_bot_v.gif" width="24" height="25"></td>
			
			    <td align="center" width="34%">
			    <input id="searchButton" name="searchButton" type="button" class="button" value="Search" onclick="search()" /> &nbsp;&nbsp; <input id="resetButton" name="resetButton" type="button" class="button" value="Reset" onClick="resetform()" />
			    </td>
				<td><img src="images/log/line_bot_v.gif" width="24" height="25"></td>
				<td width="30%"><img src="images/log/line_bot.gif" width="100%" height="25"></td>				
				<td width="24" ><img src="images/log/line_bot_right.gif" width="24" height="25"></td>
			
			  </tr> 
			  
			</table>
</div>
<%if(logForm.getResultList()!=null){ 
  
    int start = 0;
    int end = 0;
    String displaying="";
    if (logForm.getCurrentPage()==1){
        start = 1;
    }else{
    	start = (logForm.getPageSize() * (logForm.getCurrentPage()-1) +1);
    }
    if (logForm.getResultList() !=null){
    	if (logForm.getResultList().size() > logForm.getTotalResult()){
    		displaying = ", displaying "+start+" to "+ (logForm.getPageSize() * logForm.getCurrentPage())+"";
    	}
    	else if (logForm.getResultList().size() == logForm.getTotalResult()&& logForm.getResultList().size() !=0){
    		displaying = ", displaying "+start+" to "+ logForm.getResultList().size()+"";
    	}
    	else if (logForm.getResultList().size() < logForm.getTotalResult() && logForm.getResultList().size() != 0 && logForm.getTotalResult() ==1){
    		displaying = ", displaying 1 to "+ logForm.getResultList().size()+"";
    	}
    	else if (logForm.getResultList().size() < logForm.getTotalResult() && logForm.getResultList().size() != 0 && logForm.getTotalResult() > 1){    	    	
    		displaying = ", displaying "+start+" to "+ (logForm.getResultList().size()+ (logForm.getPageSize() * (logForm.getCurrentPage()-1)))+"";
    	}
    }
  %>

<table width="99%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td colspan="2"><img src="images/log/c.gif" alt="" width="100%" height="5" /></td>
	</tr>
	<tr>	
	<td colspan="2">
	<%	 if (logForm.getResultList() !=null && logForm.getResultList().size()>0){%>
	<div align="right"><span class="textTop"><%=logForm.getTotalResult() %> Item(s) found <%=displaying %>  </span></div>
	<%} %>
	</td>
	</tr>
	<tr>
	<td>&nbsp;
	<%if (logForm.getResultList()!=null && logForm.getResultList().size()>0){%>
	<input type="button" value="Print" onClick="window.print()" class="button">
	<%} %>
	</td>
	
	<td align="right" class="textTop">
<% 
	if (logForm.getResultList().size() > 0) {
	if (logForm.getCurrentPage() != 1) {
%>    
    	<input type="button" name ="previous" value="<" onclick ="goToPage('<%=(logForm.getCurrentPage()-1)%>')" class="button">
<% 
	} else {
%>    
	  <input type="button" name ="previous" value="<"  disabled="disabled" class="button">
<% 
	}
%>    
        
    <select name="selectPerPage"  onchange="goToPage('1')"> 
<% 	
	Vector v = new Vector(LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getItemPerPageMap().keySet());
	for(int i =0;i< v.size();i++) {
		if (logForm.getPageSize() == Integer.parseInt((String)LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getItemPerPageMap().get(Integer.toString(i+1)))) {
%>     
     		<option value ="<%=(String)LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" selected ><%=(String)LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<% 
		} else {
%>
	    	<option value ="<%=(String)LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" ><%=(String)LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<%	
		}
	}
%>     
     
    </select> 
<% 
	int allPage =  logForm.getTotalResult() / logForm.getPageSize();
	if (allPage*logForm.getPageSize()  < logForm.getTotalResult()) {
		allPage++;
	}
	if (allPage != logForm.getCurrentPage())	{	
%>    
    
    <input type="button" name ="next" value=">" onclick ="goToPage('<%=(logForm.getCurrentPage()+1)%>')" class="button"> 
<% 
	} else {
%>
    <input type="button" name ="next" value=">"  disabled="disabled" class="button"> 
<% 
	}
%>

 <%=logForm.getCurrentPage() %>/<%=allPage%>
<%	
	}	
%>    
    
	</td>
	</tr>
	<tr>
		<td align="center" class="textError"  colspan="2"><!-- Detail -->
		<%if(logForm.getResultList().size()==0){ %>
		<div>No Data Found</div>
		<%}else{ %>
		<table border="0" width="100%">
			<tr class="tableRow">
				<td>
				<div>
				<table id="resultTable" border="0" cellpadding="1" cellspacing="1" bgcolor="#636384" width="100%">
					<tr id="resultTableH" class="tableHeader" align="left">
						<td ><div align="center" class="style2"><%=logForm.getColumnName()[0] %></div></td>
						<td><div align="center" class="style2"><%=logForm.getColumnName()[1] %></div></td>
						<td width="10%"><div align="center" class="style2"><%=logForm.getColumnName()[2] %></div></td>
						<td width="15%"><div align="center" class="style2"><%=logForm.getColumnName()[3] %></div></td>
						<td width="10%"><div align="center" class="style2"><%=logForm.getColumnName()[4] %></div></td>
						<td ><div align="center" class="style2"><%=logForm.getColumnName()[5] %></div></td>
					</tr>
					<%int offset = ((logForm.getCurrentPage()-1)*logForm.getPageSize())+1;
					for(int i=0;i<logForm.getResultList().size();i++){
					
						Vector result = (Vector)logForm.getResultList().get(i);
						%>
						
					<tr class="tableRow<%=(i%2==0)?"":"2" %>" valign="top">
						<td width="5%"><div align="center"><%=i+offset %></div></td>
						<td width="10%"><div align="center"><%=result.get(0) %></div></td>
						<td  width="10%"> <div align="center"><%=result.get(1) %></div></td>
						<td><div align="center"><%=result.get(2) %></div></td>
						<td><div align="center"><%=result.get(3) %></div></td>
						<td  width="35%">
						<b>New Data</b><br>
						<div align="left"><%=DisplayFormatUtil.replace(result.get(4).toString().substring(1,result.get(4).toString().length()-1),",","<br>")%></div>
						<%if(result.get(5)!=null){ %>
						<hr>
						<b>Old Data</b><br>
						<div align="left"><%=DisplayFormatUtil.replace(result.get(5).toString().substring(1,result.get(5).toString().length()-1),",","<br>")%></div>
						<%} %>
						</td>
						
					</tr>
					<%} %>
				</table>
				</div>
				</td>
			</tr>
			
		</table>
		<%} %>
		<!-- End Detail --></td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100%"><img src="images/log/c.gif" alt="" width="100%" height="5" /></td>
	</tr>
</table>
</form>
<script language="javascript" type="text/javascript">
<!--

top.clearConsole();
createPath();
function search(){
	top.clearConsole();
	var usernameTextbox = document.getElementById("userNameTextbox");
	var fromDateTextbox = document.getElementById("fromDateTextbox");
	var toDateTextbox = document.getElementById("toDateTextbox");
	var ok = 'Y';
	if(!usernameTextbox||usernameTextbox.value.length==0){
		top.writeConsole("Please fill in Username");
		ok='N';		
	}
   if (ok == 'Y'){
   		document.getElementById('resetButton').disabled = true;
		document.getElementById('searchButton').disabled = true;
		document.form.submit();
	}	
}
function changeCriterialSelectBox1(){
<%if("SEARCH_TRANSACTION_LOG".equals(logForm.getAction())){%>
	var criterialSelectBox1 = document.getElementById("criterialSelectBox1");
	var criterialSelectBox3 = document.getElementById("criterialSelectBox3");
	var value = criterialSelectBox1.options[criterialSelectBox1.selectedIndex].value;
	if(value==''||value=='CLT'||value=='IWC') criterialSelectBox3.disabled = false;
	else criterialSelectBox3.disabled = true;
<%}%>
}


function createPath(){
	top.createPath("Logs >"+"<%=logForm.getTitle()%>");
}

function resetform(){
	var action = document.getElementById("action");
	action.value = "INIT_SEARCH_LOG";
	document.getElementById("userName").value='<%=logForm.getUsername()%>';
	document.getElementById("handleForm").value="N";
	document.getElementById('resetButton').disabled = true;
	document.getElementById('searchButton').disabled = true;
	document.form.submit();
}

// -->
</script>
<%if (logForm.hasErrors()) {
		Vector v = logForm.getFormErrors();
		for (int i = 0; i < v.size(); i++) {
			//out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(i) + "</span><br>");
				out.print("<script>top.writeConsole('"+v.elementAt(i)+"','red')</script>");
		}
	} 
%>
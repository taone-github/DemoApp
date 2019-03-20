<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.util.MasterConstant"%>
<%
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	Vector vResult = MasterForm.getVMasterModelMs();
	Vector dataVect = (Vector)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_VECTOR);
	HashMap keyColumn = (HashMap)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_KEY);
	com.master.util.Log4jUtil.log("keyColumn : " + keyColumn);
	Vector errVector = (Vector)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_ERROR);
	HashMap redField = (HashMap)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_REDFIELD);
	
%>
Excel Mode
<br>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%><div id="module-excel-button" style="width:100%" >
	<input type="button" value="Validate" onclick="validateExcel()"/>
	<input type="button" value="Submit" onclick="swapToDetailMany('save')"/>
	<input type="button" value="Cancel" onclick="swapToDetailMany('cancel')"/>
</div>
<div id="excel_<%=module%>Error">
<%
	if(null!=errVector){
		for (int s = 0; s < errVector.size(); s++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + errVector.elementAt(s) + "</span><br>");
		}
	}
%>
</div>
<table width="100%" cellpadding="0" cellspacing="0" align="center" >
	<tbody>
		<tr>
<%
//Header
String tableName = "";
for (int i= 0;i < vResult.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vResult.get(i);
	tableName = moduleM.getTableName();

%>  
			<td class="headtable1 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header">
				<div class="fontheadtable1"><%=MasterUtil.displayFieldName(moduleM,request)%>
				<%if(keyColumn.containsKey(moduleM.getFieldID())){ %>
				<span class ="TextWarningNormal">*</span>
				<%} %>
				</div>
			</td>
<%}//End Header %>
		</tr>
<%

	for (int i= 0;i < dataVect.size();i++) {//Row
		HashMap storeAction = (HashMap) dataVect.get(i);
		HashMap data = (HashMap)storeAction.get(tableName);
		HashMap hRedfield = (HashMap)redField.get(i);
%>
		<tr>
			<%
				for (int k =0;k < vResult.size();k++ ) {//Column
					ModuleFieldM  moduleFieldM = (ModuleFieldM)vResult.get(k);
		  			String fieldId = moduleFieldM.getModuleID() + "_" + moduleFieldM.getFieldID() + "_" + i;

					String updateOnChange = "onchange=\"saveExcel('"+moduleFieldM.getModuleID()+"', '"+moduleFieldM.getFieldID()+"','"+i+"')\"";
					if(moduleFieldM.getObjType().equals(MasterConstant.DATEBOX)){
						updateOnChange += " onkeydown= \"javascript:DateFormat(this,this.value,event,false,'1')\" onblur=\"javascript:checkDate(this,false)\"";
					}
					
					String markField = "";
					if(null!=hRedfield && hRedfield.containsKey(moduleFieldM.getFieldID())){
						markField += "style=\"background-color: red\"";
					}
					
					String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,data,MasterForm.getHAllobjects());
			%>
				<td  class="datatable-many" >
						<input id="<%=fieldId%>" type="text" <%=updateOnChange%> value="<%=strSearchResult%>" <%=markField%>/>
				</td>
			<%}//End Column %>
		</tr>
		
<% 
	}//End Row
%>			
	</tbody>
</table>
<script language="JavaScript">
function saveExcel(moduleId , fieldId , index){
	var value = $('#'+moduleId+'_'+fieldId+'_'+index).val();
	var dataString = "mode=edit&module="+moduleId+"&fieldId="+fieldId+"&index="+index+"&value="+value;
	jQuery.ajax({
		type: "POST",
		data: dataString,
		url: "<%=request.getContextPath()%>/ManualServlet?className=manual.eaf.many.ProcessExcelMany",
		success: function(data){
			//$('#excel_'+moduleId+'Error').html('');
			//$('#excel_'+moduleId+'Error').html(data);
		}
	});
}

function swapToDetailMany(mode) {
	var dataString = "mode="+mode+"&module=<%=module%>";
	jQuery.ajax({
		type: "POST",
		data: dataString,
		url: "<%=request.getContextPath()%>/ManualServlet?className=manual.eaf.many.ProcessExcelMany",
		success: function(data){
			<%=module%>CreateRow();
		}
	}); 
}

function validateExcel(){
	var dataString = "mode=validate&module=<%=module%>";
	jQuery.ajax({
		type: "POST",
		data: dataString,
		url: "<%=request.getContextPath()%>/ManualServlet?className=manual.eaf.many.ProcessExcelMany",
		success: function(data){
			<%=module%>SwapToImportExcel();
		}
	});
}

</script>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="java.util.LinkedHashMap"%>
<%@ page import="com.master.model.DynaListPropM"%>
<%@ page import="com.master.model.DynaListValueM"%>

<%
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	Vector vResult = MasterForm.getVMasterModelMs();
	Vector dataVect = (Vector)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_VECTOR);
	HashMap keyColumn = (HashMap)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_KEY);
	Vector keyColumnValidate = (Vector)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_HEADCOLUMN);
	
	com.master.util.Log4jUtil.log("keyColumnValidate :"+keyColumnValidate);
	Vector errVector = (Vector)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_ERROR);
	HashMap redField = (HashMap)request.getSession().getAttribute(MasterConstant.EAF_SESSION.EXCEL_REDFIELD);
	//com.master.util.Log4jUtil.log("keyColumn : " + keyColumn);
	

	com.master.util.Log4jUtil.log("keyColumn : " + keyColumn);
	LinkedHashMap lhFieldColumn = new LinkedHashMap();
	String entityID = (String)request.getSession().getAttribute("entityID");
	HashMap objValue = MasterForm.getStoreHashMap();
	HashMap objHTMLHashMap = MasterForm.getHAllobjects(); 
	com.master.util.Log4jUtil.log("entityID : " + entityID);
	String selectdOption="";
	int processID=0;
%>
Excel Mode
<br>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%><div id="module-excel-button" style="width:100%" >
	<input type="button" value="Validate" onclick="validateExcel()"/>
<%
if(null!=errVector){ //swapToDetailMany('save')
	if(errVector.size()==0){%>
	<input id="save_excel" type="button" value="Save" onclick="saveEntity()"/>
<%	}
} %>
	<input type="button" value="Cancel" onclick="swapToDetailMany('cancel')"/>
</div>
<div id="excel_<%=module%>Error">
<%
	//alert($('#submitExcel'));
	if(null!=errVector){
		for (int s = 0; s < errVector.size(); s++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + errVector.elementAt(s) + "</span><br>");
		}
		//$('#submitExcel').attr("disabled", true);
	}else{
		//$('#submitExcel').attr("disabled", false);
	}
%>
</div>
<table width="100%" cellpadding="0" cellspacing="0" align="center" >
	<tbody>
		<tr>
<%
//Header

com.master.util.Log4jUtil.log("excel template >>>>"+vResult);
String tableName = "";
for (int i= 0;i < vResult.size();i++) {
	ModuleFieldM  moduleM = (ModuleFieldM)vResult.get(i);
	tableName = moduleM.getTableName();

%>  
			<td class="headtable1 <%=moduleM.getModuleID()%>_<%=moduleM.getFieldID()%>_header">
				<div class="fontheadtable1"><%=MasterUtil.displayFieldName(moduleM,request)%>
				<%if(keyColumnValidate.contains(moduleM.getFieldID())){ %>
				<span class ="TextWarningNormal">*</span>
				<%} %>
				</div>
			</td>
<%}//End Header %>
		</tr>
<%
com.master.util.Log4jUtil.log("excel template dataVect>>>>"+dataVect);
	for (int i= 0;i < dataVect.size();i++) {//Row
		HashMap storeAction = (HashMap) dataVect.get(i);
		HashMap data = (HashMap)storeAction.get(tableName);
		HashMap hRedfield = (HashMap)redField.get(i);
		com.master.util.Log4jUtil.log("masterForm data>>>"+data);
%>
		<tr>
			<input type="hidden" id="TMP_ID_<%=i%>" value="<%=data.get("TMP_ID")%>" >
			<%
				processID = Integer.parseInt((String)data.get("PROCESS_ID"));
				for (int k =0;k < vResult.size();k++ ) {//Column
					ModuleFieldM  moduleFieldM = (ModuleFieldM)vResult.get(k);
		  			String fieldId = moduleFieldM.getModuleID() + "_" + moduleFieldM.getFieldID() + "_" + i;

					String updateOnChange = "onchange=\"saveExcel('"+moduleFieldM.getModuleID()+"', '"+moduleFieldM.getFieldID()+"','"+i+"')\"";
					if(moduleFieldM.getObjType().equals(MasterConstant.DATEBOX)){
						updateOnChange += " onkeydown= \"javascript:DateFormat(this,this.value,event,false,'1')\" onblur=\"javascript:checkDate(this,false)\"";
					}
					
					String markField = "";
					//if(null!=hRedfield && hRedfield.containsKey(moduleFieldM.getFieldID())){
					if(keyColumn.containsKey(moduleFieldM.getFieldID())){
						markField += "style=\"background-color: red\"";
					}
					
					String strSearchResult = MasterUtil.getInstance().displaySearchResult(moduleFieldM,data,MasterForm.getHAllobjects());
			
					if (MasterConstant.DYNAMICLISTBOX.equalsIgnoreCase(moduleFieldM.getObjType())) { %>
						
						
						<% 
						
						lhFieldColumn.put(moduleFieldM.getFieldID(), moduleFieldM.getFieldID());
				
						HashMap hFieldProps = (HashMap)objHTMLHashMap.get(moduleFieldM.getObjType());
						Object prmObj = hFieldProps.get(moduleFieldM.getMfID());
						DynaListPropM prmDynaListPropM = (DynaListPropM)prmObj;								

							
						Vector vDynaListValeM = new Vector();
							
						if (moduleFieldM.getVDependencyFields().size() == 0 ) {								
							com.master.util.Log4jUtil.log("Not DependencyFields");
							vDynaListValeM = MasterUtil.getListboxValue(prmDynaListPropM, entityID,request);							
						} else {
							com.master.util.Log4jUtil.log("DependencyFields");
							if ((prmDynaListPropM.getConditionValue() != null) && (prmDynaListPropM.getConditionValue().indexOf("&")!= -1)) {
								vDynaListValeM = MasterUtil.getListboxValue(prmDynaListPropM,moduleFieldM.getVDependencyFields(),objValue, entityID, request);
							} 
						}
						com.master.util.Log4jUtil.log("vDynaListValeM>>>"+vDynaListValeM);
						com.master.util.Log4jUtil.log("updateOnChange>>>"+updateOnChange);
						com.master.util.Log4jUtil.log("markField>>>"+markField);
						%>
						<td  class="datatable-many" >
							<select id="<%=fieldId%>" <%=updateOnChange%>  <%=markField%> >
								<option value="" ></option>
						<%
						for (int d= 0;d < vDynaListValeM.size();d++) {
								DynaListValueM prmDynaListValueM  = (DynaListValueM)vDynaListValeM.get(d);	
								selectdOption = "";
								if(strSearchResult.equals(prmDynaListValueM.getValue())){
									selectdOption = "selected";
								}
									%>
								<option value="<%=prmDynaListValueM.getValue() %>" <%=selectdOption%> ><%=prmDynaListValueM.getShowValue() %></option>
								
								<% 		
						}
						%>
							</select>
						</td>
					<% }else{
						com.master.util.Log4jUtil.log("fieldId>>>>"+fieldId+" value>>"+strSearchResult );
					%>
						<td  class="datatable-many" >
							<input id="<%=fieldId%>" type="text" <%=updateOnChange%> value="<%=strSearchResult%>" <%=markField%>/>
						</td>
					<%}%>
			<%}//End Column %>
		</tr>
		
<% 
	}//End Row
	com.master.util.Log4jUtil.log("end excel template##############");
%>			
	</tbody>
</table>
<input type="hidden" id="PROCESS_ID" value="<%=processID%>" >
<%if (MasterForm.getModuleM().isPagingFlag()) { %>
	<jsp:include flush="true" page="paggingExcel.jsp"/>
<%} %>

<script language="JavaScript">

<% if(null!=errVector){ 
	if(errVector.size()==0){%>
		$("[name='Save']").show();
<% }else{ %>
		$("[name='Save']").hide();
<% }
}%>

function saveExcel(moduleId , fieldId , index){
	$('#save_excel').hide();
	$("[name='Save']").hide();
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
	/*if(mode== "save"){
		if($("#excel_<%=module%>Error").html() != ""){
			return;
		}
	}*/
	
	var dataString = "mode="+mode+"&module=<%=module%>";
	jQuery.ajax({
		type: "POST",
		data: dataString,
		url: "<%=request.getContextPath()%>/ManualServlet?className=manual.eaf.many.ProcessExcelMany",///ManualServlet?className=com.manual.utility.excel.ProcessExcelManyManual",
		success: function(data){
			//alert(data);
			try{
				if ($.trim(data) == "moreChildFlag"){
					saveDraftEntity();
				}else
					<%=module%>CreateRow();
			}catch(err){
				alert("Import Excel Error!!");
			}
		}
	}); 
}

function changePageExcel(pageNum) {
	var dataString = "mode=pagging&module=<%=module%>&page="+pageNum+"&showPerPage="+$('#selectPerPageExcel').val()+"&processid="+$('#PROCESS_ID').val();
	jQuery.ajax({
		type: "POST",
		data: dataString,
		url: "<%=request.getContextPath()%>/ManualServlet?className=manual.eaf.many.ProcessExcelMany",
		success: function(data){
			<%=module%>SwapToImportExcel();
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
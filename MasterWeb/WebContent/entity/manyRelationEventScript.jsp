<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="java.util.Vector"%>
<%@page import="com.master.model.ModuleFieldM"%>
<%@page import="com.master.util.MasterConstant"%>
<%
	String module = (String)request.getSession().getAttribute("module");
	/* Fix wrong module ID when call ${module}CreateRow() function */
 	if(request.getParameter("requestModule") != null) {
 		module = request.getParameter("requestModule");
 	}
	
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	MasterFormHandler masterForm = (MasterFormHandler)request.getSession().getAttribute(module+"_session");
	if (masterForm == null) {
		masterForm = new MasterFormHandler();
		request.getSession().setAttribute(module+"_session",masterForm);
	}
	
	
	String templateCode = form.getEntityM().getTemplateCode();
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	if(templateCode.equals("PB1")){
		templateCode = "ProfesionalBlue_01";
	}else if(templateCode.equals("PS1")){
		templateCode = "ProSilver";
	}
%>


<script type="text/javascript">
	function <%=module%>Copy() {
		var num = 0;
		var allList ='';
		try {
			if (document.masterForm.<%=module%>deleteRow.checked == true ) {
				allList = 'copyRow='+ document.masterForm.<%=module%>deleteRow.value+'&';
			}
			num = document.masterForm.<%=module%>deleteRow.length;
			for (i=0;i < num ;i++) {
				 if (document.masterForm.<%=module%>deleteRow[i].checked == true ) {
				 	allList = allList+'copyRow=' + document.masterForm.<%=module%>deleteRow[i].value+'&';
				 }
			}
		} catch(e){}		
		if (allList != '') {
			ajax("<%=request.getContextPath()%>/ProcessManyRowServlet?module=<%=module%>&"+allList+"process=<%=com.master.util.MasterConstant.PROCESS_MODE_INSERT%>",<%=module%>CreateRow); 
		}
	}
	
	function <%=module%>Delete() {
		var num = 0;
		var allList ='';
		try {
			if (document.masterForm.<%=module%>deleteRow.checked == true ) {
				// ------ allList = 'deleteRow='+ document.masterForm.<%=module%>deleteRow.value+'&'; worrachet 2012-05-09 
				allList = allList+ "keyForSearch=" + encodeURIComponent(document.masterForm.<%=module%>deleteRow.value) +'&';
				allList = allList + 'deleteRow=0&';
			}
			num = document.masterForm.<%=module%>deleteRow.length;
			for (i=0;i < num ;i++) {
				 if (document.masterForm.<%=module%>deleteRow[i].checked == true ) {
				 	// ------- allList = allList+'deleteRow=' + document.masterForm.<%=module%>deleteRow[i].value+'&'; worrachet 2012-05-09 
				 	allList = allList+ "keyForSearch=" + encodeURIComponent(document.masterForm.<%=module%>deleteRow[i].value) +'&';
				 	allList = allList+'deleteRow=' + i +'&';
				 }
			}
		} catch(e){}
		if (allList != '') {
			//ajax("<%=request.getContextPath()%>/ProcessManyRowServlet?module=<%=module%>&"+allList+"process=<%=com.master.util.MasterConstant.PROCESS_MODE_INSERT%>",<%=module%>CreateRow);
			jQuery.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/ProcessManyRowServlet?module=<%=module%>&"+allList+"process=<%=com.master.util.MasterConstant.PROCESS_MODE_INSERT%>",
				success: function(data){
					<%=module%>CreateRow();
				}
			});
		}
		<%=module%>DeleteManual();
	}
	    	
	function <%=module%>CreateRow(data) {
		try {
			jQuery.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/entity/<%=templateCode%>/manyRelation.jsp?requestModule=<%=module%>",
				success: function(data){
					//var htmlInDiv = jQuery(data).find("#<%=module%>Many").html();
					//jQuery("#<%=module%>Many").hide();
					//jQuery("#<%=module%>Many").html(htmlInDiv);
					//jQuery("#<%=module%>Many").fadeIn("fast");
					//Sam change to draw all MG
					jQuery("#<%=module%>MG").hide();
					jQuery("#<%=module%>MG").html(data);
					jQuery("#<%=module%>MG").fadeIn("fast");
					try {
						<%=module%>CreateRowForManual();
					} catch(e){
					}	
				}
			});
		} catch(e) {
			alert(e);
		}
	}
	
	function clickEditNextEntity(nextEntityID, nextTabID, currentModuleID, currentRow)
	{
		if(!ajaxValidateProcess()) return;
		blockScreen();
		var uri = '<%=request.getContextPath()%>/ManualServlet';
		var data = {
			className : 'com.master.manual.GetParamNextEntityManual',
			nextEntityID : nextEntityID,
			currentModuleID : currentModuleID,
			currentRow : currentRow
		}
		jQuery.ajax({
				type: "POST",
				url: uri,
				data: data,
				async: false,
				success: function(data){
					 if(data.indexOf('ERROR') != 0)
					 {
					 	if (data != "") {
							$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
							document.masterForm.goEntity.value = nextEntityID;
							document.masterForm.goEntityTab.value  = nextTabID;
							document.masterForm.backEntityTab.value = document.masterForm.currentTab.value;
							document.masterForm.keyForSearch.value  = data;
							ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);
						}	
						else
						{
							alert('ERROR - Anable to get key for open the page.');
							unblockScreen();
						}
					 }
					 else
					 {
					 	alert(data);
					 	unblockScreen();
					 }
				}
			});
	}
	
	function AjaxDeleteRowsMany(module) {
		var num = 0;
		var allList ='';
		try {
			if (document.masterForm.<%=module%>deleteRow.checked == true ) {
				allList = 'deleteRow='+ document.masterForm.<%=module%>deleteRow.value+'&';
			}
			num = document.masterForm.<%=module%>deleteRow.length;
			for (i=0;i < num ;i++) {
				 if (document.masterForm.<%=module%>deleteRow[i].checked == true ) {
				 	allList = allList+'deleteRow=' + document.masterForm.<%=module%>deleteRow[i].value+'&';
				 }
			}
		} catch(e){}		
		if (allList != '') {
			blockScreen();
			var formName = "masterForm";
			var uri = "<%=request.getContextPath()%>/ManualServlet";
			var dataString = "className=com.master.manual.AjaxDeleteRowsManyManualClass";
			dataString += "&"+allList+"";
			dataString += "&module="+module+"";
			jQuery.ajax({
				type: "POST",
				url: uri,
				data: dataString,
				async: false,
				success: function(data){
					 <%=module%>CreateRow(data);
					 unblockScreen();
				}
			});
		}
	}
	
	//WiroonAdd20091008
	function <%=module%>checkAllList(){
		var num = document.masterForm.<%=module%>deleteRow.length;
		if (document.getElementsByName("deleteAll")[0].checked) {
			var deleteSelected = document.getElementsByName('<%=module%>deleteRow');		
			if(deleteSelected.length != undefined) {
				for(index = 0 ;index<deleteSelected.length;index++){
					deleteSelected[index].checked = true;
				}
			} else {
				deleteSelected[0].checked = true;
			}
		} else {
			var deleteSelected = document.getElementsByName('<%=module%>deleteRow');
			if(deleteSelected.length != undefined) {
				for(index = 0 ;index<deleteSelected.length;index++){
					deleteSelected[index].checked = false;
				}
			} else {
				deleteSelected[0].checked = false;
			}
		}
		<%if(masterForm.getModuleM().isPagingFlag()){%>
		// changeAllCheckBoxMany(document.getElementsByName("deleteAll")[0],'<%=module%>');
		<%}%>
	}
	function <%=module%>checkList() 
	{
		var allChecked = true;
		$('[name=<%=module%>deleteRow]').each(function() {
			console.log('is checked = ' +$(this).is(":checked"))
			if(!$(this).is(":checked")) {
				$('[name=<%=module%>checkAll]').prop('checked', false);
				allChecked = false;
				return;
			}
		});
		if(allChecked) {
			$('[name=<%=module%>checkAll]').prop('checked', true);
		}
	}

/*------------filter data in many module-----------------*/
	function <%=module%>FilterData(){
		blockScreen();
		var uri = "<%=request.getContextPath()%>/FilterCriteriaServlet";
		var dataString ="moduleID=<%=module%>";
<%
		Vector vFilterFileds = masterForm.getFilterFields();
		if (vFilterFileds != null && vFilterFileds.size() > 0) {
			for (int i = 0; i < vFilterFileds.size();i++) {
				ModuleFieldM prmModuleFieldM =  (ModuleFieldM)vFilterFileds.get(i);	
				if (prmModuleFieldM.isSearchFromTo()) {
%>					
					dataString = dataString + "&FROM_<%=prmModuleFieldM.getFieldID()%>=" + document.masterForm.FROM_<%=prmModuleFieldM.getFieldID()%>.value;
					dataString = dataString + "&TO_<%=prmModuleFieldM.getFieldID()%>=" + document.masterForm.TO_<%=prmModuleFieldM.getFieldID()%>.value;
<%
				} else {
					String getFieldValue = prmModuleFieldM.getFieldID();
					if(MasterConstant.POPUP.equalsIgnoreCase(prmModuleFieldM.getObjType()) || MasterConstant.DYNAMICLISTBOX.equalsIgnoreCase(prmModuleFieldM.getObjType())){
						getFieldValue += "_FILTER";
					}else if(MasterConstant.DATEBOX.equalsIgnoreCase(prmModuleFieldM.getObjType())){
						getFieldValue = getFieldValue + "_" +prmModuleFieldM.getMfID();
					}
%>
					dataString = dataString + "&<%=prmModuleFieldM.getFieldID()%>=" + encodeURIComponent(document.masterForm.<%=getFieldValue%>.value);
<%
				}
			}	
		}
%>		
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: <%=module%>paintManyAjax
		});
	}
/***********************
* Reset filter criteria.
*/
function <%=module%>ResetFilter(){
	<%
		
		if (vFilterFileds != null && vFilterFileds.size() > 0) {
			for (int i = 0; i < vFilterFileds.size();i++) {
				ModuleFieldM prmModuleFieldM =  (ModuleFieldM)vFilterFileds.get(i);	
				if (prmModuleFieldM.isSearchFromTo()) {
	%>
					$("[name='FROM_<%=prmModuleFieldM.getFieldID()%>']").val("");
					$("[name='TO_<%=prmModuleFieldM.getFieldID()%>']").val("");
<%				} else {
%>					
					$("[name='<%=prmModuleFieldM.getFieldID()%>']").val("");
<%					
				}
				
				if(MasterConstant.POPUP.equalsIgnoreCase(prmModuleFieldM.getObjType())) {
%>					
					$("[name='<%=prmModuleFieldM.getFieldID()%>']").val("");
					$("[name='<%=prmModuleFieldM.getFieldID()%>_DESC']").val("");
<%	
				}
			}	
		}
		%>
}

	function <%=module%>paintManyAjax(data){		
		var tabID = document.masterForm.currentTab.value;
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=templateCode%>/manyRelation.jsp?requestModule=<%=module%>";
		var dataString = "CURRENT_TAB=" + tabID;
		var divIDToPaint = "<%=module%>MG";
		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){
					jQuery("#" + divIDToPaint).hide();
					jQuery("#" + divIDToPaint).html(data);
					jQuery("#" + divIDToPaint).fadeIn("fast");
					try {
						<%=module%>FilterManualJS();
					} catch(e) {
					}	
					unblockScreen();					
			   }
			});
		}
	}
	
	/*
	* Sam add new Delete Function for paging
	*/
	function <%=module%>DeletePaging() {
		ajax("<%=request.getContextPath()%>/ProcessManyRowPagingServlet?module=<%=module%>",<%=module%>CreateRow); 
	}
	
	
/**----------------------------**/
	function <%=module%>ImportFile(){
		openDialog('<%=request.getContextPath()%>/entity/<%=templateCode%>/many/uploadFile.jsp?moduleID=<%=module%>', 380, 150,scrollbars=0, setPrefs);
	}
	
	function <%=module%>ImportExcel(){
		openDialog('<%=request.getContextPath()%>/entity/<%=templateCode%>/many/uploadExcel.jsp?moduleID=<%=module%>', 380, 150,scrollbars=0, setPrefs);
	}
	
	function <%=module%>SwapToImportExcel(){
		try {
			jQuery.ajax({
				type: "POST",
				data: "module=<%=module%>",
				url: "<%=request.getContextPath()%>/entity/<%=templateCode%>/many/excelTemplate.jsp",
				success: function(data){
					//var htmlInDiv = jQuery(data).find("#<%=module%>Many").html();
					//jQuery("#<%=module%>Many").hide();
					//jQuery("#<%=module%>Many").html(htmlInDiv);
					//jQuery("#<%=module%>Many").fadeIn("fast");
					//Sam change to draw all MG
					jQuery("#<%=module%>MG").hide();
					jQuery("#<%=module%>MG").html(data);
					jQuery("#<%=module%>MG").fadeIn("fast");
					try {
						<%=module%>SwapToImportExcelForManual();
					} catch(e){
					}	
				}
			});
		} catch(e) {
			alert(e);
		}
	}
	
	function <%=module%>ExportExcel() {
		var dataString = "mode=export&module=<%=module%>";
		window.open("<%=request.getContextPath()%>/manual/jsp/result_excel.jsp?"+dataString);
	}
	
	function <%=module%>ExportExcelTemplate() {
		var dataString = "mode=export&module=<%=module%>";
		window.open("<%=request.getContextPath()%>/manual/jsp/result_excel_template.jsp?"+dataString);
	}
	
	function <%=module%>CancelEdit() {
		jQuery.ajax({
			type: "POST",
			url: "<%=request.getContextPath()%>/ManualServlet?className=com.master.servlet.entity.ProcessManyPaggingCancel&module=<%=module%>",
			success: function(data){
				<%=module%>CreateRow();
			}
		});
	}
	
</script>
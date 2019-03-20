<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.util.MasterConstant"%>

<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	String searchForUpdate = (String)request.getSession().getAttribute(entityID+"searchForUpdate");
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	/* uriPostParam -> see in MasterUtil.loadDefaultParam(...) */
	String uriPostParam = (String)request.getSession().getAttribute("uriPostParam_session");
	if(null == uriPostParam){
		uriPostParam = "";
	}
	
	String userName = (String)request.getSession().getAttribute("userName");
%>



<script language="javascript">
	<%/* start search function */%>
	
	function searchResult() {
		blockScreen();
		//displayWaitBlock("Searching...");
		window.document.masterForm.action.value = "searchEntity";
		window.document.masterForm.handleForm.value = "Y";
		document.masterForm.orderBy.value = "";
		document.masterForm.orderByType.value = "";
		document.masterForm.page.value = "1";
		if(document.masterForm.clearCheckboxSession != null)
		document.masterForm.clearCheckboxSession.value = "Y";
		window.document.masterForm.submit();
	}
	
	function resetSearchCriteria(){
		$('.searchCriteriaContainer :input:not(:button, :submit, :reset, :radio)')
		.val('')
		.removeAttr('checked')
		.removeAttr('selected');
		
		loadDefaultValue();
	}
	
	function loadDefaultValue(){		
		var dataString = "className=com.master.servlet.SearchCriteriaResetServlet";
		dataString += "&entityID=<%=entityID%>&moduleID=<%=form.getMainModuleID()%>";										
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false, 		   
		   success: function(data){		
			   displayJSON(data);
			   
		   }
		});
	}
	
	function changePageAndSize(pageNum) {	
		blockScreen();	
		window.document.masterForm.action.value = "searchEntity";
		window.document.masterForm.handleForm.value = "Y";
		window.document.masterForm.volumePerPage.value = window.document.masterForm.selectPerPage.value;
		window.document.masterForm.page.value = pageNum;
		window.document.masterForm.submit();
	}
	
	function addEntity(){
		blockScreen();
		window.location = "<%=request.getContextPath()%>/FrontController?action=loadEntity&entityID=<%=form.getEntityM().getEntityID()%>&tabID=<%=form.getCurrentTab()%>&userName=<%=userName%>&newRequestFlag=Y&searchForUpdate=<%=searchForUpdate%>&fromProcess=<%=MasterConstant.PROCESS_MODE_SEARCH%><%=uriPostParam%>";
	}
 	
	function actionFormSubmit(strAction,strHandleForm) {
		document.masterForm.action.value = strAction;
		document.masterForm.handleForm.value = strHandleForm;
		document.masterForm.submit();
	}
	
	function actionOrderBy(strAction,strHandleForm,strOrderBy) {
		var orderType = document.masterForm.orderByType.value;
		if (orderType == 'asc') {
			document.masterForm.orderByType.value = 'desc';	
		} else {
			document.masterForm.orderByType.value = 'asc';	
		}		

		document.masterForm.action.value = strAction;
		document.masterForm.handleForm.value = strHandleForm;		
		document.masterForm.orderBy.value = strOrderBy;	
		
		document.masterForm.submit();
	}	
	
	// @worrachet 
	// fix remove featur store checkbox on session
	
	function checkAllList() {
		var num = document.masterForm.deleteRow.length;
		if (document.masterForm.deleteAll.checked) {
			for (i=0;i< num;i++) {
				document.masterForm.deleteRow[i].checked = true;
			}
		} else {
			for (i=0;i< num;i++) {
				document.masterForm.deleteRow[i].checked = false;
			}
		}
		changeAllCheckBox(document.masterForm.deleteAll);
	}
	/*
	function checkAllList() {
		var num = document.masterForm.deleteRow.length;
		if (document.masterForm.deleteAll.checked) {
			document.masterForm.deleteRow.checked = true;
			for (i=0;i< num;i++) {
				document.masterForm.deleteRow[i].checked = true;
			}
		} else {
			document.masterForm.deleteRow.checked = false;
			for (i=0;i< num;i++) {
				document.masterForm.deleteRow[i].checked = false;
			}
		}
	}
	function checkList() 
	{
		var num = document.masterForm.deleteRow.length;
		var allCheck = true;
		for (i=0;i< num;i++) {
			if(!document.masterForm.deleteRow[i].checked)
			{
				allCheck=false;
			}
		}
		if((typeof num == 'undefined') && !document.masterForm.deleteRow.checked){
			allCheck=false
		}
		document.masterForm.deleteAll.checked=allCheck;
	}
	$(document).ready(function() 
	{
		$("[name=deleteRow]").click(checkList);
	});
	*/
	function <%=form.getMainModuleID()%>ExportExcel() {
		var dataString = "mode=export&module=<%=form.getMainModuleID()%>&showsearch=1";
		window.open("<%=request.getContextPath()%>/manual/jsp/result_excel.jsp?"+dataString);
		
	}
<%//---------- mannual--------//%>
 	function popupKYC() {
		var url = '<%=request.getContextPath()%>/template/template.jsp';
//		var winDialog = window.showModalDialog(url, window, "dialogWidth:750px; dialogHeight:300px; center:yes; help:no; resizeable:no; status:no; ");
		var winDialog = window.open(url,'',"scrollbars=1,width=750,height=380");
	 //	window.onfocus = function(){if (winDialog.closed == false){winDialog.focus();};}; 
 	//	winDialog.onunload = function(){alert('closing')};	
	}
	
	function popupManual(popUpName, W, H) {
		if(popUpName != null && popUpName != ""){
			var url = popUpName;
			var winProp = 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no, width=' + W + ',height=' + H + ',left=300,top=23';
			var winDialog = window.open(url, '', winProp);
		}
	}
<%//---------------------------%>

// Decorate Functions
	function displayMessageBlock(message) {
		var messageBlock = document.getElementById("_messageBlock");
		if (messageBlock) {
			messageBlock.style.display = "block";
			document.getElementById("_messageBlock_message").innerHTML = message;
			
			messageBlock.style.left = ((document.body.clientWidth - messageBlock.offsetWidth) / 2 + document.body.scrollLeft) + "px";
			messageBlock.style.top = ((document.body.clientHeight - messageBlock.offsetHeight) / 2 + document.body.scrollTop) + "px";
			
			var background = document.getElementById("_messageBlock_background");
			background.style.width = messageBlock.offsetWidth + "px";
			background.style.height = messageBlock.offsetHeight + "px";
		} else {
			alert(message);
		}
	}
	
	function displayWaitBlock(message) {
		displayMessageBlock("<img style=\"vertical-align: middle;\" src=\"tiny_mce/themes/advanced/skins/default/img/progress.gif\"/> " + message);
	}
	
	function exportExcel(showRowHeader, showRowNumber) {
		showRowHeader = showRowHeader || true;
		showRowNumber = showRowNumber || true;
		
		window.open("<%=request.getContextPath()%>/entity/search/downloadexcel?showRowHeader=" + showRowHeader + "&showRowNumber=" + showRowNumber)
		
	}

//-----------------------------------Set current entity-------------------------------
	
	
	function windowFocus(){				
		var dataString = "entityID=<%=entityID%>&currentForm=<%=form.getMainModuleID()%>_session&currentScreen=SEARCHENTITY_SCREEN";										
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/SetCurrentEntityServlet";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false, 		   
		   success: function(data){												
		   }
		});
	}
	
	//Sam fix SetCurrentEntity
	//14/11/2011
	//window.onfocus = windowFocus;
	//window.onblur = windowFocus;

	//windowFocus();
	
	$(document).ready(function() {
	var dataString = "<input type=\"hidden\" name=\"beweno1\" value=\"<%=entityID%>\">"
	+"<input type=\"hidden\" name=\"beweno2\" value=\"<%=form.getMainModuleID()%>_session\">"
	+"<input type=\"hidden\" name=\"beweno3\" value=\"SEARCHENTITY_SCREEN\">";
	
	//append several form at once
	$('form').append(dataString); 
	});
//------------------------------------------------------------------------------------------
		
</script>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.MasterFormHandler" %>


<%
	String entityID = (String)request.getSession().getAttribute("entityID");
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String module = (String)request.getSession().getAttribute("module");
	String moduleSession = module +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	if (MasterForm == null) {
		MasterForm = new MasterFormHandler();
		request.getSession().setAttribute(moduleSession,MasterForm);
	}
%>

<script type="text/javascript">
	function actionFormSubmit(strAction,strHandleForm) {
		//if(!ajaxValidateMaster()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		document.masterForm.action.value = strAction;
		document.masterForm.handleForm.value = strHandleForm;
		document.masterForm.submit();
	}
	
	function loadForUpdate(str, rowNum) {
		window.document.masterForm.action.value = "loadUpdateMaster";
		window.document.masterForm.handleForm.value = "N";
		window.document.masterForm.loadUpdateValue.value = str;
		window.document.masterForm.submit();
	}
	
	function changePageAndSize(pageNum) {
		window.document.masterForm.action.value = "searchMaster";
		window.document.masterForm.handleForm.value = "Y";
		window.document.masterForm.volumePerPage.value = window.document.masterForm.selectPerPage.value;
		window.document.masterForm.page.value = pageNum;
		window.document.masterForm.submit();
	}
	
	function searchResult() {
		window.document.masterForm.action.value = "searchMaster";
		window.document.masterForm.handleForm.value = "Y";
		document.masterForm.orderBy.value = "";			
		document.masterForm.orderByType.value = "";	
		document.masterForm.page.value = "1";
		window.document.masterForm.submit();
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
					    
	function actionAdd() {
		 window.location = "./FrontController?action=loadMaster&moduleName=<%=MasterForm.getModuleM().getModuleID()%>";
	}      
	
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
	}

	function moveSelectValue(fromField, toField){
		//alert(fromField+" : "+toField);
		var opts='';
		var fbox = document.getElementById(fromField);
		var tbox = document.getElementById(toField)

		var arrFbox = new Array();
	    var arrTbox = new Array();
	    var arrLookup = new Array();
	    var i;
	    for(i=0; i<tbox.options.length; i++) {
	    	arrLookup[tbox.options[i].text] = tbox.options[i].value;
	    	arrTbox[i] = tbox.options[i].text;  
	    }
	    var fLength = 0;
	    var tLength = arrTbox.length
	    for(i=0; i<fbox.options.length; i++) {
			arrLookup[fbox.options[i].text] = fbox.options[i].value;
			if(fbox.options[i].selected && fbox.options[i].value != "") {
				arrTbox[tLength] = fbox.options[i].text;
				tLength++;
			} else {
				arrFbox[fLength] = fbox.options[i].text;
				fLength++;
			}
	    }
	    arrFbox.sort();
	    arrTbox.sort();
	    fbox.length = 0;
	    tbox.length = 0;
	    var c;
	    for(c=0; c<arrFbox.length; c++) {
			var no = (window.Option ? new Option() : document.createElement("option") )
			no.value = arrLookup[arrFbox[c]];
			no.text = arrFbox[c];
			fbox[c] = no;
	    }
	    for(c=0; c<arrTbox.length; c++) {
			var no = (window.Option ? new Option() : document.createElement("option") )
			no.value = arrLookup[arrTbox[c]];
			no.text = arrTbox[c];
			tbox[c] = no;
	    }
		
	}

//-----------------------------------Set current entity-------------------------------
		
	function windowFocus(){		
		var dataString = "entityID=<%=entityID%>&currentForm=<%=module%>_session&currentScreen=MANY_TEMPLATE_SCREEN";										
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
	+"<input type=\"hidden\" name=\"beweno2\" value=\"<%=module%>_session\">"
	+"<input type=\"hidden\" name=\"beweno3\" value=\"MANY_TEMPLATE_SCREEN\">";
	
	//append several form at once
	$('form').append(dataString); 
	});
//-------------------------------------------------------------------------------------	
	
	function validateKeyMany(key){
		//generate key parameter
		var dataString = "listKey=";
		for(var i=0; i<key.length; i++) {
			dataString += key[i]+','+jQuery('[name="'+key[i]+'"]').val();
			if(i!=(key.length-1)){
				dataString+='||';
			}
		}
		var result = 'N';
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet?className=com.master.manual.ValidateKeyManual";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false, 		   
		   success: function(data){
		   		result = data;
		   }
		});
		return result;
	}
	
	function validateTest(){
		var keyArray=new Array("ITEM_DES","AMOUNT");
		var isValid = validateKeyMany(keyArray);
		if(isValid == 'Y'){
			actionFormSubmit('insertMany','Y');
		}else{
			alert('Dup');
		}
	}
</script>
var processID;
function loadDialog(bol){
		if(bol){
			processID = setTimeout("fn_WarningMessage()", 0);
			
		}
}

function fn_WarningMessage(){
	var features = "dialogWidth:400px;dialogHeight:225px;scroll:no;status:no;resizable:no;help:no;";	
	 window.showModalDialog('FrontController?page=MESSAGE_SCREEN',window, features);
	 clearTimeout(processID);
}

function fn_NextAction(param){
	selectAll('formName', 'selectedMedicalInfoM');
	selectAll('formName', 'selectedListOfDocumentM');
	selectAll('formName', 'selectedIncompleteM');
	document.forms['formName'].nextAction.value = param;
	doProcess('formName', '','WARNING_MESSAGES_ACTION','Y','1','N','');
	
}
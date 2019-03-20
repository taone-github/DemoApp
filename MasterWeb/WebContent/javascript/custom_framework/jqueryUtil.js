

/*-----------------------------------------------------------------------------------*/

/*-- Call AJAX for validate process before save --*/

function ajaxValidateProcess(){
	var formName = "masterForm";
	var uri = getcontextPath() + "/ManualServlet";
	var dataString = "className=com.master.manual.ValidateProcessManualClass";
	dataString += "&action=saveEntity";
	dataString += "&handleForm=Y";
	dataString += sweepAjaxForm(formName);
	
	var isValidateFieldsPass = false;
	jQuery.ajax({
		type: "POST",
		url: uri,
		data: dataString,
		async: false,
		success: function(data){
			if("Y" == data){
				isValidateFieldsPass = true;
			}else{
				try{
					eval(data);
				}catch(e){};
			}
		}
	});
	return isValidateFieldsPass;
}

/*-- Start can save checkBox value to moduleTable --*/
function mapCheckBoxToColumn(checkBoxID, textBoxID){
	/*-- To Update -- textBox have value -> checkBox is checked	--*/
	if(document.getElementById(textBoxID)){
		if(document.getElementById(textBoxID).value == jQuery("#"+checkBoxID).val()){
			jQuery("#"+checkBoxID).attr('checked', true);
		}else{
			jQuery("#"+checkBoxID).attr('checked', false);
		}
	}
	
	/*-- To Save -- checkBox is checked -> set value to textBox --*/
	jQuery("#"+checkBoxID).click(function (){
		if(document.getElementById(textBoxID)){
			if(jQuery("#"+checkBoxID+":checked").val() != null){
				document.getElementById(textBoxID).value = jQuery("#"+checkBoxID+":checked").val();
			}else{
				document.getElementById(textBoxID).value = "";
			}
		}
	});
}
/*-- End can save checkBox value to moduleTable --*/

/*-----------------------------------------------------------------------------------*/
/*-- start validate e-mail --*/
/* must wrap the target element with jQuery before use this function */
/* EX: 
		validateEMail(jQuery("#md0907201305_E_MAIL_1_InputField input[name='E_MAIL_1']"), ERR_VALIDATE_EMAIL_MSG, "ALERT");
 */
var CONST_REGEX_EMAIL = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
function validateEMail(targetObj, errMessage, respType){
	targetObj.blur(function(){
		var emailString = targetObj.val();
		if(null != emailString && "" != emailString){
			var regex = new RegExp(CONST_REGEX_EMAIL);
			if(!regex.test(emailString)){
				if("ALERT" == respType){
					alert(errMessage);
				}
				targetObj.focus();
				return false;
			}
		}
		return true;
	});
}

/*-----------------------------------------------------------------------------------*/
/*-- end validate e-mail --*/
function textBoxFocusInvoker(){
	jQuery("input:text, textarea").focus(function() {
		jQuery(this).addClass("textBoxFocus");
	});

	jQuery("input:text, textarea").blur(function() {
		jQuery(this).removeClass("textBoxFocus");
	});
}

/*-----------------------------------------------------------------------------------*/
// textBoxToDatePicker("BIRTH_DATE");
function textBoxToDatePicker(textBoxName){
	// paint datePicker
	jQuery("[name='"+textBoxName+"']").after('&nbsp;<IMG id="'+textBoxName+'_IMG" style="CURSOR:hand" alt="" src="' + getcontextPath() + '/images/calendar_new.gif" />');
	jQuery("#"+textBoxName+"_IMG").click(function(){
		var calenImg = document.forms['masterForm'].elements[textBoxName+"_IMG"];
		var calenObj = document.forms['masterForm'].elements[textBoxName];
		popUpCalendarModify(calenImg,calenObj,'dd/mm/yyyy','','','','right',false);
	});
}


/*-----------------------------------------------------------------------------------*/
function createHiddenField(formName, fieldName, strVal){
	if(document.getElementById(fieldName)){
		document.getElementById(fieldName).value = strVal;	
	}else{
		var inputField = document.createElement("input");
		inputField.setAttribute("type", "hidden");
		inputField.setAttribute("name", fieldName);
		inputField.setAttribute("id", fieldName);
		inputField.setAttribute("value", strVal);
		document.getElementById(formName).appendChild(inputField);
	}
}

/*-----------------------------------------------------------------------------------*/

var objTypeConst = new Array();
objTypeConst["TEXTBOX"] = "TB";
objTypeConst["RADIOBOX"] = "RD";
objTypeConst["CHECKBOX"] = "CH";
objTypeConst["LISTBOX"] = "LB";
objTypeConst["DYNAMICLISTBOX"] = "DLB";
objTypeConst["ATTACHMENTLISTBOX"] = "ALB";
objTypeConst["TEXTAREA"] = "TA";
objTypeConst["POPUP"] = "POP";
objTypeConst["DATEBOX"] = "DB";
objTypeConst["HIDDEN"] = "HD";
objTypeConst["NOT_OBJECT"] = "NO";

var objNamingConst = new Array();
objNamingConst["DISPLAY_FIELD"] = "DisplayField";
objNamingConst["EDITABLE_FIELD"] = "EditableField";
objNamingConst["POP_UP_MF_ID"] = "popUp_mfID";

/**
*
*	characteristics
*	1. swap element to edit mode
*	2. keep newText & newValue
*	3. set new Text to <a href/>
*	4. set new value to hiddenField
*	5. update session with ajax servlet
*	6. swap element back to view mode
*
*	see in -> manyRelation.jsp
*	usage -> onclick="swapElement('request.getContextPath()', '<%=htmlComponentNamed %>','<%=labelNamed %>','<%=i %>', '<%=moduleFieldM.getObjType() %>', '<%=moduleFieldM.getModuleID() %>', '<%=moduleFieldM.getFieldID() %>')"
*
*	htmlComponentNamed = id of div that contain the editable component such as dropDownList textBox dateBox etc.
*	labelNamed = id of div that contain <a href/>, when you click this href, it will change to edit mode.
*	i = rowID (looping with "for")
*	moduleFieldM.getObjType() = TB, LB, DB, ...
*
**/
function swapElement(contextPath, idToShow, idToHide, rowID, objType, moduleID, fieldID){
	/* not allowed to edit more than one line */
	//toggleViewMode();
	
	var hiddenBoxID = moduleID + "_" + fieldID;
	/* start get object of html component */
	var objList = document.forms['masterForm'].elements[hiddenBoxID];
	var objIsArray = true;
	if(objList.length == null){
		objIsArray = false;
	}
	/* end get object of html component */

	/* swap from view mode to edit mode */
	swapBackElement(idToShow, idToHide);
	
	
	
	/* start case of each object type */
	if(objTypeConst["TEXTBOX"] == objType){
		jQuery("#" + idToShow).find("input:text").attr("size", "5");
		jQuery("#" + idToShow).find("input:text").focus();
		jQuery("#" + idToShow).find("input:text").blur(function () {
			var oldValue = jQuery("#" + idToHide).find("a").text();
			var newText = newValue = jQuery("#" + idToShow).find("input:text").val();
			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			jQuery("#" + idToHide).find("a").text(newText);
			/* start set value from textBox to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from textBox to hidden field */
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
			
			manualTBEditinLine(rowID,moduleID, fieldID, oldValue, newValue);
			
						
		});
	}else if(objTypeConst["LISTBOX"] == objType || objTypeConst["DYNAMICLISTBOX"] == objType){
		jQuery("#" + idToShow).find("select").focus();
		jQuery("#" + idToShow).find("select").blur(function () {
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
		});
		jQuery("#" + idToShow).find("select").change(function () {
			var newText = jQuery("#" + idToShow).find("select option:selected").text();
			var newValue = jQuery("#" + idToShow).find("select option:selected").val();
			if(newValue == "" || newValue == null){
				newText = "";
			}
			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			jQuery("#" + idToHide).find("a").text(newText);
			/* start set value from dropDownList to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from dropDownList to hidden field */
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
			
			manualLBEditinLine(rowID,moduleID, fieldID, newValue);
		});
	}else if(objTypeConst["DATEBOX"] == objType){
		jQuery("#" + idToShow).find("input:text").attr("size", "10");
	
		/* start change javascript of <a href/>, use the array of dateBox as an input */
		var dateBoxName = jQuery("#" + idToShow).find("input:text").attr("name");	
		var dateList = document.forms['masterForm'].elements[dateBoxName];
		if(dateList.length != null){
			jQuery("#" + idToShow).find("a").click(function (){
				jQuery("#" + idToShow).find("a").removeAttr("href");
				jQuery("#" + idToShow).find("a").attr("href", "javascript:show_calendar('masterForm."+dateBoxName+"["+rowID+"]');");
			});
		}
		/* end change javascript of <a href/>, use the array of dateBox as an input */
		
		jQuery("#" + idToShow).find("input:text").focus(function () {
			var newText = newValue = jQuery("#" + idToShow).find("input:text").val();
			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			jQuery("#" + idToHide).find("a").text(newText);
			/* start set value from textBox to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from textBox to hidden field */
			
			jQuery("#" + idToHide).find("a").focus();
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
		});
	}else if(objTypeConst["TEXTAREA"] == objType){
		jQuery("#" + idToShow).find("textarea").focus();
		jQuery("#" + idToShow).find("textarea").blur(function () {
			var newText = newValue = jQuery("#" + idToShow).find("textarea").val();

			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			jQuery("#" + idToHide).find("a").text(newText);
			/* start set value from textArea to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from textArea to hidden field */
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
		});
	}else if(objTypeConst["RADIOBOX"] == objType){
		/* radioGroup of every rows are the same group, so checkd the radio in current focus by the code belowed */
		if(objIsArray){
			jQuery("#" + idToShow).find("input:radio[value='"+objList[rowID].value+"']").attr("checked", "checked");
		}
		/* event when change the radio button */
		jQuery("#" + idToShow).find("input:radio").click(function () {
			var newText = jQuery("#" + idToShow).find("input:radio:checked").parent().text();
			var newValue = jQuery("#" + idToShow).find("input:radio:checked").val();
			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			jQuery("#" + idToHide).find("a").text(newText);
			/* start set value from radioButton to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from radioButton to hidden field */
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
		});
	}else if(objTypeConst["POPUP"] == objType){
		var popUpValNameList = document.forms['masterForm'].elements[fieldID];
		
		/* in manyRelation, we will invoke popUp manually. so remove the old codes */
		jQuery("#" + idToShow).find("input:text['"+fieldID+"']").removeAttr("onblur");
		jQuery("#" + idToShow).find("input:button").removeAttr("onclick");
		
		/* mfID be used when call PopUpServlet */		
		var popUp_mfID = jQuery("#" + idToHide).find("input:hidden[name='"+objNamingConst["POP_UP_MF_ID"]+"']").val();
		
		/* start open popUp, case of manyRow or oneRow */
		/* enable description field for event catching to invoke function when the popUp is closed */
		if(popUpValNameList.length != null){
			jQuery("#" + idToShow).find("input:button").click(function (){
				jQuery("#" + idToShow).find("input:text['"+fieldID+"_DESC']").attr("disabled", "");
				popupClick(contextPath, moduleID, fieldID, fieldID, popUp_mfID, rowID,'BLANK');
			});
		}else{
			jQuery("#" + idToShow).find("input:button").click(function (){
				jQuery("#" + idToShow).find("input:text['"+fieldID+"_DESC']").attr("disabled", "");
				popupClick(contextPath, moduleID, fieldID, fieldID, popUp_mfID, '','BLANK');
			});
		}
		/* end open popUp, case of manyRow or oneRow */
		
		jQuery("#" + idToShow).find("input:text[name='"+fieldID+"_DESC']").focus(function (){
			/* disable description field when popUp is closed */
			jQuery("#" + idToShow).find("input:text[name='"+fieldID+"_DESC']").attr("disabled", "disabled");
			
			/* get new value */
			//var newText = newValue = jQuery("#" + idToShow).find("input:text['"+fieldID+"']").val();
			var newText = jQuery("#" + idToShow).find("input:text[name='"+fieldID+"_DESC']").val();

			newValue = encodeURIComponent(jQuery("#" + idToShow).find("input:text['"+fieldID+"']").val());

			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			jQuery("#" + idToHide).find("a").text(newText);
			/* start set value from textBox to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from textBox to hidden field */
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
		});
	}
	/* end case of each object type */
}

function swapBackElement(idToShow, idToHide){
	jQuery("#" + idToShow).show();
	/* remove editableComponent */
	if(idToHide.indexOf(objNamingConst["EDITABLE_FIELD"]) > 0) {
        jQuery("#" + idToHide).html("");
    }else{
		jQuery("#" + idToHide).hide();
	}
	jQuery("#" + idToShow).attr("disabled", "");
}

function toggleViewMode(){
	jQuery("div").find("[id$='"+objNamingConst["DISPLAY_FIELD"]+"']").show();
	//jQuery("div").find("[id$='"+objNamingConst["EDITABLE_FIELD"]+"']").hide();
	jQuery("div").find("[id$='"+objNamingConst["EDITABLE_FIELD"]+"']").html("");
	jQuery("div").find("[id$='"+objNamingConst["EDITABLE_FIELD"]+"']").attr("disabled", "disabled");
}

function ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType) {
	//alert('moduleID -> ' + moduleID + '\n' + 'fieldID -> ' + fieldID + '\n' + 'rowID -> ' + rowID);
	newValue = newValue.replace(/&/g,'<@change@>');
	var paramList = "module=" + moduleID;
	paramList += "&fieldID=" + fieldID;
	paramList += "&rowID=" + rowID;
	paramList += "&newValue=" + newValue;
	paramList += "&objType=" + objType;
	var uri = contextPath + "/AjaxUpdateManyRowServlet"; 
	
	jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: paramList,
		   success: ajaxFormUpdateHandler
		   });
	
	
}

function ajaxFormUpdateHandler(data){
	return;
}

function manualTBEditinLine(rowID,moduleID, fieldID) {
	//for override
}
function manualLBEditinLine(rowID,moduleID, fieldID, newValue) {
	//for override
}
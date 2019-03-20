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
objTypeConst["SUGGESTION"] = "SB";

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

	/* ==============
	 * 20-08-2015
	 * WORRACHET
	 * Fix "objList" = undefined
	 * ============== */
	if(objList == undefined)
	{
		objList = $('#'+moduleID+'MG [name='+hiddenBoxID+']' );
	}

	//console.log('objType:'+objType);
	
	var objIsArray = true;
	if(objList.length == null){
		objIsArray = false;
	}
	/* end get object of html component */

	/* swap from view mode to edit mode */
	swapBackElement(idToShow, idToHide);
	/* start case of each object type */
	if(objTypeConst["TEXTBOX"] == objType || objTypeConst["SUGGESTION"] == objType){
		jQuery("#" + idToShow).find("input").attr("size", "5");
		jQuery("#" + idToShow).find("input").attr("class", "textinbox-many");
		//Sam found div that hold input must remove disable too
		jQuery("#" + idToShow).find("input").focus();
		jQuery("#" + idToShow).find("input").blur(function () {
			var oldValue = jQuery("#" + idToHide).find("span").text();
			var newText = newValue = jQuery("#" + idToShow).find("input").val();
			
			// swap from edit mode to view mode 
			swapBackElement(idToHide, idToShow);
			
			if(newText==""){	
				jQuery("#" + idToHide).find("span").html('&nbsp;');
				
			}else{
				jQuery("#" + idToHide).find("span").text(newText);
			}
			
			jQuery("#" + idToHide).css('display','block');
			jQuery("#" + idToHide).find("span").attr('title',newText);
			
			// start set value from textBox to hidden field 
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			// end set value from textBox to hidden field 
			
			// update HashMap in session by ajax 
			// fix issue Thai with encodeURL
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
			
			manualTBEditinLine(rowID,moduleID, fieldID, oldValue, newValue);		
		});
	}else if(objTypeConst["LISTBOX"] == objType || objTypeConst["DYNAMICLISTBOX"] == objType){
		jQuery("#" + idToShow).find("select").focus();
		jQuery("#" + idToShow).find("select").css("left", "0");
		jQuery("#" + idToShow).find("select").css('position','static');
		jQuery("#" + idToShow).find("select").css('display','inline');
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
			
			if(newText==""){	
				jQuery("#" + idToHide).find("span").html('&nbsp;');
				
			}else{
				jQuery("#" + idToHide).find("span").text(newText);
			}
			
			jQuery("#" + idToHide).css('display','block');
			jQuery("#" + idToHide).find("span").attr('title',newText);
			
			/* start set value from dropDownList to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from dropDownList to hidden field */
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
		});
	}else if(objTypeConst["DATEBOX"] == objType){
	
		/* start change javascript of <a href/>, use the array of dateBox as an input */
		/*
		var dateBoxName = jQuery("#" + idToShow).find("input:text").attr("name");	
		var dateList = document.forms['masterForm'].elements[dateBoxName];
		if(dateList.length != null){
			jQuery("#" + idToShow).find("span").click(function (){
				jQuery("#" + idToShow).find("span").removeAttr("href");
				jQuery("#" + idToShow).find("span").attr("href", "javascript:show_calendar('masterForm."+dateBoxName+"["+rowID+"]');");
			});
		}
		*/
		/* end change javascript of <a href/>, use the array of dateBox as an input */
		
		jQuery("#" + idToShow).find("input").attr("class", "textinbox-many");
		jQuery("#" + idToShow).find("input").css('display','inline');
		jQuery("#" + idToShow).find("input").css('margin','2px 0px 0px 1px');
		//jQuery("#" + idToShow).find(".ui-datepicker-trigger").css('position','static');
		jQuery("#" + idToShow).find(".ui-datepicker-trigger").css('display','inline');
		jQuery("#" + idToShow).find(".ui-datepicker-trigger").css('float','none');
		jQuery("#" + idToShow).find(".ui-datepicker-trigger").css('margin','2px 0px 0px 1px');
		
		/*
		* FIX : 2014-10-28 : check calendar is open or not before swap element
		*/
		var click1 = false;
		if(jQuery("#" + idToShow).find('img.check-clicked').length == 0) {
			jQuery("#" + idToShow).find("img.ui-datepicker-trigger").click(function () {
				 click1 = true;
			}).addClass('check-clicked');
		}
		onBlurFunc = function () {
			var newText = newValue = jQuery("#" + idToShow).find("input").val();
			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			if(newText==""){	
				jQuery("#" + idToHide).find("span").html('&nbsp;');
				
			}else{
				jQuery("#" + idToHide).find("span").text(newText);
			}
			
			jQuery("#" + idToHide).css('display','block');
			jQuery("#" + idToHide).find("span").attr('title',newText);
			
			/* start set value from textBox to hidden field */
			if(objIsArray){
				objList[rowID].value = newValue;
			}else{
				objList.value = newValue;
			}
			/* end set value from textBox to hidden field */
			
			jQuery("#" + idToHide).find("span").focus();
			
			/* update HashMap in session by ajax */
			ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType);
		};
		
		jQuery("#" + idToShow).find("input").blur(function() {
//			setTimeout(function() {
				if($(this).datepicker( "widget" ).is(":visible"))
				{
					click1 = false;
				}
				else if(click1)
				{
					click1 = false;
				}
				else
				{
					onBlurFunc();
				}
//			}, 100);
		});
	}else if(objTypeConst["TEXTAREA"] == objType){
		jQuery("#" + idToShow).find("textarea").focus();
		jQuery("#" + idToShow).find("textarea").blur(function () {
			var newText = newValue = jQuery("#" + idToShow).find("textarea").val();

			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			if(newText==""){	
				jQuery("#" + idToHide).find("span").html('&nbsp;');
				
			}else{
				jQuery("#" + idToHide).find("span").text(newText);
			}
			
			jQuery("#" + idToHide).css('display','block');
			jQuery("#" + idToHide).find("span").attr('title',newText);
			
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
			
			if(newText==""){	
				jQuery("#" + idToHide).find("span").html('&nbsp;');
				
			}else{
				jQuery("#" + idToHide).find("span").text(newText);
			}
			
			jQuery("#" + idToHide).css('display','block');
			jQuery("#" + idToHide).find("span").attr('title',newText);
			
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
		
		jQuery("#" + idToShow).find("input").css("position", "static");
		jQuery("#" + idToShow).find("input").css('display','inline');
		jQuery("#" + idToShow).find(".alldot2").css('position','static');
		jQuery("#" + idToShow).find(".alldot2").css('display','inline');
		
		var popUpValNameList = document.forms['masterForm'].elements[fieldID];
		
		/* in manyRelation, we will invoke popUp manually. so remove the old codes */
		jQuery("#" + idToShow).find("input[name='"+fieldID+"']").removeAttr("onblur");
		jQuery("#" + idToShow).find("input[name='"+fieldID+"']").removeAttr("onfocus");
		jQuery("#" + idToShow).find(".alldot2").removeAttr("onclick");
		
		/* mfID be used when call PopUpServlet */
		var popUp_mfID = jQuery("#" + idToHide).find("input:hidden[name='"+objNamingConst["POP_UP_MF_ID"]+"']").val();
		
		/* start open popUp, case of manyRow or oneRow */
		/* enable description field for event catching to invoke function when the popUp is closed */
		jQuery("#" + idToShow).find(".alldot2").click(function (){
			jQuery("#" + idToShow).find("input[name='"+fieldID+"_DESC']").removeAttr("disabled");
			popupClickDivTheme(contextPath, moduleID, fieldID, fieldID, popUp_mfID, '','BLANK','','ONE');
		});
		/* end open popUp, case of manyRow or oneRow */

		jQuery("#" + idToShow).find("input[name='"+fieldID+"_DESC']").focus(function (){
			/* disable description field when popUp is closed */
			jQuery("#" + idToShow).find("input[name='"+fieldID+"_DESC']").attr("disabled", "disabled");
			
			/* get new value */
			//var newText = newValue = jQuery("#" + idToShow).find("input:text['"+fieldID+"']").val();
			var newText = jQuery("#" + idToShow).find("input[name='"+fieldID+"_DESC']").val();

			newValue = encodeURIComponent(jQuery("#" + idToShow).find("input[name='"+fieldID+"']").val());

			
			/* swap from edit mode to view mode */
			swapBackElement(idToHide, idToShow);
			
			if(newText==""){	
				jQuery("#" + idToHide).find("span").html('&nbsp;');
				
			}else{
				jQuery("#" + idToHide).find("span").text(newText);
			}
			
			jQuery("#" + idToHide).css('display','block');
			jQuery("#" + idToHide).find("span").attr('title',newText);
			
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
/*
function swapBackElement(idToShow, idToHide){
	jQuery("#" + idToShow).show();
	/* remove editableComponent /
	if(idToHide.indexOf(objNamingConst["EDITABLE_FIELD"]) > 0) {
        jQuery("#" + idToHide).html("");
    }else{
    	jQuery("#" + idToHide).hide();
	}
	jQuery("#" + idToShow).attr("disabled", "");
}
*/
//Sam not work don't know why
function swapBackElement(idToShow, idToHide){
	//jQuery("#" + idToShow).show();
	//alert(jQuery("#" + idToShow).css('text-align'))
	
	/*
	 * 09-18-2014
	 * FIX : text alignment issue
	 */
	jQuery("#" + idToShow).css('display','inline');
	//jQuery("#" + idToShow).css('display','block');
	//jQuery("#" + idToShow).show();
	if(idToHide.indexOf(objNamingConst["EDITABLE_FIELD"]) > 0) {
        jQuery("#" + idToHide).html("");
    }else{
    	jQuery("#" + idToHide).hide();
	}
	jQuery("#" + idToShow).removeAttr('disabled');
}
function toggleViewMode(){
	jQuery("div").find("[id$='"+objNamingConst["DISPLAY_FIELD"]+"']").show();
	jQuery("div").find("[id$='"+objNamingConst["EDITABLE_FIELD"]+"']").html("");
	jQuery("div").find("[id$='"+objNamingConst["EDITABLE_FIELD"]+"']").attr("disabled", "disabled");
}

function ajaxFormUpdate(contextPath, moduleID, fieldID, rowID, newValue, objType) {
	//alert('moduleID -> ' + moduleID + '\n' + 'fieldID -> ' + fieldID + '\n' + 'rowID -> ' + rowID);
	newValue = newValue.replace(/&/g,'<@change@>');
	var paramList = "module=" + moduleID;
	paramList += "&fieldID=" + fieldID;
	paramList += "&rowID=" + rowID;
	paramList += "&newValue=" + encodeURI(newValue);
	paramList += "&objType=" + objType;
	var uri = contextPath + "/AjaxUpdateManyRowServlet"; 
	
	jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: paramList,
		   success: function(data){
				ajaxFormUpdateHandler(data);
				jQuery("#"+moduleID+"Many").find("[id$='"+objNamingConst["DISPLAY_FIELD"]+"']").removeAttr('disabled');
			}
		   });
	
	
}

function ajaxFormUpdateHandler(data){	
	return;
}

function manualTBEditinLine(rowID,moduleID, fieldID) {
	//for override
}
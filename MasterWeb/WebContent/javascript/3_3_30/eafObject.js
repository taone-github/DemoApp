//for support json this script need to run after json paint
//$(document).ready( function() {
//	initObject();
//});


function initObject(){
	$('input').each(function(){
		$(this).focus(function(){
			$(".selectbox").removeClass("selectbox").addClass("componentSelect");
			$(this).parent().parent().find('.componentSelect').removeClass("componentSelect").addClass("selectbox");
		});
		$(this).blur(function(){
			$(".selectbox").removeClass("selectbox").addClass("componentSelect");
		});
	});
	
	$('textarea').each(function(){
		$(this).focus(function(){
			$(".selectbox").removeClass("selectbox").addClass("componentSelect");
			$(this).parent().parent().find('.componentSelect').removeClass("componentSelect").addClass("selectbox");
		});
		$(this).blur(function(){
			$(".selectbox").removeClass("selectbox").addClass("componentSelect");
		});
	});

	$('.calendarEN').each(function(){
	    $(this).datepicker({ 
	    	changeYear:true, 
            changeMonth:true, showOn: "button", buttonImage: "images/calendar_Div.gif", buttonImageOnly: true, dateFormat: 'dd/mm/yy', isBuddhist: false});
	});
	
	$('.calendarEN_TO').each(function(){
	    $(this).datepicker({ 
	    	changeYear:true, 
            changeMonth:true, showOn: "button", buttonImage: "images/calendar_Div.gif", buttonImageOnly: true, dateFormat: 'dd/mm/yy', isBuddhist: false});
	});
	
	$('.calendarTH').each(function(){
	    $(this).datepicker({ 
	    	changeYear:true, 
            changeMonth:true,showOn: "button", buttonImage: "images/calendar_Div.gif", buttonImageOnly: true, dateFormat: 'dd/mm/yy', isBuddhist: true});
	});
	
	$('.calendarTH_TO').each(function(){
	    $(this).datepicker({ 
	    	changeYear:true, 
            changeMonth:true,showOn: "button", buttonImage: "images/calendar_Div.gif", buttonImageOnly: true, dateFormat: 'dd/mm/yy', isBuddhist: true});
	});

	//Fix Search object
	$('.textbox1search').each(function(){
		$(this).find('.componentDiv div').css('left','20');
		
		//change left of img index 1
		$(this).find('.componentDiv img:eq(1)').css('left','400px');
		
		$(this).find('.alldot2').css('left','250');
		//For Old dynamic
		$(this).find('.listboxtype').css('left','0');
		//for Old radio
		$(this).find('.radioGroupTable').css('left','0');
		
		//For PMS
		//$(this).find('.componentDiv img:eq(1)').css('left','418px');
	});
	
	//alert($('.content-all').css('height'));
	//$('form[name=masterForm]').css('height',$('.content-all').css('height'));
}

function popupClickDivTheme(contextPath, moduleID, fieldID, objName, mfID, rowID ,strInput, entityID , moduleType){
	var searchTxt = "";
	var masterForm = "masterForm";
	if(moduleType == 'MANY'){
		masterForm = "masterForm"+moduleID;
	}
	if(fieldID != "" && fieldID != null){
		//searchTxt =  eval("document."+masterForm+"."+fieldID+".value");
		searchTxt = $('input[name='+fieldID+']').val();
	}	
	var depenCriteria = "";	
	if (strInput != "BLANK") {
		var arrInput = strInput.split('@');
		var i=0;
		
		
		for (i=0;i< (arrInput.length-1);i++) {					
//			depenCriteria = depenCriteria +  "&"+arrInput[i]+"="+ encodeURIComponent(eval("document."+masterForm+"."+arrInput[i]+".value"));		
			depenCriteria = depenCriteria +  "&"+arrInput[i]+"="+ encodeURIComponent($("[name="+arrInput[i]+"]").val());		
		}
	}
	
	if(entityID != '') {
		var dataString = "&entityIDForList="+entityID;
		dataString += "&moduleIDForAction="+moduleID;
		dataString += "&newRequestFlag=Y";
		dataString += "&popupFlag=Y";
		dataString += "&formName="+moduleID+"Form";
		dataString += "&objName="+objName;
		dataString += "&mfID=" + mfID;
		dataString += "&rowID="+rowID;
		dataString += "&fieldID="+fieldID;
		dataString += depenCriteria;
		var uri = contextPath +"/ManualServlet?className=com.avalant.display.many.LoadListManyManual";
		
		blockScreen();
		
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:  false,
		   success: function(data){
			$('#many_'+moduleID+'_dialog').html(data);
			//change width onfly
			//$('#many_'+moduleID+'_dialog').dialog('option','width',970);
			//$('#many_'+moduleID+'_dialog').dialog('option','height',300);
			var divObj = $('#many_'+moduleID+'_dialog');
			divObj.dialog({
					   autoOpen: false,
					   modal: true,
					   open: true,
					   maxWidth: "500px",
					   width: $(window).width() > 500 ? "500px" : "90%",
					   close: function() {
					   $(this).dialog('close');
					}
			});
			divObj.dialog('open');
//			$('.ui-dialog-content').css({"left":""});
//			$('.ui-dialog-content').css({"height":""});
//			$('.ui-widget-content').css({"height":""});
			$('#many_'+moduleID+'_dialog').css({"height":""});
			unblockScreen();
		   },
		   error: function(x, t, m) 
		   {
		        if(t==="timeout") 
		        {
		            alert("ERROR: request timeout.");
		        }
		        else 
		        {
		            alert('ERROR: ' +t);
		        }
		        unblockScreen();
		    }
		});
		
	} else { 
		
		var dataString = "modulename="+moduleID;
		dataString += "&formName="+moduleID+"Form";
		dataString += "&objName="+objName;
		dataString += "&mfID="+mfID;
		dataString += "&searchTxt="//+searchTxt;
		dataString += "&rowID="+rowID;
		dataString += "&fieldID="+fieldID;
		dataString += "&moduleType="+moduleType;
		dataString += depenCriteria;	
		//window.open(contextPath + "/PopupServlet?"+dataString,"mywindow","width=450,height=280,scrollbars=1,status=1,toolbar=1");
		//paint to dialog
		
		var uri = contextPath+"/ManualServlet?className=com.avalant.display.PopupProSilver";
		
		blockScreen();
		
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false,
		   success: function(data) {
//			   console.log(data);
				$('#'+moduleID+'_'+fieldID+'_dialog').html(data);
				/* 20180516 - fixed dialog overflow on mobile screen */
				var divObj = $('#'+moduleID+'_'+fieldID+'_dialog');
				divObj.dialog({
						   autoOpen: false,
						   modal: true,
						   open: true,
						   maxWidth: "500px",
						   width: $(window).width() > 500 ? "500px" : "90%",
						   close: function() {
							   $(this).dialog('close');
						   }
				});
				divObj.dialog('open');
				
				$('#'+moduleID+'_'+fieldID+'_dialog').css({"height":""});
//				$('.ui-dialog-content').css({"height":""});
//				$('.ui-widget-content').css({"height":""});
//				$('.ui-dialog-content').css({"left":""});
				unblockScreen();
				try{
					fieldID + 'PopupOpenManualJS()';
				}catch(e){}
				
		   },
		   error: function(x, t, m) 
		   {
		        if(t==="timeout") 
		        {
		            alert("ERROR: request timeout.");
		        }
		        else 
		        {
		            alert('ERROR: ' +t);
		        }
		        unblockScreen();
		    }
		});
	}
}

function setValListBox(fieldName , newValue){
	var radioPopupLabel = fieldName + '_PopupLabel';
	var labelName = fieldName + '_Label';
	var arrow = '<a href="#" class="arrowblack"></a>';
	var labelL 	= $('.'+radioPopupLabel+'[value='+newValue+']').attr('label');
	var listLabelClass = $('#' + labelName).find('div').attr('class');
	var id = $('#' + labelName).find('div input').attr('id');
	$('#' + labelName).html('<div class="'+listLabelClass+'"><input type="hidden" name="' + fieldName + '" value="' + newValue + '"id="'+id+ '" /> ' + labelL +'</div>' +arrow+ "  ");
}

function setValRadioBox(fieldName , newValue){
	var radioPopupLabel = fieldName + '_PopupLabel';
	var labelName = fieldName + '_Label';
	var labelL 	= $('.'+radioPopupLabel+'[value='+newValue+']').attr('label');
	$('#' + labelName).html('<input disabled type="radio" name="' + fieldName + '" value="' + newValue + '" checked/> ' + labelL);
}

function popupOnBlurDivTheme(contextPath, moduleID, fieldID, objName, mfID, rowID, strInput, entityID , moduleType , obj){
	var searchTxt = "";
	var fieldVal = $(obj).val();

	if(fieldID != "" && fieldID != null){
//		if(moduleType == 'MANY' ){
//			searchTxt =  eval("document.masterForm"+moduleID+"."+fieldID+".value");
//		}else if(moduleType == 'MATRIX'){
//			searchTxt = $("input[name="+fieldID+"]").val()  ;
//		}else{
//			searchTxt =  eval("document.masterForm."+fieldID+".value");
//		}
		searchTxt = fieldVal;
	}
		console.log(">>>"+searchTxt+"<<<");
	var depenCriteria = "";
	
	if (strInput != "BLANK") {
		var arrInput = strInput.split('@');
		var i=0;	
		for (i=0;i< (arrInput.length-1);i++) {
			if(moduleType == 'MANY'){
				depenCriteria = depenCriteria+ "&"+arrInput[i]+"="+ encodeURIComponent(eval("document.masterForm"+moduleID+"."+arrInput[i]+".value"));
			}else if(moduleType == 'MATRIX'){
				depenCriteria = depenCriteria+ "&"+arrInput[i]+"="+ encodeURIComponent($("input[name="+arrInput[i]+"]").val());
			}else{
				depenCriteria = depenCriteria+ "&"+arrInput[i]+"="+ encodeURIComponent(eval("document.masterForm."+arrInput[i]+".value"));
			}
		}
	}	
	

	
	if (searchTxt != "" &&  searchTxt != undefined) {
		var uri = contextPath+"/ManualServlet?className=manual.eaf.popup.PopupOneRecordServlet";
		var dataString = "mfID="+mfID+"&modulename="+moduleID+"&fieldID="+fieldID+"&searchTxt="+encodeURIComponent(searchTxt)+depenCriteria;
		jQuery.ajax({
			type: "POST",
			url: uri,
			data: dataString,
			success: function(data){				
				if (data != "") {
					var arr = data.split('_|_');									
					if (parseInt(arr[0]) == 1) {
						// eval("document.masterForm."+fieldID+".value=\""+arr[1]+"\"");
						// eval("document.masterForm."+fieldID+"_DESC.value=\""+arr[2]+"\"");
						try {
							if(moduleType == 'MANY' ){
								eval("document.masterForm"+moduleID+"."+fieldID+".value=\""+arr[1]+"\"");
								eval("document.masterForm"+moduleID+"."+fieldID+"_DESC.value=\""+arr[2]+"\"");
							}else if(moduleType == 'MATRIX'){
								$("input[name="+fieldID+"]").val(arr[1])  ;
								$("input[name="+fieldID+"_DESC]").val(arr[2])  ;
							}else{
								eval("document.masterForm."+fieldID+".value=\""+arr[1]+"\"");
								eval("document.masterForm."+fieldID+"_DESC.value=\""+arr[2]+"\"");
							}
						} catch (e) {
							if(moduleType == 'MANY'){
								eval("document.masterForm"+moduleID+"."+fieldID+".value=\""+addSlashAtFrontOfSpecialChar(arr[1])+"\"");
								eval("document.masterForm"+moduleID+"."+fieldID+"_DESC.value=\""+addSlashAtFrontOfSpecialChar(arr[2])+"\"");
							}else if(moduleType == 'MATRIX'){
								$("input[name="+fieldID+"]").val(addSlashAtFrontOfSpecialChar(arr[1]))  ;
								$("input[name="+fieldID+"_DESC]").val(addSlashAtFrontOfSpecialChar(arr[2]))  ;
							}else{
								eval("document.masterForm."+fieldID+".value=\""+addSlashAtFrontOfSpecialChar(arr[1])+"\"");
								eval("document.masterForm."+fieldID+"_DESC.value=\""+addSlashAtFrontOfSpecialChar(arr[2])+"\"");
							}
						}	
					} else {
						try {
							if(moduleType == 'MANY'  )
							{
								eval("document.masterForm"+moduleID+"."+fieldID+".value=\"\"");
								eval("document.masterForm"+moduleID+"."+fieldID+"_DESC.value=\"\"");
							}else if(moduleType == 'MATRIX'){
								$("input[name="+fieldID+"]").val('')  ;
								$("input[name="+fieldID+"_DESC]").val('')  ;
							}else
							{
								eval("document.masterForm."+fieldID+".value=\"\"");
								eval("document.masterForm."+fieldID+"_DESC.value=\"\"");
							}
							 $(obj).val('');
						} catch (e) {}
						popupClickDivTheme(contextPath, moduleID, fieldID, objName, mfID, rowID,strInput, entityID, moduleType);
					} 	

				} else {
					try {
						if(moduleType == 'MANY')
						{
							eval("document.masterForm"+moduleID+"."+fieldID+".value=\"\"");
							eval("document.masterForm"+moduleID+"."+fieldID+"_DESC.value=\"\"");
						}else if(moduleType == 'MATRIX'){
							$("input[name="+fieldID+"]").val('')  ;
							$("input[name="+fieldID+"_DESC]").val('')  ;
						}
						else
						{
							eval("document.masterForm."+fieldID+".value=\"\"");
							eval("document.masterForm."+fieldID+"_DESC.value=\"\"");
						}
						 $(obj).val('');
					} catch (e) {}
					popupClickDivTheme(contextPath, moduleID, fieldID, objName, mfID, rowID,strInput, entityID, moduleType);
				}

				 try { 
					 eval(objName+"PopupManualJS()");
				 } catch(e) { 
				 }					
			}

		});						
	} else {
		if(moduleType == 'MANY' ){
			eval("document.masterForm"+moduleID+"."+fieldID+".value =\"\"");
			eval("document.masterForm"+moduleID+"."+fieldID+"_DESC.value =\"\"");
		}else if(moduleType == 'MATRIX'){
			$("input[name="+fieldID+"_DESC]").val('')  ;
		}else{
			eval("document.masterForm."+fieldID+".value =\"\"");
			eval("document.masterForm."+fieldID+"_DESC.value =\"\"");
		}
	}
}

//## input -> String objName
//## set money format to field after fetching the data from database
function moneyFormatDivTheme(objName, moduleType , moduleId){
	var objList = null;
	//Sam change masterForm to masterForm[MODULE_ID] for popup in ProSilver
	if(moduleType == 'MANY'){
		objList = document.forms['masterForm'+moduleId].elements[objName];
	}else if (moduleType == 'MATRIX'){
		objList = $('[id='+objName+']');
	}else{
		objList = $('[name='+objName+']');//document.forms['masterForm'].elements[objName];
	}
	
	var objIsArray = true;
	if(objList.length == null){
		objIsArray = false;
	}
	
	if(objIsArray){
		for(var i=0; i<objList.length; i++){
			if(objList[i].value.indexOf(',') == -1){
				convert2Digit(objList[i], 2);
				addComma(objList[i]);
			}
		}
	}else{
		if(objList != null && objList != undefined && objList.value != '') {
			if(objList.value.indexOf(',') == -1){
				convert2Digit(objList, 2);
				addComma(objList);
			}
		}
//		if(document.getElementById(objName) && document.getElementById(objName).value != null && document.getElementById(objName).value != ""){
//			if(document.getElementById(objName).value.indexOf(',') == -1){
//				convert2Digit(document.getElementById(objName), 2);
//				addComma(document.getElementById(objName));
//			}
//		}
	}
}
var skipKeyMany = '';

function setSkipKeyMany(oldVal){
	skipKeyMany = oldVal;
}

function validateKeyMany(key,newVal){
	var result = 'N';
	if(skipKeyMany != newVal){
		//generate key parameter
		var dataString = "listKey=";
		for(var i=0; i<key.length; i++) {
			dataString += key[i]+','+jQuery('[name="'+key[i]+'"]').val();
			if(i!=(key.length-1)){
				dataString+='||';
			}
		}
		result = 'N';
		var uri = getcontextPath()+"/ManualServlet?className=com.master.manual.ValidateKeyManual";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false, 		   
		   success: function(data){
		   		result = data;
		   }
		});
	}else{
		result = 'Y'; // Same old value = not dup
	}
	return result;
}

function closeAllSlideObject(){
	try{
		$("[id$='_UIID']").hide();
	}catch(e){
	}
}

function downloadFile(reportName,fileName){
	var validate = true;
	if(reportName == 'TenantRequest' || reportName == 'TimeTenantRequest'){
		if($('[name=FROM_TR_DATE]').val() == '' || $('[name=TO_TR_DATE]').val() == '' || $('[name=SUBJECT_TYPE_ID]').val() == ''){
			validate = false;
		}
		
	}else{
		if($('[name=FROM_PAID_DATE]').val() == '' || $('[name=TO_PAID_DATE]').val() == ''|| $('[name=ACCOUNT_CODE]').val() == ''){
			validate = false;
		}
	}
	if(validate){
		var dataString = '&TODAY='+toDayStr+'&'+jQuery("form[name='masterForm']").serialize();
		var url = "/MasterWeb/manual/jsp/result_pdf.jsp?reportName="+reportName+"&fileName="+fileName+dataString;
		window.open(url, scrollbars=0,toolbar=0, menubar=0,directories=0);
	}else{
		alert('Please fill all condition');
	}
}

function switchTabByJS(tabId){
	setCurrentSpanGeneralTab(tabId); 
	switchTabAjax(tabId, 'moduleContainer');
}

function initEafTab(){
	//height background lower tab
	try{
	//Rearrange height of module one
	assignHeighForModuleOne();
	}catch(e){}
	try{
		
		var h = $('.miniBlock').css('height');
		$('.grey-block').css('height',h);
		$('.grey-block').css( "height", "+=30px" );
		$('.left-line').css('height',h);
		$('.left-line').css( "height", "+=30px" );
		//$('.moduleDiv').last().css('border-bottom','#bfbfbf 1px solid');
	}catch(e){}
}

function initGeneralTab(){
	try{
		//one layer tab
		var h = $('.content-all').css('height');
		//alert('h = ' + h);
		//$('.content-center-normalTab').css('height',h);
		//$('.content-center-normalTab').css('height','+=20px');
	}catch(e){}
	try{
		var h = $('.content-all').css('height');
		$('.gridModuleContainer').css('height',h );
		$('.gridModuleContainer').css('height','+=20px');
	}catch(e){}
}

function clearSearchCriteria() {
    $('.searchCriteriaContainer').find(':input').each(function() {
        switch(this.type) {
            case 'password':
            case 'select-multiple':
            case 'select-one':
            case 'text':
            case 'textarea':
                $(this).val('');
                break;
            case 'checkbox':
            case 'radio':
                this.checked = false;
        }
    });
}

function postInitEAF(){
	//height search box
	initObject();
	try{
		var h = $('.content-all2').css('height');
		$('.content-center2').css('height',h);
		$('.content-center2').css('height','+=20px' );
		$('.content-left2').css('height',h);
		$('.content-left2').css('height','+=20px' );
	}catch(e){}
	initGeneralTab();
	initEafTab();
}

function initPictureObject(fieldId,value,imgName,moduleId){
	$("#pictureDiv_"+moduleId).show();
	$("#pictureDiv_"+moduleId).find("#tempIMG").attr('src',value);
	$("#pictureDiv_"+moduleId).find("#fieldId_pic").val(fieldId);
	$("#pictureDiv_"+moduleId).find("#oldImgName").val(imgName);
}

function initPictureMain(moduleId, viewModeFlag){
	$("#container").append(
			"<div class=pictureDiv style=\"display:none\" id=pictureDiv_"+moduleId+">"+
			"<form id=\"theuploadform_"+moduleId+"\">"+
			"<div id=resultUpload_"+moduleId+"><img width=\"200\" height=\"200\" id=\"tempIMG\" alt=\"image not found\" ></div>"+
			/*
			 * FIX : 28-10-2014 : parse viewModeFlag for hide upload button
			 */
			(viewModeFlag ? "" : "<input id=\"fileName\" name=\"fileName\" size=\"10\" type=\"file\" />")+
			(viewModeFlag ? "" : "<input onclick=\"uploadPicture('"+moduleId+"')\" type=\"button\" value=\"Upload\" />")+
			"<input id=\"fieldId_pic\" name=\"fieldId_pic\"  type=\"hidden\" />"+
			"<input id=\"oldImgName\" name=\"oldImgName\"  type=\"hidden\" />"+
			"</form>"+
			"<iframe name=\"postiframe_"+moduleId+"\" id=\"postiframe_"+moduleId+"\" style=\"display:none\" />"+
			"</div>"
	);
}

function initPictureMany(moduleId, viewModeFlag){
	$("#pic_"+moduleId).append(
			"<div style=\"display:none\" id=pictureDiv_"+moduleId+">"+
			"<form id=\"theuploadform_"+moduleId+"\">"+
			"<div id=resultUpload_"+moduleId+"><img width=\"200\" height=\"200\" id=\"tempIMG\" alt=\"image not found\" ></div>"+
			/*
			 * FIX : 28-10-2014 : parse viewModeFlag for hide upload button
			 */
			(viewModeFlag ? "" : "<input id=\"fileName\" name=\"fileName\" size=\"10\" type=\"file\" />")+
			(viewModeFlag ? "" : "<input onclick=\"uploadPicture('"+moduleId+"')\" type=\"button\" value=\"Upload\" />")+
			"<input id=\"fieldId_pic\" name=\"fieldId_pic\"  type=\"hidden\" />"+
			"<input id=\"oldImgName\" name=\"oldImgName\"  type=\"hidden\" />"+
			"</form>"+
			"<iframe name=\"postiframe_"+moduleId+"\" id=\"postiframe_"+moduleId+"\" style=\"display:none\" />"+
			"</div>"
	);
}

function uploadPicture(moduleId){
	var form = $('#theuploadform_'+moduleId);
    form.attr("action", "UploadPicture");
    form.attr("method", "post");
    form.attr("enctype", "multipart/form-data");
    form.attr("encoding", "multipart/form-data");
    form.attr("target", "postiframe_"+moduleId);
    form.attr("file", $("#theuploadform_"+moduleId).find('#fileName').val());
    form.submit();

    $("#postiframe_"+moduleId).load(function () {
        iframeContents = $("#postiframe_"+moduleId)[0].contentWindow.document.body.innerHTML;
        $("#resultUpload_"+moduleId).html(iframeContents);
    });
    return false;
}

function manualAfterDepend(fieldId){
	
}

function showErrorProsilver(msg){
	//alert('Msg');
	$('.oneWebErrorConsole').html(msg);
	setTimeout("jQuery(\".oneWebErrorConsole\").fadeIn(\"fast\")", 200);
}

function initPictureObject(fieldId,value,imgName){
	$(".pictureDiv").show();
	$("#tempIMG").attr('src',value);
	$("#fieldId_pic").val(fieldId);
	$("#oldImgName").val(imgName);
}

var popup;
var processMode = {UPDATE : "UPDATE" , SEARCH : "SEARCH"};

function loadReportEntity(entityID){
	
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201701231622
	* cancel function loadReportEntity() in eafObject.js 
	* Reason : com.manual.ERP.ReportManualServlet does not exits in EAFCore
	* ReportManualServlet is also removed from web.xml
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	alert('ERROR : loadReportEntity : function removed since Oneweb 4.0');
	return;
	
	var dataString = "entityID=" + entityID ;
	dataString += "&functionName=getReportPath";
	var uri = "/MasterWeb/ReportManualServlet";
		jQuery.ajax({
		type: "POST",
		url: uri,
		data: dataString,
		async: false,
		success: function(data){
			
		}
	});
}

function exportPDF() {
	
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201701231626
	* cancel function exportPDF() in eafObject.js 
	* Reason : com.manual.report.ExportJasperServlet does not exits in EAFCore
	* ExportJasperServlet is also removed from web.xml
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	alert('ERROR : exportPDF : function removed since Oneweb 4.0');
	return;
	
	var validate = true;
	var mode = $(".insertScreen").length == 0 ? processMode.SEARCH : processMode.UPDATE;
	var entityID = $('[name=beweno1]').val();
	if(mode == processMode.SEARCH){
		var dataString = $(".searchCriteriaContainer :input").serialize() + "&entityID=" + entityID;//alert(dataString);
	} else {
		loadReportEntity(entityID);
		var dataString = $("#gridModuleContainer :input").serialize() + "&entityID=" + entityID;
	}
	var url = "/MasterWeb/ExportJasperServlet?" + dataString;
	popup = window.open(url, 'Avalant', 'location=0,titlebar=0,scrollbars=0,toolbar=0, menubar=0,directories=0,height=' + screen.height + ',width=' + screen.width);
	popup.moveTo(0,0);
}
//$.importJS("javascript/lang/controlLang.js");

$.getScript("javascript/lang/controlLang.js");




function checkDate1(formName,field,mandate, objDate, isBuddhist){
	 
	 //var obj=eval("document."+formName+"."+field);	
	 // ************************ objDate work with Core version 3.3.37 build 4 only ****************************
	 var obj= objDate!=undefined ? objDate : eval("document."+formName+"."+field);	
	 if (obj.value != "") {					 
	 	//if(!validateUSDate(obj.value) && obj.value != '' ){
		//Praisan Khunkaew 28/11/2007
		var strDate = obj.value;
		var arrayField = obj.value.split('/');
		
		/*
		 * FIX : 2014-10-28 : isBuddhist for check buddhist year
		 */
		if(isBuddhist != undefined && isBuddhist)
		{
			strDate = arrayField[0] + '/' + arrayField[1] + '/' + (parseInt(arrayField[2]) - 543);// ร ยนโ�ฌร ยธโ€บร ยธยฅร ยธยตร ยนห�ร ยธยขร ยธโ�ข ร ยธลพ.ร ยธยจ. ร ยนฦ’ร ยธยซร ยนโ€ฐร ยนโ�ฌร ยธโ€บร ยนโ€กร ยธโ�ข ร ยธโ€�.ร ยธยจ.
		} 
		else if(parseInt(arrayField[2]) >= 2550)
		{
			strDate = arrayField[0] + '/' + arrayField[1] + '/' + (parseInt(arrayField[2]) - 543);// ร ยนโ�ฌร ยธโ€บร ยธยฅร ยธยตร ยนห�ร ยธยขร ยธโ�ข ร ยธลพ.ร ยธยจ. ร ยนฦ’ร ยธยซร ยนโ€ฐร ยนโ�ฌร ยธโ€บร ยนโ€กร ยธโ�ข ร ยธโ€�.ร ยธยจ.
		}
		
		if(!validateUSDate(obj) && obj.value != '' ){
			obj.focus();
			obj.select();
		}else{
			if(mandate && obj.value==''){ 
				alert(WRONG_DATE); 
				//alert('<%=ErrorUtil.getShortErrorMessage(request,"INVALID_DATE")%>');//mol comment 15/09/2006
				obj.focus();
				obj.select();
			}else{
				autoConvertThaiYear(obj);
			}
		}
	}
 }
 
 function checkDate(obj,mandate, isBuddhist){
	//var obj=eval("document."+form+"."+field);
	//if(!validateUSDate(obj.value) && obj.value != '' ){
	//Praisan Khunkaew 28/11/2007
	var strDate = obj.value;
	var arrayField = obj.value.split('/');	
	
	/*
	 * FIX : 2014-10-28 : isBuddhist for check buddhist year
	 */
	if(isBuddhist != undefined && isBuddhist)
	{
		strDate = arrayField[0] + '/' + arrayField[1] + '/' + (parseInt(arrayField[2]) - 543);// ร ยนโ�ฌร ยธโ€บร ยธยฅร ยธยตร ยนห�ร ยธยขร ยธโ�ข ร ยธลพ.ร ยธยจ. ร ยนฦ’ร ยธยซร ยนโ€ฐร ยนโ�ฌร ยธโ€บร ยนโ€กร ยธโ�ข ร ยธโ€�.ร ยธยจ.
	}
	else if(parseInt(arrayField[2]) >= 2550)
	{
		strDate = arrayField[0] + '/' + arrayField[1] + '/' + (parseInt(arrayField[2]) - 543);// ร ยนโ�ฌร ยธโ€บร ยธยฅร ยธยตร ยนห�ร ยธยขร ยธโ�ข ร ยธลพ.ร ยธยจ. ร ยนฦ’ร ยธยซร ยนโ€ฐร ยนโ�ฌร ยธโ€บร ยนโ€กร ยธโ�ข ร ยธโ€�.ร ยธยจ.
	}
	
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201704181118 : date format is wrong when open calendar and close without selecting date
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	if(obj.value != '' && !validateUSDate(obj)){
		obj.focus();
		obj.select();
	}else{
		if(mandate && obj.value=='') { 
			alert(WRONG_DATE); 
			//alert('<%=ErrorUtil.getShortErrorMessage(request,"INVALID_DATE")%>');//mol comment 15/09/2006
			obj.focus();
			obj.select();  
		}else{
			autoConvertThaiYear(obj);
		}
	} 
 }
 
 
  
function validateUSDate( obj , isBuddhist) { 
	var strDate = obj.value;
	var strValue = trimString(strDate);
	var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
		
	if(!objRegExp.test(strValue) && strValue != "" ){
		 alert(WRONG_DATE);
		 obj.value =  "";
		//alert('<%=ErrorUtil.getShortErrorMessage(request,"INVALID_DATE")%>');//mol comment 15/09/2006
		 return false;
	} else {
		var strSeparator = strValue.substring(2,3) //find date separator
		var arrayDate = strValue.split('/'); //split date into month, day, year
    
		//create a lookup for months not equal to Feb.
		var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
		var intDay = parseInt(arrayDate[0],10);
	
		//var m = '09';
		var intMonth = parseInt(arrayDate[1],10);
		var intYear = parseInt(arrayDate[2]);
		//	var intChristYear = intYear - 543;
		//alert(intDay);
		//	alert(arrayDate[1]);
		//alert(arrayDate[2]);
    
		if(arrayLookup[arrayDate[1]] != null) {
			if((intDay <= arrayLookup[arrayDate[1]]) && intDay != 0 && intMonth < 13) {
				return true; //found in lookup table, good date
			}
        
		}
    
		/*
		 * FIX : 2014-10-28 : isBuddhist for check buddhist year
		 */
		if(isBuddhist != undefined && isBuddhist)
		{
			intYear = intYear -543;
		}
		else if (intYear >= 2550) {
			intYear = intYear -543;
		}
    
		//check for February   
		//	alert(intChristYear);
		//if( ((intYear % 4 == 3 && intDay <= 29) || (intYear % 4 != 3 && intDay <=28)) && intDay !=0 && intMonth <13 && intMonth >0  )
		if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0&& intMonth <13 ) // Update by Praisan Khunkaew 28/11/2007 
		{
			return true; //Feb. had valid number of days
		}
      
  		
		if(strValue == '') {
			return true;
		}
     
  	    alert(WRONG_DATE);
  	    obj.value =  "";
  		//alert('<%=ErrorUtil.getShortErrorMessage(request,"INVALID_DATE")%>');//mol comment 15/09/2006
  	    return false;
  }
}

	function trimString (str) {
	  str = this != window? this : str;
	  return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
	}

/*
	pass fieldID = '' -> when you want to search all (no criteria)
	pass rowID = '' -> when the popUp is not in manyRelation
*/
function popupClick(contextPath, moduleID, fieldID, objName, mfID, rowID ,strInput, entityID){
	var searchTxt = "";
	if(fieldID != "" && fieldID != null){
		searchTxt =  eval("document.masterForm."+fieldID+".value");
	}	
	var depenCriteria = "";	
	if (strInput != "BLANK") {
		var arrInput = strInput.split('@');
		var i=0;	
		for (i=0;i< (arrInput.length-1);i++) {					
			depenCriteria = depenCriteria +  "&"+arrInput[i]+"="+ encodeURIComponent(eval("document.masterForm."+arrInput[i]+".value"));			
		}
	}
	
	if(entityID != '') {
		var url = contextPath + "/FrontController?action=loadListMany"
		var dataString = "&entityIDForList="+entityID;
			dataString += "&moduleIDForAction="+moduleID;
			dataString += "&newRequestFlag=Y";
			dataString += "&popupFlag=Y";
			dataString += "&openFirstTime=Y";
			dataString += "&formName="+moduleID+"Form";
			dataString += "&objName="+objName;
			dataString += "&mfID=" + mfID;
			dataString += "&rowID="+rowID;
		dataString += "&fieldID="+fieldID;
			dataString += depenCriteria;	
		
		var height = 500;
		var width = 500;
		var left   = (screen.width  - width)/2;
	 	var top    = (screen.height - height)/2;
		window.open(url+dataString,"mywindow","scrollbars=1,width="+width+",height="+height+",left="+left+",top="+top);   
	} else { 
	
		var dataString = "modulename="+moduleID;
		dataString += "&formName="+moduleID+"Form";
		dataString += "&objName="+objName;
		dataString += "&mfID="+mfID;
		dataString += "&searchTxt="//+searchTxt;
		dataString += "&rowID="+rowID;
		dataString += "&fieldID="+fieldID;
		dataString += depenCriteria;	
		window.open(contextPath + "/PopupServlet?"+dataString,"mywindow","width=450,height=280,scrollbars=1,status=1,toolbar=1");       
	}
}

function popupOnBlur(contextPath, moduleID, fieldID, objName, mfID, rowID, strInput, entityID){
	var searchTxt = "";
	if(fieldID != "" && fieldID != null){
		searchTxt =  eval("document.masterForm."+fieldID+".value");
	}
		
	var depenCriteria = "";
	
	if (strInput != "BLANK") {
		var arrInput = strInput.split('@');
		var i=0;	
		for (i=0;i< (arrInput.length-1);i++) {						
			depenCriteria = depenCriteria+ "&"+arrInput[i]+"="+ encodeURIComponent(eval("document.masterForm."+arrInput[i]+".value"));
		}
	}	
	

	
	if (searchTxt != "" &&  searchTxt != undefined) {
		var uri = contextPath+"/ManualServlet?className=manual.eaf.popup.PopupOneRecordServlet";
		var dataString = "mfID="+mfID+"&modulename="+moduleID+"&fieldID="+fieldID+"&searchTxt="+searchTxt+depenCriteria;
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
							eval("document.masterForm."+fieldID+".value=\""+arr[1]+"\"");
						 	eval("document.masterForm."+fieldID+"_DESC.value=\""+arr[2]+"\"");
						} catch (e) {
							eval("document.masterForm."+fieldID+".value=\""+addSlashAtFrontOfSpecialChar(arr[1])+"\"");
						 	eval("document.masterForm."+fieldID+"_DESC.value=\""+addSlashAtFrontOfSpecialChar(arr[2])+"\"");
						
						}	
					} else {
						popupClick(contextPath, moduleID, fieldID, objName, mfID, rowID,strInput, entityID);
					} 	

				} else {
					popupClick(contextPath, moduleID, fieldID, objName, mfID, rowID,strInput, entityID);
				}

				 try { 
					 eval(objName+"PopupManualJS()");
				 } catch(e) { 
				 }					
			}

		});						
	} else {
		eval("document.masterForm."+fieldID+"_DESC.value =\"\"");
	}	
}

function checkdateFromtTo(fromObj,toObj) {
	try{
//		#rawi modify date from to support manual popup function
//		var  fromValue = fromObj.value;
//		var  toValue = toObj.value;
		var  fromValue = '';	
		var  toValue = '';	
		var FLAG = 'N';
		if(fromObj.value == undefined || toObj.value == undefined){
			fromValue = $("[name='"+fromObj+"']").val();
			toValue = $("[name='"+toObj+"']").val();
			FLAG = 'Y';
		}else{
			fromValue = fromObj.value;
			toValue = toObj.value;
		}
		if ((fromValue != '') && (toValue != '')){					
			var fromSprit = fromValue.split('/');
			var toSprit = toValue.split('/');				
			var toInt = parseInt(toSprit [2] + toSprit [1] +toSprit [0]); 
			var fromInt = parseInt(fromSprit [2] + fromSprit [1] +fromSprit [0]); 
			if (fromInt > toInt ) {							
				alert(WRONG_FROM_TO);
				if(FLAG == 'Y'){
					$("[name='"+toObj+"']").val('');
				}else{
					toObj.value ="";	
				}
			}						 	
		}	
	} catch (e) {}
}


	/* added by tiw - 29/06/2011 - for js special char eval*/
	function addSlashAtFrontOfSpecialChar(str){							
		str = str.replace(/\\/g, "\\\\");
		str = str.replace(/\'/g, "\\\'");
		str = str.replace(/\"/g, "\\\"");
		str = str.replace(/\n/g, "\\\n");
		str = str.replace(/\r/g, "\\\r");
		str = str.replace(/\t/g, "\\\t");
		//str = str.replace(/\b/g, "\\\b");
		str = str.replace(/\f/g, "\\\f");

		return str;
	}

	function autoConvertThaiYear(obj){
		var arrayField = obj.value.split('/');
		if(obj.className.indexOf('calendarTH') !== -1 || obj.className.indexOf('calendarTH_TO') !== -1){
			if(parseInt(arrayField[2]) < 2300)
				obj.value = arrayField[0] + '/' + arrayField[1] + '/' + (parseInt(arrayField[2]) + 543);
		}else if(obj.className.indexOf('calendarEN') !== -1 || obj.className.indexOf('calendarEN_TO') !== -1){
			if(parseInt(arrayField[2]) > 2300)
				obj.value = arrayField[0] + '/' + arrayField[1] + '/' + (parseInt(arrayField[2]) - 543);
		}
	}
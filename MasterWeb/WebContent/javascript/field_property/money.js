function checkLength(thisObj, maxlength) {
	/*var key = window.event.keyCode;
	
	if (key == 17 || key == 86) {
		thisObj.maxLength = 100;
	} else if (key == 109 && thisObj.value.indexOf('-') == -1) {
		thisObj.maxLength = thisObj.value.length + 1;
	} else {
		if (thisObj.value.indexOf(".") == -1 && key != 110 && key != 190) {
			thisObj.maxLength = maxlength;
		} else {

			if (thisObj.value.indexOf(".") < 12) {
				thisObj.maxLength = 100;
			} else if (thisObj.value.indexOf(".") == 12) {
				thisObj.maxLength = 15;
			}
		}
	}*/
}

function addComma(thisObj) {
	if (thisObj.value != '') {
		num = thisObj.value.replace(/,/, '');
		x = num.split('.');
		x1 = x[0];
		y = x[1];
		if (num == '') {
			y = '0.00';
		} else if (y == null || y == '' || typeof (y) == 'undefined') {
			y = ".00";
		} else if (y.length == 1) {
			y = "." + y + "0";
		} else {
			y = "." + y;
		}
		var rgx = /(\d+)(\d{3})/;
		while (rgx.test(x1)) {
			x1 = x1.replace(rgx, '$1' + ',' + '$2');
		}
		thisObj.value = x1 + y;
	}
}

function convert2Digit(obj, digitCount) {
	var maxlength = obj.maxLength;
	if (obj.value != '') {
		var a = obj.value;
		if(a.indexOf(".")!=-1){
			var b = new Number(a);
			var c = b.toFixed(digitCount);
			obj.value = c;
		}else{
			var b = a.substring(0, maxlength-digitCount-1);   // example maxlength = 18 so integer = 15, . = 1 and digitCount = 2
			var c = new Number(b);
			var d = c.toFixed(digitCount);
			obj.value = d;
		}
	}
}

function removeCurrentCommas(thisObj) {
	thisObj.value = thisObj.value.replace(/\,/g, '');
	thisObj.setSelectionRange(0,0);
}

function limitText(limitField, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	}
}
//
//function onKeyAllowed(e, decimalAllow) {
//	var key;
//	var keychar;
//	var keyAllow = false;
//	if (window.event) {
//		key = window.event.keyCode;
//	} else if (e) {
//		key = e.which;
//		srcElement = e.srcElement;
//	} else {
//		keyAllow = true;
//	}
//	
//	keychar = String.fromCharCode(key);
//	
//	if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27)) {
//		keyAllow = true;
//	} else if ((("0123456789").indexOf(keychar) > -1)) {
//		keyAllow = true;
//	} else if (decimalAllow && (keychar == ".")) {
//		keyAllow = true;
//	} else {
//		keyAllow = false;
//	}
//	
//	/*
//	 * FIX: 19-10-2014 : check currency max length
//	 * 
//	 */
//	if(keyAllow && decimalAllow && !((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27)))
//	{
//		var evt = e || window.event; // this assign evt with the event object
//	    
//		var srcElement = evt.target || evt.srcElement; // this assign current with the event target
//		
//	    if(srcElement != undefined)
//		{
//			var maxlen = $(srcElement).attr('maxlength');
//			
//			if(maxlen && $(srcElement).val().length > 0)
//			{
//				var prevVal = $(srcElement).val(); // value before change
//				
//				setTimeout(function() {
//					
//					var x1 = $(srcElement).val().split('.')[0]; // value after change
//					
//					if(x1.length > maxlen-3) 
//					{
//						$(srcElement).val(prevVal);
//					}
//				}, 1);
//			}
//		}
//		else
//		{
//			alert('ERROR: window.event is undefined.');
//		}
//	}
//	
//	
//	return keyAllow;
//}


/*
 * FIX : 26-10-2014 : CURRENCY FIELD IN CHROME
 */
function onKeyAllowed(e, decimalAllow) {
	var key;
	var keychar;
	var keyAllow = false;
	if (window.event) {
		key = window.event.keyCode;
	} else if (e) {
		key = e.which;
		srcElement = e.srcElement;
	} else {
		keyAllow = true;
	}
	
	keychar = String.fromCharCode(key);
	
	//if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27) || (key == 37)/*left arrow*/ || (key == 39)/*right arrow*/) {
	if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27) || (key == 37)/*left arrow*/ || (key == 39 && String.fromCharCode(0x2019) != keychar)/*right arrow*/) {
		keyAllow = true;
	} else if ((("0123456789").indexOf(keychar) > -1) 
			/*|| ((95<key && key<=105) || key==110)*/
		) {
		keyAllow = true;
	} else if (decimalAllow && (keychar == ".")) {
		keyAllow = true;
	} else {
		keyAllow = false;
	}
	//alert(String.fromCharCode(0x2019) + ':' + keychar)
	//alert(String.fromCharCode(0x2019) != keychar)
	
//	if(keychar) {
//		try {
//			if(!$.isNumeric(keychar.replace(/,/g, ""))){
//				keyAllow = false;
//			}
//		} catch (e) {
//			keyAllow = false;
//		}
//	}
	
	
	/*
	 * FIX: 19-10-2014 : check currency max length
	 * 
	 */
	
	//if(keyAllow && decimalAllow && !((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27) || (key == 37)/*left arrow*/ || (key == 39)*//*right arrow*/))
	if(keyAllow )
	{
		var evt = e || window.event; // this assign evt with the event object
	    
		var srcElement = evt.target || evt.srcElement; // this assign current with the event target
		
	    if(srcElement != undefined)
		{
			var maxlen = $(srcElement).attr('maxlength');
			var prevVal = $(srcElement).val(); // value before change
			if(decimalAllow && 
					!((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27) || (key == 37)/*left arrow*/ || (key == 39)/*right arrow*/)) {
				if(maxlen && $(srcElement).val().length > 0)
				{
					setTimeout(function() {
						
						var x1 = $(srcElement).val().split('.')[0]; // value after change
						
						if(x1.length > maxlen-3) 
						{
							$(srcElement).val(prevVal);
						}
					}, 0.001);
				}
			}
			
			setTimeout(function() {
				// check again
				if(!$.isNumeric($(srcElement).val().replace(/,/g, ""))) {
					$(srcElement).val(prevVal);
				}
				
			}, 0.001);
		}
		else
		{
			alert('ERROR: window.event is undefined.');
		}
	}
	
	
	if(!keyAllow) {
		if(e.preventDefault) {
			e.preventDefault();
		} else {
			e.returnValue = false;
		}
	}
	
	return keyAllow;
}

function validateFormat(thisObj,decimalAllow){
	var num = thisObj.value;
	if(decimalAllow){
		for (i = 0; i < num.length; i++) {
			keychar = num.substring(i, i + 1);
			if ("01234.56789".indexOf(keychar) == -1) {
				alert(decimalMsgErr);
				thisObj.value = "";
				break;
			}
		}
	}else{
		for (i = 0; i < num.length; i++) {
			keychar = num.substring(i, i + 1);
			if ("0123456789".indexOf(keychar) == -1) {
				alert(intMsgErr);
				thisObj.value = "";
				break;
			}
		}
	}
}

function validateData(thisObj) {
	var num = thisObj.value.replace(/,/, '');
	var isAllowed = true;
	var i = 0;
	// alert("+" + num + "+");
	for (i = 0; i < num.length; i++) {
		keychar = num.substring(i, i + 1);
		if ("01234.56789".indexOf(keychar) == -1) {
			alert(moneyMsgErr);
			thisObj.value = "0.00";
			break;
		}
	}
}

// ## input -> String objName
// ## set money format to field after fetching the data from database
function displayMoneyFormat(objName) {
	var objList = document.forms['masterForm'].elements[objName];
	// Sam change masterForm to masterForm[MODULE_ID] for popup in ProSilver

	var objIsArray = true;
	if (objList.length == null) {
		objIsArray = false;
	}

	if (objIsArray) {
		for ( var i = 0; i < objList.length; i++) {
			if (objList[i].value.indexOf(',') == -1) {
				convert2Digit(objList[i], 2);
				addComma(objList[i]);
			}
		}
	} else {
		if (document.getElementById(objName)
				&& document.getElementById(objName).value != null
				&& document.getElementById(objName).value != "") {
			if (document.getElementById(objName).value.indexOf(',') == -1) {
				convert2Digit(document.getElementById(objName), 2);
				addComma(document.getElementById(objName));
			}
		}
	}
}

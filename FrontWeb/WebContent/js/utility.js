/*********************************************************************************************************************************
*  Javascript Utility power by Khanthamat
*********************************************************************************************************************************/	
	var Day;
	var Month;
	var Year;

	var nullObject = null;
	var undefineObject = 'undefined';
	var numberObject = 'number';
	var stringObject = 'string';
	var booleanObject = 'boolean';

	var delMsg = "Are you sure Delete?";
	var edtMsg = "Are you Save?";
	var cancelMsg = "Are you sure Cancel?";

/*********************************************************************************************************************************
*  STATIC KEY VALIABLE
*********************************************************************************************************************************/
	var LEFT_ARROW = 37;
	var RIGHT_ARROW = 39;
	var BACKSPACE = 8;
	var DELETE = 46;
	var NUMBER_0 = 96;
	var NUMBER_9 = 105;
	var CHAR_0 = 48;
	var CHAR_9 = 57;
	var CHAR_SLACH = 191;
	var NUMBER_SLACH = 111;
	var CTRL = 17;
	var CHAR_V = 86;
	var CHAR_C = 67;
	var CHAR_X = 88;

	var TAB = 9;
	var SHIFT = 16;
	var END = 35;
	var ENTER = 13;
	var HOME = 36
	var Num0 = 96;
	var Num9 = 105;
	var No0 = 48;
	var No9 = 57;
	var CHAR_A = 65;
	var CHAR_Z = 90;
	var CHAR_a = 97;
	var CHAR_z = 122;
	var Negative = 109;

/*********************************************************************************************************************************
*  FUNCTION CLEAR FIELD
*********************************************************************************************************************************/	
	function clearField(obj){
		obj.value = '';
	}

/*********************************************************************************************************************************
*  FUNCTION CLEAR FIELD
*********************************************************************************************************************************/	
	function getNowDate(){
		var nowDate = new Date();
		var date =  nowDate.getDate();
		var month = nowDate.getMonth() +1;
		var year =  nowDate.getYear()+543;

		if(date >0 && date < 10){
			date = "0" + date;
		}

		if(month >0 && month < 10){
			month = "0" + month;
		}		

		return date + "/"+ month +"/" + year;
		
	}

/*********************************************************************************************************************************
*  FUNCTION IS DATE
*********************************************************************************************************************************/	
	function isDate(dateObj, alertMessages) {
		var dateStr = dateObj.value;
		var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
		var matchArray = dateStr.match(datePat); // is the format ok?
		
		if(dateObj.value == '')return false;

		if (matchArray == null) {
			if(alertMessages){
				alert("Please enter format date as  \'DD/MM/YYYY\'");
				dateObj.value = '';
				dateObj.focus();
			}
			return false;
		}

		Month = matchArray[3]; // p@rse date into variables
		Day = matchArray[1];
		Year = matchArray[5]-543;

//		if(Year > 2500)Year -= 543;

		var Feb = 28; 
		if((Year % 4 == 0 && Year%100 != 0) || Year %400 == 0) Feb = 29;

		var aryMonth = new Array(31,Feb,31,30,31,30,31,31,30,31,30,31);

		if(Year < 1900 && Year >3000){
			if(alertMessages){
				alert("Please enter new Year");
				dateObj.focus();
			}
			return false;
		}else if(Month < 1 || Month > 12 ){
			if(alertMessages){
				alert("Please enter new Month");
				dateObj.focus();
			}
			return false;
		}else if(Day < 1 || Day > aryMonth[Month-1]){
			if(alertMessages){
				alert("Please enter new Day");
				dateObj.focus();
			}
			return false;
		}
			
		/*if(Year < 2500){
			Year += 543;
		}*/
	/*	if(Year < 2500){
			Year = parseInt(Year) + parseInt(543);
		}*/

		var reFormatDate = '';
		if(Day.length == 1)reFormatDate = "0" + Day + "/";
		else reFormatDate  = Day + "/";

		if(Month.length == 1)reFormatDate += "0" + Month + "/";
		else reFormatDate += Month + "/";
		reFormatDate += Year+543;
		
		dateObj.value = reFormatDate;	

		return true;
	}

/*********************************************************************************************************************************
*  FUNCTION DATE DIFF
*********************************************************************************************************************************/
	function dateDiff(objFirstDate, objSecondDate) {
		date1 = new Date();
		date2 = new Date();
		dateX = new Date();
		dateY = new Date();
		dateZ = new Date();
		diff  = new Date();

		if (isDate(objFirstDate, false)) { // Validates first date 
			var FirstDate = Month + "/" + Day + "/" + (Year - 543);

			date1temp = new Date(FirstDate);
			date1.setTime(date1temp.getTime());

		}
		else return false; // otherwise exits

		if (isDate(objSecondDate, false)) { // Validates second date 
			var SecordDate = Month + "/" + Day + "/" +  (Year - 543);
			date2temp = new Date(SecordDate);
			date2.setTime(date2temp.getTime());
		}
		else return false; // otherwise exits

		// sets difference date to difference of first date and second date

		diff.setTime(Math.abs(date1.getTime() - date2.getTime()));		

		timediff = diff.getTime();
		//alert(timediff);
		days = Math.floor(timediff / (1000 * 60 * 60 * 24)); 
		timediff = days * (1000 * 60 * 60 * 24);
		
		if(days == 0)days = 0;
		else if(date1.getTime() - date2.getTime() < 0) days *= -1;
		
		return days;

/*		weeks = Math.floor(timediff / (1000 * 60 * 60 * 24 * 7));
		timediff -= weeks * (1000 * 60 * 60 * 24 * 7);

		days = Math.floor(timediff / (1000 * 60 * 60 * 24)); 
		timediff -= days * (1000 * 60 * 60 * 24);

		hours = Math.floor(timediff / (1000 * 60 * 60)); 
		timediff -= hours * (1000 * 60 * 60);

		mins = Math.floor(timediff / (1000 * 60)); 
		timediff -= mins * (1000 * 60);

		secs = Math.floor(timediff / 1000); 
		timediff -= secs * 1000;

		dateform.difference.value = weeks + " weeks, " + days + " days, " + hours + " hours, " + mins + " minutes, and " + secs + " seconds";

		return false; // form should never submit, returns false*/
	}


/*********************************************************************************************************************************
*  FUNCTION IS OBJECT
*********************************************************************************************************************************/	
	function isObject(obj){
		if(obj == nullObject) return false;

		if(objectType(obj) == undefineObject)return false;

		return true;
	}	

/*********************************************************************************************************************************
*  FUNCTION OBJECT TYPE
*********************************************************************************************************************************/
	function objectType(obj){
		return typeof(obj);
	}
	
/*********************************************************************************************************************************
*  FUNCTION OBJECT SIZE
*********************************************************************************************************************************/
	function objectSize(obj){
		if(objectType(obj) == undefineObject){
			return 0;

		}else if(obj.length){
			return obj.length;
			
		}else{
			return 1;
		}
	}


/*********************************************************************************************************************************
*  FUNCTION IS NUMBER
*********************************************************************************************************************************/
	function isNumber(obj){		
		//var num = obj.value.replace(',','');
		var num = placeNum(obj.value);
		if(num == ''){
			return false;
			
		
		}else if(isNaN(Number(num))){
			obj.value = '';
			alert('Please insert Number Only');
			obj.focus();
			return false;
	
		} else if(Number(num) < 0) {
			obj.value = '';//Math.abs(obj.value);
			alert('Please insert Positive Number Only');			
			obj.focus();
			return false;
			
		} else {
			return true;
		}
	}
//---------------------------------------------------------------------------------------------------------------------------------------------
	function isNumber(obj, showmsg){
		//var num = obj.value.replace(',','');
		var num = placeNum(obj.value);

		if(num == ''){
			return false;			
		
		}else if(isNaN(Number(num))){
			obj.value = '';
			if(showmsg){
				alert('Please insert Number Only');
			}
			obj.focus();
			return false;
	
		} else if(Number(num) < 0) {
			obj.value = '';//Math.abs(obj.value);
			if(showmsg){
				alert('Please insert Positive Number Only');			
			}
			obj.focus();
			return false;
			
		} else {
			return true;
		}
	}

/*********************************************************************************************************************************
*  FUNCTION DO PROCESS
*********************************************************************************************************************************/
	function doProcess(formName, page, action, handleForm, order, validateForm, activity){
//		try{
			
			var obj = document.forms[formName];
			disableAllButton(obj);
			obj.page.value = page;
			obj.action.value = action;
			obj.handleForm.value = handleForm;
			obj.order.value = order;
			obj.validateForm.value = validateForm;
			obj.activity.value = activity;
			obj.method = 'post';
			obj.submit();
//		} catch(er){}
	}

/*********************************************************************************************************************************
*  FUNCTION SET FOCUS
*********************************************************************************************************************************/
	function setFocus(formName, id){
		var obj = document.forms[formName];
		obj.id.value = id;
	}

/*********************************************************************************************************************************
*  FUNCTION SET FOCUSINPUT
*********************************************************************************************************************************/
	function setFocusInput(id){
		if(event.keyCode == ENTER){
			var obj = document.getElementById(id);
			if(isObject(obj)){
				obj.focus();
			}
		}
	}

/*********************************************************************************************************************************
*  FUNCTION SET VALUE TO INPUT
*********************************************************************************************************************************/
	function setValuetoInput(formName, aryName, aryValue){
		var objName = aryName.split(',');
		var objValue = aryValue.split(',');

		if(objName.length != objValue.length)
			return 0;

		for(var i = 0; i < objName.length; i++){
			var obj = eval('document.forms['+formName+'].' + objName[i]);
			if(isObject(obj)){
				obj.value = objValue[i];
			}
		}	
	}

/*********************************************************************************************************************************
*  FUNCTION CHECK ALL
*********************************************************************************************************************************/
	function checkAll(formName, objChkAll, chkNameIndex){
		var objChk;
		if(chkNameIndex != ''){
			objChk = eval('document.forms['+formName+'].' + chkNameIndex);
		} 
		
		if(objChk){
			if(objChkAll.checked){
				if(objectSize(objChk) == 1){
					objChk.checked = true;

				} else {
					for(i = 0; i <objChk.length; i++){
						objChk[i].checked = true;
					}
				}
			} else {
				if(objectSize(objChk) == 1){
					objChk.checked = false;

				} else {
					for(i = 0; i <objChk.length; i++){
						objChk[i].checked = false;
					}
				}			
			}
		}
	}

/*********************************************************************************************************************************
*  FUNCTION CHECK LIST
*********************************************************************************************************************************/
	function checkList(formName, objChkAll, chkNameIndex){
		var objChk;
		if(chkNameIndex != ''){
			objChk = eval('document.forms['+formName+'].' + chkNameIndex);
		} 
		
		var chkAll = true;

		if(objChk){
			if(objectSize(objChk) == 1){
				if(!objChk.checked)chkAll = false;

			} else {
				for(i = 0; i <objChk.length; i++){
					if(!objChk[i].checked)chkAll = false;
				}					
			}
			
			objChkAll .checked = chkAll;
		}
	}
/*********************************************************************************************************************************
*  FUNCTION CONFIRM MESSAGES
*********************************************************************************************************************************/
	function confirmMessages(msgType, inputMsg){
		var message = '';
		if(inputMsg =='')message = msgType;
		else message = inputMsg;

		if(confirm(message)){
			return true;
		}
		return false;
	}

/*********************************************************************************************************************************
*  FUNCTION AUTO FORMAT DATE
*********************************************************************************************************************************/
var format1 = 'dd/mm/yyyy';

function autoFormatDate(obj, format){	
//---------------------- First Technic -------------------------------------//
/*	var strDate = obj.value;

	blockKeySize(strDate, 9);
	blockKeyPress(numberOnly);

	var dateformat = '';
	if((strDate.length == 2 || strDate.length == 5) && !isSpecialKey(event.keyCode)){
		dateformat = strDate + "/" ;
		obj.value = dateformat;	
		
	} else {
		dateformat = strDate;
		obj.value = dateformat;	
	}

	return dateformat;*/

//----------------------- Second Technic -----------------------------------//
/*	var LEFT_ARROW = 37;
	var RIGHT_ARROW = 39;
	var BACKSPACE = 8;
	var DELETE = 46;
	var NUMBER_0 = 96;
	var NUMBER_9 = 105;
	var CHAR_0 = 48;
	var CHAR_9 = 57;
	var CHAR_SLACH = 191;
	var NUMBER_SLACH = 111;
	var CTRL = 17;
	var CHAR_V = 86;
	var CHAR_C = 67;
	var CHAR_X = 88;

	var TAB = 9;
	var SHIFT = 16;
	var END = 35;
	var ENTER = 13;
	var HOME = 36
	var Num0 = 96;
	var Num9 = 105;
	var No0 = 48;
	var No9 = 57;
	var CHAR_A = 65;
	var CHAR_Z = 90;
	var CHAR_a = 97;
	var CHAR_z = 122;
	var Negative = 109;*/

	var strDate = obj.value;	
	var code = event.keyCode;

	if((code != CTRL) && (code != CHAR_V) && (code != CHAR_C) && (code != CHAR_X)
			&& (code != LEFT_ARROW) && (code != RIGHT_ARROW) && (code != BACKSPACE) && (code != DELETE)){

			blockKeySize(strDate, 9);
			blockKeyPress(numberOnly);

			var dateformat = '';
			if((strDate.length == 2 || strDate.length == 5) && !isSpecialKey(event.keyCode)){
				dateformat = strDate + "/" ;
				obj.value = dateformat;
				
			} else {
				//dateformat = strDate;
				//obj.value = dateformat;	
			}

			return dateformat;
	}
	

//---------------------------- Third Technic -------------------------------------------//
	//alert(event.keyCode);
	/*var LEFT_ARROW = 37;
	var RIGHT_ARROW = 39;
	var BACKSPACE = 8;
	var DELETE = 46;
	var NUMBER_0 = 96;
	var NUMBER_9 = 105;
	var CHAR_0 = 48;
	var CHAR_9 = 57;
	var CHAR_SLACH = 191;
	var NUMBER_SLACH = 111;

	var code = event.keyCode;
	
	if((code >= CHAR_0 && code <= CHAR_9) || (code >= NUMBER_0 && code <= NUMBER_9) 
			|| code == LEFT_ARROW || code == RIGHT_ARROW || code == BACKSPACE || code == DELETE){
		
			return code;	
	} else {
		event.returnValue = false;
	}*/
}

/*********************************************************************************************************************************
*  FUNCTION REMOVE VALUE IN LEFT SELECTION
*********************************************************************************************************************************/
function removeLeftSelected(objLeftSelect, objRightSelect){
	if(isObject(objLeftSelect) && isObject(objRightSelect)){
		for(var j = 0; j < objRightSelect.length; j++){
			for(var i = objLeftSelect.length - 1; i >= 0 ; i--){
				if(objLeftSelect.options[i].value == objRightSelect.options[j].value){
					objLeftSelect.options[i] = null;
				}
			}
		}
	}
}

/*********************************************************************************************************************************
*  FUNCTION NUMBER FORMAT
*********************************************************************************************************************************/
/* Example
		formatNumber(3, "$0.00")  => $3.00
		formatNumber(3.14159265, "##0.####") => 3.1416
		formatNumber(3.14, "0.0###%") => 314.0%
		formatNumber(314159, ",##0.####") => 314,159
		formatNumber(31415962, "$,##0.00") => $31,415,962.00
		formatNumber(cat43, "0.####%") => null
		formatNumber(0.5, "#.00##") => 0.50
		formatNumber(0.5, "0.00##") => 0.50
		formatNumber(0.5, "00.00##") => 00.50
		formatNumber(4.44444, "0.00") => 4.44
		formatNumber(5.55555, "0.00") => 5.56
		formatNumber(9.99999, "0.00") => 10.00		
*/
   // CONSTANTS
  var separator = ",";  // use comma as 000's separator
  var decpoint = ".";  // use period as decimal point
  var percent = "%";
  var currency = "$";  // use dollar sign for currency

  function formatNumber(number, format, print) {  // use: formatNumber(number, "format")
	if(objectType(number) == undefineObject)return;
	
	number = number.toString();
	
	if(number.indexOf(',') >= 0){
		number = placeNum(number);
	}

    if (print) document.write("formatNumber(" + number + ", \"" + format + "\")<br>");

    if (number - 0 != number) return null;  // if number is NaN return null
    var useSeparator = format.indexOf(separator) != -1;  // use separators in number
    var usePercent = format.indexOf(percent) != -1;  // convert output to percentage
    var useCurrency = format.indexOf(currency) != -1;  // use currency format
    var isNegative = (number < 0);
    number = Math.abs (number);
    if (usePercent) number *= 100;
    format = strip(format, separator + percent + currency);  // remove key characters
    number = "" + number;  // convert number input to string

     // split input value into LHS and RHS using decpoint as divider
    var dec = number.indexOf(decpoint) != -1;
    var nleftEnd = (dec) ? number.substring(0, number.indexOf(".")) : number;
    var nrightEnd = (dec) ? number.substring(number.indexOf(".") + 1) : "";

     // split format string into LHS and RHS using decpoint as divider
    dec = format.indexOf(decpoint) != -1;
    var sleftEnd = (dec) ? format.substring(0, format.indexOf(".")) : format;
    var srightEnd = (dec) ? format.substring(format.indexOf(".") + 1) : "";

     // adjust decimal places by cropping or adding zeros to LHS of number
    if (srightEnd.length < nrightEnd.length) {
      var nextChar = nrightEnd.charAt(srightEnd.length) - 0;
      nrightEnd = nrightEnd.substring(0, srightEnd.length);
      if (nextChar >= 5) nrightEnd = "" + ((nrightEnd - 0) + 1);  // round up

 // patch provided by Patti Marcoux 1999/08/06
      while (srightEnd.length > nrightEnd.length) {
        nrightEnd = "0" + nrightEnd;
      }

      if (srightEnd.length < nrightEnd.length) {
        nrightEnd = nrightEnd.substring(1);
        nleftEnd = (nleftEnd - 0) + 1;
      }
    } else {
      for (var i=nrightEnd.length; srightEnd.length > nrightEnd.length; i++) {
        if (srightEnd.charAt(i) == "0") nrightEnd += "0";  // append zero to RHS of number
        else break;
      }
    }

     // adjust leading zeros
    sleftEnd = strip(sleftEnd, "#");  // remove hashes from LHS of format
    while (sleftEnd.length > nleftEnd.length) {
      nleftEnd = "0" + nleftEnd;  // prepend zero to LHS of number
    }

    if (useSeparator) nleftEnd = separate(nleftEnd, separator);  // add separator
    var output = nleftEnd + ((nrightEnd != "") ? "." + nrightEnd : "");  // combine parts
    output = ((useCurrency) ? currency : "") + output + ((usePercent) ? percent : "");
    if (isNegative) {
      // patch suggested by Tom Denn 25/4/2001
      output = (useCurrency) ? "(" + output + ")" : "-" + output;
    }
    return output;
  }

  function strip(input, chars) {  // strip all characters in 'chars' from input
    var output = "";  // initialise output string
    for (var i=0; i < input.length; i++)
      if (chars.indexOf(input.charAt(i)) == -1)
        output += input.charAt(i);
    return output;
  }

  function separate(input, separator) {  // format input using 'separator' to mark 000's
    input = "" + input;
    var output = "";  // initialise output string
    for (var i=0; i < input.length; i++) {
      if (i != 0 && (input.length - i) % 3 == 0) output += separator;
      output += input.charAt(i);
    }
    return output;
  }

/*********************************************************************************************************************************
*  FUNCTION TIME FORMAT
*********************************************************************************************************************************/
function timeFormat(objTime){
	var time = objTime.value;
	var code = event.keyCode;

	if((code != CTRL) && (code != CHAR_V) && (code != CHAR_C) && (code != CHAR_X)
			&& (code != LEFT_ARROW) && (code != RIGHT_ARROW) && (code != BACKSPACE) && (code != DELETE)){
	
			blockKeySize(time, 4);
			blockKeyPress(numberOnly);

			if(time.length == 0) {
				return true;
			}

			if((time.length == 2) && !(isSpecialKey(event.keyCode))){
				objTime.value = time + ":";								
				return true;

			}else {
				//objTime.value = time;
				return time;
			}

			
	}
}	

/*********************************************************************************************************************************
*  FUNCTION IS TIME
*********************************************************************************************************************************/
function isTime(objTime){
	var time = objTime.value;
	var timePatern = /^(([0,1][0-9])|(2[0-3]))(:|\.)(([0-5][0-9]))$/;
	var matchArray = time.match(timePatern); // is the format ok?

	if(time.length == 0) return true;

	time = time.replace('.', ':');
	 
	if(matchArray == null){
		alert("Invalid time?");
		objTime.value ='';
		objTime.focus();
		return false;

	} else {
		objTime.value = time;
		return true;
	}
}

/*********************************************************************************************************************************
*  FUNCTION SELECT ALL
*********************************************************************************************************************************/
function selectAll(formName, selectedName){
	objSelected = eval('document.forms['+formName+'].' + selectedName);
	
	if(isObject(objSelected)){
		for(var i = 0; i < objSelected.length; i++){
			objSelected.options[i].selected = true;
		}
	}
}

/*********************************************************************************************************************************
*  FUNCTION DELAY TIME
*********************************************************************************************************************************/
var AlertedTime = 0;
function delayFinished(delaytime){
		var time = new Date().getTime();
		if((time - AlertedTime) > delaytime){
			AlertedTime = time;
			return true;
		}

		return false;
}

/*********************************************************************************************************************************
*  STATIC KEY VALIABLE
*********************************************************************************************************************************/
/*var TAB = 9;
var DELETE = 46;
var BACKSPACE = 8
var CTRL = 17;
var SHIFT = 16;
var END = 35;
var ENTER = 13;
var HOME = 36
var Num0 = 96;
var Num9 = 105;
var No0 = 48;
var No9 = 57;
var CHAR_A = 65;
var CHAR_Z = 90;
var CHAR_a = 97;
var CHAR_z = 122;
var Negative = 109;*/
/*********************************************************************************************************************************
*  FUNCTION IS SPECIAL KEY
*********************************************************************************************************************************/
function	isSpecialKey(key){
	if(!(key >= CHAR_A && key <= CHAR_Z) && !(key >= No0 && key <= No9) && !(key >= Num0 && key <= Num9)){
		return true;
	}

	return false;
}

/*********************************************************************************************************************************
*  FUNCTION BLOCK KEY PRESS
*********************************************************************************************************************************/
var numberOnly = 1;
var charOnly = 2;
var all = 3;
var numberPositiveOnly = 4;

function blockKeyPress(type){
	if(type == numberOnly){
		if(event.keyCode >= CHAR_A && event.keyCode <= CHAR_Z){
			event.returnValue = false;
		}

	}else if(type == numberPositiveOnly){
		if((event.keyCode >= CHAR_A && event.keyCode <= CHAR_Z) || (event.keyCode == Negative)){
			event.returnValue = false;
		}
	} else if(type == charOnly){
		if(event.keyCode >= 48 && event.keyCode <= 57){
			event.returnValue = false;
		}
	}
}

/*********************************************************************************************************************************
*  FUNCTION BLOCK KEY SIZE
*********************************************************************************************************************************/
function blockKeySize(data, size){
	if(data.length <=  size 
		|| (!(event.keyCode >= CHAR_A && event.keyCode <= CHAR_Z) 
		&& !(event.keyCode >= No0 && event.keyCode <= No9)
		&& !(event.keyCode >= Num0 && event.keyCode <= Num9))){

		event.returnValue = true;

	} else event.returnValue = false;
}

/*********************************************************************************************************************************
*  FUNCTION BACK GROUND PROCESS
*********************************************************************************************************************************/
var processID = 0;
function startProcess(callFunction, delayTime){
	processID = setTimeout("callProcess('"+callFunction+"', "+delayTime+")", delayTime);
}

function callProcess(callFunction, delayTime){
	processID = setTimeout(callFunction, delayTime);
	processID = setTimeout("callProcess('"+callFunction+"', "+delayTime+")", delayTime);
}

function endProcess(){
   if(processID) {
      clearTimeout(processID);
      processID  = 0;
   }
}

/*********************************************************************************************************************************
*  FUNCTION SET PROPERTY BOJECT
*********************************************************************************************************************************/
function setPropertiesObject(obj, className, readOnly){
	obj.className = className;
	obj.readOnly = readOnly;
}

/*********************************************************************************************************************************
*  FUNCTION SET PROPERTY ID
*********************************************************************************************************************************/
function setProtertiesID(objIDName, parameter){
	if(isObject(objIDName)){
		objIDName.href = parameter;
	}
}

/*********************************************************************************************************************************
*  FUNCTION RESET SCREEN
*********************************************************************************************************************************/
function resetScreen(formName, aryName){
		var objName = aryName.split(',');

		for(var i = 0; i < objName.length; i++){
			var obj = eval('document.forms['+formName+'].' + objName[i]);
				if(isObject(obj)){
					obj.value = '';
				}
		}
}

/*********************************************************************************************************************************
*  FUNCTION AUTO TEXT SPEC FOR CLAIM ONLY
*********************************************************************************************************************************/
function claimSetTextAuto(text, objTextBox){
	var temp = objTextBox.value;
	if(event.keyCode == BACKSPACE || event.keyCode == DELETE)return 0;

	var textPat = /Ç./;
	var matchArray = temp.match(textPat); // is the format ok?

	if(matchArray == null){
		objTextBox.value = text + temp;
	}
}

/*********************************************************************************************************************************
*  FUNCTION IS KEY CODE
*********************************************************************************************************************************/
function isKeyCode(key){
	if(event.keyCode == key)return true;
	else return false;
}

/*********************************************************************************************************************************
*  FUNCTION CAPTURE EVENT
*********************************************************************************************************************************/
function captureEvent(){
	return window.event.type;
}

/*********************************************************************************************************************************
*  FUNCTION GET CHAR CODE
*********************************************************************************************************************************/
function getCharCode(code){
	return String.fromCharCode(code);
}

/*********************************************************************************************************************************
*  FUNCTION DISABLE BUTTON
*********************************************************************************************************************************/
function disableButton(formName, aryButton, disable){
	var objButton = aryButton.split(',');

	for(var i = 0; i < objButton.length; i++){
		var obj = eval('document.forms['+formName+'].' + objButton[i]);
			if(isObject(obj)){
				if(disable == true){
					obj.disabled = true;
				} else{
					obj.disabled = false
				}
			}
	}	
}

function disableAllButton(e) {
	for (i=0;i<e.elements.length;i++){
		elementTyle = e.elements[i];
		if(elementTyle.type == "button"){
			elementTyle.disabled = true;		
		}
	}
}

/*********************************************************************************************************************************
*  FUNCTION SUBMIT FORM
*********************************************************************************************************************************/
function submitForm(formName){
	document.forms[formName].method = 'post';
	document.forms[formName].submit();
}

/*********************************************************************************************************************************
*  FUNCTION SORT SELECT BOX
*********************************************************************************************************************************/
	function sortSelectBox(objMain){		
		if(!isObject(objMain))return false;

		var obj = objMain.options;
		
		if(obj.options.length > 0){
			var newOption = new Option();
			for(var i = 0; i < obj.options.length; i++){
				for(var j = i; j< obj.options.length; j++){
					if(obj.options[i].text > obj.options[j].text){
						var Text, Value;
						Text = obj.options[i].text;
						Value = obj.options[i].value;
						obj.options[i] = new Option(obj.options[j].text, obj.options[j].value);
						obj.options[j] = new Option(Text, Value);
					}
				}

				objMain[i] = new Option(obj.options[i].text, obj.options[i].value);
			}
		}
	}

/*********************************************************************************************************************************
*  FUNCTION ADD ON CLICK
*********************************************************************************************************************************/
function add_onClick(select1,select2) {

	var size1 = select1.options.length;
	var sizeSelected = 0;
	var arrValueSelected = new Array();
	var arrTextSelected = new Array();

	//***************** Add to right panel ******************
	for(i=0;i<size1;i++){
		if(select1.options[i].selected){
			arrValueSelected[sizeSelected] = select1.options[i].value;
			arrTextSelected[sizeSelected] = select1.options[i].text;
			sizeSelected++;
		}
	}

	var size2 = select2.options.length;
	var count = 0;
	
	for(i=0;i<sizeSelected;i++){
		if(size2 == 0){
			select2.options[i] = new Option(arrTextSelected[i]);
			select2.options[i].value = arrValueSelected[i];
			
		}else{
			select2.options[size2+count] = new Option(arrTextSelected[i]);
			select2.options[size2+count].value = arrValueSelected[i];
			count++;
		}
	}

	//***************** remove from left panel ******************
	var arrValueNotSelected = new Array();
	var arrTextNotSelected = new Array();
	var sizeSelected = 0;
	var sizeNotSelected = 0;
	for(i=0;i<size1;i++){
			if(select1.options[i].selected){
				arrValueSelected[sizeSelected] = select1.options[i].value;
				arrTextSelected[sizeSelected] = select1.options[i].text;
				sizeSelected++;
			}else{
				arrValueNotSelected[sizeNotSelected] = select1.options[i].value;
				arrTextNotSelected[sizeNotSelected] = select1.options[i].text;
				sizeNotSelected++;
			}
	}

	select1.length=sizeNotSelected;

	for(i=0;i<sizeNotSelected;i++){
			select1.options[i].value=arrValueNotSelected[i];
			select1.options[i].text=arrTextNotSelected[i];
	}
	
	sortSelectBox(select1);
	sortSelectBox(select2);
}

/*********************************************************************************************************************************
*  FUNCTION REMOVE ON CLICK
*********************************************************************************************************************************/
function remove_onClick(select1,select2) {
	//***************** Add to left panel ******************
	var size1 = select1.options.length;
	var size2 = select2.options.length;
	var sizeSelected = 0;
	var arrValueSelected = new Array();
	var arrTextSelected = new Array();

	for(i=0;i<size2;i++){
		if(select2.options[i].selected){
			arrValueSelected[sizeSelected] = select2.options[i].value;
			arrTextSelected[sizeSelected] = select2.options[i].text;
			sizeSelected++;
		}
	}

	var count = 0;
	for(i=0;i<sizeSelected;i++){
		if(size1 == 0){
			select1.options[i] = new Option(arrTextSelected[i]);
			select1.options[i].value = arrValueSelected[i];
		}else{
			select1.options[size1+i] = new Option(arrTextSelected[i]);
			select1.options[size1+i].value = arrValueSelected[i];
			count++;
		}
	}


	//***************** remove from right panel ******************

	var arrValueNotSelected = new Array();
	var arrTextNotSelected = new Array();
	var sizeNotSelected = 0;

	for(i=0;i<size2;i++){
			if(select2.options[i].selected){
				arrValueSelected[sizeSelected] = select2.options[i].value;
				arrTextSelected[sizeSelected] = select2.options[i].text;
				sizeSelected++;
			}else{
				arrValueNotSelected[sizeNotSelected] = select2.options[i].value;
				arrTextNotSelected[sizeNotSelected] = select2.options[i].text;
				sizeNotSelected++;
			}
	}

	select2.length=sizeNotSelected;

	for(i=0;i<sizeNotSelected;i++){

			select2.options[i].value=arrValueNotSelected[i];
			select2.options[i].text=arrTextNotSelected[i];
	}
	
	sortSelectBox(select1);
	sortSelectBox(select2);	
}

/*********************************************************************************************************************************
*  FUNCTION TEXT UPPER CASE 
*********************************************************************************************************************************/
function upper(obj){
	obj.value = obj.value.toUpperCase();
}

/*********************************************************************************************************************************
*  FUNCTION PLACE NUM
*********************************************************************************************************************************/
function placeNum(str){
	return replaceAll(str, ',', '');
}

/*********************************************************************************************************************************
*  FUNCTION REPLACE ALL
*********************************************************************************************************************************/
function replaceAll(str, oldChr, replaceChr){
	var isComma = true;
	while(isComma){
		str = str.replace(oldChr, replaceChr);
		isComma = str.indexOf(oldChr);
		if(isComma <= 0){
			isComma = false;
		}
	}
	return str;
}

/*********************************************************************************************************************************
*  FUNCTION IS ARRAY
*********************************************************************************************************************************/
function isArray(obj){
	try{
		return(typeof(obj.length) == undefineObject)?false:true;
	}catch(e){
		return false;
	}	
}

/*********************************************************************************************************************************
*  FUNCTION CALCULATE
*********************************************************************************************************************************/
function calculate(formName, tmpCalculate, parameter){
	parameter = placeNum(parameter);

	var objTmp = eval('document.' +  formName +'.' + tmpCalculate);
	objTmp.value = parameter;
//	alert(parameter);
//	changeStringToRealValue(objTmp.value);
	var result = eval(objTmp.value);
	return result
}

/*********************************************************************************************************************************
*  FUNCTION REAL NUM
*********************************************************************************************************************************/
function realNum(objValue){
	if(objValue.length > 0){
		objValue = placeNum(objValue);
		objValue = formatNumber(objValue, "##0.00");		
	}

	return objValue;
}

/*********************************************************************************************************************************
*  FUNCTION IS OBJECT SELECT
*********************************************************************************************************************************/
function isObjectSelect(formName, strName, messages){
	var obj = eval('document.'  +  formName +'.' + strName);
	if(!isObject(obj)){
		alert(	messages);
		return false;

	}else if(true){
		var objSize = objectSize(obj);
		if(objSize == 1 && !obj.checked){
			alert(messages);					
			return false;

		} else if(objSize > 1){
			var hasChecked = false;	
			for(var i = 0; i < objSize; i++){
				if(obj[i].checked){
					hasChecked = true;								
				}
			}
			
			if(!hasChecked){
				alert(messages);
				return false;
			}
		}
	}

	return true;
}

/*********************************************************************************************************************************
*  FUNCTION LAYER
*********************************************************************************************************************************/
function layer(id, data, show){
	//<span id = 'layer1' style='position:absolute;'></span>
	var desc = "<table bgcolor=#dddddd><tr><td class=bu2 valign=middle nowrap onclick=layer('" + id + "','',false) style='cursor:hand'>&nbsp:&nbsp;" + data + "&nbsp;</td></tr></table>"
	var objId = document.getElementById(id);

	if(show){
		objId.innerHTML = desc;

	} else {
		objId.innerHTML = '';
	}

	objId.style.pixelTop = objId.offsetTop;
	objId.style.pixelLeft = objId.offsetLeft;
}

/*********************************************************************************************************************************
*  FUNCTION LIST YEAR
*********************************************************************************************************************************/
function listYear(objSelectBox){
	var index = objSelectBox.selectedIndex;
	var selectYear = '';
	if(index >= 0){
		selectYear = objSelectBox.options[index].value;
	}

	var dDate = '';
	if(index < 0){
		dDate = '';

	}else {
		dDate = objSelectBox.options[index].value;
	}

	if(dDate == ''){
		dDate = new Date();	
		var year = dDate.getFullYear();

	} else {
		year = dDate;
	}

	if(year < 2500){
		year = parseInt(year) + parseInt(543);
	}
	
	var current = year;
	year = year - 5;
	if(year < 2500){
		year = 2500;
	}

	for(var i = 0; i < 11; i++){ 
		objSelectBox.options[i]  = new Option(parseInt(year)+i, parseInt(year)+i);
		if(index < 0){
			index = 0;
		}
		if(selectYear != null && (selectYear == parseInt(year)+i || parseInt(year)+i == current)){
			objSelectBox.options[i].selected = true; 
		}
	}
}

/*********************************************************************************************************************************
*  FUNCTION UPPER CASE 
*********************************************************************************************************************************/
function upperCase(obj){
		var aToA = 32;
		if(event.keyCode >= CHAR_a && event.keyCode <= CHAR_z){
			event.keyCode-=aToA;
		}

		if(event.type == 'blur'){
			upper(obj);
		}
}
function TimeFormat(textObj, theTextValue){
	var textVal=textObj.value;
	if(textVal!=""){
			var count=0;
			var textVal=textObj.value;
			for(var i=0;i<textVal.length;i++){
				if(textVal.substr(i,1)==":") count++;
			}
			var strHour="",strMinute=""
			if(count==0){
				if(textVal.length <4) {
					goErrorTime(textObj);
					return;
				}
				strHour = textVal.substr(0,2);
				strMinute = textVal.substr(2,2);
			} else if(count==1){
				timeArray = textVal.split(":");
				strHour = timeArray[0];
				strMinute = timeArray[1];
			}
			else {
				// in case "/"
			}
			if(strHour.length<2) strHour = "0"+strHour;
			if(strMinute.length<2) strMinute = "0"+strMinute;
			// Reformat the time for validation
			if(strHour == 24) strHour = "00"
			var strSeperator = ":"
			var vTimeValueCheck = strHour + strSeperator + strMinute;
			if (!timeValid(vTimeValueCheck)) {
				goErrorTime(textObj);
				return;
			}

		textObj.value = strHour + ":" + strMinute;
		return true;
	}
}
function timeValid(objName){
	var strHour;
	var strMinute;
	var datefield = objName;
	var strSeperator = ":"
	if (datefield.indexOf(strSeperator) != -1) {
		strTimeArray = datefield.split(strSeperator);
		if (strTimeArray.length != 2) {
			err = 1;
			return false;
		}
		else {
			strHour = strTimeArray[0];
			strMinute = strTimeArray[1];
		}
		if (isNaN(strHour)) return false;
		if (isNaN(strMinute)) return false;
		//alert(isNaN(strHour) + "..." + isNaN(strMinute))
		intHour = parseInt(strHour);
		intMinute = parseInt(strMinute);
		//alert(intHour + "..." + intMinute)
		//alert(isNaN(intHour) + "..." + isNaN(intMinute))
		if (isNaN(intHour)) {
			err = 2;
			return false;
		}
		if (isNaN(intMinute)) {
			err = 3;
			return false;
		}
		if(intHour > 24) return false;
		if(intMinute >= 60) return false;
		
		return true;
	}

}
function DateFormat(textObj, theTextValue, e, dateCheck, dateType){
	var textVal=textObj.value;
	if(textVal!=""){
		if((dateCheck)){
			var count=0;
			var textVal=textObj.value;
			for(var i=0;i<textVal.length;i++){
				if(textVal.substr(i,1)=="/") count++;
			}
			var strDay="",strMonth="",strYear="";
			if(count==0){
				strDay = textVal.substr(0,2);
				strMonth = textVal.substr(2,2);
				strYear = textVal.substr(4,4);
			} else if(count==2){
				dateArray = textVal.split("/");
				strDay = dateArray[0];
				strMonth = dateArray[1];
				strYear = dateArray[2];
			}
			else {
				// in case "/"
			}

			if(strDay.length<2) strDay = "0"+strDay;
			if(strMonth.length<2) strMonth = "0"+strMonth;
			if((strYear.length<4) || (strYear.length>4)){
				goError(textObj);
				return;
			}
			// Reformat the date for validation
			var strSeperator = "/"
			var vDateValueCheck = strMonth+strSeperator+strDay+strSeperator+strYear;
			if (!dateValid(vDateValueCheck)) {
				goError(textObj);
				return;
			}
		//alert("Date OK : " + strDay + "/" + strMonth + "/" + strYear);
		textObj.value = strDay + "/" + strMonth + "/" + strYear;
		return true;
		}
	}
}
function goErrorTime(textObj){
	if(confirm("Invalid Time!\n[HH:MM] is required\nDo your want to edit now?")){
		textObj.focus();
		textObj.select();
	}else{
		textObj.value="";
	}
}
function goError(textObj){
	if(confirm("Invalid Date!\n[dd/mm/yyyy(A.D.)] is required\nDo your want to edit now?")){
		textObj.focus();
		textObj.select();
	}else{
		textObj.value="";
	}
}


//check dateValid
function dateValid(objName) {
var strDate;
var strDateArray;
var strDay;
var strMonth;
var strYear;
var intday;
var intMonth;
var intYear;
var booFound = false;
var datefield = objName;
var strSeparatorArray = new Array("-"," ","/",".");
var intElementNr;
// var err = 0;
var strMonthArray = new Array(12);
strMonthArray[0] = "Jan";
strMonthArray[1] = "Feb";
strMonthArray[2] = "Mar";
strMonthArray[3] = "Apr";
strMonthArray[4] = "May";
strMonthArray[5] = "Jun";
strMonthArray[6] = "Jul";
strMonthArray[7] = "Aug";
strMonthArray[8] = "Sep";
strMonthArray[9] = "Oct";
strMonthArray[10] = "Nov";
strMonthArray[11] = "Dec";
//strDate = datefield.value;
strDate = objName;
if (strDate.length < 1) {
return true;
}
for (intElementNr = 0; intElementNr < strSeparatorArray.length; intElementNr++) {
if (strDate.indexOf(strSeparatorArray[intElementNr]) != -1) {
strDateArray = strDate.split(strSeparatorArray[intElementNr]);
if (strDateArray.length != 3) {
err = 1;
return false;
}
else {
strDay = strDateArray[0];
strMonth = strDateArray[1];
strYear = strDateArray[2];
}
booFound = true;
   }
}
if (booFound == false) {
if (strDate.length>5) {
strDay = strDate.substr(0, 2);
strMonth = strDate.substr(2, 2);
strYear = strDate.substr(4);
   }
}
//Adjustment for short years entered
if (strYear.length == 2) {
strYear = '20' + strYear;
}
strTemp = strDay;
strDay = strMonth;
strMonth = strTemp;
intday = parseInt(strDay, 10);
if (isNaN(intday)) {
err = 2;
return false;
}
intMonth = parseInt(strMonth, 10);
if (isNaN(intMonth)) {


for (i = 0;i<12;i++) {
if (strMonth.toUpperCase() == strMonthArray[i].toUpperCase()) {
intMonth = i+1;
strMonth = strMonthArray[i];
i = 12;
   }
}
if (isNaN(intMonth)) {
err = 3;
return false;
   }


}
intYear = parseInt(strYear, 10);
if (isNaN(intYear)) {
err = 4;
return false;
}
if (intMonth>12 || intMonth<1) {
err = 5;
return false;
}
if ((intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12) && (intday > 31 || intday < 1)) {
err = 6;
return false;
}
if ((intMonth == 4 || intMonth == 6 || intMonth == 9 || intMonth == 11) && (intday > 30 || intday < 1)) {
err = 7;
return false;
}
if (intMonth == 2) {
if (intday < 1) {
err = 8;
return false;
}
if (LeapYear(intYear) == true) {
if (intday > 29) {
err = 9;
return false;
   }
}
else {
if (intday > 28) {
err = 10;
return false;
      }
   }
}
return true;
}
function LeapYear(intYear) {
if (intYear % 100 == 0) {
if (intYear % 400 == 0) {
return true;
   }
}
else {
if ((intYear % 4) == 0) {
return true;
   }
}
return false;
}
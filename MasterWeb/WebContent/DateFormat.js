
var isNav4 = false;
var isNav5 = false; 
var isIE4 = false; 
var strSeperatorDate = "/"; 
var vDateType = 3;
var vYearType = 4;
var vYearLength = 2;
var err = 0;
if(navigator.appName == "Netscape") {
if (navigator.appVersion < "5") {
isNav4 = true;
isNav5 = false;
}
else
if (navigator.appVersion > "4") {
isNav4 = false;
isNav5 = true;
   }
}
else {
isIE4 = true;
}
function DateFormat(vDateName, vDateValue, e, dateCheck, dateType) {
vDateType = dateType;
if (vDateValue == "~") {
alert("AppVersion = "+navigator.appVersion+" \nNav. 4 Version = "+isNav4+" \nNav. 5 Version = "+isNav5+" \nIE Version = "+isIE4+" \nYear Type = "+vYearType+" \nDate Type = "+vDateType+" \nSeparator = "+strSeperatorDate);
vDateName.value = "";
vDateName.focus();
return true;
}
var whichCode = (window.Event) ? e.which : e.keyCode;
if (vDateValue.length > 8 && isNav4) {
if ((vDateValue.indexOf("-") >= 1) || (vDateValue.indexOf("/") >= 1))
return true;
}
var alphaCheck = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/-";
if (alphaCheck.indexOf(vDateValue) >= 1) {
if (isNav4) {
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
}
else {
vDateName.value = vDateName.value.substr(0, (vDateValue.length-1));
return false;
   }
}
if (whichCode == 8 || whichCode == 13)
return false;
else {
var strCheck = '47,48,49,50,51,52,53,54,55,56,57,58,59,95,96,97,98,99,100,101,102,103,104,105';
if (strCheck.indexOf(whichCode) != -1) {
if (isNav4) {
if (((vDateValue.length < 6 && dateCheck) || (vDateValue.length == 7 && dateCheck)) && (vDateValue.length >=1)) {
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
}
if (vDateValue.length == 6 && dateCheck) {
var mDay = vDateName.value.substr(2,2);
var mMonth = vDateName.value.substr(0,2);
var mYear = vDateName.value.substr(4,4)
if (mYear.length == 2 && vYearType == 4) {
var mToday = new Date();
var checkYear = mToday.getFullYear() + 30; 
var mCheckYear = '20' + mYear;
if (mCheckYear >= checkYear)
mYear = '19' + mYear;
else
mYear = '20' + mYear;
}
var vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
if (!dateValid(vDateValueCheck)) {
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
}
return true;
}
else {
if (vDateValue.length >= 8  && dateCheck) {
if (vDateType == 1) // mmddyyyy
{
var mDay = vDateName.value.substr(2,2);
var mMonth = vDateName.value.substr(0,2);
var mYear = vDateName.value.substr(4,4)
vDateName.value = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
}
if (vDateType == 2) // yyyymmdd
{
var mYear = vDateName.value.substr(0,4)
var mMonth = vDateName.value.substr(4,2);
var mDay = vDateName.value.substr(6,2);
vDateName.value = mYear+strSeperatorDate+mMonth+strSeperatorDate+mDay;
}
if (vDateType == 3) // ddmmyyyy
{
var mMonth = vDateName.value.substr(2,2);
var mDay = vDateName.value.substr(0,2);
var mYear = vDateName.value.substr(4,4)
vDateName.value = mDay+strSeperatorDate+mMonth+strSeperatorDate+mYear;
}
var vDateTypeTemp = vDateType;
vDateType = 1;
var vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
if (!dateValid(vDateValueCheck)) {
alert("Invalid Date\nPlease Re-Enter");
vDateType = vDateTypeTemp;
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
}
vDateType = vDateTypeTemp;
return true;
}
else {
if (((vDateValue.length < 8 && dateCheck) || (vDateValue.length == 9 && dateCheck)) && (vDateValue.length >=1)) {
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
         }
      }
   }
}
else {
if (((vDateValue.length < 8 && dateCheck) || (vDateValue.length == 9 && dateCheck)) && (vDateValue.length >=1)) {
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
return true;
}
if (vDateValue.length >= 8 && dateCheck) {
if (vDateType == 1){
var mMonth = vDateName.value.substr(0,2);
var mDay = vDateName.value.substr(3,2);
var mYear = vDateName.value.substr(6,4)
}
if (vDateType == 2)
{
var mYear = vDateName.value.substr(0,4)
var mMonth = vDateName.value.substr(5,2);
var mDay = vDateName.value.substr(8,2);
}
if (vDateType == 3){
var mDay = vDateName.value.substr(0,2);
var mMonth = vDateName.value.substr(3,2);
var mYear = vDateName.value.substr(6,4)
}
if (vYearLength == 4){
if (mYear.length < 4){
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
return true;
   }
}
var vDateTypeTemp = vDateType;
vDateType = 1;
var vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
if (mYear.length == 2 && vYearType == 4 && dateCheck) {
var mToday = new Date();
var checkYear = mToday.getFullYear() + 30; 
var mCheckYear = '20' + mYear;
if (mCheckYear >= checkYear)
mYear = '19' + mYear;
else
mYear = '20' + mYear;
vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
if (vDateTypeTemp == 1)
vDateName.value = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
if (vDateTypeTemp == 3)
vDateName.value = mDay+strSeperatorDate+mMonth+strSeperatorDate+mYear;
} 
if (!dateValid(vDateValueCheck)){
alert("Invalid Date\nPlease Re-Enter");
vDateType = vDateTypeTemp;
vDateName.value = "";
vDateName.focus();
return true;
}
vDateType = vDateTypeTemp;
return true;
}
else {
if (vDateType == 1){
if (vDateValue.length == 2){
vDateName.value = vDateValue+strSeperatorDate;
}
if (vDateValue.length == 5){
vDateName.value = vDateValue+strSeperatorDate;
   }
}
if (vDateType == 2){
if (vDateValue.length == 4){
vDateName.value = vDateValue+strSeperatorDate;
}
if (vDateValue.length == 7){
vDateName.value = vDateValue+strSeperatorDate;
   }
} 
if (vDateType == 3){
if (vDateValue.length == 2){
vDateName.value = vDateValue+strSeperatorDate;
}
if (vDateValue.length == 5){
vDateName.value = vDateValue+strSeperatorDate;
   }
}
return true;
   }
}

if (vDateValue.length == 10&& dateCheck){
if (!dateValid(vDateName)){
alert("Invalid Date\nPlease Re-Enter");
vDateName.focus();
vDateName.select();
   }
}
return false;
}
else {

if (isNav4){
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
}
else
{
//vDateName.value = vDateName.value.substr(0, (vDateValue.length-1));
return false;
         }
      }
   }
}

function DateFormat2(vDateName,vDateValue,e,dateCheck,dateType){
 vDateType = dateType;
if (vDateValue == "~") {
    alert("AppVersion = "+navigator.appVersion+" \nNav. 4 Version = "+isNav4+" \nNav. 5 Version = "+isNav5+" \nIE Version = "+isIE4+" \nYear Type = "+vYearType+" \nDate Type = "+vDateType+" \nSeparator = "+strSeperatorDate);
    vDateName.value = "";
    vDateName.focus();
    return true;
  }
var whichCode = (window.Event) ? e.which : e.keyCode;
  if (vDateValue.length > 8 && isNav4) {
    if ((vDateValue.indexOf("-") >= 1) || (vDateValue.indexOf("/") >= 1)){
      return true;
    }
  }
  var alphaCheck = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/-";
  if (alphaCheck.indexOf(vDateValue) >= 1) {
    if (isNav4) {
      vDateName.value = "";
      vDateName.focus();
      vDateName.select();
      return false;
    } else {
       return false;
    }
  }
 if (whichCode == 8) 
	return false;
  else {
	var strCheck = '47,48,49,50,51,52,53,54,55,56,57,58,59,95,96,97,98,99,100,101,102,103,104,105';
	if (strCheck.indexOf(whichCode) != -1) {
	 if (isNav4) {
        if (((vDateValue.length < 6 && dateCheck) || (vDateValue.length == 7 && dateCheck)) && (vDateValue.length >=1)) {
		  alert("Invalid Date\nPlease Re-Enter");
		  vDateName.value = "";
		  vDateName.focus();
		  vDateName.select();
		  return false;
		}
		if (vDateValue.length == 6 && dateCheck){
		  var mDay = vDateName.value.substr(2,2);
		  var mMonth = vDateName.value.substr(0,2);
		  var mYear = vDateName.value.substr(4,4)
	    if (mYear.length == 2 && vYearType == 4){
			var mToday = new Date();
			var checkYear = mToday.getFullYear() + 30; 
			var mCheckYear = '20' + mYear;
			if (mCheckYear >= checkYear)
			  mYear = '19' + mYear;
			else
			  mYear = '20' + mYear;
		  }
		  var vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
		  if (!dateValid(vDateValueCheck)){
		    alert("Invalid Date\nPlease Re-Enter");
		    vDateName.value = "";
		    vDateName.focus();
		    vDateName.select();
		    return false;
		  }
		  return true;
	    }else{
		 if (vDateValue.length >= 8  && dateCheck) {
		   if (vDateType == 1){
			  var mDay = vDateName.value.substr(2,2);
			  var mMonth = vDateName.value.substr(0,2);
			  var mYear = vDateName.value.substr(4,4)
			  vDateName.value = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
			}
			if (vDateType == 2) {
			  var mYear = vDateName.value.substr(0,4)
			  var mMonth = vDateName.value.substr(4,2);
			  var mDay = vDateName.value.substr(6,2);
			  vDateName.value = mYear+strSeperatorDate+mMonth+strSeperatorDate+mDay;
			}
			if (vDateType == 3){
			  var mMonth = vDateName.value.substr(2,2);
			  var mDay = vDateName.value.substr(0,2);
			  var mYear = vDateName.value.substr(4,4)
			  vDateName.value = mDay+strSeperatorDate+mMonth+strSeperatorDate+mYear;
			}
			var vDateTypeTemp = vDateType;
			vDateType = 1;
			var vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
			if (!dateValid(vDateValueCheck)) {
			  alert("Invalid Date\nPlease Re-Enter");
			  vDateType = vDateTypeTemp;
			  vDateName.value = "";
			  vDateName.focus();
			  vDateName.select();
			  return false;
			}
			vDateType = vDateTypeTemp;
			return true;
		  } else {
			if (((vDateValue.length < 8 && dateCheck) || (vDateValue.length == 9 && dateCheck)) && (vDateValue.length >=1)) {
			  alert("Invalid Date\nPlease Re-Enter");
			  vDateName.value = "";
			  vDateName.focus();
			  vDateName.select();
			  return false;
			}
		  }
		  
   		}
	  } else {
	  	if (((vDateValue.length < 8 && dateCheck) || (vDateValue.length == 9 && dateCheck)) && (vDateValue.length >=1)) {
		  alert("Invalid Date\nPlease Re-Enter");
		  vDateName.value = "";
		  vDateName.focus();
		  return true;
	    }
	    if(vDateValue.length >= 8 && dateCheck){
		if (vDateType == 1){
		    var mMonth = vDateName.value.substr(0,2);
		    var mDay = vDateName.value.substr(3,2);
		    var mYear = vDateName.value.substr(6,4)
		  }
		if(vDateType == 2){
		    var mYear = vDateName.value.substr(0,4)
		    var mMonth = vDateName.value.substr(5,2);
		    var mDay = vDateName.value.substr(8,2);
		  }
		 if (vDateType == 3){
		    var mDay = vDateName.value.substr(0,2);
		    var mMonth = vDateName.value.substr(3,2);
		    var mYear = vDateName.value.substr(6,4)
		  }
	      if (vYearLength == 4){
		    if (mYear.length < 4){
			  alert("Invalid Date\nPlease Re-Enter");
			  vDateName.value = "";
			  vDateName.focus();
			  return true;
   		    }
		  }
		 var vDateTypeTemp = vDateType;
		  vDateType = 1;
		  var vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
		  if (mYear.length == 2 && vYearType == 4 && dateCheck) {
		    var mToday = new Date();
		    var checkYear = mToday.getFullYear() + 30; 
		    var mCheckYear = '20' + mYear;
		    if (mCheckYear >= checkYear)
			  mYear = '19' + mYear;
		    else
			  mYear = '20' + mYear;
		     vDateValueCheck = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
		    if (vDateTypeTemp == 1)
		      vDateName.value = mMonth+strSeperatorDate+mDay+strSeperatorDate+mYear;
		    if (vDateTypeTemp == 3)
		      vDateName.value = mDay+strSeperatorDate+mMonth+strSeperatorDate+mYear;
	      }
	  if (!dateValid(vDateValueCheck)){
		    alert("Invalid Date\nPlease Re-Enter");
			vDateType = vDateTypeTemp;
			vDateName.value = "";
			vDateName.focus();
			return true;
	      }
	  	  vDateType = vDateTypeTemp;
	  	  return true;
		} else {
		 if (vDateType == 1){
			if (vDateValue.length == 2){
			  vDateName.value = vDateValue+strSeperatorDate;
			}		  			
		  }
		  if (vDateType == 2){
			if (vDateValue.length == 4){
			  vDateName.value = vDateValue+strSeperatorDate;
		    }
		  }
		  return true;
        }
      }
      if (vDateValue.length == 7 && dateCheck){
		if (!dateValid(vDateName)) {
			alert("Invalid Date\nPlease Re-Enter");
			vDateName.focus();
			vDateName.select();
   		}
	  }
	   return false;
	  }else{ 
 	if(isNav4){
	    vDateName.value = "";
	    vDateName.focus();
	    vDateName.select();
	    return false;
	  }else{
	    vDateName.value = vDateName.value.substr(0, (vDateValue.length-1));
	    return false;
      }
    }
  }
}

  



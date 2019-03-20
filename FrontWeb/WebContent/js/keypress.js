// JavaScript Document
function keyPressInteger(){
	var strChar=String.fromCharCode(event.keyCode);
	if(!validateInteger(strChar)){			
			window.event.returnValue = false;
	}	
}

function keyPressFloat(strValue,strDecimal){
	var strChar=String.fromCharCode(event.keyCode);
	if(validateInteger(strChar) || strChar=="."){
			//first charecter
			if(strValue==""){
				if(strChar=="."){
					window.event.returnValue = false;
				}
			}
			var newArray=strValue.split(".");
			if(newArray.length==2){
				 if(strChar=="."){
					window.event.returnValue = false;
				}else{
					if(strDecimal!=0){
						if(newArray[1].length==strDecimal){
							window.event.returnValue = false;
						}
					}
				}
			}
		}else{			
			window.event.returnValue = false;
	}
}


function  validateNumeric( strValue ) {
/******************************************************************************
DESCRIPTION: Validates that a string contains only valid numbers.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
******************************************************************************/
  var objRegExp  =  /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/;

  //check for numeric characters
  return objRegExp.test(strValue);
}

function validateInteger( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only
    valid integer number.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
******************************************************************************/
  var objRegExp  = /(^-?\d\d*$)/;

  //check for integer characters
  return objRegExp.test(strValue);
}

function keyPressDate(strValue){
	var strChar=String.fromCharCode(event.keyCode);
	var objRegExpFirstDigit  = /^\d{1}$/ ;
	var objRegExpSepDigit = /^\/$/;	
	if(strValue.length==0){
		if(!objRegExpFirstDigit.test(strChar) || strChar>3){			
			window.event.returnValue = false;
		}
	}else if(strValue.length==1){
		if(!objRegExpFirstDigit.test(strChar)){
			window.event.returnValue = false;
		}else{
			if(strValue==0){
				if(strChar==0){
					window.event.returnValue = false;
				}
			}else if(strValue==3){
				if(strChar>1){
					window.event.returnValue = false;
				}
			}
		//alert("false");
	  }
   }else if(strValue.length==2){
    	if(!objRegExpSepDigit.test(strChar)){
			window.event.returnValue = false;
		}
   }else if(strValue.length==3){
   		if(!objRegExpFirstDigit.test(strChar) || strChar>1){
			window.event.returnValue = false;
		}		
   }else if(strValue.length==4){
   		if(!objRegExpFirstDigit.test(strChar) || strChar>2){
			window.event.returnValue = false;
		}		
   }else if(strValue.length==5){
    	if(!objRegExpSepDigit.test(strChar)){
			window.event.returnValue = false;
		}
   }else if(strValue.length>5 && strValue.length<10){
   		if(!objRegExpFirstDigit.test(strChar)){
			window.event.returnValue = false;
		}	
   }else{
   		window.event.returnValue = false;
   }
}

function validateTHDate(strValue) {
/************************************************
DESCRIPTION: Validates that a string contains only
    valid dates with 2 digit month, 2 digit day,
    4 digit year. Date separator can be ., -, or /.
    Uses combination of regular expressions and
    string parsing to validate date.
    Ex. mm/dd/yyyy or mm-dd-yyyy or mm.dd.yyyy

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

REMARKS:
   Avoids some of the limitations of the Date.parse()
   method such as the date separator character.
*************************************************/
  var objRegExp = /^\d{2}(\-|\/|\.)\d{2}\1\d{4}$/

  //check to see if in correct format
  if(!objRegExp.test(strValue)){
    return false; //doesn't match pattern, bad date
  }else{
    var strSeparator = strValue.substring(2,3) //find date separator
    var arrayDate = strValue.split(strSeparator); //split date into month, day, year
    //create a lookup for months not equal to Feb.
    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
    var intDay = parseInt(arrayDate[0]);

    //check if month value and day value agree
    if(arrayLookup[arrayDate[1]] != null) {
      if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
        return true; //found in lookup table, good date
    }

    //check for February (bugfix 20050322)
    var intMonth = parseInt(arrayDate[1]);
    if (intMonth == 2) { 
       var intYear = parseInt(arrayDate[2]);
       if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
          return true; //Feb. had valid number of days
       }
  }
  return false; //any other values, bad date
}
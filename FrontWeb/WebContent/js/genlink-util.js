
var splitIndex = 0;
var splitArray = new Array();

function checkTextArea(szFieldName, nMaxRows, nMaxCols , szLabel) {
	var isValid = true;
	var errLine="";
	var messageErr="";
	if (szFieldName.value != "")
	{
		split(szFieldName.value,'\r\n');
		var errMaxCols = "Please do not enter more than " + nMaxCols + " characters per line. ";
		var errMaxRows = "Please do not enter more than " + nMaxRows + " lines.";
		var newrows = 0;
			for (i=0;i < splitIndex ;i++ )
			{
				if (splitArray[i].length > nMaxCols)
				{
					//alert("Please do not enter more than " + nMaxCols + " characters per line."+" :line"+(i+1));
					if (errLine =="")
					{
						errLine = errMaxCols+ (i+1);
					}else{
						errLine = errLine +", " + (i+1);
					}
					isValid= false;
				}else {
					newrows +=1;
				}
			}
			if (!isValid)
			{
				messageErr = errLine;
			}
			if (nMaxRows !=0 && newrows > nMaxRows)
			{
				//alert(errMaxRows);
				if (messageErr == "")
				{
					messageErr = errMaxRows;
				}else{
					messageErr = messageErr+"<br>"+errMaxRows;
				}
				isValid= false;
			}
			if (!isValid)
			{
				alert(messageErr);
			}
	}
	return isValid;
}

function split(string, text){
	splitIndex = 0;
	splits(string,text);
}

function splits (string, text){
	var strLength = string.length, txtLength = text.length;
	if ( (strLength == 0) || (txtLength == 0)) return;
	
	var i = string.indexOf(text);
	if ((!i) && (text != string.substring(0,txtLength))) return;
	if (i == -1)
	{
		splitArray[splitIndex++] = string;
		return;
	}
	splitArray[splitIndex++] = string.substring(0,i);
	if (i+txtLength < strLength)
		splits(string.substring(i+txtLength,strLength),text);
	return;
}

function  convertDate(strDate) {
	var em = strDate;
	var index
	var strReturn="";
		if (em.length > 0 ) {			
			index = em.indexOf("/");
			while (index > 0) {
				if (em.indexOf("/") != -1) {
					index = em.indexOf("/");
					strReturn =  strReturn + em.substring(0,index);
					em = em.substring(index+1);
				} else {
					strReturn = strReturn + em;
					break;
				}
			}
		}
		
		strDate = strReturn;
	return strDate;
}

function checkNumber(FormName,ElemName){
	var bolNumber  = false;
	var temp     = document.forms[FormName].elements[ElemName];
	var numLength   = temp.value.length - 1;
	var lastChar = temp.value.substr(numLength,1);
	for(i=0;i<=9;i++){
		if(lastChar == i.toString()){
			bolNumber  = true;
		}
	}
	if(lastChar == "."){
		bolNumber  = true;
	}
	if(!bolNumber){
		temp.value = temp.value.substring(0,numLength);
	}
}
function checkNumberAndDot(FormName,ElemName){
	var bolNumber  = false;
	var temp     = document.forms[FormName].elements[ElemName];
	var numLength   = temp.value.length - 1;
	var lastChar = temp.value.substr(numLength,1);
	for(i=0;i<=9;i++){
		if(lastChar == i.toString()){
			bolNumber  = true;
		}
	}
	if(!bolNumber){
		temp.value = temp.value.substring(0,numLength);
	}
}
function setValueNumber(value,places,comma){
	nf = new NumberFormat();
	nf.setNumber(value);
	nf.setPlaces(parseInt(places));
	nf.setCommas(comma);

	strValue = nf.toFormatted();
	return strValue;
}
function trim(inputString) {
   if (typeof inputString != "string") { return inputString; }
   var retValue = inputString;
   var ch = retValue.substring(0, 1);
   while (ch == " ") { // Check for spaces at the beginning of the string
      retValue = retValue.substring(1, retValue.length);
      ch = retValue.substring(0, 1);
   }
   ch = retValue.substring(retValue.length-1, retValue.length);
   while (ch == " ") { // Check for spaces at the end of the string
      retValue = retValue.substring(0, retValue.length-1);
      ch = retValue.substring(retValue.length-1, retValue.length);
   }
   while (retValue.indexOf("  ") != -1) { // Note that there are two spaces in the string - look for multiple spaces within the string
      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // Again, there are two spaces in each of the strings
   }
   return retValue; // Return the trimmed string back to the user
} // Ends the "trim" function
function checkAll(formName,fieldName) {
	if (document.forms[formName].elements[fieldName].length){
		var num = document.forms[formName].elements[fieldName].length;
		for (j = 0; j < num; j++) {
			if (document.forms[formName].elements[fieldName][j])    {
				document.forms[formName].elements[fieldName][j].checked =true;
			}
		}
	}else {
			document.forms[formName].elements[fieldName].checked =true;
	}
}

function uncheckAll(formName,fieldName) {
	if (document.forms[formName].elements[fieldName].length){
		var num = document.forms[formName].elements[fieldName].length;
		for (j = 0; j < num; j++) {
			if (document.forms[formName].elements[fieldName][j])    {
				document.forms[formName].elements[fieldName][j].checked =false;
			}
		}
	}else {
			document.forms[formName].elements[fieldName].checked =false;	
	}
}

browserName = navigator.appName;          
        browserVer = parseInt(navigator.appVersion); 
  if ((browserName == "Netscape" && browserVer >= 3) || (browserVer > 3)) version = "n3";
            else version = "n2";
function openwindow(url,windowname,w,h) {   
	x = (window.screen.width - w)/2;
	y = (window.screen.height - h)/2;
	p = 'scrollbars=yes,resizable=1,height='+h+',top=' + y + ',width='+ w +',left=' + x;
	if (version == "n3") {
			remote=window.open(url,windowname,p);
	}	
}
function openFullWindow(url,windowname){
	p = 'scrollbars=yes,resizable=1,toolbar=yes,menubar=yes,location=yes,location=yes,status=yes';
	if (version == "n3") {
			remote=window.open(url,windowname,p);
	}	
}
/*function openwindow(url,windowname,w,h) {   
	x = (window.screen.width - w)/2;
	y = (window.screen.height - h)/2;
	p = 'scrollbars=yes,resizable=1,height='+h+',top=' + y + ',width='+ w +',left=' + x;
window.showModalDialog(url,null,p);
}*/

function checkInteger(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName];
	var checkOK = "1234567890";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Numeric charecters only");
    			e.select();
    			//return (false);
				
				}
}

function checkDecimal(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName];
	var checkOK = "1234567890.,";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Currency Number only");
    			e.select();
    			//return (false);
				
				}
}

function checkSignedInteger(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName];
	var checkOK = "1234567890-";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Numeric charecters only");
    			e.select();
    			//return (false);
				
				}
}

function checkSignedDecimal(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName];
	var checkOK = "1234567890.,-";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Currency Number only");
    			e.select();
    			//return (false);
				
				}
}

function checkIntegerAndComma(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName];
	var checkOK = "1234567890,";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Numeric charecters only");
    			e.select();			
				return false;
				}
	return true;
}
function checkIntegerMulti(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName][0];
	var checkOK = "1234567890";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Numeric charecters only");
    			e.select();
    			//return (false);
				
				}
}

function checkDecimalMulti(FormName,ElemName){
	var bolNumber  = false;
	var e     = document.forms[FormName].elements[ElemName][0];
	var checkOK = "1234567890.,";
  	var checkStr = e.value;
  	var allValid = true;
  	
			for (i = 0;  i < checkStr.length;  i++)
  				{
    				ch = checkStr.charAt(i);
    				for (j = 0;  j < checkOK.length;  j++)
     					if (ch == checkOK.charAt(j))
        					break;
    					if (j == checkOK.length)
   					 	{
     			 			allValid = false;
     						 break;
   					 	}
 					 }

				if (!allValid){
    			alert("This field requires Currency Number only");
    			e.select();
    			//return (false);
				
				}
}


function disableAllButton(FormName){

	var e     = document.forms[FormName];
	
	for (i = 0; i<e.elements.length; i++){
			tmp = e.elements[i]
			if (tmp.type == "button"){
				tmp.disabled = "true";
			}
	}

}

function enableAllButton(FormName){

	var e     = document.forms[FormName];
	
	for (i = 0; i<e.elements.length; i++){
			tmp = e.elements[i]
			if (tmp.type == "button"){
				tmp.disabled = "false";
			}
	}

}

function enableAllButtonExcludeButton(FormName,excludeButton){

	var e     = document.forms[FormName];
	
	for (i = 0; i<e.elements.length; i++){
			tmp = e.elements[i]
			if (tmp.type == "button" && tmp.name != excludeButton){
				tmp.disabled = "false";
			}
	}

}


function checkAllExceptDisabled(formName,fieldName) {
	if (document.forms[formName].elements[fieldName].length){
		var num = document.forms[formName].elements[fieldName].length;
		for (j = 0; j < num; j++) {
			if (document.forms[formName].elements[fieldName][j])    {
				document.forms[formName].elements[fieldName][j].checked =true;
			}
		}
	}else {
		document.forms[formName].elements[fieldName].checked =true;
	}
} // end function checkAllExceptDisabled

function uncheckAllExceptDisabled(formName,fieldName) {
	if (document.forms[formName].elements[fieldName].length){
		var num = document.forms[formName].elements[fieldName].length;
		for (j = 0; j < num; j++) {
			if (document.forms[formName].elements[fieldName][j] && document.forms[formName].elements[fieldName][j].disabled == false)    {
				document.forms[formName].elements[fieldName][j].checked =false;
			}
		}
	}else {
		document.forms[formName].elements[fieldName].checked =false;
	}
} // end function uncheckAllExceptDisabled

// Check &
function checkAmpersand(FormName){

	var e     = document.forms[FormName];
	for (i = 0; i<e.elements.length; i++){
			tmp = e.elements[i];
			
			if(tmp.type !="button" && tmp.value.indexOf("&") != -1){
						return false;
				}
	}
	return true;

}
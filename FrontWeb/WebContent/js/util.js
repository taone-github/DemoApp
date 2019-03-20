function reformatClaimNo(o){
 // o.value=o.value.toUpperCase();
  if(o!=null && o.value.length!=0){  
    if(o.value.length == 5)
      o.value=o.value+"-";    
  }
  
}

function toupperCase(o){      
    o.value=o.value.toUpperCase();
//    o.value=o.value.toUpperCase().replace(/([^0-9A-Z^�-�_-])/g,""); 

}
function disableAllButton(e) {
	for (i=0;i<e.elements.length;i++){
		tmp = e.elements[i];
		if(tmp.type == "button"){
			tmp.disabled = true;		
		}
	}
}
function cancelLink () {
  return false;
}

function disableAllLink(){
	for(var i=0;i<document.links.length;++i){
		var link = document.links[i];
		
		if (link.onclick){
			link.oldOnClick = link.onclick;
		}
		link.onclick = cancelLink;
		if (link.style){
			link.style.cursor = 'default';
		}	
	}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloaden_images() { //v3.0
  var d=document; if(d.en_US/images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloaden_US/images.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
} 

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function textLimit(field, maxlimit) {
	if (field.value.length > maxlimit){
		field.value = field.value.substring(0, maxlimit);
	}
}

function checkTextLimit(field, maxlimit) {
  if(event.keyCode == 13){    
	if (field.value.length < 98) {
       for (i=field.value.length;i<98;i++) {
           field.value = field.value+' ';           
       }       
     
    } else if (field.value.length >98 && field.value.length < 198) {
       for (i=field.value.length;i<198;i++) {
           field.value = field.value+' ';
       } 
     
    } else if (field.value.length >198 && field.value.length < 298) {
       for (i=field.value.length;i<298;i++) {
           field.value = field.value+' ';
       } 
     
    }
  } else {
    if ( (field.value.length == 98) || (field.value.length == 198) || (field.value.length == 298)){
		field.value = field.value+'\n';
	}	
  }
}

function checkTextLimitNotAutoSpace(field, maxlimit) {
    if ( (field.value.length == 98) || (field.value.length == 198) || (field.value.length == 298)){
		field.value = field.value+'\n';
	}
}


/*change day of month*/
function update_day(date1){
	var date_arr = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	temp=date1[0].selectedIndex;
	for(x=date1[0].length;x>1;x--){
		date1[0].options[x-1]=null;
	}
	if(date1[1].options[date1[1].selectedIndex].value!=""){
	selection=date_arr[parseInt(date1[1].options[date1[1].selectedIndex].value,10)-1];
	}else{
	selection=31;
	}
	ret_val=0;
	if(selection == 28){
		year=parseInt(date1[2].options[date1[2].selectedIndex].value,10);
		if(year%4!=0||year%100==0)ret_val=0;
		else if(year%400==0)ret_val=1;
		else ret_val=1;
	}
	selection = selection + ret_val;
	for(x=1;x<selection+1;x++){
		if(x<10) date1[0].options[x]=new Option("0"+x,"0"+x);
		else date1[0].options[x]=new Option(""+x,""+x);
	}
	if(temp == -1)date1[0].options[0].selected=true;
	else date1[0].options[temp].selected=true;
}

function displayComma(textField,number) {
   var result;
   number = '' + number;
   var point = number.indexOf('.');
   var numAfterPoint ;

   if (point >= 0) {
      numAfterPoint = number.substring(point+1,number.length);
      number = number.substring(0,point);
   } else { 
	  numAfterPoint = '00' ;
   }
   if (number.length > 3) {   
	 	var mod = number.length % 3;
		var output = (mod > 0 ? (number.substring(0,mod)) : '');
		for (i=0 ; i < Math.floor(number.length / 3); i++) {
	      if ((mod == 0) && (i == 0))
	         output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
	      else
	         output+= ',' + number.substring(mod + 3 * i, mod + 3 * i + 3);
	    }
	    result = output+'.'+numAfterPoint;
   } else result = number+'.'+numAfterPoint;
   textField.value = result;
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
function move(fbox, tbox, flag) {

	var arrFbox = new Array();
	var arrTbox = new Array();
	var arrLookup = new Array();
	var i;
	
	for (i = 0; i < tbox.options.length; i++) {
		arrLookup[tbox.options[i].text] = tbox.options[i].value;
		arrTbox[i] = tbox.options[i].text;
	}
	var fLength = 0;
	var tLength = arrTbox.length;
	for(i = 0; i < fbox.options.length; i++) {
		arrLookup[fbox.options[i].text] = fbox.options[i].value;
		if (fbox.options[i].selected && fbox.options[i].value != "") {
		    
		    // old
		    // arrTbox[tLength] = fbox.options[i].text;
			// tLength++;
		    
		    
		    // new
		    if (flag) {
			    for (k = 0;tbox.options.length; k++) {			    
			       if (tbox.options[k] != null ) {
				       if (fbox.options[i].value == tbox.options[k].value)
				          return;			      
				   } else {
				       break;
				   }
				   					
			    } 
			    arrFbox[fLength] = fbox.options[i].text;
				fLength++;
		    }
		    arrTbox[tLength] = fbox.options[i].text;
			tLength++;	
		    //---------
		}
		else {
			arrFbox[fLength] = fbox.options[i].text;
			fLength++;
   		}
	}
	//arrFbox.sort();
	//arrTbox.sort();
	fbox.length = 0;
	tbox.length = 0;
	var c;
	for(c = 0; c < arrFbox.length; c++) {
		var no = new Option();
		no.value = arrLookup[arrFbox[c]];
		no.text = arrFbox[c];
		fbox[c] = no;		
	}
	for(c = 0; c < arrTbox.length; c++) {
		var no = new Option();
		no.value = arrLookup[arrTbox[c]];
		no.text = arrTbox[c];
		tbox[c] = no;
   }
}

//Date Format
//Begin
// Check browser version
var isNav4 = false, isNav5 = false, isIE4 = false
var strSeperator = "/"; 
// If you are using any Java validation on the back side you will want to use the / because 
// Java date validations do not recognize the dash as a valid date separator.
var vDateType = 3; // Global value for type of date format
//                1 = mm/dd/yyyy
//                2 = yyyy/dd/mm  (Unable to do date check at this time)
//                3 = dd/mm/yyyy
var vYearType = 4; //Set to 2 or 4 for number of digits in the year for Netscape
var vYearLength = 2; // Set to 4 if you want to force the user to enter 4 digits for the year before validating.
var err = 0; // Set the error code to a default of zero
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
// vDateName = object name
// vDateValue = value in the field being checked
// e = event
// dateCheck 
// True  = Verify that the vDateValue is a valid date
// False = Format values being entered into vDateValue only
// vDateType
// 1 = mm/dd/yyyy
// 2 = yyyy/mm/dd
// 3 = dd/mm/yyyy
//Enter a tilde sign for the first number and you can check the variable information.
if (vDateValue == "~") {
alert("AppVersion = "+navigator.appVersion+" \nNav. 4 Version = "+isNav4+" \nNav. 5 Version = "+isNav5+" \nIE Version = "+isIE4+" \nYear Type = "+vYearType+" \nDate Type = "+vDateType+" \nSeparator = "+strSeperator);
vDateName.value = "";
vDateName.focus();
return true;
}
var whichCode = (window.Event) ? e.which : e.keyCode;
//alert(e.keyCode)
// Check to see if a seperator is already present.
// bypass the date if a seperator is present and the length greater than 8
if (vDateValue.length > 8 && isNav4) {
if ((vDateValue.indexOf("-") >= 1) || (vDateValue.indexOf("/") >= 1))
return true;
}
//Eliminate all the ASCII codes that are not valid
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
if (whichCode == 8) { //Ignore the Netscape value for backspace. IE has no value
return false;

}
else {
//Create numeric string values for 0123456789/
//The codes provided include both keyboard and keypad values
var strCheck = '36,47,48,49,50,51,52,53,54,55,56,57,58,59,95,96,97,98,99,100,101,102,103,104,105,37,38,39,40,46,17,67,86';
// 37-40 = Left Right Up Down
// 46 = Delete
// 17+67 = Copy
// 17+86 = Paste
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
	//Turn a two digit year into a 4 digit year
	if (mYear.length == 2 && vYearType == 4) {
		var mToday = new Date();
		//If the year is greater than 30 years from now use 19, otherwise use 20
		var checkYear = mToday.getFullYear() + 30; 
		var mCheckYear = '20' + mYear;
		if (mCheckYear >= checkYear)
			mYear = '19' + mYear;
		else
			mYear = '20' + mYear;
	}
	var vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;
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
// Reformat the date for validation and set date type to a 1
if (vDateValue.length >= 8  && dateCheck) {
if (vDateType == 1) // mmddyyyy
{
var mDay = vDateName.value.substr(2,2);
var mMonth = vDateName.value.substr(0,2);
var mYear = vDateName.value.substr(4,4)
vDateName.value = mMonth+strSeperator+mDay+strSeperator+mYear;
}
if (vDateType == 2) // yyyymmdd
{
var mYear = vDateName.value.substr(0,4)
var mMonth = vDateName.value.substr(4,2);
var mDay = vDateName.value.substr(6,2);
vDateName.value = mYear+strSeperator+mMonth+strSeperator+mDay;
}
if (vDateType == 3) // ddmmyyyy
{
var mMonth = vDateName.value.substr(2,2);
var mDay = vDateName.value.substr(0,2);
var mYear = vDateName.value.substr(4,4)
vDateName.value = mDay+strSeperator+mMonth+strSeperator+mYear;
}
//Create a temporary variable for storing the DateType and change
//the DateType to a 1 for validation.
var vDateTypeTemp = vDateType;
vDateType = 1;
var vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;
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
// Non isNav Check
if (((vDateValue.length < 8 && dateCheck) || (vDateValue.length == 9 && dateCheck)) && (vDateValue.length >=1)) {
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
return true;
}
// Reformat date to format that can be validated. mm/dd/yyyy
if (vDateValue.length >= 8 && dateCheck) {
// Additional date formats can be entered here and parsed out to
// a valid date format that the validation routine will recognize.
if (vDateType == 1) // mm/dd/yyyy
{
var mMonth = vDateName.value.substr(0,2);
var mDay = vDateName.value.substr(3,2);
var mYear = vDateName.value.substr(6,4)
}
if (vDateType == 2) // yyyy/mm/dd
{
var mYear = vDateName.value.substr(0,4)
var mMonth = vDateName.value.substr(5,2);
var mDay = vDateName.value.substr(8,2);
}
if (vDateType == 3) // dd/mm/yyyy
{
var mDay = vDateName.value.substr(0,2);
var mMonth = vDateName.value.substr(3,2);
var mYear = vDateName.value.substr(6,4)
}
if (vYearLength == 4) {
if (mYear.length < 4) {
alert("Invalid Date\nPlease Re-Enter");
vDateName.value = "";
vDateName.focus();
return true;
   }
}
// Create temp. variable for storing the current vDateType
var vDateTypeTemp = vDateType;
// Change vDateType to a 1 for standard date format for validation
// Type will be changed back when validation is completed.
vDateType = 1;
// Store reformatted date to new variable for validation.
var vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;
if (mYear.length == 2 && vYearType == 4 && dateCheck) {
//Turn a two digit year into a 4 digit year
var mToday = new Date();
//If the year is greater than 30 years from now use 19, otherwise use 20
var checkYear = mToday.getFullYear() + 30; 

//alert(mToday.getFullYear());
var mCheckYear = '20' + mYear;
if (mCheckYear >= checkYear)
mYear = '19' + mYear;
else
mYear = '20' + mYear;
vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;
// Store the new value back to the field.  This function will
// not work with date type of 2 since the year is entered first.
if (vDateTypeTemp == 1) // mm/dd/yyyy
vDateName.value = mMonth+strSeperator+mDay+strSeperator+mYear;
if (vDateTypeTemp == 3) // dd/mm/yyyy
vDateName.value = mDay+strSeperator+mMonth+strSeperator+mYear;
} 
if (!dateValid(vDateValueCheck)) {
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
if (vDateType == 1) {
if (vDateValue.length == 2) {
vDateName.value = vDateValue+strSeperator;
}
if (vDateValue.length == 5) {
vDateName.value = vDateValue+strSeperator;
   }
}
if (vDateType == 2) {
if (vDateValue.length == 4) {
vDateName.value = vDateValue+strSeperator;
}
if (vDateValue.length == 7) {
vDateName.value = vDateValue+strSeperator;
   }
} 
if (vDateType == 3) {
if (vDateValue.length == 2) {
vDateName.value = vDateValue+strSeperator;
}
if (vDateValue.length == 5) {
vDateName.value = vDateValue+strSeperator;
   }
}
return true;
   }
}
if (vDateValue.length == 10&& dateCheck) {
if (!dateValid(vDateName)) {
// Un-comment the next line of code for debugging the dateValid() function error messages
//alert(err);  
alert("Invalid Date\nPlease Re-Enter");
vDateName.focus();
vDateName.select();
   }
}
return false;
}
else {
// If the value is not in the string return the string minus the last
// key entered.
if (isNav4) {
vDateName.value = "";
vDateName.focus();
vDateName.select();
return false;
}
else
{
vDateName.value = vDateName.value.substr(0, (vDateValue.length));
return false;
         }
      }
   }
}
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
if (intYear % 400 == 0) { return true; }
}
else {
if ((intYear % 4) == 0) { return true; }
}
return false;
}
//  End -->


<!-- Show HINT-->


<!-- Begin -->
//   ##############  SIMPLE  BROWSER SNIFFER
if (document.layers) {navigator.family = "nn4"}
if (document.all) {navigator.family = "ie4"}
if (window.navigator.userAgent.toLowerCase().match("gecko")) {navigator.family = "gecko"}

//  #########  popup text 
descarray = new Array(
"This site has some of the greatest scripts around!",
"These popups can have varying width. It is dependant upon the text message.",
"You can have <b>two</b> lines <br>and HTML content.",
"You can also have images in here like this:<br><img src=greenbar.gif>",
"You can put in a really long <br>description if it is nessary to <br>explain something in detail, <br>like a warning about content <br>or privacy.",
"</center>Lastly, you can have links like these:<br><a href='http://javascript.internet.com/'>JavaScript Source</a><br><a href='http://javascript.internet.com/'>JavaScript Source</a><br><a href='http://javascript.internet.com/'>JavaScript Source</a><br>With a change in the onmouseout event handler."
);

overdiv="0";
//  #########  CREATES POP UP BOXES 
function popLayer(a){
//if(!descarray[a]){descarray[a]="<font color=red>This popup (#"+a+") isn't setup correctly - needs description</font>";}

if (navigator.family == "gecko") {pad="0"; bord="1 bordercolor=black";}
else {pad="1"; bord="0";}
desc = 	  "<table cellspacing=0 cellpadding="+pad+" border="+bord+"  bgcolor=000000><tr><td>\n"
	+"<table cellspacing=0 cellpadding=3 border=0 width=100%><tr><td bgcolor=ffffdd><center><font size=-1>\n"
	//+descarray[a]
	+a
	+"\n</td></tr></table>\n"
	+"</td></tr></table>";
if(navigator.family =="nn4") {
	document.object1.document.write(desc);
	document.object1.document.close();
	document.object1.left=x+15;
	document.object1.top=y-5;
	}

else if(navigator.family =="ie4"){

	object1.innerHTML=desc;
	object1.style.pixelLeft=x+15;
	object1.style.pixelTop=y-5;
	}
else  if(navigator.family =="gecko"){
	document.getElementById("object1").innerHTML=desc;
	document.getElementById("object1").style.left=x+15;
	document.getElementById("object1").style.top=y-5;
	}
}
function hideLayer(){
if (overdiv == "0") {
	if(navigator.family =="nn4") {eval(document.object1.top="-500");}
	else if(navigator.family =="ie4"){object1.innerHTML="";}
	else if(navigator.family =="gecko") {document.getElementById("object1").style.top="-500";}
	}
}

//  ########  TRACKS MOUSE POSITION FOR POPUP PLACEMENT
var isNav = (navigator.appName.indexOf("Netscape") !=-1);
function handlerMM(e){
x = (isNav) ? e.pageX : event.clientX + document.body.scrollLeft;
y = (isNav) ? e.pageY : event.clientY + document.body.scrollTop;
}
if (isNav){document.captureEvents(Event.MOUSEMOVE);}
document.onmousemove = handlerMM;
//  End -->

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

function isAllDigit() {
     if (event.keyCode < 45 || event.keyCode > 57) 
        event.returnValue = false;
}

function isDigitNoneNegative() {     
     if (event.keyCode == 46) // dot
        event.returnValue = true;
     else if (event.keyCode < 48 || event.keyCode > 57 ) 
        event.returnValue = false;
}

function isDigitNoneNegativeNoneDot() {     
     if (event.keyCode < 48 || event.keyCode > 57 ) 
        event.returnValue = false;
}

function isDigitCanNegativeNoneDot() {     
     if (event.keyCode == 46 || event.keyCode == 47)
        event.returnValue = false;
     else if (event.keyCode < 45 || event.keyCode > 57 ) 
        event.returnValue = false;
}

/*********************************************************************************************************************************
*  FUNCTION BLOCK KEY PRESS
*********************************************************************************************************************************/
var numberOnly = 1;
var charOnly = 2;
var all = 3;

function blockKeyPress(type){
	if(type == numberOnly){
		if(event.keyCode >= CHAR_A && event.keyCode <= CHAR_Z)event.returnValue = false;
	
	} else if(type == charOnly){
		if(event.keyCode >= 48 && event.keyCode <= 57)event.returnValue = false;
	}
}

function setFocusInput(id){
	if(event.keyCode == ENTER){
		var obj = document.getElementById(id);
		if(isObject(obj)){
			obj.focus();
		}
	}
}

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



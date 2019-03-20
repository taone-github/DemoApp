//----------- ------------//
/*
    Author        :   Kietchai Panichsarn
    Copyright     :   (C) 2005 TISCO IT
    Description   :   
    email         :   kietchai@tisco.co.th
    written on    :   11 October 2005
    lastupdated   :   11 October 2005
*/
function validUserName(theUserName, alertString){
	var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]"
	var validChars="\[^\\s" + specialChars + "\][a-zA-Z0-9]"
	var quotedUser="(\"[^\"]*\")"
	var atom=validChars + '+'
	var word="(" + atom + "|" + quotedUser + ")"
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$")
	if (theUserName.match(userPat)==null) {
		alert(alertString + " doesn't seem to be valid, only (a-z, A-Z, 0-9) characters is recognized");
		return false;
	}
	return true;
}


//------ -------------------- ------//
var message="Function Disabled!";
function clickIE4(){
	if (event.button==2){
		return false;
	}
}
function clickNS4(e){
	if (document.layers||document.getElementById&&!document.all){
		if (e.which==2||e.which==3){
			return false;
		 }
	}
}

if (document.layers){
document.captureEvents(Event.MOUSEDOWN);
document.onmousedown=clickNS4;
}
else if (document.all&&!document.getElementById){
document.onmousedown=clickIE4;
}

document.oncontextmenu=new Function("return false")
//------ Key Press ------//
document.onkeydown =microsoftKeyPress;
function microsoftKeyPress() {
	if (window.event.keyCode == 122 ) {
		window.event.keyCode = 0;
		return false; 
	} 
	if (window.event.ctrlKey) {
		if (window.event.keyCode == 78 ) {
			return false; 
		} 
	}
}
function isFrame(){
	if(udf(parent.frames[0]))document.location.href="/"
}
function udf(x){
	x=""+x
	if(x=="undefined")return true
	else return false
}
isFrame();
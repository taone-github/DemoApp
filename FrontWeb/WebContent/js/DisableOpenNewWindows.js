//Disable Rigth Click
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

document.oncontextmenu=new Function("return false");


//Disable Shift Click   
function mouseDown(e) {
	var shiftPressed=0;
 	if(parseInt(navigator.appVersion)>3) {	
  		if(navigator.appName=="Netscape")
       		shiftPressed=(e.modifiers-0>3);
  		else 
  			shiftPressed=event.shiftKey;
  		if(shiftPressed) {
  			alert("Can't open new windows");
   			return false;
  		}
 	}
 	return true;
}

if(parseInt(navigator.appVersion)>3) {
 	document.onmousedown = mouseDown;
 	if(navigator.appName=="Netscape") {
  		document.captureEvents(Event.MOUSEDOWN);
  	}
}

//Disable Ctrl N
function netscapeKeyPress(e) {
 
}

function microsoftKeyPress() {
      
	if((event.keyCode == 78) && (event.ctrlKey)){
		event.cancelBubble = true;
		event.returnValue = false;
		event.keyCode = false; 
		return false;
	}
	
	//F5
	if(event.keyCode == 116)
	{
		window.event.returnValue = false;
		event.keyCode = false; 
		return false;
			
	}

}

 if(navigator.appName == 'Netscape') {
     window.captureEvents(Event.KEYPRESS);
     window.onKeyPress = netscapeKeyPress;
 }else{
 	 window.document.onkeydown = new Function("microsoftKeyPress();");
 }


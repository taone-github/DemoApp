var isIE=(document.all)?true:false
var isNav=(document.layers)?true:false
function showLayer(sheet)
{
	if(isIE) document.all[sheet].style.visibility="visible"
	else if(isNav)document.layers[sheet].visibility="visible"
}
function hideLayer(sheet)
{
	if(isIE) document.all[sheet].style.visibility="hidden"
	else if(isNav) document.layers[sheet].visibility="hidden"
}

function overTextBox(tb){
	tb.style.background = "#EDF5FB";
}
function outTextBox(tb){
	tb.style.background = "FFFFFF";
}
function overButton(tb){
	tb.style.color = "#3366CC";
}
function outButton(tb){
	tb.style.color = "#000000";
}
function row_overTR(theTR){
	theTR.style.background = "lightblue";
}
function row_outTR(theTR, theColor){
	theTR.style.background = theColor;
}
/**
    Parameters:
    	inputObj: element index
    	offset: number of offset
    Action:
    	get the object which is inputObj+offset
*/

function getArrayIndexAt(inputObj, offset){
    var btnIndex = -1;
    for(i=0;i<document.all.length;i++) {
      if(document.all[i].name==inputObj.name) {
         btnIndex += 1;
         if(document.all[i]==inputObj){
            //alert(btnIndex);
            return document.all[i+offset];
         }
      }
    }
}
function openWindowLookup(theCodeTextBox, theDescription, theDescriptionSpan, theFromAction) {

	if (((theCodeTextBox.value != "") && (theFromAction == 'change')) || (theFromAction == 'click')) {
        var sFeatures = "dialogHeight:500px; dialogWidth:450px; center:yes; resizable:yes";
        var retval = new Array();
        retval = window.showModalDialog( "frameLK.htm", sFeatures);
        if(retval != null) {
 			theCodeTextBox.value = retval[0];
 			theDescription.value = retval[1];
			theDescriptionSpan.innerText = retval[1];
 		}
    }
    else {
		theCodeTextBox.value = "";
		thedescription.value = "";
		theDescriptionSpan.innerText = "";
	}
    theCodeTextBox.focus();
	return true;
}
var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4)) 
var dialogWin = new Object() 
function openDialog(url, width, height, returnFunc, args) {
	if (!dialogWin.win || (dialogWin.win && dialogWin.win.closed)) {
		dialogWin.returnFunc = returnFunc
		dialogWin.returnedValue = ""
		dialogWin.args = args
		dialogWin.url = url
		dialogWin.width = width
		dialogWin.height = height
		dialogWin.name = "openDialog";//(new Date()).getSeconds().toString()
		if (Nav4) {
			dialogWin.left = window.screenX + 
			   ((window.outerWidth - dialogWin.width) / 2)
			dialogWin.top = window.screenY + 
			   ((window.outerHeight - dialogWin.height) / 2)
			var attr = "screenX=" + dialogWin.left + 
			   ",screenY=" + dialogWin.top + ",resizable=no, scrollbars=1 ,width=" + 
			   dialogWin.width + ",height=" + dialogWin.height
		} else {
			dialogWin.left = (screen.width - dialogWin.width) / 2
			dialogWin.top = (screen.height - dialogWin.height) / 2
			var attr = "left=" + dialogWin.left + ",top=" + 
			   dialogWin.top + ",resizable=no, scrollbars=1,width=" + dialogWin.width + 
			   ",height=" + dialogWin.height
		}		
		dialogWin.win=window.open(dialogWin.url, dialogWin.name, attr)
		dialogWin.win.focus()
	} else {
		dialogWin.win.focus()
	}
}
function deadend() {
	if (dialogWin.win && !dialogWin.win.closed) {
		dialogWin.win.focus()
		return false
	}
} 
function checkModal() {
	if (dialogWin.win && !dialogWin.win.closed) {
		dialogWin.win.focus()	
	}
} 
function setPrefs() { 
	document.returned.searchURL.value = dialogWin.returnedValue
} 

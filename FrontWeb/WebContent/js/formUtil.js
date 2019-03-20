// JavaScript Document
/* javascript for check all checkbox */
function selectAll(checkBox){
	var size=checkBox.length;
	if(size>0){
		for(var i=0;i<size;i++){
			checkBox[i].checked = true;
		}
	}else if(size==undefined){
		var e = checkBox;
		e.checked = true;
	}
}
function deSelectAll(checkBox){
	var size=checkBox.length;
	if(size>0){
		for(var i=0;i<size;i++){
			checkBox[i].checked = false;
		}
	}else if(size==undefined){
		var e = checkBox;
		e.checked = false;
	}
}
function ToggleAll(e,formName,checkallName,listName) { 
		if (e.checked) {
			CheckAll(formName,checkallName,listName);
		} else {
	    ClearAll(formName,checkallName,listName);
		}
  }
	function Check(e) {
		e.checked = true;
	}
  function Clear(e) {
		e.checked = false;
	}
  function CheckAll(formName,checkallName,listName) {
		var ml = formName;
		var len = 0;
		if(listName != undefined)
			len = listName.length;

		if(len==undefined){
		var e = listName;
					Check(e);
		}else{
			for (var i = 0; i < len; i++) {
			var e = listName[i];
						Check(e);
			}
		}		
		checkallName.checked = true;
	}
  function ClearAll(formName,checkallName,listName) {
		var ml = formName;
		var len = 0;
		if(listName != undefined)
			len = listName.length;

		if(len==undefined){
		var e = listName;
					Clear(e);
		}else{
			for (var i = 0; i < len; i++) {
			var e = listName[i];
						Clear(e);
			}
		}
		checkallName.checked = false;
	}	 

	function CheckNotAll(formName,checkallName,listName) {
		var ml = formName;
		var len = listName.length;
		var isAll = true;
		if(len==undefined){
			var e = listName; 
			if(!e.checked) 	isAll = false;			
		}else{
			for (var i = 0; i < len; i++) {
				var e = listName[i];
				if(!e.checked){
					isAll = false;
					break;
				} 
			}
		}			
		checkallName.checked = isAll;
	}
var checkflag = "false";

function check(field) {
   
	if (checkflag == "false") {
		if(field.length==null)
			field.checked = true;
		else
			for (i = 0; i < field.length; i++) {
			    if(!field[i].disabled)						
				field[i].checked = true;
			}
		checkflag = "true";
		return "Uncheck All"; }
	else {
		if(field.length==null)
			field.checked = false;
		else
			for (i = 0; i < field.length; i++) {
				field[i].checked = false; }
		checkflag = "false";
		return "Check All"; }
    
}

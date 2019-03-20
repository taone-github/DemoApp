/*********************************************************************************************************************************
*  FUNCTION LIST YEAR
*********************************************************************************************************************************/
function listYear(objSelectBox){
	var index = objSelectBox.selectedIndex;
	var selectYear = '';
	if(index >= 0){
		selectYear = objSelectBox.options[index].value;
	}

	var dDate = '';
	if(index < 0){
		dDate = '';

	}else {
		dDate = objSelectBox.options[index].value;
	}

	if(dDate == ''){
		dDate = new Date();	
		var year = dDate.getFullYear();

	} else {
		year = dDate;
	}

	if(year < 2500){
		year = parseInt(year) + parseInt(543);
	}
	
	var current = year;
	year = year - 20;
	if(year < 2500){
		year = 2500;
	}

	for(var i = 0; i <= 41; i++){ 
		objSelectBox.options[i]  = new Option(parseInt(year)+i, parseInt(year)+i);
		if(index < 0){
			index = 0;
		}
		if(selectYear != null && (selectYear == parseInt(year)+i || parseInt(year)+i == current)){
			objSelectBox.options[i].selected = true; 
		}
	}
}

/*********************************************************************************************************************************
*  FUNCTION LIST MONTH
*********************************************************************************************************************************/
function listMonth(objMonth){
	var listMonthValue = new Array('', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
	var listMonthText = new Array('Please Select', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

	var dDate = new Date();	
	var month = 0;
	if(objMonth.selectedIndex <= 0){		
		month = dDate.getMonth() + 1;

	} else {
		month = objMonth.selectedIndex;
	}

	for(var i = 0; i <= 12; i++){
		objMonth.options[i] = new Option(listMonthText[i], listMonthValue[i]);		
	} 

	objMonth.options[month].selected = true;
}

/*********************************************************************************************************************************
*  FUNCTION CHECK DURATION MONTH
*********************************************************************************************************************************/
function chkDurationMonth(fromMonth, toMonth){
	if((fromMonth.selectedIndex >= 0) && (toMonth.selectedIndex >= 0)){
		if(fromMonth.selectedIndex > toMonth.selectedIndex){
			toMonth.selectedIndex = fromMonth.selectedIndex;
		}		
	}
}

/*********************************************************************************************************************************
*  FUNCTION CHECK DURATION YEAR
*********************************************************************************************************************************/
function chkDurationYear(fromYear, toYear){
	if((fromYear.selectedIndex >= 0) && (toYear.selectedIndex >= 0)){
		if(fromYear.selectedIndex > toYear.selectedIndex){
			toYear.selectedIndex = fromYear.selectedIndex;
		}
	}
}
/*********************************************************************************************************************************
*  FUNCTION BLOCK KEY PRESS
*********************************************************************************************************************************/
var numberOnly = 1;
var charOnly = 2;
var all = 3;
var numberPositiveOnly = 4;

function blockKeyPress(type){
	if(type == numberOnly){
		if(event.keyCode >= CHAR_A && event.keyCode <= CHAR_Z){
			event.returnValue = false;
		}

	}else if(type == numberPositiveOnly){
		if((event.keyCode >= CHAR_A && event.keyCode <= CHAR_Z) || (event.keyCode == Negative)){
			event.returnValue = false;
		}
	} else if(type == charOnly){
		if(event.keyCode >= 48 && event.keyCode <= 57){
			event.returnValue = false;
		}
	}
}
function func_Num_Date(thisObj, thisEvent) {
	if (event.keyCode < 47 || event.keyCode > 57) event.returnValue = false;
}
function addSlashFormat(field){
	//alert('function addSlashFormat \n\n field = '+field+' \n\n document.getElementById(field).value = '+document.getElementById(field).value);
	
	var date = document.getElementById(field).value;
	if(date.length == 2 || date.length == 5){
		document.getElementById(field).value = date + '/';}
}
	
	function checkDate(field){
	
		//var date = document.getElementById(field).value;
		var date = field.value;
		date = trim(date);
		//alert('2date = '+date);
		if(date != ''){
			if (date.length != 10 && date != ''){
				alert('Invalid Format Date (dd/mm/yyyy)');
				field.value = '';
				field.focus();
			}else{
				if(date.charAt(2) == '/' && date.charAt(5) == '/'){
					var anum=/(^\d+$)|(^\d+\.\d+$)/;
					//p is paid
					var pDateDay = date.substring(0,2);
					var pDateMonth = date.substring(3,5);
					var pDateYear = date.substring(6);
					//alert('pDateDay = '+pDateDay+'\n pDateMonth = '+pDateMonth+'\n pDateYear = '+pDateYear);
					if (anum.test(pDateDay)){
						if (anum.test(pDateMonth)){
							if (anum.test(pDateYear)){
								var intpDay = pDateDay * 1;
								var intpMonth = pDateMonth * 1;
								var intpYear = pDateYear * 1;
								if (intpDay <= 31){
									if (intpMonth <= 12){
										if (intpYear > 1000){
											//February Case 29 Days
											if(intpYear % 4 == 0 && intpMonth == 2 && intpDay > 29){
												alert('Invalid Format Date (dd/mm/yyyy)');
												field.value = '';
												field.focus();
											}else{
												//February Case 28 Days
												if(intpYear % 4 != 0 && intpMonth == 2 && intpDay > 28){
													alert('Invalid Format Date (dd/mm/yyyy)');
													field.value = '';
													field.focus();
												}else{
													//Case 30 Days in One Month
													if((intpMonth == 4 || intpMonth == 6 || intpMonth == 9 || intpMonth == 11) && intpDay > 30){
														alert('Invalid Format Date (dd/mm/yyyy)');
														field.value = '';
														field.focus();
													}else{
													}
												}
											}
										}else{
											alert('Invalid Format Date (dd/mm/yyyy)');
											field.value = '';
											field.focus();
										}
									}else{
										alert('Invalid Format Date (dd/mm/yyyy)');
										field.value = '';
										field.focus();
									}
								}else{
									alert('Invalid Format Date (dd/mm/yyyy)');
									field.value = '';
									field.focus();
								}
							}else{
								alert('Invalid Format Date (dd/mm/yyyy)');
								field.value = '';
								field.focus();
							}
						}else{
							alert('Invalid Format Date (dd/mm/yyyy)');
							field.value = '';
							field.focus();
						}
					}else{
						alert('Invalid Format Date (dd/mm/yyyy)');
						field.value = '';
						field.focus();
					}
				}else{
					alert('Invalid Format Date (dd/mm/yyyy)');
					field.value = '';
					field.focus();
				}
			}
		}
	}
function checkEndMoreThanStart(field,start_date,end_date){
	var startField = document.getElementById(start_date);
	var endField = document.getElementById(end_date);
	var field = document.getElementById(field);
	//alert('start date = '+startField.value+'\n end date = '+endField.value);
	if(startField.value=='' || endField.value == '')
		return false;
		
	var sDate = startField.value;
	var sDay = sDate.substring(0,2) * 1;
	var sMonth = sDate.substring(3,5) * 1;
	var sYear = sDate.substring(6) * 1;
	var eDate = endField.value;
	var eDay = eDate.substring(0,2) * 1;
	var eMonth = eDate.substring(3,5) * 1;
	var eYear = eDate.substring(6) * 1;
	if(eYear > sYear){
	}else if(eYear == sYear){
		if(eMonth > sMonth){
		}else if(eMonth == sMonth){
			if(eDay >= sDay){
			}else{
				alert('End Date must more than Start Date');
				field.value = '';
				field.focus();
			}
		}else{
			alert('End Date must more than Start Date');
				field.value = '';
				field.focus();
		}
	}else{
		alert('End Date must more than Start Date');
				field.value = '';
				field.focus();
	}	
}
// Removes leading whitespaces
function LTrim( value ) {
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
}

// Removes ending whitespaces
function RTrim( value ) {
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
}

// Removes leading and ending whitespaces
function trim( value ) {
	return LTrim(RTrim(value));
}
function goToPage(pageNo){
	var currentPage = document.getElementById("pageNo");
	document.form.itemsPerPage.value = document.form.selectPerPage.value;
	currentPage.value = pageNo;
	document.form.submit();
}

function isNumeric(sText){
   var ValidChars = "0123456789";
   var IsNumber=true;
   var Char;
   for (i = 0; i < sText.length && IsNumber; i++) { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) {
         IsNumber = false;
      }
   }
   return IsNumber;
}
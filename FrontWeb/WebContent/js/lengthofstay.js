/*********************************************************************************************************************************
*  FUNCTION LENGTH OF STAY
*********************************************************************************************************************************/
	function fn_LengthOfStay(){
		var obj = document.forms['formName'];
		var objLengthOfStay = obj.F_CLAIMM_LengthOfStay_INT;
		var objAdmitDate  = obj.F_CLAIMM_AdmitDate_DATE;
		var objDischargeDate  = obj.F_CLAIMM_DischargeDate_DATE;
				
		//Check DischargeDate and AdmitDate must be value.
		if(!isDate(objAdmitDate, false) || !isDate(objDischargeDate, false)){
			objLengthOfStay.value = 0;
			return false;
		
		// LengthOfStay = (Discharge - Admit) +- 1	
		} else if((objLengthOfStay.value > (dateDiff(objDischargeDate, objAdmitDate)+2))
			|| (objLengthOfStay.value < (dateDiff(objDischargeDate, objAdmitDate)))){
			
			alert('Length of stay will be set to ' + (dateDiff(objDischargeDate, objAdmitDate)+1));
			objLengthOfStay.value = dateDiff(objDischargeDate, objAdmitDate)+1;
			
		// Length of stay less equal than zero length of stay is set to 1
		}else if(objLengthOfStay.value <= 0){
			alert('Length of stay will be set to 1');
			objLengthOfStay.value = 1;
		}
	}

/*********************************************************************************************************************************
*  FUNCTION DISCHARGE DATE LENGTH OF STAY
*********************************************************************************************************************************/
	function fn_DischargeDateLengthofStay(){
	var obj = document.forms['formName'];
	//Check Admit or Discharge Date is empty set length of stay equals 0
	if((obj.F_CLAIMM_DischargeDate_DATE.value == '') || (obj.F_CLAIMM_AdmitDate_DATE.value == '')){
		obj.F_CLAIMM_LengthOfStay_INT.className = 'boxReadonly';
		obj.F_CLAIMM_LengthOfStay_INT.readOnly = true;
		obj.F_CLAIMM_LengthOfStay_INT.value = 0;
	
	//Check Admit date < Discharge date	show error message and clear Discharge date
	}else if ((isDate(obj.F_CLAIMM_AdmitDate_DATE, false) && isDate(obj.F_CLAIMM_DischargeDate_DATE, false)) 
		&& dateDiff(obj.F_CLAIMM_DischargeDate_DATE,obj.F_CLAIMM_AdmitDate_DATE) < 0) {
				
		alert('Length of Stay = ' + dateDiff(obj.F_CLAIMM_DischargeDate_DATE,obj.F_CLAIMM_AdmitDate_DATE) + '\u000a Please verify Admit Date and Discharge Date');
		obj.F_CLAIMM_DischargeDate_DATE.value = "";
		obj.F_CLAIMM_LengthOfStay_INT.className = 'boxReadonly';
		obj.F_CLAIMM_LengthOfStay_INT.readOnly = true;
		obj.F_CLAIMM_LengthOfStay_INT.value = 0;					
	
	//Calculate Admit date - Discharge Date 			
	} else {
		obj.F_CLAIMM_LengthOfStay_INT.className = 'box';
		obj.F_CLAIMM_LengthOfStay_INT.readOnly = false;
		obj.F_CLAIMM_LengthOfStay_INT.value = dateDiff(obj.F_CLAIMM_DischargeDate_DATE, obj.F_CLAIMM_AdmitDate_DATE)+1;
	}

/*		var obj = document.forms['formName'];
	if((obj.F_CLAIMM_DischargeDate_DATE.value == '') || (obj.F_CLAIMM_AdmitDate_DATE.value == '')){
		obj.F_CLAIMM_LengthOfStay_INT.className = 'boxReadonly';
		obj.F_CLAIMM_LengthOfStay_INT.readOnly = true;
	} else {
		obj.F_CLAIMM_LengthOfStay_INT.className = 'box';
		obj.F_CLAIMM_LengthOfStay_INT.readOnly = false;		
	}*/
}
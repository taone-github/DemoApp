/*********************************************************************************************************************************
*  FUNCTION AUTO RUN
*********************************************************************************************************************************/	
var showFomatMoney =  ',##0.00';

	autoRun();
	function autoRun(){
		fn_GrandTotal();
	}

/*********************************************************************************************************************************
*  FUNCTION GRAND TOTAL
*********************************************************************************************************************************/	
	function fn_GrandTotal(){
		var tmpCal = 'tmpCalculate';
		var formName = 'formName';

		var obj = document.forms[formName];
		var sumItem = 0.00, sumDis = 0.00, sumNotCover = 0.00, sumNet = 0.00;
		var calBillAmount = 0.00 , calDisCountAmount = 0.00, calNotCoverAmount = 0.00, calNetItemizeAmount = 0.00;
				
		for(var i = 0; i <objectSize(obj.F_SIMBM_billingAmount_Edit_DOUBLE); i++){		
			if(objectSize(obj.F_SIMBM_billingAmount_Edit_DOUBLE) == 1){	
				/* Sum all bill amount */
				if(isNumber(obj.F_SIMBM_billingAmount_Edit_DOUBLE, false)){
					obj.F_SIMBM_billingAmount_Edit_DOUBLE.value = formatNumber(obj.F_SIMBM_billingAmount_Edit_DOUBLE.value, showFomatMoney);
					calBillAmount = placeNum(obj.F_SIMBM_billingAmount_Edit_DOUBLE.value);
					sumItem = calculate(formName, tmpCal, realNum(sumItem) + '+' + realNum(calBillAmount));
				}
				
				/* Sum all discount amount */
				if(isNumber(obj.F_SIMBM_discountAmount_Edit_DOUBLE, false)){
					obj.F_SIMBM_discountAmount_Edit_DOUBLE.value = formatNumber(obj.F_SIMBM_discountAmount_Edit_DOUBLE.value, showFomatMoney);
					calDisCountAmount = placeNum(obj.F_SIMBM_discountAmount_Edit_DOUBLE.value);
					sumDis = calculate(formName, tmpCal, realNum(sumDis) + '+' + realNum(calDisCountAmount));
				}
				
				/* Sum all not cover amount */
				if(isObject(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE) && isNumber(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE, false)){
					obj.F_SIMBM_notCoverAmount_Edit_DOUBLE.value = formatNumber(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE.value, showFomatMoney);
					calNotCoverAmount = placeNum(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE.value);
					sumNotCover = calculate(formName, tmpCal, realNum(sumNotCover) + '+' + realNum(calNotCoverAmount));
				}
				
					/* Sum all net itemize amount */
				if(isNumber(obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE, false)){
					obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE.value = formatNumber(obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE.value, showFomatMoney);
					calNetItemizeAmount = placeNum(obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE.value);
					sumNet =calculate(formName, tmpCal, realNum(sumNet) + '+' + realNum(calNetItemizeAmount));
				}
				
			} else {
				/* Sum all bill amount */
				if(isNumber(obj.F_SIMBM_billingAmount_Edit_DOUBLE[i], false)){
					obj.F_SIMBM_billingAmount_Edit_DOUBLE.value = formatNumber(obj.F_SIMBM_billingAmount_Edit_DOUBLE.value, showFomatMoney);
					calBillAmount = placeNum(obj.F_SIMBM_billingAmount_Edit_DOUBLE[i].value);					
					sumItem = calculate(formName, tmpCal, realNum(sumItem) + '+' + realNum(calBillAmount));
				}
				
				/* Sum all discount amount */	
				if(isNumber(obj.F_SIMBM_discountAmount_Edit_DOUBLE[i], false)){
					obj.F_SIMBM_discountAmount_Edit_DOUBLE.value = formatNumber(obj.F_SIMBM_discountAmount_Edit_DOUBLE.value, showFomatMoney);
					calDisCountAmount = placeNum(obj.F_SIMBM_discountAmount_Edit_DOUBLE[i].value);
					sumDis = calculate(formName, tmpCal, realNum(sumDis) + '+' + realNum(calDisCountAmount));
				}

				/* Sum all not cover amount */
				if(isObject(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE) && isObject(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE[i]) && isNumber(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE[i], false)){
					obj.F_SIMBM_notCoverAmount_Edit_DOUBLE[i].value = formatNumber(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE[i].value, showFomatMoney);
					calNotCoverAmount = placeNum(obj.F_SIMBM_notCoverAmount_Edit_DOUBLE[i].value);
					sumNotCover = calculate(formName, tmpCal, realNum(sumNotCover) + '+' + realNum(calNotCoverAmount));
				}
				
				/* Sum all net itemize amount */	
				if(isNumber(obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE[i], false)){
					obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE[i].value = formatNumber(obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE[i].value, showFomatMoney);
					calNetItemizeAmount = placeNum(obj.F_SIMBM_netItemizeAmount_Edit_DOUBLE[i].value);
					sumNet = calculate(formName, tmpCal, realNum(sumNet) + '+' + realNum(calNetItemizeAmount));
				}
			}
		}
		
		obj.F_RECEIPTM_GrandTotalBillingAmount_DOUBLE.value = formatNumber(sumItem, showFomatMoney);
		obj.F_RECEIPTM_GrandTotalDiscountAmount_DOUBLE.value = formatNumber(sumDis, showFomatMoney);
		
		if(isObject(obj.F_RECEIPTM_GrandTotalNotCoverAmount_DOUBLE)){
			obj.F_RECEIPTM_GrandTotalNotCoverAmount_DOUBLE.value = formatNumber(sumNotCover, showFomatMoney);		
		}		

		obj.F_RECEIPTM_GrandTotalNetAmount_DOUBLE.value = formatNumber(sumNet, showFomatMoney);
		
		document.getElementById('sumItem').innerHTML = formatNumber(sumItem, showFomatMoney);
		document.getElementById('sumDis').innerHTML = formatNumber(sumDis, showFomatMoney);		
		if(isObject(obj.F_RECEIPTM_GrandTotalNotCoverAmount_DOUBLE)){
			document.getElementById('sumNotCoverAmount').innerHTML = formatNumber(sumNotCover, showFomatMoney);
		}
		document.getElementById('sumNet').innerHTML = formatNumber(sumNet, showFomatMoney);
	}

/*********************************************************************************************************************************
*  FUNCTION SIMB CALCULATE
*********************************************************************************************************************************/	
	function fn_SimbCalculate(index){
		var tmpCal = 'tmpCalculate';
		var formName = 'formName';

		var objBill, objPercent, objDiscount, objNotCover, objNetItem;
		var calBill, calPercent, calDiscount, calNotCover, calNetItem;
		
		//Create instance object
		if(index == -1){		
			objBill = eval('document.forms[\'formName\'].F_SIMBM_billingAmount_DOUBLE');
			objPercent = eval('document.forms[\'formName\'].F_SIMBM_percentDiscount_DOUBLE');
			objDiscount = eval('document.forms[\'formName\'].F_SIMBM_discountAmount_DOUBLE');
			objNotCover = eval('document.forms[\'formName\'].F_SIMBM_notCoverAmount_DOUBLE');
			objNetItem = eval('document.forms[\'formName\'].F_SIMBM_netItemizeAmount_DOUBLE');	
						
		} else if(index == -2) {
			objBill = eval('document.forms[\'formName\'].F_SIMBM_billingAmount_Edit_DOUBLE');
			objPercent = eval('document.forms[\'formName\'].F_SIMBM_percentDiscount_Edit_DOUBLE');
			objDiscount = eval('document.forms[\'formName\'].F_SIMBM_discountAmount_Edit_DOUBLE');
			objNotCover = eval('document.forms[\'formName\'].F_SIMBM_notCoverAmount_Edit_DOUBLE');
			objNetItem = eval('document.forms[\'formName\'].F_SIMBM_netItemizeAmount_Edit_DOUBLE');			
		
		} else {		
			objBill = eval('document.forms[\'formName\'].F_SIMBM_billingAmount_Edit_DOUBLE[' + index + ']');
			objPercent = eval('document.forms[\'formName\'].F_SIMBM_percentDiscount_Edit_DOUBLE[' + index + ']');
			objDiscount = eval('document.forms[\'formName\'].F_SIMBM_discountAmount_Edit_DOUBLE[' + index + ']');

			if(isObject(eval('document.forms[\'formName\'].F_SIMBM_notCoverAmount_Edit_DOUBLE')))
				objNotCover = eval('document.forms[\'formName\'].F_SIMBM_notCoverAmount_Edit_DOUBLE[' + index + ']');

			objNetItem = eval('document.forms[\'formName\'].F_SIMBM_netItemizeAmount_Edit_DOUBLE[' + index + ']');
		}

		//Set default value 0.00 when data blank
		var arrayObject = new Array(objBill, objPercent, objDiscount, objNotCover, objNetItem);
		for(var i = 0; i < arrayObject.length; i++){
			if((isObject(arrayObject[i])) && (!(isNumber(arrayObject[i])) || (arrayObject[i]  <= 0))){
				arrayObject[i].value = formatNumber('0', showFomatMoney);
			}		
		}

		// Input BillAmount and Percent and Discount 
		if(isNumber(objBill) && isNumber(objPercent) && isNumber(objDiscount) && calculate(formName, tmpCal, realNum(objPercent.value) + '>0')){
			objBill.value = formatNumber(objBill.value, showFomatMoney);
			calBill = placeNum(objBill.value);

			objPercent.value = formatNumber(objPercent.value, showFomatMoney);
			calPercent = placeNum(objPercent.value);

			//calculate with (Bill * Percent) / 100 iqore Discount = discountAmount
			tmpDiscount = objDiscount.value;
			objDiscount.value = formatNumber(calculate(formName, tmpCal, '(' + realNum(calBill) + '*' + realNum(calPercent) + ')/ 100') , showFomatMoney);
			//check for insert Discount recalculate percent discount to zero
			if(tmpDiscount != objDiscount.value && activeInput == DISCOUNT_AMOUNT){
				objDiscount.value =  formatNumber(tmpDiscount, showFomatMoney);
				objPercent.value = formatNumber('0', showFomatMoney);
			}
			
			calDiscount = placeNum(objDiscount.value);

			objNetItem.value = formatNumber(calculate(formName, tmpCal, realNum(calBill) + '-' + realNum(calDiscount)), showFomatMoney);
			calNetItem = placeNum(objNetItem.value);

			if(isObject(objNotCover) && isNumber(objNotCover)){
				objNetItem.value = formatNumber(objNetItem.value, showFomatMoney);
				calNetItem = placeNum(objNetItem.value);
				
				objNotCover.value = formatNumber(objNotCover.value, showFomatMoney);
				calNotCover = placeNum(objNotCover.value);

				objNetItem.value = formatNumber(calculate(formName, tmpCal, realNum(calNetItem) + '-' + realNum(calNotCover)), showFomatMoney);
				calNetItem = placeNum(objNetItem.value );
			}
		
		} else if(isNumber(objBill) && isNumber(objPercent) && objPercent.value > 0){
			objBill.value = formatNumber(objBill.value, showFomatMoney);
			calBill = placeNum(objBill.value);

			objPercent.value = formatNumber(objPercent.value, showFomatMoney);
			calPercent = placeNum(objPercent.value);
			/* Calculate discount amount = (bill amount * percent discount amount) / 100 */
			objDiscount.value = formatNumber(calculate(formName, tmpCal, '(' + realNum(calBill) + '*'  + realNum(calPercent) + ')/100'), showFomatMoney);
			
			calDiscount = placeNum(objDiscount.value);
		
			/* Calculate net item = bill amount - discount amount */
			objNetItem.value =  formatNumber(calculate(formName, tmpCal, realNum(calBill) + '-' + realNum(calDiscount)), showFomatMoney);
			calNetItem = placeNum(objNetItem.value);

			/* if not cover has value so net item  = net item - not cover */
			if(isObject(objNotCover) && isNumber(objNotCover)){
				objNetItem.value = formatNumber(objNetItem.value, showFomatMoney);
				calNetItem = placeNum(objNetItem.value );

				objNotCover.value = formatNumber(objNotCover.value, showFomatMoney);
				calNotCover = placeNum(objNotCover.value);

				/* Calculate net item = net item - not cover amount */
				objNetItem.value = formatNumber(calculate(formName, tmpCal, realNum(calNetItem) + '-' + realNum(calNotCover)), showFomatMoney);
			}

		} else if(isNumber(objBill) && isNumber(objDiscount)){
			objBill.value = formatNumber(objBill.value, showFomatMoney);
			calBill = placeNum(objBill.value);

			objDiscount.value = formatNumber(objDiscount.value, showFomatMoney);
			calDiscount = placeNum(objDiscount.value);

			/* Net item = bill amount - discount amount */
			objNetItem.value = formatNumber(calculate(formName, tmpCal, realNum(calBill) + '-' + realNum(calDiscount)), showFomatMoney);
			calNetItem = placeNum(objNetItem.value); 

			if(isObject(objNotCover) && isNumber(objNotCover)){
				objNetItem.value = formatNumber(objNetItem.value, showFomatMoney);
				calNetItem = placeNum(objNetItem.value );

				objNotCover.value = formatNumber(objNotCover.value, showFomatMoney);
				calNotCover = placeNum(objNotCover.value);

				/* Calculate each net item = net item - not cover */
				objNetItem.value = formatNumber(calculate(formName, tmpCal, realNum(calNetItem) + '-' + realNum(calNotCover)), showFomatMoney);
			}

		} else if(!isNumber(objBill) && (isNumber(objPercent) || isNumber(objDiscount))){
			objBill.value = formatNumber(0.00, showFomatMoney);
			objPercent.value = formatNumber(0.00, showFomatMoney);
			objDiscount.value = formatNumber(0.00, showFomatMoney);
			objNetItem.value = formatNumber(0.00, showFomatMoney);
			
		} else if(isNumber(objBill) && !isNumber(objPercent) && !isNumber(objDiscount)){								
				if(isObject(objNotCover) &&  isNumber(objNotCover)){
					objBill.value = formatNumber(objBill.value, showFomatMoney);
					calBill = placeNum(objBill.value); 

					objNotCover.value  = formatNumber(objNotCover.value, showFomatMoney);
					calNotCover = placeNum(objNotCover.value); 

					objNetItem.value = formatNumber(objNetItem.value, showFomatMoney);
					calNetItem = placeNum(objNetItem.value);
					
					objNetItem.value = formatNumber(calculate(formName, tmpCal, realNum(calBill) + '-' + realNum(calNotCover)), showFomatMoney);
					
					/* If not cover more than bill amount the system will be alert error message. */
					if(calculate(formName, tmpCal, '(' + realNum(calBill) + '-' + realNum(calNotCover) + ') < 0')){
						alert("Not Cover cannot be more than Billing Amount.");
						objNotCover.value = formatNumber(0.00, showFomatMoney);
						objNetItem.value = objBill.value;
						objNotCover.setfocus();
					}
				}
			
			if(!isObject(objNotCover) ||  !isNumber(objNotCover)){
				objNetItem.value = formatNumber(objBill.value, showFomatMoney);
			}

		} else if(!isNumber(objBill)){
			objNetItem.value = '';

		}

		if(calculate(formName, tmpCal, realNum(objNetItem.value)  + '< 0')){
			alert('Discount cannot be more than Itemize Billing Amount.');
			objPercent.value = formatNumber(0.00, showFomatMoney);
			objDiscount.value = formatNumber(0.00, showFomatMoney);
			objNetItem.value = formatNumber(0.00, showFomatMoney);
			if(isObject(objNotCover)){
				objNotCover.value = formatNumber(0.00, showFomatMoney);
			}

			if(calculate(formName, tmpCal, realNum(objPercent.value) + '> 0')){
				objPercent.focus();
			}else {				
				objDiscount.focus();
			}
		}
		
		fn_GrandTotal();
	}

/*********************************************************************************************************************************
*  FUNCTION GET ACTIVE INPUT
*********************************************************************************************************************************/
var activeInput = '';
var BILLING_AMOUNT = 'BillingAmount'
var PERCENT_DISCOUNT = 'PercentDiscount';
var DISCOUNT_AMOUNT = 'DiscountAmount';
var NOT_COVER = 'NotCover';
function fn_getActiveInput(inputName){
	activeInput = inputName;
}
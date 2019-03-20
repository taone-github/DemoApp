/*
 * Kitti Daowan
 * 26/12/2011
 * 
 * this java script for control checkbox value on session
 */

//this function was trigger when user click check box
//then call ajax for add/delete value on session
function changeCheckBox(checkItem){
	blockScreen();
	var CONTEXTPATH = getcontextPath();
	var dataString = checkItem.value+"&isCheck="+checkItem.checked+"&isAll="+false;
	var uri = CONTEXTPATH+"/CheckBoxServlet";
	jQuery.ajax({
	   type: "POST",
	   url: uri,
	   data: dataString,
	   async:   false,
	   success: function(data){
		//alert("Checked : " + checkItem.checked);
		if(data == 'true'){
			$('input[name=deleteAll]').attr('checked', true);
		}
		unblockScreen();
	   }
	});
}
function changeCheckBoxMany(checkItem,moduleId){
	blockScreen();
	var CONTEXTPATH = getcontextPath();
	var dataString = checkItem.value+"&isCheck="+checkItem.checked+"&isAll="+false;
	dataString += "&moduleId="+moduleId;
	var uri = CONTEXTPATH+"/CheckBoxServlet";
	jQuery.ajax({
	   type: "POST",
	   url: uri,
	   data: dataString,
	   async:   false,
	   success: function(data){
		//alert("Checked : " + checkItem.checked);
		if(data == 'true'){
			$("#" + moduleId + "MG").find("[name=deleteAll]").attr('checked', true);
		}
		unblockScreen();
	   }
	});
}

function checkedAllData(checkBoxObj){
	checked = checkBoxObj.checked;	
	var lengthRow = document.getElementsByName('checkRow').length;
	
	$('[name=checkRow]').each(function () {
		if(!$(this).attr('disabled') && !$(this).hasClass('search-tr-hide-cb')) {
			$(this).attr('checked', checked);
			/* ========================================
			 * Fix :: 01/09/2016 :: 
			 * attr('checked', checked) does not work when click check all second time.
			 * ======================================== */
			$(this).prop('checked', checked);
		}
	});
	
	// search-tr-hide-cb
//	for (var i = 0; i < lengthRow; i++) 
//	{
//		/*
//		* 01-10-2015 FT031_HideCheckboxMany
//		*/
//		//if(document.getElementsByName('checkRow')[i].disabled == false)
//		if(document.getElementsByName('checkRow')[i].disabled == false)
//		{	
//			document.getElementsByName('checkRow')[i].checked = checked;
//		}
//	}
	try{
		checkedAllManual(checkBoxObj);
	}catch(e){ }
 }

function changeAllCheckBox(checkItem){
	blockScreen();
	var CONTEXTPATH = getcontextPath();
	var dataString = "isCheck="+checkItem.checked+"&isAll="+true;
	var uri = CONTEXTPATH+"/CheckBoxServlet";
	jQuery.ajax({
	   type: "POST",
	   url: uri,
	   data: dataString,
	   async:   false,
	   success: function(data){
		//alert("Checked : " + checkItem.checked);
		unblockScreen();
	   }
	});
}

function changeAllCheckBoxMany(checkItem,moduleId){
	blockScreen();
	var CONTEXTPATH = getcontextPath();
	var dataString = "isCheck="+checkItem.checked+"&isAll="+true;
	dataString += "&moduleId="+moduleId;
	var uri = CONTEXTPATH+"/CheckBoxServlet";
	jQuery.ajax({
	   type: "POST",
	   url: uri,
	   data: dataString,
	   async:   false,
	   success: function(data){
		//alert("Checked : " + checkItem.checked);
		unblockScreen();
	   }
	});
}

function addDataByKey(data,key){
	blockScreen();
	var CONTEXTPATH = getcontextPath();
	var dataString = key+"&isCheck="+checkItem.checked+"&isAll="+false+"&tempText="+data+"&addDataMode="+true;
	var uri = CONTEXTPATH+"/CheckBoxServlet";
	jQuery.ajax({
	   type: "POST",
	   url: uri,
	   data: dataString,
	   async:   false,
	   success: function(data){
		//alert("Checked : " + checkItem.checked);
		unblockScreen();
	   }
	});
}
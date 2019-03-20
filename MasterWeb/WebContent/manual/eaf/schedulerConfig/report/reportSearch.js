try {
	
	
	//Initial Menu Button
	$('#addButtonID').html("<a href='" + getcontextPath() + "/FrontController?action=loadEntity&entityID=SB_REPORT_EN&tabID=SB_REPORT_TAB001'><img src='./theme/005/images/b_add2.gif' border='0' alt='Add' name='addButtonID'></a>");
	$('#editButtonID').html("<img src='./theme/005/images/b_edit2_d.gif' name='editButtonID' >");
	$('#deleteButtonID').html("<img src='./theme/005/images/b_delete2_d.gif' name='deleteButtonID'>");
	$('#searchButtonID').html("<a href='" + getcontextPath() + "/FrontController?action=loadSearchEntity&entityID=SB_REPORT_EN&tabID=SB_REPORT_TAB001&searchForUpdate=Y'><img src='./theme/005/images/b_search2.gif' border='0' alt='Search' name='searchButtonID'></a>");
	$('#exitButtonID').html("<img src='./theme/005/images/b_exit2.gif' alt='Exit' border='0' name='exitButtonID'>");

	
} catch (e){
	alert("Exception :"+e);
}

try {
	var contextPath = getcontextPath();
	
	//Initial Menu Button
	$('#addButtonID').html("<img src='./theme/005/images/b_add2_d.gif' border='0' alt='Add' name='addButtonID'>");
	$('#editButtonID').html("<img src='./theme/005/images/b_edit2_d.gif' name='editButtonID' >");
	$('#deleteButtonID').html("<img src='./theme/005/images/b_delete2_d.gif' name='deleteButtonID'>");
	$('#searchButtonID').html("<a href='" + getcontextPath() + "/FrontController?action=loadSearchEntity&entityID=SB_REPORT_EN&tabID=SB_REPORT_TAB001&searchForUpdate=Y'><img src='./theme/005/images/b_search2.gif' border='0' alt='Search' name='searchButtonID'></a>");
	$('#exitButtonID').html("<img src='./theme/005/images/b_exit2.gif' alt='Exit' border='0' name='exitButtonID'>");

	//Inital Data
	$('input[name=SERVICES_CLASS]').val("com.avalant.rms.bean.process.JasperReportDaoImpl");
	$('input[name=JOB_CODE]').val("RP");
	
	document.getElementsByName("REPORT_ID")[0].onblur = setReportID;
	document.getElementsByName("REPORT_NAME")[0].onblur = setReportID;
	
	
	//Mandatory Field
	mandatoryField("SB_REPORT_MD001_REPORT_ID_LabelField");
	
	function mandatoryField(fieldID){
		var obj = $('#'+fieldID+'');
//		var objs = obj.split(":");
//		obj.html(objs[0]+" * :");
	}	
	
	function setReportID() {
		reportID = $('input[name=REPORT_ID]').val();
		reportName = $('input[name=REPORT_NAME]').val();
		var uri = contextPath
				+ "/ManualServlet?className=manual.eaf.scheduler.servlet.report.SetReportIDServlet&reportID="+reportID+"&reportName="+reportName;
		var dataString = "";
		var result = "";

		jQuery.ajax( {
			type :"POST",
			url :uri,
			data :dataString,
			async :false, // wait ultil complete
			success : function(data) {
				result = data;
			}
		});
		return result;
	}
	
	
} catch (e){
	alert("Exception :"+e);
}

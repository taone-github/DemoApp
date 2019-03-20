try {
	//Initial Data
	var contextPath = getcontextPath();
	
	$('input[name=REPORT_ID]').val(getReportID());
	$('input[name=REPORT_NAME]').val(getReportName());
	
	function getReportID() {
		var uri = contextPath
				+ "/ManualServlet?className=manual.eaf.scheduler.servlet.report.GetReportIDServlet";
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
	
	function getReportName() {
		var uri = contextPath
				+ "/ManualServlet?className=manual.eaf.scheduler.servlet.report.GetReportNameServlet";
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
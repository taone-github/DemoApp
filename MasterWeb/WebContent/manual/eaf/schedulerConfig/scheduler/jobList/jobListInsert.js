try {
	var contextPath = getcontextPath();
	
	document.getElementsByName("JOB_TYPE")[0].onchange = getDropDown;
	
	function getDropDown() {
		var job = document.getElementsByName("JOB_TYPE")[0].value;
		var uri = contextPath
				+ "/ManualServlet?className=manual.eaf.scheduler.servlet.scheduler.GetJobDropDownServlet&job="+job;
		var dataString = "";

		jQuery.ajax( {
			type :"POST",
			url :uri,
			data :dataString,
			async :false, // wait ultil complete
			success : function(data) {
				document.getElementById("SB_SCHEDULER_MD003_JOB_ID_InputField").innerHTML = data;
			}
		});
	}
	
	
} catch (e){
	alert("Exception :"+e);
}

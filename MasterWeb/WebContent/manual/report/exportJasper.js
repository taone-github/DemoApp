jQuery(document).ready(function() {
	var index = 0;
	jQuery(".SB_REPORT_MD001_REPORT_PATH_col").each(function(){
		var path = $(this).find("div a").text();
		var file = $("#REPORT_NAME_"+index).find("a").text();
		$(this).find("div a").html('test');
		$(this).find("div a").click(function(){
			//downloadFile('',file,path);
			alert(path+file);
		});
		index++;
	});
});

function downloadFile(mode,fileName,filePath){
	//blockScreen();
	var url = "/MasterWeb/manual/jsp/result_pdf.jsp?mode="+mode+"&fileName="+fileName+"&filePath="+filePath;
	//var pdfWindow = window.open(url, scrollbars=0,toolbar=0, menubar=0,directories=0);
	window.open(url, scrollbars=0,toolbar=0, menubar=0,directories=0);
	//window.open('C:/EAF_GenerateReport/OicGETM_Billing_Report.pdf','_blank');
	//window.open(url,'','height=100,width=100,menubar=no,scrollbars=no,resizable=no');
	//document.getElementById('createSchedulerForm').src = url; 
	//unblockScreen()
}
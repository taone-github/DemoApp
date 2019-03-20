//$.importJS("javascript/constant.js");	

var CONTEXTPATH='';
$.getScript("javascript/constant.js", function(){
	CONTEXTPATH = getcontextPath();
	checkLocal();
 }); 

function  checkLocal(){		
		var uri = CONTEXTPATH+"/ManualServlet";		
		var dataString = "className=manual.eaf.lang.GetLangServlet";
		
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: function(data) {
				var path = "javascript/lang/"+data +"/langConstant.js";
				$.getScript(path);
		   }

		});	
}

 checkLocal();


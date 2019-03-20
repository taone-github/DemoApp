<%@ page contentType="text/html;charset=UTF-8"%>
<HTML>
<HEAD>
<TITLE>Avalant</TITLE>  
<link href="javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet"> 
<link rel="stylesheet" href="theme/dist/css/skins/skin-blue.min.css">
<link rel="stylesheet" href="theme/dist/css/AdminLTE.min.css">
<script type="text/javascript">
function upload(){
	var form = document.AddImageForm;
	form.Attachement.disabled = true;
	form.cancel.disabled = true;
	var filename = form.fileName.value;
	var name = filename.substring(filename.lastIndexOf('\\')+1,filename.length);
	if(form.fileName.value!=""){
		showDiv();
		form.submit(); 
	}else {
	  	alert('can\'t upload');
	  	form.Attachement.disabled = false;
		form.cancel.disabled = false;
	}  	
}
function checkFileFormat(){
	var form=document.AddImageForm;
	var vfileName=form.fileName.value;
	if(vfileName!=''){
		var extension=vfileName.substring(vfileName.lastIndexOf('.')+1,vfileName.length);
		if(extension!='' && !(extension.toLowerCase()=='csv' || extension.toLowerCase()=='jpg'||extension.toLowerCase()=='jpeg'||extension.toLowerCase()=='gif'||extension.toLowerCase()=='doc' ||extension.toLowerCase()=='xls'||extension.toLowerCase()=='ppt'||extension.toLowerCase()=='pdf'||extension.toLowerCase()=='txt')){
			alert("Extension of file must be jpg, jpeg, gif, doc, xls, ppt,pdf, txt, only.");
			form.reset();
		}  
	} 
}	
function showDiv() { 
	document.getElementById('PlsWaitMessage').innerHTML ='<font color=\'red\' >Please wait ...<b></b></font>'; 
} 
</script>
</HEAD>
<BODY>
<div class="content-wrapper">
<form name="AddImageForm" method="post" enctype="multipart/form-data" action="UploadServlet">
<div class="totalpagepadding"></div>
<div class="totalpagepadding"></div>

<div class="content-all vertical-center-row row-centered" style="background-color: #ffffff">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<% 
	request.getSession().setAttribute("module",request.getParameter("moduleID"));
%>
	<div class="col-sm-3"></div>
	<div class="text-center col-md-4 col-md-offset-4">
		<div class="row row-centered">
			<div class="col-sm-2"><label>File Name : </label></div>
			<div class="col-sm-10"><input type="file" name="fileName" class="input" value="" onchange="checkFileFormat()"></div>
		</div>
		<br>
		<div class="row row-centered">
			<div class="col-sm-6">
			<input type="button" name="Attachement" class="btn btn-default input" value="Attach" onClick="upload();"> 
			<input type="button" name="cancel" class="btn btn-default input" value="Cancel" onClick="javascript:window.close();">
			</div>
		</div>
		<div class="row row-centered">
			<div id="PlsWaitMessage" style="visibility: visible"><font color='red' > <b>&nbsp;&nbsp;&nbsp; </b></font></div>
			<br>
		</div>
	</div>
</div>

<div class="totalpagepadding"></div>
<div class="totalpagepadding"></div>
</form>
</div>
</BODY>
</HTML>

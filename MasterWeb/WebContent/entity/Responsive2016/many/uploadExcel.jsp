<%@ page contentType="text/html;charset=UTF-8"%>
<HTML>
<HEAD>
<TITLE>Avalant</TITLE>  

<style type="text/css">
<!--
.font2 {
color:#000063;
font-family:"MS Sans Serif";
font-size:9pt;
font-weight:bold;
}
.input {
background-color:#FFFFFF;
border:1px solid #C6D3E7;
color:#4F4F4F;
font-family:Microsoft Sans Serif,Arial,Helvetica;
font-size:12px;
}
-->
</style>
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
<form name="AddImageForm" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/UploadExcel">
<div class="content page-padding">
<% 
	request.getSession().setAttribute("module",request.getParameter("moduleID"));
%>
	<br>
	<div class="textbox1">
		<div class="col-sm-2"><label>File Name </label></div>
		<div class="col-sm-10"><input type="file" name="fileName" class="input" value="" onchange="checkFileFormat()"></div>
	</div>
	<br>
	<div class="module-many-button">
		<input type="button" name="Attachement" class="btn btn-default input" value="Attached" onClick="upload();"> 
		<input type="button" name="cancel" class="btn btn-default input" value="Cancel" onClick="javascript:window.close();">
	</div>
	<div id="PlsWaitMessage" style="visibility: visible"><font color='red' > <b>&nbsp;&nbsp;&nbsp; </b></font></div>
</div>
</form>
</div>
</BODY>
</HTML>

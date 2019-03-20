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
<BODY style="margin: 0;padding: 0;" >
<div>
<form name="AddImageForm" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/UploadFile">
<table cellpadding="0" cellspacing="0" width="100%" height="100%" border="0" bgcolor="#e9edf6">
<% 
	request.getSession().setAttribute("module",request.getParameter("moduleID"));
%>
<TBODY>
	<tr valign="top">
		<td width="92">&nbsp;</td>
		<td colspan="2"></td>
		<td width="51" >&nbsp;</td>
	</tr>
	<tr>
		<td align="right"><font class="font2">File Name :&nbsp;</font></td>
		<td colspan="2"><input type="file" name="fileName" class="input" value="" onchange="checkFileFormat()"></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center" colspan="3">
		<input type="button" name="Attachement" class="input" value="Attached" onClick="upload();"> 
		<input type="button" name="cancel" class="input" value="Cancel" onClick="javascript:window.close();">
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">		
		<div id="PlsWaitMessage" style="visibility: visible"><font color='red' > <b>&nbsp;&nbsp;&nbsp; </b></font></div>
		<br>
		</td>
	</tr>
</TBODY>
</table>
</form>
</div>
</BODY>
</HTML>

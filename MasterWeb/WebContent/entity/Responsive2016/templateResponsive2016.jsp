<%@page import="com.eaf40.security.CSRFManager"%>
<%@ page import="com.master.util.MasterConstant"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	com.master.util.Log4jUtil.log("entitySession==>"+entitySession);
	com.master.form.EntityFormHandler form = (com.master.form.EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new com.master.form.EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	boolean divTheme =  com.avalant.feature.ExtendFeature.getInstance().useFeature("FT003_DivTmObj");
	com.avalant.display.TabDisplay tabDisplay = new com.avalant.display.TabDisplay(request);
	
	request.setAttribute("_divTheme", divTheme);
	request.setAttribute("_isRequireWFFlag", form.getEntityM().isRequireWFFlag());
	request.setAttribute("_currentMode", form.getCurrentMode());
	request.setAttribute("_PROCESS_MODE_UPDATE", MasterConstant.PROCESS_MODE_UPDATE);
	request.setAttribute("_wfPtid", (String) request.getSession().getAttribute("wfPtid"));
	request.setAttribute("_wfJobId", (String) request.getSession().getAttribute("wfJobId"));
	request.setAttribute("_tabDisplay", tabDisplay);
	request.setAttribute("_haveGeneralTab", tabDisplay.haveGeneralTab());
	
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201702151143
	* BPM Integration
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	request.setAttribute("_wftask_id", form.getWfTaskID());
	request.setAttribute("_wfProcess_key", form.getWfProcessKey());
	request.setAttribute("_isImageViewerEnabled", form.getEntityM().isImageViewerEnabled());

	
%>


<form name="masterForm" action="FrontController" method="post">
	<input type = "hidden"  name="action" value ="">
	<input type = "hidden"  name="handleForm" value ="">
	<input type = "hidden"  name="sessionForm" value ="">
	<input type = "hidden" name="currentTab" value="<%=form.getCurrentTab()%>">
	<input type = "hidden" name="goEntity" value="">
	<input type = "hidden" name="goEntityTab" value="">
	<input type = "hidden" name="keyForSearch" value="">
	<input type = "hidden" name="goEntityKey" value="">
	<input type = "hidden" name="goEntityField" value="">
	<input type = "hidden" name="nextTab" value="">
	<input type = "hidden" name="nextEntity" value="">
	<input type = "hidden" name="backEntityTab" value="">
	<input type = "hidden" name="interfaceParam" value="">
	<input type = "hidden" name="saveDraftFlag" value="">
	<input type = "hidden" name="newVersionData" value="">
	<input type = "hidden" name="conditionValue" value="">
	<input type = "hidden" name="mfID" value="">
	<input type = "hidden" name="commitFlag" value="">
	<% 
	
	%>
	<input type = "hidden" name="_csrf" value="<%=CSRFManager.getToken(request).getToken() %>"/>
	<%
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201702151143
	* BPM Integration
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	%>
	<input type = "hidden" name="_b_id" id="_b_id" value="">
	<c:if test="${ _wftask_id != null || _wfProcess_key != null}">
		<input type = "hidden" name="_wftask_id" id="_wftask_id" value="${ _wftask_id }">
		<input type = "hidden" name="_wfProcess_key" id="_wfProcess_key" value="${ _wfProcess_key }">
	</c:if>

	<c:if test="${ _isRequireWFFlag && _currentMode == _PROCESS_MODE_UPDATE}">
	
		<input type="hidden" name="wfJobId" value="${ _wfJobId }" />
		<input type="hidden" name="wfPtid" value="${ _wfPtid }" />
		<input type="hidden" name="wfAction" id="wfAction" />
		
		<div id="wfAction_dialog">
			<%com.avalant.display.WfActionDisplay wfad = new com.avalant.display.WfActionDisplay(); %>
			<%=wfad.getListAction((String)request.getSession().getAttribute("wfJobId")) %>
		</div>
		
		<script type="text/javascript">
			$('#wfAction_dialog').dialog({ width: 400, autoOpen: false, height:'auto', title: 'Workflow Action' });
		</script>
	
	</c:if>


	<div class="rightcontent">
		<div class="spacetop"></div>
		
		<c:if test="${ _isImageViewerEnabled }">
			<div class="row">
				<div id="img-controller-colapse-collpased" style="position: fixed; top: 10px; left: 5px; width: 270px; height: 32px; color: rgb(238, 238, 238); line-height: 40px; text-align: center; cursor: pointer; border-radius: 5px; z-index: 99999; opacity: 0.5; display: none;">
					<div class="pull-right box-tools btn-group btn-group-sm entity-btn-group" style="float:left !important">
						<button type="button" class="btn btn-github btn-xs pstips" id="img-controller-colapse-collpased-btn" title="Smart Image Viewer" onclick="$.MasterWeb.toggleSmartImage()">
							<i class="glyphicon glyphicon-picture"></i>
						</button>
					</div>
				</div>


				<div id="imageViewerEntityLeft" class="col-md-6 pre-scrollable medium-scrollable 100ScreenHeight">
					<jsp:include flush="true" page="/entity/image-viewer.jsp"/>
				</div>
				<div id="imageViewerEntityRight" class="col-md-6 pre-scrollable medium-scrollable 100ScreenHeight">
		</c:if>
		
		<div class="left-white-0px">
		
			<%
			/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			* Display general tab
			* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
			%>
			<jsp:include flush="true" page="tab/generalTab.jsp" />
		
		</div>
		
		<%
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		* FIX : 201612191556
		* apply AdminLTE theme for responsive2016
		* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		%>
		<c:choose>
			<c:when test="${ _haveGeneralTab }">
				<div class="left-white-10px">
					<div class="padding-zero content">
						<div class="grey-block">
							<div class="left-line"></div>
							
							<jsp:include flush="true" page="tab/downTab.jsp" />
							
						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				
				<div class="left-white-0px">
					<jsp:include flush="true" page="tab/normalTab.jsp" />
				</div>
				
			</c:otherwise>
		</c:choose>
			
		<c:if test="${ _isImageViewerEnabled }">
			</div> <!-- end imageViewerEntityLeft -->
			</div> <!-- end imageViewerEntityRigth -->
		</c:if>
		
	</div>
</form>



<script type="text/javascript">
function setSizePopupActionFlowManual(moduleId) {
	$('#many_'+moduleId+'_dialog').dialog("option", "position", "[1,40]");
	$('#many_'+moduleId+'_dialog').dialog("option", "width","99%");
}
function openAttachDialog(objName, moduleID, width,height){
	var dataString ='';
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201704261308 : Image viewer
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	//var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.display.many.LoadAttachDialog&moduleName="+moduleID+"&objName="+objName;
	
	var uri = CONTEXTPATH + "/ManualServlet?className=com.avalant.display.many.LoadAttachDialog&moduleName="+moduleID+"&objName="+objName;
	blockScreen();
	
	$.ajax({
	   type: "POST",
	   url: uri,
	   data: dataString,
	   //async:   false,
	   success: function(data){
		   var dialodId = moduleID+'_'+objName+'_dialog';
			$('#'+ dialodId).html(data);
			$('#'+ dialodId).dialog('open');
			$('.ui-dialog-content').css({"height":""});
			$('.ui-widget-content').css({"height":""});
		unblockScreen();
		
	   }
	});
}
// function upload(moduleId,objName){
// 	var form = document.AddImageForm;
// 	form.Attachment.disabled = true;
// 	form.cancel.disabled = true;
// 	var filename = form.fileName.value;
// 	var name = filename.substring(filename.lastIndexOf('\\')+1,filename.length);
<%-- 	var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.utility.upload.UploadFileResponsive&action=upload&template=Responsive&moduleId="+moduleId+"&id="+objName; --%>
// 	var dataString = new FormData($('#AddImageForm'));
// 	if(form.fileName.value!=""){
// 		showDiv();
// 		$.ajax({
// 			   url: uri,
// 			   type: 'POST',
// 			   data: dataString,
// 			   contentType: false,
// 			   processData: false,
// 		       async: true,
// 			   success: function(data){
// 				   var dialodId = moduleId+'_'+objName+'_dialog';
// 				   if(data == '' || data == undefined){
// 					   alertBox("Upload Successful");
// 					   $('#'+ dialodId).dialog('close');
// 					}else{
// 						var $data = $.parseJSON(data);
// 						if(validateFormDataObject($data,'ERROR')){
// 							hideWaitDiv();
// 							alertBox(getFormDataObject($data, 'returnMessage'));
// 						  	form.Attachment.disabled = false;
// 							form.cancel.disabled = false;
// 						}else{
// 							 alertBox("Upload Successful");
// 							 $('#'+ dialodId).dialog('close');
// 							 var imgPath = getFormDataObject($data, 'uploadURL');
// 							 rewriteImageList(imgPath, moduleId, objName,name);
// 						}
// 					}
// 			   },
// 		       error:function(msg) {
// 		    	   hideWaitDiv();
// 		    	   alertBox("Couldn't upload file .."+msg);
// 		       }
// 			});
// 	}else {
// 	  	alertBox('can\'t upload');
// 	  	form.Attachment.disabled = false;
// 		form.cancel.disabled = false;
// 	}  	
// }
function checkFileFormat(){
	var form=document.AddImageForm;
	var vfileName=form.fileName.value;
	if(vfileName!=''){
		var extension=vfileName.substring(vfileName.lastIndexOf('.')+1,vfileName.length);
		if(extension!='' && !(extension.toLowerCase()=='csv' || extension.toLowerCase()=='jpg'||extension.toLowerCase()=='jpeg'||extension.toLowerCase()=='gif'||extension.toLowerCase()=='doc' ||extension.toLowerCase()=='xls'||extension.toLowerCase()=='ppt'||extension.toLowerCase()=='pdf'||extension.toLowerCase()=='txt')){
			alertBox("Extension of file must be jpg, jpeg, gif, doc, xls, ppt,pdf, txt, only.");
			form.reset();
		}  
	} 
}
function submitAttachForm(){
	if($('#fileName').val() != '' && $('#fileName').val() != undefined) {
		$('#AddImageForm').submit();
	} else {
		alertBox('Please select the file to attach');
	}
}
function deleteImage(objName){
	$('#'+objName).find('#imageCheckbox').each(function(index, value) {
		if($(this).is(':checked') ){
			deleteAjaxImage.call(this,index, objName);
		}
	});
}
function deleteAjaxImage(index, objName){	
	var origBox = $(this);
	var uri = "<%=request.getContextPath()%>/UploadServlet";			
	$.ajax({
	   type: "POST",
	   url: uri,
	   data: "action=delete&indexRow="+index+"&filename="+origBox.val() ,
	   async: false,
	   success: function(data){
		   origBox.parent().remove();
	   }
	});
}
function showDiv() { 
	$('#PlsWaitMessage').html('<font color=\'red\' >Please wait ...<b></b></font>'); 
} 
function hideWaitDiv() { 
	$('#PlsWaitMessage').html(''); 
} 
function validateFormDataObject($data,typeJson){
	var validateForm = false;
	if($data != undefined){
		$.map($data, function(item){
			var type = item.id;
			if(type == typeJson){
				if(item.value != undefined && item.value  != ''){
					validateForm = true;
				}
			}
		});
	}
	return validateForm;
}
function getFormDataObject($data,typeJson){
	var dataVal = "";
	if($data != undefined){
		$.map($data, function(item){
			if(item.id == typeJson){
				dataVal = item.value;
			}
		});
	}
	return dataVal;
}
function rewriteImageList(imgPath, moduleId, objName,name) {
	var imagelistDiv = $("#"+objName+"_box");
	var hiddenStr = "<input type='hidden' name='"+moduleId+"_ROW_STATUS' value='INSERT'>"
					+"<input type='hidden' name ='"+moduleId+"_"+objName+"' value ='"+name+"'> ";
	var appendStr = "<div class='col-sm-2'>"
		+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='"+imgPath+"' target='_blank'>"
		+"<img src='pic1.gif' border=0></a><br>"
		+"<input type='checkbox' id='imageCheckbox' value='"+name+"'>&nbsp;&nbsp;"
		+ name
// 		+"<div class='btn-small-spec btn-group' role='group' aria-label='Third group'> "
// 		+"<button class='btn btn-default' type='button' onclick='deleteImageAttach($(this))'>"
// 		+"<i class='glyphicon glyphicon-remove' aria-hidden='true'></i></button>"
// 		+"</div>"
		+ hiddenStr.toString()+"</div>";
	imagelistDiv.append(appendStr);
}
function manualSwitchTab() {
	var tabID = document.masterForm.currentTab.value;
	try{
		$("#"+tabID).parent().parent().children('li').removeClass('active');
		$("#"+tabID).parent().parent().children('li').each(function(){
			$(this).children('a').removeClass('childtab');
		});
		$("#"+tabID).parent().addClass('active');
		$("#"+tabID).addClass('childtab');
	}catch(e){

		alert(e);}
} 
</script>

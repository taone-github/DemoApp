<%@ page errorPage="/blank.jsp" %>
<%@page import="com.avalant.display.CalculateUtil"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.oneweb.j2ee.system.LoadXML"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@ page import="com.master.util.MasterConstant"%>

<%
	//String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String hostPrefix = "";
	String themeCode = request.getParameter("themeCode");
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	String module = (String)request.getSession().getAttribute("module");
		
	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	String template = form.getEntityM().getTemplateCode();
	boolean divTheme =  com.avalant.feature.ExtendFeature.getInstance().useFeature("FT003_DivTmObj");
%>

<script type="text/javascript">
var DEFAULT_ALERT_BOX_WIDTH = '600px'; 
 	function popupActionFlow(moduleID){
 		var left   = (screen.width)/2 - (750/2);
 		var top    = (screen.height)/2 - 300/2;
 		<%
 			if(!divTheme){
 		%>

		var url = "<%=request.getContextPath()%>/FrontController?action=loadInsertMany&moduleName="+moduleID;		
		var winDialog = window.open(url,moduleID,"scrollbars=1,left="+left+",top="+top+",width=90%,height=300");
	 	window.onfocus = function(){if (winDialog.closed == false){winDialog.focus();};}; 
 		<%	} else{%>
 			var dataString ='';
 			var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.display.many.LoadInsertManyManual&moduleName="+moduleID;
			
			blockScreen();
			
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   // fix 04/04/2018 open async false because sometime after open position strangely
			   async:   false,
			   success: function(data){
				$('#many_'+moduleID+'_dialog').html(data);
				
				try{
					setSizePopupActionFlowManual(moduleID);
				}catch(e){}
				//$('#many_'+moduleID+'_dialog').dialog('option','width',750);
				//$('#many_'+moduleID+'_dialog').dialog('option','height',500);
				$('#many_'+moduleID+'_dialog').dialog('open');
				$('#many_'+moduleID+'_dialog').focus();
// 				$('.ui-dialog-content').css({"height":""});
// 				$('.ui-widget-content').css({"height":""});
				
				$("body").css("overflow", "hidden");
				try{
					popupActionFlowManual(moduleID);
				}catch(e){}
				
				unblockScreen();
				
			   }
			});
 		<%	}%>
	
		textareaFixHeight();		
	}

		function loadUpdateMany(moduleID,rowID){
 		var left   = (screen.width)/2 - 750/2;
 		var top    = (screen.height)/2 - 300/2;
		<%
 			if(!divTheme){
 		%>
		var url = "<%=request.getContextPath()%>/FrontController?action=loadUpdateMany&moduleName="+moduleID+"&rowID="+rowID;
		var winDialog = window.open(url,moduleID,"scrollbars=1,left="+left+",top="+top+",width=750,height=300");
	 	window.onfocus = function(){if (winDialog.closed == false){winDialog.focus();};}; 
 		winDialog.onunload = function(){alert('closing')};	
 		
 		<%	}else{%>
 			var dataString ='';
 			var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.display.many.LoadUpdateManyManual&moduleName="+moduleID+"&rowID="+rowID;
			
			blockScreen();
			
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   async:   false,
			   success: function(data){
				$('#many_'+moduleID+'_dialog').html(data);
				
				/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				* 22-08-2016
				* for set size popup
				*/
				try{
					setSizePopupActionFlowManual(moduleID);
				}catch(e){}
				//$('#many_'+moduleID+'_dialog').dialog('option','width',750);
				//$('#many_'+moduleID+'_dialog').dialog('option','height',500);
				$('#many_'+moduleID+'_dialog').dialog('open');
// 				$('.ui-widget-content').css({"height":""});
// 				$('.ui-dialog-content').css({"height":""});
				$("body").css("overflow", "hidden");
				try{
					loadUpdateManyManual(moduleID,rowID);
				}catch(e){
				}
				
				unblockScreen();
				
			   }
			});
 		<%	}%>
 		
	}
	function popupList(entityID,moduleID,mtxLoader, manualParam){
		<%
 			if(!divTheme){
 		%>
		var url = "<%=request.getContextPath()%>/FrontController?action=loadListMany&entityIDForList="+entityID+"&moduleIDForAction="+moduleID+"&newRequestFlag=Y&openFirstTime=Y&mtxLoader="+mtxLoader;
		var left   = (screen.width  - 950)/2;
 		var top    = (screen.height - 500)/2;
		
		var winDialog = window.open(url,entityID,"scrollbars=1,width=950,height=500,left="+left+",top="+top);
	 	window.onfocus = function(){if (winDialog.closed == false){winDialog.focus();};}; 
 		winDialog.onunload = function(){alert('closing')};	
 		blockScreen();
 		<%	}else{%>
 			var dataString ='';
 			var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.display.many.LoadListManyManual&entityIDForList="+entityID+"&moduleIDForAction="+moduleID+"&newRequestFlag=Y&openFirstTime=Y&mtxLoader="+mtxLoader;
			
			/*
			* 30-04-2015 :: add manual parameter to URL
			*/
			if(manualParam != undefined && manualParam != null && manualParam != '')
			{
				uri = uri + (manualParam.indexOf('&') === 0 ? '' : '&') + manualParam;
			}
			
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   //async:   false,
			   async:   true,
			   success: function(data){
				$('#many_'+moduleID+'_dialog').html(data);
				//change width onfly
				/* 
				* RLS_20150813
				* $('#many_'+moduleID+'_dialog').dialog('option','width',1000);
				*/
				$('#many_'+moduleID+'_dialog').dialog('option','width', ($( window ).width()-50));
				/*
				* RLS_20150813
				* $('#many_'+moduleID+'_dialog').dialog('option','height',$(window).height());
				*/
				$('#many_'+moduleID+'_dialog').dialog('option','height', ($( window ).height()-50));
				
				//$('#many_'+moduleID+'_dialog').dialog('option','position',['top', 100]);
				$('#many_'+moduleID+'_dialog').dialog('open');
				//$('.ui-dialog-content').css({"height":$(window).height()});
				
				//$('#many_'+moduleID+'_dialog').dialog( 'option', 'position', ['center',20] );
				/*
				* set dialog height
				*/
				//$('.ui-widget-content').css({"height":$(window).height()-20});
				
				/*
				* set body inside height
				*/
				/*
				* RLS_20150813
				* $('#many_'+moduleID+'_dialog').find('#content').css({"height":$(window).height()-70});
				*/
				$('#many_'+moduleID+'_dialog').find('.listcontent').css({"height": ($( window ).height()-100)});
				
				/*
				* hide main page's scroll bar
				*/
				$("body").css("overflow", "hidden");
				
				saveModuleMatrix();
				
				try{
					if(moduleID=='MD113918528'){
						$('.content-center-search-many').css('height','50%');
					}
					
					/*
					* RLS_20150813
					* $('#many_'+moduleID+'_dialog').css('max-height',$(window).height());
					*/
					/* var h = $('.content-all').css('height');
					$('.content-center-search-many').css('height',h);
					$('.content-center-search-many').css('height','+=30px' ); */
				
					/* var h2 = $('.content-all2').css('height');
					$('.content-center2').css('height',h2);
					$('.content-center2').css('height','+=20px' );
					$('.content-left2').css('height',h2);
					$('.content-left2').css('height','+=20px' ); */
					
				}catch(e){}
					try{
						afterPopupListManual(moduleID);
					}catch(e){}
				unblockScreen();
			   }
			});
 		<%	}%>
	}
	
	function popupListM1(entityID,moduleID,prop){
		
 			var dataString ='';
 			var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.asset.master.manual.AssetGeneralPopUp&entityIDForList="+entityID+"&moduleIDForAction="+moduleID+"&newRequestFlag=Y&openFirstTime=Y&prop="+prop;
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   async:   false,
			   success: function(data){
				$('#many_'+moduleID+'_dialog').html(data);
				//change width onfly
				$('#many_'+moduleID+'_dialog').dialog('option','width',1000);
				$('#many_'+moduleID+'_dialog').dialog('option','height',600);
				$('#many_'+moduleID+'_dialog').dialog('option','position','top');
				$('#many_'+moduleID+'_dialog').dialog('open');
				$('.ui-dialog-content').css({"height":"600"});
				$('.ui-widget-content').css({"height":""});
				try{
					/* var h = $('.content-all').css('height');
					$('.content-center-search-many').css('height',h);
					$('.content-center-search-many').css('height','+=96px' ); */
					/* var h2 = $('.content-all2').css('height');
					$('.content-center2').css('height',h2);
					$('.content-center2').css('height','+=20px' );
					$('.content-left2').css('height',h2);
					$('.content-left2').css('height','+=20px' ); */
				}catch(e){}
				try{
					//afterPopupListManual();
				}catch(e){}
			   }
			});
 		
	}
	function popupListM2(entityID,moduleID,prop){
		
 			var dataString ='';
 			var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.asset.master.manual.AssetGeneralPopUp&entityIDForList="+entityID+"&moduleIDForAction="+moduleID+"&newRequestFlag=Y&openFirstTime=Y&prop="+prop;
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   async:   false,
			   success: function(data){
				$('#one_module_dialog').html(data);
				//change width onfly
				$('#one_module_dialog').dialog('option','width',1000);
				$('#one_module_dialog').dialog('option','height',600);
				$('#one_module_dialog').dialog('option','position','top');
				$('#one_module_dialog').dialog('open');
				$('.ui-dialog-content').css({"height":"600"});
				$('.ui-widget-content').css({"height":""});
			   try{
					var h = $('.content-all').css('height');
					$('.content-center-search-many').css('height',h);
					$('.content-center-search-many').css('height','+=96px' );
					/* var h2 = $('.content-all2').css('height');
					$('.content-center2').css('height',h2);
					$('.content-center2').css('height','+=20px' );
					$('.content-left2').css('height',h2);
					$('.content-left2').css('height','+=20px' ); */
				}catch(e){}
				try{
					afterPopupListManual();
				}catch(e){}
			   }
			});
 		
	}
	function popupListM3(entityID,moduleID){
		
 			var dataString ='';
 			var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.pcms.manual.GeneratePopupSearchOneModule&entityIDForList="+entityID+"&moduleIDForAction="+moduleID+"&newRequestFlag=Y&openFirstTime=Y&prop=ONE";
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   async:   false,
			   success: function(data){
				$('#one_module_dialog').html(data);
				//change width onfly
				$('#one_module_dialog').dialog('option','width',1000);
				$('#one_module_dialog').dialog('option','height',600);
				$('#one_module_dialog').dialog('option','position','top');
				$('#one_module_dialog').dialog('open');
				$('.ui-dialog-content').css({"height":"600"});
				$('.ui-widget-content').css({"height":""});
			   try{
					var h = $('.content-all').css('height');
					$('.content-center-search-many').css('height',h);
					$('.content-center-search-many').css('height','+=96px' );
					/* var h2 = $('.content-all2').css('height');
					$('.content-center2').css('height',h2);
					$('.content-center2').css('height','+=20px' );
					$('.content-left2').css('height',h2);
					$('.content-left2').css('height','+=20px' ); */
				}catch(e){}
				try{
					afterPopupListManual();
				}catch(e){}
			   }
			});
 		
	}
	
	function cancelEntity() {
		blockScreen();
		document.masterForm.goEntity.value ='';
		document.masterForm.goEntityKey.value = '';
		document.masterForm.goEntityField.value = '';
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>CancelForm); 			
	}											

	function saveEntity(skipValidate) {
		if(!skipValidate) {
			if(!ajaxValidateProcess()) {
				return;
			}
		}
		
		saveModuleMatrix();

		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		blockScreen();
		
		/*
		* 19-02-2015
		* CPB : Defect: ST000000000888
		*/
		$(".many-module-hidden-field").attr("disabled", true);
		
		document.masterForm.goEntity.value ='';
		document.masterForm.goEntityKey.value = '';
		document.masterForm.goEntityField.value = '';
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm); 			
	}

	function saveEntityUnblockScreen() {
		if(!ajaxValidateProcess()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		document.masterForm.goEntity.value ='';
		document.masterForm.goEntityKey.value = '';
		document.masterForm.goEntityField.value = '';
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm); 			
	}


	function saveDraftEntity() {
		if(!ajaxValidateProcess()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		blockScreen();
		document.masterForm.goEntity.value ='';
		document.masterForm.goEntityKey.value = '';
		document.masterForm.goEntityField.value = '';
		document.masterForm.saveDraftFlag.value = 'Y';
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm); 			
	}
	
	function viewHistory(moduleID){
		var url = "<%=request.getContextPath()%>/FrontController?action=viewHistoryData";
		if(moduleID) {
			url += "&moduleID="+moduleID;
		}
		var left   = (screen.width  - 950)/2;
 		var top    = (screen.height - 500)/2;
		
		var winDialog = window.open(url,'',"scrollbars=1,width=950,height=500,left="+left+",top="+top);
	 	window.onfocus = function(){if (winDialog.closed == false){winDialog.focus();};}; 
 		winDialog.onunload = function(){alert('closing')};	
	}
	
	function deleteEntity(){
		blockScreen();
		document.masterForm.goEntity.value ='';
		document.masterForm.goEntityKey.value = '';
		document.masterForm.goEntityField.value = '';
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>DeleteForm);
	}											

	function saveEntityForGoEntity(prmEntity,prmFieldID,prmEntityField) {
		if(!ajaxValidateProcess()) return;
		if (document.getElementById(prmFieldID).value != "") {
			$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
			document.masterForm.goEntityKey.value   = document.getElementById(prmFieldID).value;
			document.masterForm.goEntityField.value   = prmEntityField;
			document.masterForm.goEntity.value = prmEntity;		 
			ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm); 			
		}
	}											

	function saveEntityForGoEntityFromList(prmEntity,keyValue,prmEntityField) {		
		if (keyValue != "") {
			if(!ajaxValidateProcess()) return;
			$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
			document.masterForm.goEntityKey.value  = keyValue;
			document.masterForm.goEntityField.value  = prmEntityField;		
			document.masterForm.goEntity.value = prmEntity;		 
			ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);
		}	 			
	}

	function saveEntityForCreateEntity(nextEntity,nextTab) {
		if(!ajaxValidateProcess()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		blockScreen();
		document.masterForm.nextTab.value  = nextTab;
		document.masterForm.nextEntity.value  = nextEntity;						 
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);			 			
	}

	/* 000158 */
	/*function saveEntityForCreateChildEntity(nextEntity,nextTab,interfaceParam) {
		if(!ajaxValidateProcess()) return;
		// Matrix check save 
		saveModuleMatrix();
		
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		document.masterForm.interfaceParam.value  = interfaceParam;
		document.masterForm.nextTab.value = nextTab;
		document.masterForm.nextEntity.value  = nextEntity;
		document.masterForm.backEntityTab.value = document.masterForm.currentTab.value;
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);		 			
	}*/
	function saveEntityForCreateChildEntity(nextEntity,nextTab,interfaceParam, createFromList) {
		if(!ajaxValidateProcess()) return; 
		blockScreen();
		// Matrix check save 
		saveModuleMatrix();
		
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		
		if($('#FT023').length > 0)
		{
			$('#FT023').val(createFromList == 'Y' ? createFromList : 'N');
		}
		
		document.masterForm.interfaceParam.value  = interfaceParam;
		document.masterForm.nextTab.value = nextTab;
		document.masterForm.nextEntity.value  = nextEntity;
		document.masterForm.backEntityTab.value = document.masterForm.currentTab.value;
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);		 			
	}

	function saveEntityForUpdateChildEntity(nextEntity,nextTab,keyForSearch) {		
		if (keyForSearch != "") {
			if(!ajaxValidateProcess()) return;
			blockScreen();
			// Matrix check save 
			saveModuleMatrix();
			
			$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
			document.masterForm.goEntity.value = nextEntity;
			document.masterForm.goEntityTab.value  = nextTab;
			document.masterForm.backEntityTab.value = document.masterForm.currentTab.value;
			document.masterForm.keyForSearch.value  = keyForSearch;
			ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);
		}	 			
	}

	function <%=entityID%>SaveForm(data) {
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		document.masterForm.sessionForm.value = data;
		document.masterForm.action.value = 'saveEntity';
		document.masterForm.handleForm.value = 'Y';
		document.masterForm.submit();
	}
	
	function <%=entityID%>DeleteForm(data) {
		document.masterForm.sessionForm.value = data;
		document.masterForm.action.value = 'deleteEntity';
		document.masterForm.handleForm.value = 'Y';
		document.masterForm.submit();
	}

	function <%=entityID%>CancelForm(data) {
		document.masterForm.sessionForm.value = data;
		document.masterForm.action.value = 'cancelEntity';
		document.masterForm.handleForm.value = 'N';
		document.masterForm.submit();
	}				
									
	function <%=entityID%>SwitchTab(data) {
		document.masterForm.currentTab.value = data;
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>Switch);
	}


	function <%=entityID%>Switch(data) {
		$('select[id$="_R"] option').attr('selected', 'true');
		document.masterForm.action.value = 'switchTab';
		document.masterForm.handleForm.value = 'Y';
		document.masterForm.submit();
	}
			
//---------- mannual--------//
 	function popupKYC() {
		var url = '<%=request.getContextPath()%>/template/template.jsp';
		var winDialog = window.open(url,'',"scrollbars=1,width=750,height=380");
	}
	
	function popupManual(popUpName, W, H) {
		if(popUpName != null && popUpName != ""){
			var left   = (screen.width)/2 - W/2;
	 		var top    = (screen.height)/2 - H/2;
			
			var url = popUpName;
			var winProp = 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no, width=' + W + ',height=' + H + ',left='+left+',top='+top;
			var winDialog = window.open(url, '', winProp);
		}
	}
//---------------------------
	
	// Decorate Functions
	function displayMessageBlock(message) {
		var messageBlock = document.getElementById("_messageBlock");
		if (messageBlock) {
			messageBlock.style.display = "block";
			document.getElementById("_messageBlock_message").innerHTML = message;
			
			messageBlock.style.left = ((document.body.clientWidth - messageBlock.offsetWidth) / 2 + document.body.scrollLeft) + "px";
			messageBlock.style.top = ((document.body.clientHeight - messageBlock.offsetHeight) / 2 + document.body.scrollTop) + "px";
			
			var background = document.getElementById("_messageBlock_background");
			background.style.width = messageBlock.offsetWidth + "px";
			background.style.height = messageBlock.offsetHeight + "px";
		} else {
			alert(message);
		}
	}
	
	function displayWaitBlock(message) {
		displayMessageBlock("<img style=\"vertical-align: middle;\" src=\"tiny_mce/themes/advanced/skins/default/img/progress.gif\"/> " + message);
	}	

	function checkExistEntityData() {	
		var dataString = "entitySession=<%=entitySession%>";
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/SwitchCurrentFormServlet";
			jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: function(data){			 					
				//loadListData();							
		   }
		});	
		try{
					loadListData();
				}catch(e){}			
		
	}

	function loadListData() {		 	
		/* submit form with ajax (no page refresh) */
		var dataString = "entitySession=<%=entitySession%>";					
		document.masterForm.handleForm.value = 'Y';
		dataString += sweepAjaxForm("masterForm");		
		document.masterForm.handleForm.value = '';
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/Web2Controller";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: function(data){	
		   try{
					loadListDataListener();
				}catch(e){}		 						
		   }
		});
	}

	function loadListDataListener() {
		var dataString = "entitySession=<%=entitySession%>";
		document.masterForm.action.value = 'loadListExistData';		
		dataString += sweepAjaxForm("masterForm");
		document.masterForm.action.value = '';
<%
		String volumePerPage = (String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get("1");
%>			
		var url = "<%=request.getContextPath()%>/FrontController?" +dataString+"&firstTimeFlag=Y&volumePerPage=<%=volumePerPage%>&page=1";						
		var winDialog = window.open(url,"listExistData","scrollbars=1,width=750,height=300");
	 	window.onfocus = function(){if (winDialog.closed == false){winDialog.focus();};}; 
 		winDialog.onunload = function(){alert('closing')};
	} 

	

	function forwordToParent(data){					
<%
		String jspNumber = template.substring(1,3);
%>
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=template%>/template<%=jspNumber%>.jsp";
		var dataString = "";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: function(data){
		   try{
				jQuery("#<%=entityID%>Div").hide();
				jQuery("#<%=entityID%>Div").html(data);
				jQuery("#<%=entityID%>Div").fadeIn("fast");
				}catch(e){}
		   }
		});
		
	}

	function loadManualPage(URL){
		if("" != URL && null != URL){
			parent.top.mainframe.document.location = URL;
		}
	}

//-----------------------------------Set current entity-------------------------------
	
	
	function windowFocus(){			
		var dataString = "entityID=<%=entityID%>&currentForm=<%=entityID%>_session&currentScreen=ENTITY_TEMPLATE_SCREEN";										
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/SetCurrentEntityServlet";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false, 		   
		   success: function(data){												
		   }
		});
	}
	
	$(document).ready(function() {
	var dataString = "<input type=\"hidden\" name=\"beweno1\" value=\"<%=entityID%>\">"
	+"<input type=\"hidden\" name=\"beweno2\" value=\"<%=entityID%>_session\">"
	+"<input type=\"hidden\" name=\"beweno3\" value=\"ENTITY_TEMPLATE_SCREEN\">";
	
	//append several form at once
	$('form').append(dataString);
	
	//Sam support save and open insert many
	//08/03/2012
	<%if(null!=form.getDefaultPopMany() && !"".equalsIgnoreCase(form.getDefaultPopMany())){%>
	popupActionFlow('<%=form.getDefaultPopMany()%>');
		try{
			defaultPopMany();
		}catch(e){}
	<%}%> 
	});
//-------------------------------------------------------------------------------------	

	function refreshModuleMany(entityID,moduleID){		
		
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet?className=manual.eaf.refreshModule.RefreshModuleManyServlet";
		var dataString = "entityID="+entityID+"&moduleID="+moduleID;
				
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: function(data) {
		   try{
			refreshPaintManyAjax(moduleID);	
			}catch(e){}
		   }							  
		});
		
	}



	function refreshPaintManyAjax(moduleID){		
		var tabID = document.masterForm.currentTab.value;
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=template%>/manyRelation.jsp?requestModule="+moduleID;
		var dataString = "CURRENT_TAB=" + tabID;
		var divIDToPaint = moduleID+"MG";
		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){
			    try{
					jQuery("#" + divIDToPaint).hide();
					jQuery("#" + divIDToPaint).html(data);
					jQuery("#" + divIDToPaint).fadeIn("fast");		
					}catch(e){}													
			   }
			});
		}
	}

	function moveSelectValue(fromField, toField){
		var opts='';
		var fbox = document.getElementById(fromField);
		var tbox = document.getElementById(toField)

		var arrFbox = new Array();
	    var arrTbox = new Array();
	    var arrLookup = new Array();
	    var i;
	    for(i=0; i<tbox.options.length; i++) {
	    	arrLookup[tbox.options[i].text] = tbox.options[i].value;
	    	arrTbox[i] = tbox.options[i].text;  
	    }
	    var fLength = 0;
	    var tLength = arrTbox.length
	    for(i=0; i<fbox.options.length; i++) {
			arrLookup[fbox.options[i].text] = fbox.options[i].value;
			if(fbox.options[i].selected && fbox.options[i].value != "") {
				arrTbox[tLength] = fbox.options[i].text;
				tLength++;
			} else {
				arrFbox[fLength] = fbox.options[i].text;
				fLength++;
			}
	    }
	    arrFbox.sort();
	    arrTbox.sort();
	    fbox.length = 0;
	    tbox.length = 0;
	    var c;
	    for(c=0; c<arrFbox.length; c++) {
			var no = new Option();
			no.value = arrLookup[arrFbox[c]];
			no.text = arrFbox[c];
			fbox[c] = no;
	    }
	    for(c=0; c<arrTbox.length; c++) {
			var no = new Option();
			no.value = arrLookup[arrTbox[c]];
			no.text = arrTbox[c];
			tbox[c] = no;
	    }
		
	}
	
	function  moveAllValue(fromField, toField)
	{
		$('#' + fromField + ' option').attr('selected', 'true');
		moveSelectValue(fromField, toField)
	}

	function setDynamicSchema(schemaName) {
		var dataString = "schemaActionType=SET&dynamicSchema=" + schemaName;										
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/SetDynamicSchemaServlet";
		jQuery.ajax({
			type: "POST",
		   	url: uri,
		   	data: dataString,
		   	async:   false, 		   
		   	success: function(data){												
		   
		   	}
		});
	}
	
	function delDynamicSchema() {
		var dataString = "schemaActionType=DEL";									
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/SetDynamicSchemaServlet";
		jQuery.ajax({
			type: "POST",
		   	url: uri,
		   	data: dataString,
		   	async:   false, 		   
		   	success: function(data){												
		   
		   	}
		});
	}
	
	//Sam create new funtion
	//support save and open insert many
	//08/03/2012
	function saveAndPopupActionFlow(moduleID){
		if(!ajaxValidateProcess()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		blockScreen();
		document.masterForm.saveToManyFlag.value = moduleID;
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);
	}
	
	//Sam save and nextTab LoadListMany
	function addManyByList(nextEntity,nextTab,moduleID) {
		if(!ajaxValidateProcess()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		document.masterForm.nextTab.value = nextTab;
		document.masterForm.nextEntity.value  = nextEntity;
		document.masterForm.backEntityTab.value = document.masterForm.currentTab.value;
		document.masterForm.moduleIDForAction.value = moduleID;
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm);			 			
	}
	
	function actionWorkflow() {
		if(!ajaxValidateProcess()) return;
		var isOneAction = submitWfOneAction();
		if(isOneAction){
			saveEntity();
		}else{
			$('#wfAction_dialog').dialog('open');
		}
	
	}
	
	function newEntityVersion() {
		if(!ajaxValidateProcess()) return;
		$('select[id$="_R"] option').attr('selected', 'true'); //Auto select value in multi select box.
		blockScreen();
		document.masterForm.goEntity.value ='';
		document.masterForm.goEntityKey.value = '';
		document.masterForm.goEntityField.value = '';
		document.masterForm.newVersionData.value = 'Y';
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>SaveForm); 			
	
	}
	function refreshPageByAccessCondition(entityID)
	{
		blockScreen();
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet?className=com.avalant.rules.j2ee.RefeshPageOnConditionChange";
		var dataString = "entityID="+entityID+'&';
		dataString += $('form[name=masterForm]').serialize();
		
		jQuery.ajax({
			type: "POST",
		   	url: uri,
		   	data: dataString,
		   	success: function(data) {
				if(data != '') 
				{
					window.location = "<%=request.getContextPath()%>/FrontController?page="+data;
				}
				unblockScreen();
		   	}							  
		});	
	}
	
	/*
	* 11-09-2014
	* text area max length
	*/
/*	$.fn.maxlength = function() {
	  if($(this).attr('maxlength') != undefined)
		{
			$(this).keyup(function () {
				//get the limit from maxlength attribute
				var limit = parseInt($(this).attr('maxlength'));
				//get the current text inside the textarea
				var text = $(obj).val();
				//count the number of characters in the text
				var chars = text.length;
			
				//check if there are more characters then allowed
				if(chars > limit){
					//and if there are use substr to get the text before the limit
					var new_text = text.substr(0, limit);
				
					//and change the current text with the new text
					$(this).val(new_text);
				}
			});
		}
	};*/
$.fn.maxlength = function() {};	
	// jQuery shim for supporting <textarea> `maxlength` attribute in IE < 10
	// Author: Chris O'Brien, prettycode.org
	(function ($) {
	    // Target only IE browsers that don't support `maxlength`
	    if (typeof document.selection === 'undefined' ||
	        'maxLength' in document.createElement('textarea')
	    ) {
	    	console.log('document.selection >>> ' + document.selection);
	    	console.log('maxLength in document.createElement(textarea) >>> ' + ('maxLength' in document.createElement('textarea')));
	        return;
	    }
	 	console.log('start jQuery shim for supporting <textarea> `maxlength` attribute in IE < 10 ');
	    // IE's API into document selections
	 
	    var selection = document.selection;
	 
	    // There's a global selection (vs. getting element selection)
	 
	    function selectionLength() {
	        return selection.createRange().text.length;
	    }
	 
	    // One of several implementations that work
	 
	    function cursorIndex() {
	        var current = selection.createRange(),
	            diff = current.duplicate();
	 
	        diff.moveToElementText(this);
	        diff.setEndPoint('EndToEnd', current);
	 
	        return diff.text.length - current.text.length;
	    }
	 
	    function setCursorPosition(index) {
	        var range = this.createTextRange();
	        range.collapse(true);
	        range.moveStart('character', index);
	        range.moveEnd('character', 0);
	        range.select();
	    }
	 
	    // Don't store this anywhere; it could change dynamically
	 
	    function maxlength() {
	        return parseInt(this.getAttribute('maxlength'), 10);
	    }
	 
	    // For every <textarea maxlength...> that does or will exist...
	 
	    $(document)
	        // Only allow key actions that won't exceed maxlength, and pasting
	        .on('keydown', 'textarea[maxlength]', function (e) {
	            var value = this.value,
	                length = value.length,
	                maxLength = maxlength.call(this),
	                keyCode = e.keyCode,
	                hasSelection = !!selectionLength();
				//console.log('keyCode: '+keyCode);
	            return ((length < maxLength) ||
	                keyCode === 8 || // backspace
	                keyCode === 9 || // tab
	                keyCode === 46 || // delete
	                (keyCode >= 37 && keyCode <= 40) || // arrows
	                e.ctrlKey ||
	                hasSelection
	            );
	        })
	 
	        // 'paste' event, can happen via mouse, keyboard, or Edit menu
	 
	        .on('paste', 'textarea[maxlength]', function () {
	            var textbox = this,
	                value = textbox.value,
	                selectionLen = selectionLength(),
	                cursorPos = cursorIndex.call(textbox),
	                pasteText = window.clipboardData.getData('Text'),
	                maxLength = maxlength.call(textbox);
	 
	            var prefix = value.substring(0, cursorPos),
	                paste = pasteText.substring(0, maxLength - value.length + selectionLen),
	                suffix = value.substr(cursorPos + selectionLen);
	 
	            textbox.value = prefix + paste + suffix;
	 
	            window.setTimeout(function () {
	                setCursorPosition.call(textbox, prefix.length + paste.length);
	                $(textbox).change();
	            }, 0);
	 
	            return false;
	        })
	    ;
	 
	}(jQuery));
	
	function alertBox(msgId,callBack,fwdData,width,height){
		var constant = true;
		var msg = null;
		if(width == undefined){
			width = DEFAULT_ALERT_BOX_WIDTH;
		}
		try{
			msg = eval(msgId);
		}catch(e){}
		if(msg == undefined || null == msg || msg == ''){
			constant = false;
			msg = msgId;
		}
		if(fwdData == undefined){
			fwdData = '';
		}
		var dlgprop = {
			nl2br: false,
			title: 'Alert',
			closable: false,
			draggable: true,
			message: '<div class="row formDialog"><div class="col-xs-12">'+msg+'</div></div>', // Body
			buttons: [
			   {
				   label: 'OK',
				   cssClass: 'btn-primary',
				   action: function(dialog) {
					    dialog.close();
						try{
							if(callBack != undefined){
								new callBack(fwdData);
							}	
						}catch(e){}
				   }
			   }
			]
		};
		openBootstrapDialog(dlgprop,'auto',width, height);
	}

	function openBootstrapDialog(obj, side, width, height) {	
//		Type of dialog
//		BootstrapDialog.TYPE_DEFAULT
//		BootstrapDialog.TYPE_INFO
//		BootstrapDialog.TYPE_PRIMARY
//		BootstrapDialog.TYPE_SUCCESS
//		BootstrapDialog.TYPE_WARNING
//		BootstrapDialog.TYPE_DANGER	
		if (!obj) return false;
		var dlg = new BootstrapDialog(obj);
		dlg.realize();	
//		Use Switch case for addition
		switch(side) {
			case 'right':side = 'right-side';
			break;
		}
		dlg.getModalDialog().css({
			'width': width
		}).attr('id','form_'+obj.formId+'_dialog').data('modal', dlg)
		.find('.modal-body').css({'height': height})
		.find('.PopupFormWrapper').css('height', parseInt(height) - 63);
		
		//modalreposition(dlg.getModal(), side);	
		if (obj.title == false) {
			dlg.getModalHeader().hide();
		}
		dlg.open();	
	}
	
	function refreshOneModule(moduleID, callBack) {
		try {
			jQuery.ajax({
				type: "POST",
				url: "/MasterWeb/entity/<%=template%>/oneRelation.jsp?requestModule=" + moduleID,
				success: function(data){
					jQuery("#"+moduleID+"MG").hide();
					jQuery("#"+moduleID+"MG").html(data);
					jQuery("#"+moduleID+"MG").fadeIn("fast");
					if(callBack != undefined){
						new callBack();
					}
				}
			});
		} catch(e) {
			alert(e);
		}
	}
	
	function saveModuleMatrix(){
		if($('#matrix-box').is(':visible')){
			var moduleID = $('#matrix-box').attr('module');
			saveSessionMatrix(moduleID);
		}
	}
	
	function saveSessionMatrix(moduleID){
		var kCol = $('#keyColumn').find(':input');
		var sCol = kCol.length;		//size column
		
		//one module 
		for(var a=0; a<sCol ;a++){
			var paramOne = "moduleID="+moduleID+"&function=reOneMD";
			paramOne += "&keyName="+$(kCol[a]).attr('name');
			paramOne += "&keyValue="+$(kCol[a]).attr('value');
			
			$('[mtx-one-'+a+']').find(':input').each(function() {
				if(undefined != $(this).attr('name')){
					var mx = $(this).attr('name').indexOf("_MX_");
					var mxp = $(this).attr('name').indexOf("_MXP_");
					if(mx!=-1){
						var subMX = $(this).attr('name').substring(0,mx);
						paramOne += "&"+subMX+"="+$('input[name='+$(this).attr('name')+']:checked').val();
					}else if(mxp!=-1){
						var subMX = $(this).attr('name').substring(0,mxp);
						paramOne += "&"+subMX+"="+$('input[name='+$(this).attr('name')+']').val();
					}else{
				    	paramOne += "&"+$(this).attr('name')+"="+$(this).attr('value');
					}
				}
			});
			//save session module one process by paramOne
			reSessionModuleMatrix(paramOne);
		}
		
		var sizeRow = $("[name='"+moduleID+"_sizeRow']").val();	
		for(var b=0; b<sizeRow; b++){
			var paramRow = "moduleID="+moduleID+"&function=reManyMD";
			$('[mtx-row-key-'+b+']').find(':input').each(function() {
				paramRow += "&rowKeyName="+$(this).attr('name');
				paramRow += "&rowKeyValue="+$(this).attr('value');
				paramRow += "&rowMtxID="+$(this).attr('mtx_id');
				return false; 
			});

			 for(var c=0; c<sCol ;c++){
				var paramMany = paramRow;
				paramMany += "&colKeyName="+$(kCol[c]).attr('name');
				paramMany += "&colKeyValue="+$(kCol[c]).attr('value');
				
// 				console.log('paramMany='+paramMany);
				
				$('[mtx-many-'+b+'-'+c+']').find(':input').each(function() {
					var mx = $(this).attr('name').indexOf("_MX_");
					var mxp = $(this).attr('name').indexOf("_MXP_");
					if(mx!=-1){
						var subMX = $(this).attr('name').substring(0,mx);
						paramMany += "&"+subMX+"="+$('input[name='+$(this).attr('name')+']:checked').val();
					}else if(mxp!=-1){
						var subMX = $(this).attr('name').substring(0,mxp);
						paramMany += "&"+subMX+"="+$('input[name='+$(this).attr('name')+']').val();
					}else{
						paramMany += "&"+$(this).attr('name')+"="+$(this).attr('value');
					}
				});
				//save session module many process by paramMany
				reSessionModuleMatrix(paramMany);
			 }
		}
		
		for(var d=0; d<sizeRow; d++){
			var paramRow = "moduleID="+moduleID+"&function=reRowMD";
			$('[mtx-row-key-'+d+']').find(':input').each(function() {
				paramRow += "&rowKeyName="+$(this).attr('name');
				paramRow += "&rowKeyValue="+$(this).attr('value');
				paramRow += "&rowMtxID="+$(this).attr('mtx_id');
				return false;
			});

// 			console.log('paramRow='+paramRow);
				
			$('[mtx-row-key-'+d+']').find(':input').each(function() {
				var mx = $(this).attr('name').indexOf("_MX_");
				var mxp = $(this).attr('name').indexOf("_MXP_");
				if(mx!=-1){
					var subMX = $(this).attr('name').substring(0,mx);
					paramRow += "&"+subMX+"="+$('input[name='+$(this).attr('name')+']:checked').val();
				}else if(mxp!=-1){
					var subMX = $(this).attr('name').substring(0,mxp);
					paramRow += "&"+subMX+"="+$('input[name='+$(this).attr('name')+']').val();
				}else{
					paramRow += "&"+$(this).attr('name')+"="+$(this).attr('value');
				}
			});
// 			console.log('paramRow result='+paramRow);
			//save session module many process by paramMany
			reSessionModuleMatrix(paramRow);
			 
		}
		
	}

	function reSessionModuleMatrix(parameter){
		var uri = "/MasterWeb/ManualServlet?className=com.master.servlet.entity.AjaxUpdateMatrix";
		jQuery.ajax({
			type : "POST",
			url : uri,
			data : parameter,
			async : false,
			success : function(data) {
				
			}
		});
	}
	

	function refreshMatrixModule(moduleID) {
		try {
			jQuery.ajax({
				type: "POST",
				url: "/MasterWeb/entity/<%=template%>/matrixRelation.jsp?requestModule=" + moduleID,
				success: function(data){
					jQuery("#"+moduleID+"MG").hide();
					jQuery("#"+moduleID+"MG").html(data);
					jQuery("#"+moduleID+"MG").fadeIn("fast");
// 					var objDiv = document.getElementById("matrix-box");
// 					objDiv.scrollLeft = objDiv.scrollWidth;

					var kCol = $('#keyColumn').find(':input');
					var sCol = kCol.length - 1;	
					$('[mtx-one-'+sCol+']').find(':input').each(function() {
					    $(this).focus();
					    return false;
					});
				}
			});
		} catch(e) {
			alert(e);
		}
	}
	
	function addColumnMatrix(moduleID){
		saveModuleMatrix();
		var sizeCol = $("[name='"+moduleID+"_sizeCol']").val();	
		var parameter = "moduleID="+moduleID+"&function=addColumnMtx&sizeCol="+sizeCol;
		var uri = "/MasterWeb/ManualServlet?className=com.master.servlet.entity.AjaxUpdateMatrix";
		jQuery.ajax({
			type : "POST",
			url : uri,
			data : parameter,
			async : false,
			success : function(data) {
				refreshMatrixModule(moduleID);
			}
		});
		
	}
	
	function deleteColumnMatrix(moduleID,key){
		//save value into session
		if(confirm("Do you want to delete this column record?")){
			saveModuleMatrix();
			var uri = "/MasterWeb/ManualServlet?className=com.master.servlet.entity.AjaxUpdateMatrix";
			var parameter = "moduleID="+moduleID+"&function=delColumnMtx&"+key;
			jQuery.ajax({
				type : "POST",
				url : uri,
				data : parameter,
				async : false,
				success : function(data) {
					refreshMatrixModule(moduleID);
				}
			});
		}
		
	}
	
	function toggleOneMTX(moduleID){
		$(".toggle-one-mtx").toggle("slow",function(){

			if($(".toggle-one-mtx").is(':hidden')){
				$("#mtx-one-arrow").attr('class','fa fa-plus');
			}else{
				$("#mtx-one-arrow").attr('class','fa fa-minus');

			}	
		});
				
	}
	
	function toggleDataMTX(moduleID,groupValue){
		$(".toggle-data-mtx-"+groupValue).toggle("slow",function(){

			if($(".toggle-data-mtx-"+groupValue).is(':hidden')){
				$("#mtx-data-arrow-"+groupValue).attr('class','fa fa-plus');
			}else{
				$("#mtx-data-arrow-"+groupValue).attr('class','fa fa-minus');

			}	
		});
	}
	
	function loadPopUpMatrix(mainModule,moduleID,type){
		var dataString ='';
		console.log("moduleID="+moduleID)
		var uri = "/MasterWeb/ManualServlet?className=com.avalant.display.many.LoadInsertManyManual&moduleName="+moduleID;
		$.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   async:   false,
		   success: function(data){
				$('#matrix_'+type+'_'+mainModule+'_dialog').html(data);
				$('#matrix_'+type+'_'+mainModule+'_dialog').dialog({
						autoOpen: true,
						modal: true,
						width: "90%"
				});
				$('.ui-dialog-content').css({"height":""});
				$('.ui-widget-content').css({"height":""});
			
		   }

		});
	}
	
	function cloneColumnMatrix(moduleID,keyName,loadflag,keyValue,mainModule){
		saveModuleMatrix();
		var sizeCol = $("[name='"+moduleID+"_sizeCol']").val();	
		if(loadflag=='Y'){
			keyValue =  $('#'+mainModule+'_'+keyName+'_InputField').find("[name='"+keyName+"']").val(); 
		}
		var parameter = "moduleID="+moduleID+"&function=cloneColumnMtx&sizeCol="+sizeCol+"&keyName="+keyName+"&keyValue="+keyValue;
		var uri = "/MasterWeb/ManualServlet?className=com.master.servlet.entity.AjaxUpdateMatrix";
		jQuery.ajax({
			type : "POST",
			url : uri,
			data : parameter,
			async : false,
			success : function(data) {
				refreshMatrixModule(moduleID);
			}
		});
		
	}
	
	function resetSearchCriteria(){
		$('.searchCriteriaContainer :input:not(:button, :submit, :reset, :radio)')
		.val('')
		.removeAttr('checked')
		.removeAttr('selected');
		
		loadDefaultValue();  // script in ModuleManyDisplay.java
	}
	
	function saveRichText(){
		if($('.mceLayout').is(':visible')){
			tinyMCE.triggerSave();
		}
	}
	
	
	function savePopupJSON(moduleID,jsonData){		
//  		console.log('pass jsonData data ' + jsonData);
		$.ajax({
			dataType: 'html',          
	        contentType: 'application/json',
	        mimeType: 'application/json',
			url: $.MasterWeb.contextPath + "/web/"+moduleID+"/setsession",
			type: 'POST',
			data: jsonData,  
			async : false,
			success: function(data){
			    try{
			    	refreshPaintManyAjax(moduleID);
			    	}catch(e){}		
			    try{
			    	closePopupJson(moduleID);
				   }catch(e){}	
			   },
			error: fnError
		});

	}
	
	function saveMatrixJSON(moduleID,jsonData){		
	//	console.log('pass jsonData data ' + jsonData);	
		$.ajax({
			dataType: 'html',          
	        contentType: 'application/json',
	        mimeType: 'application/json',
			url: $.MasterWeb.contextPath + "/web/"+moduleID+"/setmatrixsession",
			type: 'POST',
			data: jsonData,  
			async : false,
			success: function(data){
			    try{
			    	refreshMatrixModule(moduleID);
			    	}catch(e){}		
			    try{
			    	closePopupJson(moduleID);
				   }catch(e){}	
			   },
			error: fnError
		});

	}
	
	function updateMatrixJSON(moduleID,jsonData){		
		//	console.log('pass jsonData data ' + jsonData);	
			$.ajax({
				dataType: 'html',          
		        contentType: 'application/json',
		        mimeType: 'application/json',
				url: $.MasterWeb.contextPath + "/web/"+moduleID+"/updatematrixsession",
				type: 'POST',
				data: jsonData,  
				async : false,
				success: function(data){
				    try{
				    	refreshMatrixModule(moduleID);
				    	}catch(e){}		
				    try{
				    	closePopupJson(moduleID);
					   }catch(e){}	
				   },
				error: fnError
			});

		}
	

</script>
<%@page import="com.avalant.feature.FT029_DBPagingMany"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/JStartTagLib.tld" prefix="taglib"%>
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String templateCode = request.getParameter("templateCode");
	if(templateCode.equals("PB1")){
		templateCode = "ProfesionalBlue_01";
	}else if ("PS1".equalsIgnoreCase(templateCode)) {
		templateCode = "ProSilver";
	}else if ("PSJ".equalsIgnoreCase(templateCode)) {
		templateCode = "ProSilverJSON";
	}
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler entityForm = (EntityFormHandler) request.getSession().getAttribute(entitySession);
	com.master.model.EntityM entityM =  entityForm.getEntityM();
	//com.master.util.Log4jUtil.log("request.getRequestURL()===>"+request.getRequestURL());
%>


<%@page import="com.master.model.ModuleActionM"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page import="com.master.util.MasterConstant"%>
<script type="text/javascript"><!--
	var divIDToPaint = "";
	var mfID = "";
	var orderingManyID = "";
	
	<%
	/*
	* FT029_DBPagingMany
	*/
	%>
	function changeManyPerPage(page,volumePerPage,moduleID,divID){
	
		var changePageFunc = function() {
			
			divIDToPaint = divID;
				orderingManyID = moduleID;
				var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet";
				var manyOrderBy = document.getElementById(moduleID + "_orderBy").value;
				var manyOrderByType = document.getElementById(moduleID + "_orderByType").value;
				
				var dataString = "className=com.master.servlet.entity.PaggingManyClass&page="+page+"&volumePerPage="+volumePerPage+"&moduleID="+moduleID;
				dataString += "&manyOrderBy=" + manyOrderBy;
				dataString += "&manyOrderByType=" + manyOrderByType;
		
				if("" != divIDToPaint){
					jQuery.ajax({
					   type: "POST",
					   url: uri,
					   data: dataString,
					   success:paintManyAjaxResponseListener
					});
				}
		};
	
		blockScreen();
		
		<%
		/*
		* EAFManualFunc001
		*/
		%>
		try { EAFManualFunc001(moduleID); } catch(e) {}
		<%
		/*
		* EAFManualFunc002
		*/
		%>
		var manualValidateResult = true;
		try { manualValidateResult = EAFManualFunc002(moduleID); } catch(e) {}
		if(!manualValidateResult) {
			return false;
		}
		
		
		<%
		if(FT029_DBPagingMany.getInstance().isFeatureUse() && entityForm.getEntityM().isSavePagingMany()) {
		%>
			var formName = "masterForm";
			var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet?className=com.master.manual.SavePagingManyManual&moduleID="+moduleID;
			var parameterList = "";
			mapFormHandlerAjax(formName, uri, parameterList, function (data) {
				var jsonObj = $.parseJSON(data);
				
				if(jsonObj.RESULT.lastIndexOf('ERROR') != -1) 
				{
					alert(jsonObj.RESULT);
					unblockScreen();
					return;
				}
				changePageFunc();
			});
		<%
		} else {
		%>
			changePageFunc();
		<% } %>
	/*
		divIDToPaint = divID;
		orderingManyID = moduleID;
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ManualServlet";
		var manyOrderBy = document.getElementById(moduleID + "_orderBy").value;
		var manyOrderByType = document.getElementById(moduleID + "_orderByType").value;
		
		var dataString = "className=com.master.servlet.entity.PaggingManyClass&page="+page+"&volumePerPage="+volumePerPage+"&moduleID="+moduleID;
		dataString += "&manyOrderBy=" + manyOrderBy;
		dataString += "&manyOrderByType=" + manyOrderByType;

		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success:paintManyAjaxResponseListener
			});
		}
		*/
	}


	
	function saveManyPermission(obj,id){
		if(obj.checked){ 
			var uri = "<%=request.getContextPath()%>/SaveManyPermissionServlet";
			var role = "" ;			
			dataString = "status=view&role=" + id + "&check=1"  ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}else{
			var uri = "<%=request.getContextPath()%>/SaveManyPermissionServlet";
			var role = "" ;
			dataString = "status=view&role=" + id + "&check=0"  ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}				
	}

	function saveManySetupButtonPermissionServlet(obj,id){
		if(obj.checked){ 
			var uri = "<%=request.getContextPath()%>/SaveManySetupButtonPermissionServlet";
			var role = "" ;			
			dataString = "status=view&role=" + id + "&check=1"  ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}else{
			var uri = "<%=request.getContextPath()%>/SaveManySetupButtonPermissionServlet";
			var role = "" ;
			dataString = "status=view&role=" + id + "&check=0"  ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}				
	}

	function saveManyMetabPermissionServlet(obj,id){
		if(obj.checked){ 
			var uri = "<%=request.getContextPath()%>/SaveManyMetabPermissionServlet";
			var role = "" ;			
			dataString = "status=view&role=" + id + "&check=1"  ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}else{
			var uri = "<%=request.getContextPath()%>/SaveManyMetabPermissionServlet";
			var role = "" ;
			dataString = "status=view&role=" + id + "&check=0"  ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}				
	}
	
	function comboBoxchangeFieldPermission(status,id)
	{				
			var uri = "<%=request.getContextPath()%>/SaveFieldPermissionServlet";	
			dataString = "status="+status+"&role=" + id + "&check=1" ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 	
	}	
		
	function saveFieldPermission(obj,id,status)
	{		
		if(obj.checked){ 
			var uri = "<%=request.getContextPath()%>/SaveFieldPermissionServlet";
			var role = "" ;			
			dataString = "status="+status+"&role=" + id + "&check=1" ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}else{
			var uri = "<%=request.getContextPath()%>/SaveFieldPermissionServlet";
			var role = "" ;
			dataString = "status="+status+"&role=" + id + "&check=0" ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}		

	}
	
	

	function savePermission(obj,id){
		if(obj.checked){ 
			var uri = "<%=request.getContextPath()%>/SavePermissionServlet";
			var role = "" ;			
			dataString = "status=view&role=" + id + "&check=1" ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}else{
			var uri = "<%=request.getContextPath()%>/SavePermissionServlet";
			var role = "" ;
			dataString = "status=view&role=" + id + "&check=0" ;
			 
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){					
			   }
			}); 
		}				
	}
<%/*********************************************************************************************/%>
<%/*** start edit responseMessage via jQuery Ajax ***/%>
<%
boolean tiscoErrMsg = com.avalant.feature.ExtendFeature.getInstance().useFeature("TISCO_ERROR_MSG");
boolean prosilverErrMsg = com.avalant.feature.ExtendFeature.getInstance().useFeature("PROSILVER_ERROR_MSG");
if(tiscoErrMsg){
//Tisco Override function fadeInMessage,fadeOutMessage,displayResponseMessage
//include at bottom page
}else if(prosilverErrMsg){
%>
	function fadeInMessage(){
		jQuery("#prosilver_message").fadeIn("fast");
	}
	function fadeOutMessage(){
		jQuery("#prosilver_message").fadeOut("fast");
	}

	function displayResponseMessage(message) {
		var prosilver_message = document.getElementById("prosilver_message");
		if (prosilver_message) {
			jQuery("#prosilver_message").html(" <img id=\"waiting\" src=\"./images/loader/pleaseWaitImage.gif\" width=\"22px\" height=\"22px\" >");
			jQuery("#prosilver_message").css("background","#FFFFD7");
			jQuery("#prosilver_message").css("opacity","0.67");
			jQuery("#prosilver_message").css("filter","alpha(opacity=67)");
		}
	}
<%
}else{
%>
	function fadeInMessage(){
		jQuery("#_messageBlock").fadeIn("fast");
	}
	function fadeOutMessage(){
		jQuery("#_messageBlock").fadeOut("fast");
	}

	function displayResponseMessage(message) {
		var messageBlock = document.getElementById("_messageBlock");
		if (messageBlock) {
				messageBlock.style.display = "block";
				document.getElementById("_messageBlock_message").innerHTML = message;
	
				messageBlock.style.left = ((document.body.clientWidth - messageBlock.offsetWidth) / 2 + document.body.scrollLeft - 120) + "px";
				messageBlock.style.top = ((document.body.clientHeight - messageBlock.offsetHeight) / 2 + document.body.scrollTop - 80) + "px";
				
				var background = document.getElementById("_messageBlock_background");
				background.style.width = messageBlock.offsetWidth + "px";
				background.style.height = messageBlock.offsetHeight + "px";
				
				jQuery("#_messageBlock").css("background","#FFFFD7");
				jQuery("#_messageBlock").css("opacity","0.67");
				jQuery("#_messageBlock").css("filter","alpha(opacity=67)");
	
				jQuery("#_messageBlock_message").css("color","#666666");
		} else {
			alert(message);
		}
	}
<%}%>
<%/*** end edit responseMessage via jQuery Ajax ***/%>
<%/*********************************************************************************************/%>
<%/*********************************************************************************************/%>
<%/*** start edit in line process via jQuery Ajax ***/%>
	function drawElementAjax(idToShow, idToHide, rowID, objType, moduleID, fieldID){
		jQuery("#"+moduleID+"Many").find("[id$='"+objNamingConst["DISPLAY_FIELD"]+"']").attr("disabled", "disabled");
		
		var uri = "<%=request.getContextPath()%>/DrawComponentServlet";
		var dataString = "rowID=" + rowID;
		dataString += "&objType=" + objType;
		dataString += "&moduleID=" + moduleID;
		dataString += "&fieldID=" + fieldID;
		
		if("" != idToShow){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   dataType: "text",
			   async: false,
			   success: function(data){
			   		toggleViewMode();
					jQuery("#" + idToShow).hide();
					jQuery("#" + idToShow).html(data);
					jQuery("#"+moduleID+"Many").find("[id$='"+objNamingConst["DISPLAY_FIELD"]+"']").attr("disabled", "");
					swapElement('<%=request.getContextPath()%>', idToShow, idToHide, rowID, objType, moduleID, fieldID);
			   }
			});
		}
	}
<%/*** end edit in line process via jQuery Ajax ***/%>
<%/*********************************************************************************************/%>	
<%/*********************************************************************************************/%>
<%/*** start condition tab process via jQuery Ajax ***/%>
	function conditionTabAjax(selectbox,mf_id){
		blockScreen();
		divIDToPaint = "miniBlock";
		document.masterForm.action.value = 'conditionTab';
		//document.masterForm.currentTab.value = 'TAB_ID_20121740890';
		document.masterForm.handleForm.value = 'Y';
		//Sam handle jquery-object(checkbox , radio , listbox)
		document.masterForm.conditionValue.value = selectbox.options[selectbox.selectedIndex].value;
		document.masterForm.mfID.value = mf_id;
		closeAllSlideObject();
		var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.master.manual.ConditionTabManual&entitySession=<%=entitySession%>";
		jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: "",
			   async : false,
			   success: function(data){
			   		conditionTabAjaxResponseListener(data);
			   }
		});
	}
	
	function conditionTabAjaxResponseListener(data){
		if(data != "" && data != null){
			var formName = "masterForm";
			var uri = "<%=request.getContextPath()%>/Web2Controller";
			var parameterList = "";
			mapFormHandlerAjax(formName, uri, parameterList, paintModuleTabAjaxResponseListener);
		}
		
		/*if(data != "" && data != null){
			alert(data);
			jQuery("#" + divIDToPaint).html(data);
			alert("complete");
		}*/
	}
	
	function paintModuleTabAjaxResponseListener(data){
		var tabID = document.masterForm.currentTab.value;
		var uri = "<%=request.getContextPath()%>/entity/<%=templateCode%>/downTabManager.jsp";
		var dataString = "";// + tabID;
		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){
			   		//console.log(data);
					jQuery("." + divIDToPaint).hide();
					jQuery("." + divIDToPaint).html(data);
					jQuery("." + divIDToPaint).fadeIn("fast");
					textBoxFocusInvoker();
					initEafTab();
					initGeneralTab();
					unblockScreen();
					
					<% String module = (String)request.getSession().getAttribute("module"); %>
					try {
						<%= module %>manualCondTab();
					} catch (e) {
						// todo: handle exception
					}
					
			   }
			});
		}
	}
<%/*** end condition tab process via jQuery Ajax ***/%>
<%/*********************************************************************************************/%>
<%/*********************************************************************************************/%>
<%/*** start switch tab process via jQuery Ajax ***/%>
	function switchTabAjax(tabID, divID){
		
		blockScreen();
		saveRichText();
		saveModuleMatrix();
		
		divIDToPaint = divID;
		document.masterForm.action.value = 'switchTab';
		document.masterForm.currentTab.value = tabID;
		document.masterForm.handleForm.value = 'Y';
		//Sam handle jquery-object(checkbox , radio , listbox)
		<%
			boolean newSwitchTab = com.avalant.feature.ExtendFeature.getInstance().useFeature("newSwitchTab");
		if(newSwitchTab){
 		%>
		closeAllSlideObject();
		var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.master.manual.SwitchTabManual&entitySession=<%=entitySession%>";
		jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: "",
			   async : false,
			   success: function(data){
			   		switchTabAjaxResponseListener(data);
			   }
		});
		<%}else{%>
			//Issue sometime SwitchCurrentFormServlet not called
			ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>", switchTabAjaxResponseListener);
		
		<%}%>
	}
	
	function switchTabAjaxResponseListener(data){
		if(data != "" && data != null){
			var formName = "masterForm";
			var uri = "<%=hostPrefix%><%=request.getContextPath()%>/Web2Controller";
			var parameterList = "";
			mapFormHandlerAjax(formName, uri, parameterList, paintModuleAjaxResponseListener);
		}
	}



	function paintManyAjaxResponseListener(data){
		var tabID = document.masterForm.currentTab.value;
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=templateCode%>/manyRelation.jsp";
		var dataString = "CURRENT_TAB=" + tabID;
// 		var scrTop = window.top.$('#mainPage').contents().find('body').scrollTop();
		var scrTop = document.documentElement.scrollTop;
		
		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){
					jQuery("#" + divIDToPaint).hide();
					jQuery("#" + divIDToPaint).html(data);
					jQuery("#" + divIDToPaint).fadeIn("fast");
					
					// add for fix scrollTop follow before tab
//  					window.top.$('#mainPage').contents().find('body').scrollTop(scrTop);
// 					document.documentElement.scrollTop = scrTop;
					var scrollMax = document.documentElement.scrollHeight - document.documentElement.clientHeight;
					if(scrTop > scrollMax){
						$('html, body').animate({ scrollTop: scrollMax -1 }, 'fast');
	 					$('html, body').animate({ scrollTop: scrollMax }, 'fast');
					}else{
						$('html, body').animate({ scrollTop: scrTop -1 }, 'fast');
	 					$('html, body').animate({ scrollTop: scrTop }, 'fast');
					}
					
					// start copy src to modify from -> function sortTableSuccess(data) -> in ajaxEventScript
					var tableHeadName = jQuery("[name='"+orderingManyID+"_tableHeadNameFocus']").val();
					var currentColNum = jQuery("[name='"+orderingManyID+"_tableHeadColFocus']").val();
					
					if(tableHeadName != "" && tableHeadName != null){
						if(tableHeadName == "orderASCDivID"){
							jQuery("div").find("[id*=orderASCDivID_]").removeClass('orderASCDiv').addClass('orderASCDivAlt');
							jQuery("div").find("[id*=orderDESCDivID_]").removeClass('orderDESCDiv').addClass('orderDESCDivAlt');
							jQuery("#orderASCDivID_"+currentColNum).removeClass('orderASCDivAlt').addClass('orderASCDiv');
						}else if(tableHeadName == "orderDESCDivID"){
							jQuery("div").find("[id*=orderASCDivID_]").removeClass('orderASCDiv').addClass('orderASCDivAlt');
							jQuery("div").find("[id*=orderDESCDivID_]").removeClass('orderDESCDiv').addClass('orderDESCDivAlt');
							jQuery("#orderDESCDivID_"+currentColNum).removeClass('orderDESCDivAlt').addClass('orderDESCDiv');
						}
					}
					// end copy src to modify from -> function sortTableSuccess(data) -> in ajaxEventScript
					
					<%
					/*
					* FT029_DBPagingMany
					*/
					%>
					<%
					/*
					* EAFManualFunc003
					*/
					%>
					try { EAFManualFunc003(divIDToPaint); } catch(e) {}
					unblockScreen();
			   }
			});
		}
		<%
		/*
		* FT029_DBPagingMany
		*/
		%>
		else
		{
			unblockScreen();
		}
	}

	
	function paintModuleAjaxResponseListener(data){
		var tabID = document.masterForm.currentTab.value;
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=templateCode%>/moduleManager.jsp";
		var dataString = "CURRENT_TAB=" + tabID;
		//var scrTop = window.top.$('#mainPage').contents().find('body').scrollTop();
		var scrTop = document.documentElement.scrollTop;
//  		console.log('scr Top module ='+scrTop);
		
		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){
				   
				   unblockScreen();
				   
					jQuery("#" + divIDToPaint).hide();
					jQuery("#" + divIDToPaint).html(data);
					jQuery("#" + divIDToPaint).fadeIn("fast");
					
					// add for fix scrollTop follow before tab
// 					window.top.$('#mainPage').contents().find('body').scrollTop(scrTop);
					var scrollMax = document.documentElement.scrollHeight - document.documentElement.clientHeight;
					if(scrTop > scrollMax){
						$('html, body').animate({ scrollTop: scrollMax -1 }, 'fast');
	 					$('html, body').animate({ scrollTop: scrollMax }, 'fast');
					}else{
						$('html, body').animate({ scrollTop: scrTop -1 }, 'fast');
	 					$('html, body').animate({ scrollTop: scrTop }, 'fast');
					}
					textBoxFocusInvoker();
					manualSwitchTab();
					initEafTab();
					initGeneralTab();
					
			   }
			});
		}
	}
	
	
	
	function manualSwitchTab() {
	} 
	
	function setCurrentTab(objID){
		jQuery("#"+objID).parent().children('li').removeClass('current');
		jQuery("#"+objID).addClass('current');
		try{
			$("#"+objID).parent().parent().children('li').removeClass('active');
			$("#"+objID).parent().addClass('active');
		}catch(e){}
	}
	
	function setCurrentTabPB1(objID){
		jQuery(".actionbar_2").removeClass('actionbar_2').addClass('actionbar_8');
		jQuery("#"+objID).children('a').removeClass('actionbar_8').addClass('actionbar_2');
		try{
			$("#"+objID).parent().parent().children('li').removeClass('active');
			$("#"+objID).parent().addClass('active');
		}catch(e){}
	}
	
	function setCurrentSpanTab(objID){
		jQuery(".downtab1Current").removeClass('downtab1Current').addClass('downtab1');
		jQuery(".downtab2Current").removeClass('downtab2Current').addClass('downtab2');
		jQuery(".downtab3Current").removeClass('downtab3Current').addClass('downtab3');
		jQuery("#t1_"+objID).removeClass('downtab1').addClass('downtab1Current');
		jQuery("#t2_"+objID).removeClass('downtab2').addClass('downtab2Current');
		jQuery("#t3_"+objID).removeClass('downtab3').addClass('downtab3Current');
		jQuery(".textontab").removeClass('textontab').addClass('textontab3');
		jQuery("#"+objID).removeClass('textontab3').addClass('textontab');
		try{
			$("#"+objID).parent().parent().children('li').removeClass('active');
			$("#"+objID).parent().addClass('active');
		}catch(e){}
	}
	
	function setCurrentSpanGeneralTab(objID){
		jQuery(".tabno1Current").removeClass('tabno1Current').addClass('tabno1');
		jQuery(".tabno2Current").removeClass('tabno2Current').addClass('tabno2');
		jQuery(".tabno3Current").removeClass('tabno3Current').addClass('tabno3');
		jQuery("#t1_"+objID).removeClass('tabno1').addClass('tabno1Current');
		jQuery("#t2_"+objID).removeClass('tabno2').addClass('tabno2Current');
		jQuery("#t3_"+objID).removeClass('tabno3').addClass('tabno3Current');
		jQuery(".textontabGeneral").removeClass('textontabGeneral').addClass('textontab2');
		jQuery("#"+objID).removeClass('textontab2').addClass('textontabGeneral');
		try{
			$("#"+objID).parent().parent().children('li').removeClass('active');
			$("#"+objID).parent().addClass('active');
		}catch(e){}
	}
	
<%/*** end switch tab process via jQuery Ajax ***/%>
<%/*********************************************************************************************/%>
<%/*********************************************************************************************/%>
<%/*** start server-side table sorting via jQuery Ajax ***/%>
	var currentColNum = "";
	var tableHeadName = "";
	
	// 2 methods called in case of exists
	// validateSortTable
	// sortTableAjaxManualAction
	function sortTableAjax(headName, colNum, columnName, orderType, divID){
		try{
			// for manual validate before sorting
			if(!validateSortTable()){
				return;
			}
		}catch(e){}
		
		currentColNum = colNum;
		tableHeadName = headName;
		divIDToPaint = divID;
		window.document.masterForm.action.value = "searchEntity";
		window.document.masterForm.handleForm.value = "Y";
		document.masterForm.orderBy.value = columnName;
		document.masterForm.orderByType.value = orderType;
		//document.masterForm.page.value = "1";
		
		try{
			// for manual webAction before sorting
			sortTableAjaxManualAction();
		}catch(e){}
	
		var formName = "masterForm";
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/Web2Controller";
		var parameterList = "";
		mapFormHandlerAjax(formName, uri, parameterList, sortTableAjaxResponseListener);
	}
	
	function sortTableAjaxResponseListener(data){
		<%
		ModuleActionM moduleActionM = MasterUtil.getInstance()
		.getModuleActionFromModuleActions(entityM.getEntityActions(), MasterConstant.PROCESS_MODE_SEARCH);
		String uri = "";
		/*
		* 25-02-2014 :: 
		* FIX : CAN'T SORT TABLE WITH MANUAL JSP EXTENDED
		*/
		//if (null != moduleActionM && null != moduleActionM.getFilePath() && !"".equals(moduleActionM.getFilePath())) {
		if (null != moduleActionM && null != moduleActionM.getSearchFilePath() && !"".equals(moduleActionM.getSearchFilePath())) {
			String filePath = moduleActionM.getFilePath();
			String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
			String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
			uri = hostPrefix + request.getContextPath() + manualUrlPath;
		} else {
			uri = hostPrefix + request.getContextPath() + "/entity/" + templateCode + "/resultSearch.jsp";
		}
		%>
		var uri = "<%=uri%>";
		//var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=templateCode%>/resultSearch.jsp";
		var dataString = "";
		if("" != divIDToPaint){
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success:sortTableSuccess 
			});
		}
	}

	function sortTableSuccess(data) {
		jQuery("#" + divIDToPaint).hide();
		jQuery("#" + divIDToPaint).html(data);
/*
		if(tableHeadName != "" && tableHeadName != null){
			if(tableHeadName == "orderASCDivID"){
				jQuery("div").find("[id*=orderASCDivID_]").removeClass('orderASCDivAlt');
				jQuery("#orderASCDivID_"+currentColNum).addClass('orderASCDivAlt');
			}else if(tableHeadName == "orderDESCDivID"){
				jQuery("div").find("[id*=orderDESCDivID_]").removeClass('orderDESCDivAlt');
				jQuery("#orderDESCDivID_"+currentColNum).addClass('orderDESCDivAlt');
			}
		}
*/

//----- the code below used for theme 005 TISCO
 
 
		if(tableHeadName != "" && tableHeadName != null){
			if(tableHeadName == "orderASCDivID"){
				jQuery("div").find("[id*=orderASCDivID_]").removeClass('orderASCDiv').addClass('orderASCDivAlt');
				jQuery("div").find("[id*=orderDESCDivID_]").removeClass('orderDESCDiv').addClass('orderDESCDivAlt');
				jQuery("#orderASCDivID_"+currentColNum).removeClass('orderASCDivAlt').addClass('orderASCDiv');
			}else if(tableHeadName == "orderDESCDivID"){
				jQuery("div").find("[id*=orderASCDivID_]").removeClass('orderASCDiv').addClass('orderASCDivAlt');
				jQuery("div").find("[id*=orderDESCDivID_]").removeClass('orderDESCDiv').addClass('orderDESCDivAlt');
				jQuery("#orderDESCDivID_"+currentColNum).removeClass('orderDESCDivAlt').addClass('orderDESCDiv');
			}
		}	

		jQuery("#" + divIDToPaint).slideDown("fast");
	}
	
<%/*** end server-side table sorting via jQuery Ajax ***/%>
<%/*********************************************************************************************/%>
<%/*********************************************************************************************/%>
<%/*** start call servlet via jQuery Ajax ***/%>
	function mapFormHandlerAjax(formName, uri, parameterList, responseListener){
		/* submit form with ajax (no page refresh) */
		var dataString = "entitySession=<%=entitySession%>";
		if("" != formName){
			//dataString += sweepAjaxForm(formName);
			$('select[id$="_R"] option').attr('selected', 'true');
			dataString += '&'+jQuery("form[name='"+formName+"']").serialize();
		}
		if("" != parameterList){
			dataString += parameterList;
		}

		
		
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: responseListener
		});
	}

	function sweepAjaxForm(formName) {
		$('select[id$="_R"] option').attr('selected', 'true');
		var arrayElement = jQuery("form[name='"+formName+"']").map(function(){
			return jQuery.makeArray(this.elements);
		});
		var formParameter = "";
		for(var i=0; i<arrayElement.length; i++){
			/*
			* 19-02-2015
			* CPB : Defect ST000000000888
			*/
			//if(arrayElement[i].type.toUpperCase() != "BUTTON"){
			if(arrayElement[i].type.toUpperCase() != "BUTTON"  && !$(arrayElement[i]).hasClass('many-module-hidden-field')){
				if(arrayElement[i].type.toUpperCase() == "CHECKBOX" || arrayElement[i].type.toUpperCase() == "RADIO"){
					if(arrayElement[i].checked){
						formParameter += "&" + arrayElement[i].name + "=" + encodeURIComponent(arrayElement[i].value);
					}
				}else{
					formParameter += "&" + arrayElement[i].name + "=" + encodeURIComponent(arrayElement[i].value);
				}
			}
		}
		return formParameter;
	}
	function deleteAjaxImage(objName,i){				
		alert(document.getElementById(objName).childNodes[i].childNodes[2].value);
		var uri = "<%=request.getContextPath()%>/UploadServlet";			
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: "action=delete&indexRow="+i+"&filename="+document.getElementById(objName).childNodes[i].childNodes[2].value ,
		   async: false,
		   success: function(data){		   		
				document.getElementById(objName).removeChild(document.getElementById(objName).childNodes[i]);
		   }
		});
	}

	function ajaxWorkflowAction(buttonId)
	{
		$('#_b_id').val(buttonId);
		
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/ajax/workflow/button/call?" + jQuery("form[name='masterForm']").serialize();

		blockScreen();
		
		jQuery.ajax({
			type: "POST",
			url: uri,
			data: {
				"handleForm" : "Y",
				"buttonId" : buttonId
			},
			success: function(data) {
				unblockScreen();
			}
		});
	}
	
		
<%/*** end call servlet via jQuery Ajax ***/%>
<%/*********************************************************************************************/%>
--></script>
<taglib:if value="<%=tiscoErrMsg%>">
<script language="javascript" src="<%=request.getContextPath()%>/manual/js/tisco/errorMessage.js"></script>
</taglib:if>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>

<%
	String entityID = (String)request.getSession().getAttribute("entityIDForList");
	String moduleMain = (String)request.getSession().getAttribute("moduleIDForAction");
	String entitySession = entityID +"_session";
	System.out.println("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	String moduleSession = form.getMainModuleID() +"_session";
	MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
	if (MasterForm == null) {
		MasterForm = new MasterFormHandler();
		request.getSession().setAttribute(moduleSession,MasterForm);
	}
	Vector vSearchCriteria = MasterForm.getVMasterModelMs();	
	String templateCode = form.getEntityM().getTemplateCode();
	if(templateCode.equals("PB1")){
		templateCode = "ProfesionalBlue_01";
	}else if(templateCode.equals("PS1")){
		templateCode = "ProSilver";
	}
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.master.model.ModuleFieldM"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="java.util.Vector"%>
<script type="text/javascript">
	function loadForUpdate(str, rowNum) {
		window.location = "<%=request.getContextPath()%>/FrontController?action=loadUpdateEntity&entityID=<%=form.getEntityM().getEntityID()%>&tabID=<%=form.getCurrentTab()%>&"+str;
	}	
	
	function changePageAndSize(pageNum) {
		window.document.masterForm.action.value = "loadListMany";
		window.document.masterForm.handleForm.value = "Y";
		window.document.masterForm.volumePerPage.value = window.document.masterForm.selectPerPage.value;
		window.document.masterForm.page.value = pageNum;
		window.document.masterForm.submit();
	}
	
	function searchResult() {
		window.document.masterForm.action.value = "loadListMany";
		window.document.masterForm.handleForm.value = "Y";
		document.masterForm.orderBy.value = "";			
		document.masterForm.orderByType.value = "";	
		document.masterForm.page.value = "1";
		window.document.masterForm.submit();
	}
	
	function resetSearchCriteria() {
	<%
		
		if (vSearchCriteria != null && vSearchCriteria.size() > 0) {
			for (int i = 0; i < vSearchCriteria.size();i++) {
				ModuleFieldM prmModuleFieldM =  (ModuleFieldM)vSearchCriteria.get(i);	
				if (prmModuleFieldM.isSearchFromTo()) {
	%>
					$("[name='FROM_<%=prmModuleFieldM.getFieldID()%>']").val("");
					$("[name='TO_<%=prmModuleFieldM.getFieldID()%>']").val("");
<%				} else {
%>					
					$("[name='<%=prmModuleFieldM.getFieldID()%>']").val("");
<%					
				}
				
				if(MasterConstant.POPUP.equalsIgnoreCase(prmModuleFieldM.getObjType())) {
%>					
					$("[name='<%=prmModuleFieldM.getFieldID()%>']").val("");
					$("[name='<%=prmModuleFieldM.getFieldID()%>_DESC']").val("");
<%	
				}
			}	
		}
		%>
	}
    
	function actionFormSubmit(strAction,strHandleForm) {
		document.masterForm.action.value = strAction;
		document.masterForm.handleForm.value = strHandleForm;
		document.masterForm.submit();
	}
	
	function actionOrderBy(strAction,strHandleForm,strOrderBy) {
		var orderType = document.masterForm.orderByType.value;
		if (orderType == 'asc') {
			document.masterForm.orderByType.value = 'desc';	
		} else {
			document.masterForm.orderByType.value = 'asc';	
		}		

		document.masterForm.action.value = strAction;
		document.masterForm.handleForm.value = strHandleForm;		
		document.masterForm.orderBy.value = strOrderBy;	
		
		document.masterForm.submit();
	}	
					        
	
	function checkAllList() {
		var num = document.masterForm.deleteRow.length;
		if (document.masterForm.deleteAll.checked) {
			for (i=0;i< num;i++) {
				document.masterForm.deleteRow[i].checked = true;
			}	
		} else {
			for (i=0;i< num;i++) {
				document.masterForm.deleteRow[i].checked = false;
			}
		}	
	}
	
	function addRecord(index,module,allSize) {
		var isValidatePass = true;
		try {
			isValidatePass = manualValidateListMany(index,module,allSize);
		} catch (e) { }
		if(!isValidatePass){
			return;
		}
		
		var uri = "<%=request.getContextPath()%>/ProcessManyListServlet?index="+index+"&module="+module;
		jQuery.ajax({
			type: "POST",
			url: uri,
			success: function(data) {
				if (index == 'All') {
					for (i=0;i< allSize;i++) {
						try{
							objButton = window.masterForm.document.getElementById("select_"+i);
							//objButton.innerHTML = "<input type=\"button\" name=\"select\" value=\"+\" class=\"button_style_1\" disabled = \"true\" >"; 
							objButton.innerHTML = "";
						}catch(e){
						}
					}	
				} else { 
					objButton = window.masterForm.document.getElementById("select_"+index);
					//objButton.innerHTML = "<input type=\"button\" name=\"select\" value=\"+\" class=\"button_style_1\" disabled = \"true\" >";
					objButton.innerHTML = "";
				}
				createRow(data);
			} 								
		});	
	}

	function createRow(data,index) { 									
		try { 
			jQuery.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/entity/<%=templateCode%>/manyRelation.jsp",
				success: function(data){					
					window.opener.document.getElementById ('<%=moduleMain%>MG').innerHTML = data;
					
					try {
						window.opener.<%=moduleMain%>manualJS();
					} catch(e) {
					}						
					windowFocus();
				}
			});
		} catch(e) {
			alert(e);
		}
	}

	function closeWindow() { 									
		window.close();
	}

//-----------------------------------Set current entity-------------------------------
	
	
	function windowFocus(){				
		var dataString = "entityIDForList=<%=entityID%>&currentForm=<%=form.getMainModuleID()%>_session&currentScreen=SEARCHENTITY_SCREEN";										
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
	
	window.onfocus = windowFocus;
	window.onblur = windowFocus;

	windowFocus();
//------------------------------------------------------------------------------------------
		
	//Sam add for ManyList Tab
	function cancelEntity() {
		blockScreen();
		ajax("<%=request.getContextPath()%>/SwitchCurrentFormServlet?entitySession=<%=entitySession%>",<%=entityID%>CancelForm); 			
	}
	function <%=entityID%>CancelForm(data) {
		document.masterForm.sessionForm.value = data;
		document.masterForm.action.value = 'cancelEntity';
		document.masterForm.handleForm.value = 'N';
		document.masterForm.submit();
	}
	function addRecordOnTab(index,module,allSize) {		 	 	
		var uri = "<%=request.getContextPath()%>/ProcessManyListServlet?index="+index+"&module="+module;
		jQuery.ajax({
			type: "POST",
			url: uri,
			success: function(data) {
				if (index == 'All') {
					for (i=0;i< allSize;i++) {
						try{
						objButton = window.masterForm.document.getElementById("select_"+i);
						//objButton.innerHTML = "<input type=\"button\" name=\"select\" value=\"+\" class=\"button_style_1\" disabled = \"true\" >"; 
						objButton.innerHTML = "";
						}catch(e){}
					}	
				} else { 
					objButton = window.masterForm.document.getElementById("select_"+index);
					//objButton.innerHTML = "<input type=\"button\" name=\"select\" value=\"+\" class=\"button_style_1\" disabled = \"true\" >";
					objButton.innerHTML = "";
				}
				//createRow(data);
				addRecordOnTabManual();
			} 								
		});	
	}
<%/*** start edit responseMessage via jQuery Ajax ***/%>
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

			//var left   = (screen.width  - 950)/2;
	 		//var top    = (screen.height - 500)/2;
/*
			alert("client W -> " + document.body.clientWidth + "\n"
				+ "client H -> " + document.body.clientHeight + "\n"
				+ "block offset W -> " + messageBlock.offsetWidth + "\n"
				+ "block offset H -> " + messageBlock.offsetHeight + "\n"
				+ "scrollLeft -> " + document.body.scrollLeft + "\n"
				+ "scrollTop -> " + document.body.scrollTop + "\n"
				+ "screen.width -> " + screen.width/2 + "\n"
				+ "screen.height -> " + screen.height/2 + "\n"
			);
*/
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
<%/*** end edit responseMessage via jQuery Ajax ***/%>
</script>
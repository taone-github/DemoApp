<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>

<%
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	String moduleMain = form.getMainModuleID();
	String templateCode = form.getEntityM().getTemplateCode();

%>

<script language="javascript">
	function loadForUpdate(str, rowNum) {
		window.location = "<%=request.getContextPath()%>/FrontController?action=loadUpdateEntity&entityID=<%=form.getEntityM().getEntityID()%>&tabID=<%=form.getCurrentTab()%>&"+str;
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

	function addRecord(index,module) {	
		ajax("<%=request.getContextPath()%>/ProcessManyListServlet?index="+index+"&module="+module,createRow); 	
		objButton = window.masterForm.document.getElementById("select_"+index);
		objButton.innerHTML = "";
	}

	function createRow(data) { 									
		try {
			jQuery.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/entity/<%=templateCode%>/listManyRelation.jsp",
				success: function(data){
					var htmlInDiv = jQuery(data).find("#<%=moduleMain%>Many").html();
					window.opener.jQuery("#<%=moduleMain%>Many").hide();
					window.opener.jQuery("#<%=moduleMain%>Many").html(htmlInDiv);
					window.opener.jQuery("#<%=moduleMain%>Many").fadeIn("fast");
				}
			});
		} catch(e) {
			alert(e);
		}
	}

	function closeWindow() { 									
		window.close();
	}

</script>
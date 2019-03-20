<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.util.MasterConstant"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.model.EntityTabM"%>

<%
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
	
	
	String userName = (String)request.getSession().getAttribute("userName");
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String template = form.getEntityM().getTemplateCode();	
	EntityTabM prmEntityTabM = MasterUtil.getMainTabID(form.getEntityM().getEntityTabs());
	String tabMain = prmEntityTabM.getTabID();
%>


<script type="text/javascript">
		
	function changePageAndSize(pageNum) {		
		window.document.masterForm.volumePerPage.value = window.document.masterForm.selectPerPage.value;
		window.document.masterForm.page.value = pageNum;
		/* submit form with ajax (no page refresh) */
		
		var dataString = "action=loadListExistData&handleForm=N";
		dataString += sweepAjaxForm("masterForm");		
		var uri = "<%=hostPrefix%><%=request.getContextPath()%>/Web2Controller";
		jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: dataString,
		   success: function(data){
				<%=entityID%>redirectListExistDataScreen(data);
		   }
		});
	}

		function <%=entityID%>redirectListExistDataScreen(data){			
			var uri = "<%=hostPrefix%><%=request.getContextPath()%>/entity/<%=template%>/listExistData.jsp";
			var dataString = "";
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){
					jQuery("#moduleContainer").hide();
					jQuery("#moduleContainer").html(data);
					jQuery("#moduleContainer").fadeIn("slow");
			   }
			});
		}		
		
		function sweepAjaxForm(formName){
			var arrayElement = jQuery("form[name='"+formName+"']").map(function(){
				return jQuery.makeArray(this.elements);
			});
			var formParameter = "";
			for(var i=0; i<arrayElement.length; i++){
				if(arrayElement[i].type.toUpperCase() != "BUTTON"){
					formParameter += "&" + arrayElement[i].name + "=" + encodeURIComponent(arrayElement[i].value);					
				}
			}
			return formParameter;
		}

		function forCloneData(keydata) {								
						
			var dataString = "action=copyExistDataToMain&entityID=<%=entityID%>&tabID=<%=tabMain%>&"+keydata;				
			var uri = "<%=hostPrefix%><%=request.getContextPath()%>/Web2Controller";
			jQuery.ajax({
			   type: "POST",
			   url: uri,
			   data: dataString,
			   success: function(data){				   
				   window.opener.forwordToParent(data);				   					
				   window.close();
			   }			   
			});
			
		}

				
				
	
</script>
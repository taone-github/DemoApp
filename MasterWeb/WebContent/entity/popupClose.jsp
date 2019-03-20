<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>

<%
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	System.out.println("entitySession==>"+entitySession);
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	String themeCode = form.getEntityM().getThemeCode();
	String module = (String)request.getSession().getAttribute("module");
	if ("PB1".equalsIgnoreCase(themeCode)) { 
		themeCode = "ProfesionalBlue_01";
	}else if ("PS1".equalsIgnoreCase(themeCode)) {
		themeCode = "ProSilver";
	}
%>	

<script language="javascript">
	ajax("<%=request.getContextPath()%>/ProcessManyRowServlet?module=<%=module%>&process=<%=com.master.util.MasterConstant.PROCESS_MODE_INSERT%>",<%=module%>CreateRow); 			
		
	function <%=module%>CreateRow(data) {
		try {
			jQuery.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/entity/<%=themeCode%>/manyRelation.jsp",
				success: function(data) {										
					window.opener.jQuery("#" + "<%=module%>MG").hide();
					window.opener.jQuery("#" + "<%=module%>MG").html(data);
					window.opener.jQuery("#" + "<%=module%>MG").fadeIn("fast");					
					try {
						window.opener.<%=module%>manualJS();
					} catch(e) {
					}						
					window.close();															
				}
			});
		} catch(e) {
			alert(e);
		}
	}	
	
</script>
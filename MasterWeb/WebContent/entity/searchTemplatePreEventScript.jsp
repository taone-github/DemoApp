<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.util.MasterConstant"%>

<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	String searchForUpdate = (String)request.getSession().getAttribute(entityID+"searchForUpdate");
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	
%>

<script language="javascript">
	<%/* start search function */%>
		
	function loadForUpdate(str, rowNum) {
		blockScreen();
		windowFocus();
		window.location = "<%=request.getContextPath()%>/FrontController?action=loadUpdateEntity&entityID=<%=form.getEntityM().getEntityID()%>&tabID=<%=form.getCurrentTab()%>&"+str;
	}	
		
</script>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.oneweb.j2ee.pattern.control.ScreenDefinition" %>
<%@page import="com.front.constant.FrontMenuConstant"%>
<jsp:useBean id="screenFlowManager" class="com.front.j2ee.pattern.control.FrontScreenFlowManager" scope="session"/>
<%
    ScreenDefinition sd = (ScreenDefinition) LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getScreenDefinitionMap().get(screenFlowManager.getCurrentScreen());
    System.out.println(">> "+LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getScreenDefinitionMap());
    System.out.println("screnn flow manager "+screenFlowManager.getCurrentScreen());
    System.out.println("sd is"+ sd);
    pageContext.getRequest().setAttribute("HtmlTitle", sd.getHtmlTitle());
	pageContext.getRequest().setAttribute("TopNav", sd.getTopNav());
	pageContext.getRequest().setAttribute("SubHeader", sd.getSubHeader());
	pageContext.getRequest().setAttribute("TopMenu", sd.getTopMenu());
	pageContext.getRequest().setAttribute("HtmlBody", sd.getHtmlBody());	
	pageContext.getRequest().setAttribute("CopyRight", sd.getCopyRight());
	pageContext.getRequest().setAttribute("LeftNav", sd.getLeftNav());
	pageContext.getRequest().setAttribute("ContentHeader", sd.getContentHeader());
	pageContext.getRequest().setAttribute("BottomNav", sd.getBottomNav());
	
	if(screenFlowManager.getCurrentScreenTemplate()==null || "".equals(screenFlowManager.getCurrentScreenTemplate())){
		pageContext.getRequest().setAttribute("ScreenTemplate", "screen_template/default/default.jsp");
	}else{
		pageContext.getRequest().setAttribute("ScreenTemplate", screenFlowManager.getCurrentScreenTemplate());
	}
%>  
                
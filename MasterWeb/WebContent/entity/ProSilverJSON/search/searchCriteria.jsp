<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.avalant.display.SearchDisplay"%>
<div class="paddingmother">
<div class="topictextbig"><%=SearchDisplay.getInstance().getEntityName(request)%></div>
<div class="boxboldbelow">
<%=SearchDisplay.getInstance().getSearchCriteriaBox(request)%>
</div>
</div>
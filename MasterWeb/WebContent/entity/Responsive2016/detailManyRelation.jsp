<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.eaf40.utils.StringUtils"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.model.ModuleM"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<%
String module = (String)request.getSession().getAttribute("module");
if(request.getParameter("requestModule") != null) {
	module = request.getParameter("requestModule");
}

MasterFormHandler masterForm = EAFManualUtil.getModuleForm(request, module);
ModuleM moduleM = masterForm.getModuleM();
String showListLayout = moduleM.getShowListLayout();
if(StringUtils.isEmpty(showListLayout)) {
	showListLayout = MasterConstant.SHOW_LIST_LAYOUT.GRID;
}

String jsp = "detailManyRelation_" + showListLayout + ".jsp";

%>

<jsp:include flush="true" page="<%=jsp %>"/>
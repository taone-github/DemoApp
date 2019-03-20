<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.eaf40.utils.StringUtils"%>
<%@page import="com.master.model.ModuleM"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%
EntityFormHandler form = EAFManualUtil.getEntityForm(request);
MasterFormHandler masterForm = EAFManualUtil.getModuleForm(request, form.getMainModuleID());

ModuleM moduleM = masterForm.getModuleM();
String showListLayout = moduleM.getShowListLayout();
if(StringUtils.isEmpty(showListLayout)) {
	showListLayout = MasterConstant.SHOW_LIST_LAYOUT.GRID;
}

String jsp = "resultDefault_" + showListLayout + ".jsp";
%>

<jsp:include flush="true" page="<%=jsp %>"/>
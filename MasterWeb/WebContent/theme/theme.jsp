
<%@page import="com.master.util.MasterConstant"%>
<%@page import="java.util.Date"%>
<%@page import="com.master.util.MasterCacheUtil"%>
<link rel="stylesheet" href="theme/init_Style.css?v=<%=MasterCacheUtil.time %>" type="text/css" />

<% 
	String themeCode = request.getParameter("themeCode");
	String themeFile = themeCode;
	if(themeCode.equals("PB1")){
		themeFile = "ProfesionalBlue_01";
	}else if(themeCode.equals("PS1")){
		themeFile = "ProSilver";
	}else if(themeCode.equals("AST")){
		themeFile = "Asset";
	}
	String mainStyle = request.getContextPath() + "/theme/" + themeFile + "/" + themeCode + "_Style.css?v=" +MasterCacheUtil.time;
	String navigationStyle = request.getContextPath() + "/theme/" + themeFile + "/" + themeCode + "_Navigation_Style.css?v=" +MasterCacheUtil.time;
	String customStyle = request.getContextPath() + "/theme/" + themeFile + "/" + themeCode + "_Custom_Style.css?v=" +MasterCacheUtil.time;
%>

<%if(null != themeCode && !"".equals(themeCode)){ %>
	<link rel="stylesheet" href="<%=mainStyle%>" type="text/css" />
	<link rel="stylesheet" href="<%=navigationStyle%>" type="text/css" />
	<link rel="stylesheet" href="<%=customStyle%>" type="text/css" />
<%} %>

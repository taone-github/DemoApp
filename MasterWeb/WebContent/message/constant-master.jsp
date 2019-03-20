<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%>
<%@page import="com.avalant.feature.FT040_MultiLang"%>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<script type="text/javascript">
var decimalMsgErr = '<%=MessageResourceUtil.getTextDescription(request, "WORDING.DECIMAL_MESSAGE_ERROR") %>';
var intMsgErr = '<%=MessageResourceUtil.getTextDescription(request, "WORDING.INT_MESSAGE_ERROR") %>';
var moneyMsgErr = '<%=MessageResourceUtil.getTextDescription(request, "WORDING.MONEY_MESSAGE_ERROR") %>';

<%
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * FIX : 201802071035 : displaying message in session timeout popup multiple language
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
FT040_MultiLang FT040 = FT040_MultiLang.getInstance();
%>
var ONEWEB_SYSTEM_MSG = {
	BEFORE_SESSION_TIMEOUT : '<%=StringEscapeUtils.escapeEcmaScript(FT040.displaysystemMessage("WORDING.BEFORE_SESSION_TIMEOUT", "Session will expire in <span id=timer>${1}</span> seconds.", request)) %>',
	EXTEND_SESSION_TIMEOUT : '<%=StringEscapeUtils.escapeEcmaScript(FT040.displaysystemMessage("WORDING.EXTEND_SESSION_TIMEOUT", "Stay Logged In", request)) %>',
	SESSION_EXPIRED : '<%=StringEscapeUtils.escapeEcmaScript(FT040.displaysystemMessage("WORDING.SESSION_EXPIRED", "Session has expired.", request)) %>',
	<%
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * FIX : 201802151405 : when chage language then redirect current page to first page of current menu
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	%>
	CONFIRM_CHANGE_LANG : '<%=StringEscapeUtils.escapeEcmaScript(FT040.displaysystemMessage("WORDING.CONFIRM_CHANGE_LANG", "This operation will reload the page, the changes you made will be lost.\nAre you sure you want to change language?.", request)) %>'
}

var switch_lang_action = '<%=((com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("SWITCH_LANG_ACTION") == null) ? "MENU" : com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("SWITCH_LANG_ACTION")) %>';

</script>
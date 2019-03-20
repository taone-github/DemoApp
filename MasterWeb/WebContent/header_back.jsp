<%@ page contentType="text/html;charset=TIS620"%>
<%@ page import="java.util.Locale"%>
<%@ taglib uri="/WEB-INF/tld/JStartTagLib.tld" prefix="taglib"%>
<%String language = "T";
            Locale locale = (Locale) session.getAttribute("LOCALE");
            if (locale != null) {
                if (locale.getLanguage().equals(new Locale("th", "TH").getLanguage())) {
                    language = "T";
                } else {
                    language = "E";
                }
            }

            %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td bgcolor="FFFFFF">
		<div align="right">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="80%"></td>
				<td width="20%">
				<div align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="right"><a href="FrontController?action=SWITCH_ENG_LANGUAGE"> <%if (language.equalsIgnoreCase("E")) {%> <img src="images/flag_eng.gif" width="38" height="18" border="0" alt=""> <%} else {%> <img src="images/flag_eng_dis.gif" width="38" height="18" border="0" alt=""> <%}

            %> </a></td>
						<td>&nbsp;&nbsp;</td>
						<td align="right"><a href="FrontController?action=SWITCH_THAI_LANGUAGE"> <%if (language.equalsIgnoreCase("T")) {%> <img src="images/flag_th.gif" width="35" height="18" border="0" alt=""> <%} else {%> <img src="images/flag_th_dis.gif" width="35" height="18" border="0" alt=""> <%}

        %> </a></td>
						<td align="right"></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>

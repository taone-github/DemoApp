<%@page import="com.master.form.MasterFormHandler"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.avalant.display.SearchDisplay"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="java.util.Vector" %>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	System.out.println("=== Div Theme searchEntity");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
%>
<form name ="masterForm" action="FrontController"  method="post" >
<input type ="hidden" name = "action" value="searchEntity">
<input type ="hidden" name = "handleForm" value = "Y">
<input type ="hidden" name = "param1" value = "Y">
<div id="content" class="row">
<div class="rightcontent twelve column center">
	<!-- <div class="spacetop">Top 10 px</div> -->
	<!-- <DIV class="bgtabrightmenu2 twelve column"> -->
	<DIV class="bgtab-menu row">
			<!-- <DIV class="tabend5"></DIV> -->
			<!-- <DIV class="taballs2 twelve column"> -->
			
			<div class="hederTabSearchLeft">
				<div class="hederTabSearchRight">
					<DIV class="hederTabSearchCenter textontab10">
						<%=SearchDisplay.getInstance().getEntityName(request)%>
					</DIV>
				</div>
			</div>	
				
			<!-- </DIV>start Main tab--><!--Tab1
			<!-- <DIV class="mothertab2">
				<DIV class="tabsearch1"></DIV>
			</DIV> -->
			<!--EndTab1-->
		<!--End Main Tab-->
	</DIV>
	<div class="bgtabtop row">
			<div class="content-top twelve column">
				<div id="<%=entityID%>Error" >
				<%if (form.hasErrors()) {%>
					<table cellspacing="0" cellpadding="0" align ="center" width="100%" >
						<tr>
							<td>
				<%
						Vector v = form.getFormErrors();
						for (int s = 0; s < v.size(); s++) {
							out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
						}
				%>
							</td>
						</tr>
					</table>
				<%} %>
				</div>
				<div class="content-center-search row">
					<!-- <div class="content-left"></div> -->
					<div class="content-all row twelve">
						<div id="<%=entityID%>_searchCriteria" class="searchCriteriaContainer row ">
							<%=SearchDisplay.getInstance().getSearchCriteriaBox(request)%>
							<div class="clear-all"><!-- Start searchbtn and reset --></div>
						</div>
						<div class="btn-content column twelve">
							<div class="btnzone row twelve">
								<%
									String buttonTag = com.master.button.DisplayButton.displayDivButton(request,entityID,"ENTITY_SEARCH");
								%>
								<%=buttonTag%>
							</div>
						</div>
					</div>
					<div class="content-right"></div>
				</div>
				<style type="text/css">
				<%=MasterUtil.generateCustomStyleByRequest(request) %>
				</style><span style="display:none">&nbsp;</span>
				<div class="content-down">
					<div class="content-center2">
						<div class="content-left2"></div>
						<div class="content-all2">
							<div class="whiteboxResultSearch">
									<div id="<%=entityID %>_resultSearchContainer" class="searchResultTable">
										<%
										String resultPage = SearchDisplay.getInstance().getResultPage(request,pageContext);
										%>
										 <jsp:include flush="true" page="<%=resultPage%>"/>
									</div>
							</div>
						</div>
						<div class="content-right2"></div>
					</div>
				</div>
			</div>
	</div>
</div>
</div>
<div id="search_dialog">
</div>
</form>
<script type="text/javascript">
$(document).ready( function() {
	$('#search_dialog').dialog({
		autoOpen: false,
		height: 500,
		width: 750,
		modal: true,
		title: 'Service'
	});
});
</script>

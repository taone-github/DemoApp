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

<div id="content" class="content seart-con">
<!-- 	<section class="content-header"><h1> -->
<!-- 	</h1></section> -->
<div class="rightcontent panel panel-default">
	<div class="panel-headline seart-hide"></div>
    <div class="seart-page"> <!--panel-subheading02  -->
		<div class="seart-sub"><%=SearchDisplay.getInstance().getEntityName(request)%></div> <!-- subheading  -->
	</div>
	
	<!-- <div class="spacetop">Top 10 px</div> -->
	<!-- <DIV class="bgtabrightmenu2 twelve column"> -->
<!-- 	<DIV class="bgtab-menu"> -->
			<!-- <DIV class="tabend5"></DIV> -->
			<!-- <DIV class="taballs2 twelve column"> -->
			
<!-- 			<div class="hederTabSearchLeft"> -->
<!-- 				<div class="hederTabSearchRight"> -->
<!-- 					<DIV class="hederTabSearchCenter textontab10"> -->
<%-- 						<%=SearchDisplay.getInstance().getEntityName(request)%> --%>
<!-- 					</DIV> -->
<!-- 				</div> -->
<!-- 			</div>	 -->
			
			<!-- </DIV>start Main tab--><!--Tab1
			<!-- <DIV class="mothertab2">
				<DIV class="tabsearch1"></DIV>
			</DIV> -->
			<!--EndTab1-->
		<!--End Main Tab-->
<!-- 	</DIV> -->
	<div class="bgtabtop page-padding">
		<div class="panel-input">
			<div class="content-top">
				<div id="<%=entityID%>Error" >
				<%if (form.hasErrors()) {%>
					<div class="row form-horizontal">
						<div class="col-xs-12 col-sm-12">
				<%
						Vector v = form.getFormErrors();
						for (int s = 0; s < v.size(); s++) {
							out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
						}
				%>
						</div>
					</div>
				<%} %>
				</div>
				<div class="content-center-search form-group-sm">
					<!-- <div class="content-left"></div> -->
<!-- 					<div class="row"> -->
						<div id="<%=entityID%>_searchCriteria" class="searchCriteriaContainer">
							<%=SearchDisplay.getInstance().getResponsiveSearchCriteriaBox(request)%>
							<div class="clear-fix"><!-- Start searchbtn and reset --></div>
						</div>
						<div class="wrap-topbtn">
<!-- 							<div class="btnzone btn-group"> -->
								<%
									String buttonTag = com.master.button.DisplayButton.displayResponsiveDivButton(request,entityID,"ENTITY_SEARCH");
								%>
								<%=buttonTag%>
<!-- 							</div> -->
						</div>
<!-- 					</div> -->
<!-- 					<div class="content-right"></div> -->
				</div>
				<br>
				<style type="text/css">
				<%=MasterUtil.generateCustomStyleByRequest(request) %>
				</style><span style="display:none">&nbsp;</span>
				<div class="content-down col-sm-12 col-xs-12">
<!-- 					<div class="content-center2"> -->
<!-- 						<div class="content-left2 col-sm-1 col-xs-1"></div> -->
<!-- 						<div class="content-all2 col-sm-10 col-xs-10"> -->
							<div class="whiteboxResultSearch">
									<div id="<%=entityID %>_resultSearchContainer" class="searchResultTable">
										<%
										String resultPage = SearchDisplay.getInstance().getResultPage(request,pageContext);
										%>
										 <jsp:include flush="true" page="<%=resultPage%>"/>
									</div>
							</div>
<!-- 						</div> -->
<!-- 						<div class="content-right2 col-sm-1 col-xs-1"></div> -->
<!-- 					</div> -->
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

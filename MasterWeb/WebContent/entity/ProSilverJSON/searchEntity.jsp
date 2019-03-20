<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.avalant.display.SearchDisplay"%>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	com.master.util.Log4jUtil.log("=== Div Theme searchEntity");
%>
<form name ="masterForm" action="FrontController"  method="post" >
<input type ="hidden" name = "action" value="searchEntity">
<input type ="hidden" name = "handleForm" value = "Y">
<div id="content">
<div class="rightcontent">
	<div class="spacetop"><!-- Top 10 px --></div>
	<div class="bgtabtop">
			<div class=bgtabrightmenu2>
				<div class=tabend5></div>
			<div class=taballs2>
				<div class=textontab10><span><%=SearchDisplay.getInstance().getEntityName(request)%></span> <span id="prosilver_message"></span></div>
			</div><!--start Main tab--><!--Tab1-->
			<div class=mothertab2>
				<div class=tabsearch1></div>
			</div><!--EndTab1-->
			<!--End Main Tab-->
			</div>
			<div class="content-top">
				<div id="<%=entityID%>Error" ></div>
				<div class="content-center-search">
					<div class="content-left"></div>
					<div class="content-all">
						<div id="<%=entityID%>_searchCriteria" class="searchCriteriaContainer">
							<%//=SearchDisplay.getInstance().getSearchCriteriaBox(request)%>
							<div class="clear-all"><!-- Start searchbtn and reset --></div>
							<div class=btnzone>
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
</form>
<script>
<% com.avalant.display.SearchDisplayJSON sdj = new com.avalant.display.SearchDisplayJSON(); %>
$(document).ready(function() {
	var jsonCriteria = <%=sdj.getSearchCriteriaBoxJSON(request)%>;
	rederCriteria(jsonCriteria);
});
</script>
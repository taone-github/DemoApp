<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.avalant.display.SearchDisplay"%>
<% 
	String entityID = (String)request.getSession().getAttribute("entityID");
	System.out.println("=== Div Theme searchEntity");
%>
<form name ="masterForm" action="FrontController"  method="post" >
<input type ="hidden" name = "action" value="searchEntity">
<input type ="hidden" name = "handleForm" value = "Y">
<div id="content">
<div class="rightcontent">
	<div class="spacetop"><!-- Top 10 px --></div>
	<div class="bgtabtop">
			<DIV class=bgtabrightmenu2>
				<DIV class=tabend5></DIV>
			<DIV class=taballs2>
				<DIV class=textontab10><%=SearchDisplay.getInstance().getEntityName(request)%></DIV>
			</DIV><!--start Main tab--><!--Tab1-->
			<DIV class=mothertab2>
				<DIV class=tabsearch1></DIV>
			</DIV><!--EndTab1-->
			<!--End Main Tab-->
			</DIV>
			<div class="content-top">
				<div id="<%=entityID%>Error" ></div>
				<div class="content-center-search">
					<div class="content-left"></div>
					<div class="content-all">
						<div id="<%=entityID%>_searchCriteria" class="searchCriteriaContainer">
							<%=SearchDisplay.getInstance().getSearchCriteriaBox(request)%>
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
				<style>
				<%=MasterUtil.generateCustomStyleByRequest(request) %>
				</style>
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
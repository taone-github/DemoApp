<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.ava.bpm.proxy.process.WfProcess" %>
<% 
	WfProcess wp = new WfProcess();
	String roleId = wp.getRoleId(request);
	com.ava.bpm.proxy.process.WfProcess wfp = new com.ava.bpm.proxy.process.WfProcess();
	com.avalant.display.WfActionDisplay.getInstance().printLog("MasterUser" + request.getSession().getAttribute("MasterUserDetails"));
	com.avalant.display.WfActionDisplay.getInstance().printLog("roleId : " + roleId);
	Vector<com.master.model.WfActivityTemplateM> vecTemplate = com.avalant.display.WfActionDisplay.getInstance().getRoleActivityMap(roleId);
	com.avalant.display.WfActionDisplay.getInstance().printLog("vecTemplate : " + vecTemplate);
%>
<jsp:include flush="true" page="../../../theme/theme.jsp">
<jsp:param name="themeCode" value="PS1"/>
</jsp:include> 
<div id="content">
<div class="rightcontent">
	<div class="spacetop"><!-- Top 10 px --></div>
	<div class="bgtabtop">
			<DIV class=bgtabrightmenu2>
				<DIV class=tabend5></DIV>
			<DIV class=taballs2>
				<DIV class=textontab10><span>To Do List</span> <span id="prosilver_message"></span></DIV>
			</DIV><!--start Main tab--><!--Tab1-->
			<DIV class=mothertab2>
				<DIV class=tabsearch1></DIV>
			</DIV><!--EndTab1-->
			<!--End Main Tab-->
			</DIV>
			<div class="content-top">
				<div class="content-center-todolist">
					<div class="content-left"></div>
					<div class="content-all">
						<div class="searchCriteriaContainer">
						<%for(int i=0;i<vecTemplate.size();i++){ %>
							<div class="topictextbig">
								<%=vecTemplate.get(i).getActivityName()%>
								<span id="<%=vecTemplate.get(i).getAtid()%>Refresh" >
									<img border="0" src="<%=request.getContextPath()%>/theme/001/127_0_0_1_files/images/refresh.gif" width="15" height="15" 
										style="cursor:hand" 
										onclick="refreshWorkList('<%=vecTemplate.get(i).getAtid()%>')" >
								</span>
							</div>
							<div id="<%=vecTemplate.get(i).getAtid()%>DIV" align="center" class="tablearea">
								<jsp:include flush="true" page="activityWorkQueue.jsp">
									<jsp:param name="ptid" value="<%=vecTemplate.get(i).getPtid()%>"/>
									<jsp:param name="atid" value="<%=vecTemplate.get(i).getAtid()%>"/>
									<jsp:param name="entityId" value="<%=vecTemplate.get(i).getEntityId()%>"/>
									<jsp:param name="tabId" value="<%=vecTemplate.get(i).getTabId()%>"/>
									<jsp:param name="pageNumber" value="1"/>
									<jsp:param name="showSize" value="10"/>
								</jsp:include>
							</div>
							<div class=spacegrid></div>
						<%} %>
						</div>
					</div>
					<div class="content-right"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script language="javascript">

	function loadForUpdateWF(str, rowNum , entId , tabId) {
		blockScreen();
		window.location = "<%=request.getContextPath()%>/FrontController?action=loadUpdateEntity&entityID="+entId+"&tabID="+tabId+"&"+str;
	}
	
	function refreshWorkList(atid){
		$('#'+atid+'Refresh').html(" <img id=\"waiting\" src=\"./images/loader/pleaseWaitImage.gif\" width=\"22px\" height=\"22px\" >");
		jQuery("#"+atid+"DIV").hide();
		var dataString = "ptid="+$('#'+atid+'_ptid').val()+"&atid="+atid+"&entityId="+$('#'+atid+'_entityId').val()+"&tabId="+$('#'+atid+'_tabId').val();
		//Pagging
		dataString += "&pageNumber="+$('#'+atid+'_pageNumber').val()+ "&showSize="+$('#'+atid+'_selectPerPage').val();
		try {
			jQuery.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/entity/ProSilver/workflow/activityWorkQueue.jsp",
				data: dataString,
				success: function(data){
					jQuery("#"+atid+"DIV").html(data);
					jQuery("#"+atid+"DIV").fadeIn("fast");
					$('#'+atid+'Refresh').html("<img border=\"0\" src=\"<%=request.getContextPath()%>/theme/001/127_0_0_1_files/images/refresh.gif\" width=\"15\" height=\"15\" "
					+ "style=\"cursor:hand\" onclick=\"refreshWorkList('"+atid+"')\">");
					adjustHeight();
				}
			});
		} catch(e) {}
	}
	
	function changePageAndSizeWF(page,atid){
		$('#'+atid+'_pageNumber').val(page);
		refreshWorkList(atid);
	}
	
	$(document).ready( function() {
		adjustHeight();
	});
	
	function adjustHeight(){
		var h = $('.content-all').css('height');
		$('.content-center-todolist').css('height',h);
		$('.content-center-todolist').css('height','+=20px' );
	}
</script>
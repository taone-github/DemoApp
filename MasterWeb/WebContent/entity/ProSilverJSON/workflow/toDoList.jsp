<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.ava.bpm.proxy.process.WfProcess" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.master.model.WfToDoListM" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.master.model.WfAttrTemplate" %>
<% 
	WfProcess wp = new WfProcess();
	String roleId = wp.getRoleId(request);

	HashMap hResult = com.avalant.display.WfActionDisplay.getInstance().searchWq(roleId,1,10);
	ArrayList<WfToDoListM> wfToDoListM = (ArrayList<WfToDoListM>)hResult.get(com.master.util.MasterValueList.DATA_VALUE);
	HashMap<String,WfAttrTemplate> wfAttrTempMap = com.avalant.display.WfActionDisplay.getInstance().getAttrTemplate();
	int allRecord = Integer.parseInt((String)hResult.get(com.master.util.MasterValueList.ALL_VOLUME));
	HashMap<String,WfAttrTemplate> attrTemplate = com.avalant.display.WfActionDisplay.getAttrTemplate();
%>
<link href="/MasterWeb/theme/ToDoList/ToDoList_style.css"
	rel="stylesheet" type="text/css">
<script src="/MasterWeb/javascript/3_3_30/html5.js"
	type="text/javascript"></script>
<nav class="mainmenu">
<ul>
	<li><a href="#"><img
		src="/MasterWeb/theme/ToDoList/images/home.png"></a></li>
	<li><a href="#"><img
		src="/MasterWeb/theme/ToDoList/images/process.png">
	<h2>Process</h2>
	</a></li>
	<li><a href="#"><img
		src="/MasterWeb/theme/ToDoList/images/monitor.png">
	<h2>Monitor</h2>
	</a></li>
	<li><a href="#"><img
		src="/MasterWeb/theme/ToDoList/images/worklist.png">
	<h2>Work List</h2>
	</a></li>
</ul>
</nav>
<aside id="ads_left">
<section id="search">
<form>
<fieldset><input name="" type="text" class="search"
	placeholder="Search..."></fieldset>
<fieldset><input name="" type="text" class=" sort"
	placeholder="All..."> <input type="submit" value=""
	class="btn_sort" /></fieldset>
<fieldset><input name="" type="text" class=" sort"
	placeholder="None Active"> <input type="submit" value=""
	class="btn_sort" /> <input type="submit" value="" class="btn_search" />
</fieldset>
</form>
</section>
<a href="Process_Thumnails.html">
<button class="btn"><img
	src="/MasterWeb/theme/ToDoList/images/icon/thumnals.png"></button>
</a>
<a href="index.html">
<button class="btn_active2"><img
	src="/MasterWeb/theme/ToDoList/images/icon/list.png"></button>
</a>
<a href="Process_List2Column.html">
<button class="btn2"><img
	src="/MasterWeb/theme/ToDoList/images/icon/column.png"></button>
</a>
<section class="TabTable">
<h3>Overdue ( 4 )</h3>
<figure class="listTable">
<img src="/MasterWeb/theme/ToDoList/images/list2.png">
</figure>
</section>

<%
String keyForSearch = null; 
String strSearchResult=null;
HashMap wqAttrHm=null;
StringBuffer keyForSearchBuffer = null;
for(int j=0;j<wfToDoListM.size();j++){

	wqAttrHm = wfToDoListM.get(j).getWqAttrHm();
	
	com.avalant.display.WfActionDisplay.getInstance().printLog("wfSearchResult.wqAttrHm :"+wqAttrHm);
	//gen key
	keyForSearchBuffer = new StringBuffer();
	Vector<com.master.model.WfProcessAttr> processAttrToShowVt = com.avalant.display.WfActionDisplay.getProcessAttr(wfToDoListM.get(j).getPtid());
	for(int k=0;k<processAttrToShowVt.size();k++){
		com.master.model.WfProcessAttr attributeM = (com.master.model.WfProcessAttr)processAttrToShowVt.get(k);
		if(attributeM.getSearchKeyFl().equals("Y")){
			//Real column name of this attr
			String key = attributeM.getWfAttrTemplate().getAttrName();
			keyForSearchBuffer.append(key+"=");
			//value
			WfAttrTemplate wat = attrTemplate.get(attributeM.getSearchField());
			//wat.getAttrName() -> FIELD_XX
			keyForSearchBuffer.append(wqAttrHm.get(wat.getAttrName())+"&");
		}
	}
	keyForSearchBuffer.append("wfJobId="+wfToDoListM.get(j).getJobId());
	keyForSearchBuffer.append("&wfPtid="+wfToDoListM.get(j).getPtid());
	keyForSearch = keyForSearchBuffer.toString();
	
	String onclickEvent = "";
	
	onclickEvent = "onclick=\"loadForUpdateWF('"+keyForSearch+"','"+j+"','"+wfToDoListM.get(j).getEntityId()+"','"+wfToDoListM.get(j).getTabId()+"')\"";
 %>
<article id="contentList">
	<section class="content">
		<a href="#" <%=onclickEvent%> ><figure class="pic_left"><img
			src="/MasterWeb/theme/ToDoList/images/icon/job.png"></figure>
		<h2 class="jobTitle"><%=wfToDoListM.get(j).getActivityName() %></h2>
		<%=wfToDoListM.get(j).getActivityDesc()%> Job ID :<%=wfToDoListM.get(j).getJobId()%></a>
	</section>
	<section class="contentright">
		<a href="#"><figure class="pic_right"><img
			src="/MasterWeb/theme/ToDoList/images/icon/user4.jpg"></figure>
		<h2 class="UserTitle"><%=wfToDoListM.get(j).getWqAttrHm().get("FIELD_01")%></h2>
		</a>
	</section>
	<section class="contentDue">
		<a href="#"><figure class="pic_left"><img
			src="/MasterWeb/theme/ToDoList/images/icon/Clock.png"></figure>
		<h2 class=" jobDue">8 Day 6 Hr</h2>
		Update Date : <%=wfToDoListM.get(j).getUpdateDate() %></a>
	</section>
</article>
<%} %>
<article id="contentList">
	<section class="content">
		<a href="#"><figure class="pic_left"><img
			src="/MasterWeb/theme/ToDoList/images/icon/job.png"></figure>
		<h2 class="jobTitle">Flight Search Service</h2>
		Simple Flight Seaech Process :103</a>
	</section>
	<section class="contentright">
		<a href="#"><figure class="pic_right"><img
			src="/MasterWeb/theme/ToDoList/images/icon/user4.jpg"></figure>
		<h2 class="UserTitle">GangNam</h2>
		</a>
	</section>
	<section class="contentDue">
		<a href="#"><figure class="pic_left"><img
			src="/MasterWeb/theme/ToDoList/images/icon/Clock.png"></figure>
		<h2 class=" jobDue">8 Day 6 Hr</h2>
		Due : 2012-12-10 11:59 AM</a>
	</section>
</article>
<section class="TabTable2">
<h3>Due Today (3)</h3>
<figure class="listTable">
<img src="/MasterWeb/theme/ToDoList/images/list.png">
</figure>
</section>
</aside>
<aside id="ads_right">
sdfsfsdfds
</aside>
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
</script>
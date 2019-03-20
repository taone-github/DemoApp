<%@ page import="java.util.Vector" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil" %>

<html>
<head>
<title>report</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK rel=StyleSheet type=text/css href="theme/report_Style.css">
<!--[if IE 8]>
<style type="text/css">
	#ads_report{width:auto;}
	.TabTable_textleft,.TabTable {height:34px;}
	.report_group{width:276px;}
	.report_group .item_count{margin: -15px 5px 0 0;}
	#ads_report .content .detail {width:85%;}
</style>
<![endif]-->
<script type="text/javascript" src="manual/js/entity/scriptReport.js"></script>
</head>
<body>
<!--div> <div><img src="images/report/logo.png">
</div>
</div>
<div class="mainmenu">
<ul>
<li><a href="#"><img src="images/report/home.png"></a></li>
<li><a href="#"><img src="images/report/process.png"><h2>Process</h2></a></li>
<li><a href="#"><img src="images/report/monitor.png"><h2>Monitor</h2></a></li>
<li><a href="#"><img src="images/report/worklist.png"><h2>Work List</h2></a></li>
</ul>
</div-->
<div id="ads_left">
<div id="bg_btn"> <a href="01-Create_workflow_info.html"><button class="tab_active">Report Builder</button></a>
<a href="02create_workflow_tab_designer.html"><button class="btn_tab">Properties</button></a>
</div>
<div id="search">
<form>
    <fieldset>
          <input name="" type="text" class="search" placeholder="Search...">
        </fieldset>
        <fieldset>
          <input name="" type="text" class=" sort" placeholder="All...">
          <input type="submit" value="" class="btn_sort"/>
        </fieldset>
        <fieldset>
          <input type="submit" value="" class="btn_search"/>
        </fieldset>
  </form></div>
 
 <div id="Report">
<div id="report_toggle" >
 <% Vector vReportGroup = (Vector)request.getSession().getAttribute("reportGroup"); %>
 <div class="TabTable">
 <span class="TabTable_title">Report (<%=vReportGroup.size() %>)</span>
 <div class="listTable"><img src="images/report/list.png" onclick="toggleMenu()"></div> </div>
  <div class="scollbar"><img src="images/report/scoll.png"></div>
	<%	
		int totalPage = 1;
		for(int i = 0; i < vReportGroup.size(); i++)
		{
	    	HashMap hResult = (HashMap)vReportGroup.get(i);%>
	    	<%if(i == 0) {
	    		totalPage = (int)Math.ceil((Integer.parseInt((String)hResult.get("COUNT_REPORT")))/10.0);
	    	%> 
	    		<script type="text/javascript">group_id = "<%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("GROUP_ID"))) %>";</script>
	    	<% } %>
	    	<div id="report_group_<%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("GROUP_ID"))) %>" 
	    		class="report_group <% if(i == 0) out.print("active"); %>"
	    		onclick="loadReportListByGroup('<%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("GROUP_ID"))) %>')"
	    	><%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("GROUP_NAME"))) %> 
	    		<div class="item_count">(<%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("COUNT_REPORT"))) %>)</div>
	    	</div>
	<%} %>
  
</div>

<div id="ads_report">
<div class="TabTable_textleft">Design Reports</div>

<% HashMap hmReport = (HashMap)request.getSession().getAttribute("report"); 
	int reportCount = 0;
	
	if(hmReport.containsKey("ALL_VOLUME") && Integer.parseInt(hmReport.get("ALL_VOLUME").toString()) > 0)
	{
		Vector vReport = (Vector)hmReport.get("DATA");
		HashMap hmReportItem = new HashMap();
		
		reportCount = vReport.size();
		String entityID;
		String reportPath;
		String outputPath;
		String fileName;
		String reportName;
		String reportDesc;
		String updateDate;
		for(int i = 0; i < vReport.size(); i++)
		{
			hmReportItem = (HashMap)vReport.get(i);
			entityID = DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hmReportItem.get("ENTITY_ID")));
			reportName = DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hmReportItem.get("REPORT_NAME")));
			reportDesc = DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hmReportItem.get("REPORT_DESC")));
			updateDate = DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hmReportItem.get("UPDATE_DATE")));
	%>
	<div class="content">
		<div class="detail" onclick="loadEntity('<%=entityID%>')">
   			<div class="pic_job"><img src="images/report/icon/job.png"></div>
   			<div class="detail_job_wrapper">
   			<div class="jobTitle"><%=reportName %></div>
   			<div class="jobDescription"><%=reportDesc %></div>
   			</div>
   		</div>
   		<div class="footer_content">Date : <%=updateDate %></div>
 	</div>
	<% } %>
	<% } %>

 <div class="Report_page">
 	<div class="Report_page_wrapper">
 	<div class="page_detail">
 	<span class="report_count"><%=reportCount %></span> 
 	Item Page <span class="page_no">1</span> of <span class="total_page"><%=totalPage %></span></div>
	 <button class="btn_page2" onclick="loadReportList('first')"><img src="images/report/icon/first.png"></button>
	 <button class="btn_page2" onclick="loadReportList('prev')"><img src="images/report/icon/previous.png"></button>
	 <button class="btn_page2" onclick="loadReportList('next')"><img src="images/report/icon/next.png"></button>
	 <button class="btn_page" onclick="loadReportList('last')"><img src="images/report/icon/last.png"></button>
	 </div>
	 </div>
 
 
 
 </div></div></div>
</body>
</html>
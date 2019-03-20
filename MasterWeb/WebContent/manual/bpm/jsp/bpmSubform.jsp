<%@ page import="java.util.Vector"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"%>
<%@ page import="com.master.form.EntityFormHandler"%>
<%@ page import="com.master.model.EntityM"%>

<%@ page import="com.ava.bpm.model.base.WfHistoryM"%>
<%@ page import="com.ava.bpm.model.base.WfActivityLinkM"%>
<%@ page import="com.ava.bpm.proxy.util.WfUtil"%>
<%@ page import="com.master.util.MasterConstant" %>
<%
String entityID =(String)request.getSession().getAttribute("entityID");
EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entityID+"_session");			

WfUtil wfUtil = new WfUtil();
String wfJobId = (String)request.getSession().getAttribute("wfJobId");
String wfPtid = (String)request.getSession().getAttribute("wfPtid");
if(wfPtid==null || wfPtid.length()==0){
   wfPtid =  form.getEntityM().getDefaultPTID();
}
System.out.println("screenPage...wfJobId:"+wfJobId+" wfPtid:"+wfPtid);
Vector wfActivityVt = null;
Vector wfHistoryVt = null;
if(MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())){
	wfActivityVt = wfUtil.getStartActionByPtid(wfPtid);
	wfHistoryVt = null;
}else{
	wfActivityVt = wfUtil.getNextActionByJobId(wfJobId);
	wfHistoryVt = wfUtil.getWfHistory(wfJobId);	
}
%>




<%
if(wfActivityVt!=null && wfActivityVt.size()>0){
%>
<select name="wfAction">
<%
	WfActivityLinkM activityLink = null;
	for(int i=0;i<wfActivityVt.size();i++){
		activityLink = (WfActivityLinkM)wfActivityVt.get(i);
%>		
	  <option value="<%=activityLink.getAction()%>"><%=activityLink.getAction()%></option>
<%
	}	
%>	
</select>
<%
}else{
%> <input type="text" name="wfAction"><%	
}
%>


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
JobId :<input type="text" name="wfJobId" size="30" value="<%=wfJobId%>">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Ptid:<input type="text" name="wfPtid" size="30" value="<%=wfPtid%>">
</br></br>

<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td colspan="4" valign="top">
			<div align="center" class="manyRowDiv">
				<table width="100%" cellpadding="1" cellspacing="1" align="center">
					<thead>
						<tr height="19">     

							<th width="1%" align="center" class="TableHeaderList">No</th>     
							<th width="9%" align="center" class="TableHeaderList">Activity Name</th>   
							<th width="9%" align="center" class="TableHeaderList">Action</th>
							<th width="9%" align="center" class="TableHeaderList">Owner</th>
							<th width="9%" align="center" class="TableHeaderList">Activity State</th>
							<th width="9%" align="center" class="TableHeaderList">Process State</th>
							<th width="9%" align="center" class="TableHeaderList">Created By</th>
							<th width="9%" align="center" class="TableHeaderList">Created Date</th>
							<th width="9%" align="center" class="TableHeaderList">Last Opened By</th>
							<th width="9%" align="center" class="TableHeaderList">Last Opened Date</th>
							<th width="9%" align="center" class="TableHeaderList">Completed By</th>
							<th width="9%" align="center" class="TableHeaderList">Completed Date</th>
					</thead>		
					<tbody>
<%
	if(wfHistoryVt!=null){
		WfHistoryM wfHistoryM = null;
		int wfHistorySize = wfHistoryVt.size();
		for(int i=0;i<wfHistorySize;i++){
			wfHistoryM = (WfHistoryM)wfHistoryVt.get(i);
%>
						<tr class="ROW" align="center">
							<td><span><%=(i+1)%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getActivityName())%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getAction())%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getOwner())%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getActivityState())%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getProcessState())%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getCreateBy())%></span></td>
							<td><span><%=wfHistoryM.getCreateDate()!=null?DisplayFormatUtil.dateTimetoString(new java.util.Date(wfHistoryM.getCreateDate().getTime())):""%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getLastOpenBy())%></span></td>
							<td><span><%=wfHistoryM.getLastOpenDate()!=null?DisplayFormatUtil.dateTimetoString(new java.util.Date(wfHistoryM.getLastOpenDate().getTime())):""%></span></td>
							<td><span><%=DisplayFormatUtil.displayHTML(wfHistoryM.getCompleteBy())%></span></td>
							<td><span><%=wfHistoryM.getCompleteDate()!=null?DisplayFormatUtil.dateTimetoString(new java.util.Date(wfHistoryM.getCompleteDate().getTime())):""%></span></td>
						</tr>

<%
		}
	}
%>					
					</tbody>
				</table>
			</div>
		</td>
	</tr>  
	<tr>

		<td colspan="4" align="right">
    
    
		</td>
	</tr>
</table>


<%@ page import="com.ava.bpm.model.base.WfProcessAttributeM"%>
<%@ page import="com.ava.bpm.model.base.WfWorkQueueM"%>
<%@ page import="com.ava.bpm.proxy.util.WfUtil"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil" %>
<%@ page import="com.oneweb.j2ee.system.LoadXML" %>
<%@ page import="com.master.util.MasterConstant"%>
<%

	
	String ptid =  request.getParameter("ptid");
	String atid = request.getParameter("atid");
	String entityId = request.getParameter("entityId");
	String tabId = request.getParameter("tabId");
	int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	int showSize = Integer.parseInt(request.getParameter("showSize"));
	com.avalant.display.WfActionDisplay.getInstance().printLog("ptid : " + ptid);
	com.avalant.display.WfActionDisplay.getInstance().printLog("atid : " + atid);
	Vector<com.master.model.WfProcessAttr>processAttrToShowVt = com.avalant.display.WfActionDisplay.getInstance().getProcessAttr(ptid);
	String displayCaption = null;
	com.avalant.display.WfActionDisplay wad = new com.avalant.display.WfActionDisplay();
	HashMap hResult = wad.searchWq(atid,ptid,pageNumber,showSize);
	ArrayList<WfWorkQueueM> wfWorkQueueList = (ArrayList<WfWorkQueueM>)hResult.get(com.master.util.MasterValueList.DATA_VALUE);
	com.master.model.WfProcessAttr attributeM = null;
	String attributeName =null;
	com.avalant.display.WfActionDisplay.getInstance().printLog("processAttrToShowVt.size() : " + processAttrToShowVt.size());

 %>
<input type=hidden id="<%=atid%>_ptid" value="<%=ptid%>" />
<input type=hidden id="<%=atid%>_entityId" value="<%=entityId%>" />
<input type=hidden id="<%=atid%>_tabId" value="<%=tabId%>" />
<table width="100%" cellpadding="0" cellspacing="0" align="center" >
		<tr>
			<td class="headtable1">
				<div class="fontheadtable1">No</div>
			</td>   
<%
for(int i=0;i<processAttrToShowVt.size();i++){
	attributeM = (com.master.model.WfProcessAttr)processAttrToShowVt.get(i);
	
//end wf
%>
			<td class="headtable1">
				<div class="fontheadtable1">
		       		<%=attributeM.getWfAttrTemplate().getDispCaption()%>
				</div>
			</td> 
<% 
 }
%>
		</tr>
<%if(wfWorkQueueList.size() == 0){%>
		<tr class="gumaygrey2" onmouseover="this.className='gumaygrey2'" onmouseout="this.className='gumaygrey2'">
			<td align="center" colspan="<%=processAttrToShowVt.size()+1 %>" class=datatable-many >
				<span><%=MessageResourceUtil.getTextDescription(request, "DEFAUL_TO_DO_LIST") %></span>
			</td>
		</tr>
<%} %>

<% 
//wf
String keyForSearch = null; 
String strSearchResult=null;
WfWorkQueueM workqueueM = null;
HashMap wqAttrHm=null;
StringBuffer keyForSearchBuffer = null;

for(int i=0;i<wfWorkQueueList.size();i++){ // display search result record
	workqueueM = wfWorkQueueList.get(i);
	wqAttrHm = workqueueM.getWqAttrHm();

	com.avalant.display.WfActionDisplay.getInstance().printLog("wfSearchResult.workqueueM :"+workqueueM.toString());
	com.avalant.display.WfActionDisplay.getInstance().printLog("wfSearchResult.wqAttrHm :"+wqAttrHm);
	//gen key
	keyForSearchBuffer = new StringBuffer();
	for(int k=0;k<processAttrToShowVt.size();k++){
		attributeM = (com.master.model.WfProcessAttr)processAttrToShowVt.get(k);
		if(attributeM.getSearchKeyFl().equals("Y")){
			//Real column name of this attr
			String key = attributeM.getWfAttrTemplate().getAttrName();
			keyForSearchBuffer.append(key+"=");
			//value
			keyForSearchBuffer.append(wqAttrHm.get(key)+"&");
		}
	}
	keyForSearchBuffer.append("wfJobId="+workqueueM.getJobId());
	keyForSearchBuffer.append("&wfPtid="+workqueueM.getPtid());
	keyForSearch = keyForSearchBuffer.toString();
//end wf
%>
	<tr class="<%=((i%2)==0)? "ROW" : "ROW_ALT" %>" onmouseover="this.className='ROW_HOVER'" onmouseout="<%=((i%2)==0)? "this.className='ROW'" : "this.className='ROW_ALT'"%>">

	<td width ="4%" align ="center"  height="19" class="datatable-many" ><%=(i+1)%></td>
<% 
	String onclickEvent = "";
	
	onclickEvent = "onclick=\"loadForUpdateWF('"+keyForSearch+"','"+i+"','"+entityId+"','"+tabId+"')\"";

// wf
	for(int j=0;j<processAttrToShowVt.size();j++){
		attributeM=(com.master.model.WfProcessAttr)processAttrToShowVt.get(j);
		attributeName = attributeM.getWfAttrTemplate().getAttrName();
		strSearchResult = (String)wqAttrHm.get(attributeName);
		com.avalant.display.WfActionDisplay.getInstance().printLog("wfSearchResult...attributeName:"+attributeName+" strSearchResult:"+strSearchResult);
// end wf
		if (strSearchResult != null && !strSearchResult.trim().equalsIgnoreCase("")) {
%>
							<td  <%=onclickEvent%>  align="center" class="datatable-many"><%=strSearchResult%></td>
<%	
		} else {
%>
							<td  <%=onclickEvent%>  align="center" class="datatable-many">&nbsp;</td>
<%	
		}
	}	
%>
						</tr>
<%	
}
%>
</table>
<!--  Pagging -->
<%

	int allRecord = Integer.parseInt((String)hResult.get(com.master.util.MasterValueList.ALL_VOLUME));
 %>
<div>
<input type=hidden id="<%=atid%>_pageNumber" value="<%=pageNumber%>"/>
<br>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0"> 
	<tr>
		<td class="text-pagging" width ="60%"> 
		Total Records found :&nbsp;<b><%=allRecord%> </b>
		</td>
		<td class="text-pagging" align="right">
<% 		
		int allPage =  allRecord / showSize;
		if (allPage*showSize  < allRecord) {
			allPage++;
		}
%>
		Page <b><%=pageNumber%></b> of <b><%=allPage%></b>
		</td>
		<td class="text-pagging" align="right">
<% 		
		if (pageNumber != 1) {
%>    
			|&nbsp;<input type="button" name ="previous" value="|<" onclick ="changePageAndSizeWF('<%=(pageNumber-1)%>','<%=atid%>')">
<% 
		} else {
%>    
			|&nbsp;<input type="button" name ="previous" value="|<"  disabled="disabled">
<% 
		}
%>
			&nbsp;<b><%=pageNumber%></b> &nbsp;
<% 
		if (allPage != pageNumber)	{	
%>
			<input type="button" name ="next" value=">|" onclick ="changePageAndSizeWF('<%=(pageNumber+1)%>','<%=atid%>')">&nbsp;| 
<% 
		} else {
%>
			<input type="button" name ="next" value=">|"  disabled="disabled">&nbsp;| 
<% 
		}
%>						
		</td>
		<td class="text-pagging" align="right" ><b>
		View&nbsp; 
			<select id="<%=atid%>_selectPerPage"  onchange="changePageAndSizeWF('1','<%=atid%>')"> 
<% 	
		Vector v = new Vector(LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().keySet());
		for(int i =0;i< v.size();i++) {
			if (showSize == Integer.parseInt((String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1)))) {
%>     
				<option value ="<%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" selected ><%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<% 
			} else {
%>
				<option value ="<%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%>" ><%=(String)LoadXML.getLoadXML(MasterConstant.EAF_MASTER_NAME).getItemPerPageMap().get(Integer.toString(i+1))%></option>
<%	
			}
		}
%>
			</select>&nbsp;per page </b>			 		
		</td>
	</tr>
</TABLE>
<br>
</div>
<!-- End pagging -->

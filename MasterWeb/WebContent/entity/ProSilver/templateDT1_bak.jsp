<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.avalant.display.TemplateDisplay" %>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.model.EntityTabM" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.model.TabM" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="java.util.ArrayList"%>
<% 
	//generate element by java
	TemplateDisplay td = new TemplateDisplay();
	Vector<String> result = td.print(request);
	int i=0;
	
	//Prepare data for condition show element
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	HashMap hTabs = form.getTabHasMap();
	ArrayList generalTabList = MasterUtil.getGeneralTab(entityTabs, hTabs);
	String currentGeneralTab = "";
	for(int j=0;j<generalTabList.size();j++) {
		EntityTabM entityTabM = (EntityTabM)generalTabList.get(j);
		TabM tabM =  (TabM)hTabs.get(entityTabM.getTabID());
		currentGeneralTab = tabM.getTabID();
	}
	String buttonAction = "ENTITY_UPDATE";
	if (MasterConstant.PROCESS_MODE_INSERT.equalsIgnoreCase(form.getCurrentMode())) {
		buttonAction = "ENTITY_INSERT";
	}

	if(null!=result && result.size() >0){
%>
<%
	//Vector Element 1
	if(i<result.size()){
		out.println(result.get(i++));
	}
%>
<%
	//General Tab Element 2 - 4
	if(generalTabList.size() > 0){
		//Vector Element 2
		if(i<result.size()){
			out.println(result.get(i++));
		}
%>
		<div id="<%=entityID%>Bt">
		<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
		<jsp:param name="module" value="<%=entityID%>"/>
		<jsp:param name="action" value="<%=buttonAction%>"/>
		</jsp:include>
		</div>
<%
		//Vector Element 3
		if(i<result.size()){
			out.println(result.get(i++));
		}
%>
		<div id="gridModuleContainer" class="gridModuleContainer <%=currentGeneralTab%>_grid">
		<jsp:include flush="true" page="moduleManager.jsp">
		<jsp:param name="CURRENT_TAB" value="<%=currentGeneralTab%>"></jsp:param>
		</jsp:include>
		</div>
<%
		//Vector Element 4
		if(i<result.size()){
			out.println(result.get(i++));
		}
	}//End General Tab Element
%>
<%
	//Normal Tab Element 5
	if (!form.getEntityM().isHideTab()) {
		//Vector Element 5
		if(i<result.size()){
			out.println(result.get(i++));
		}
	}//End Normal Tab Element 5
%>
<%
	//Normal Tab Element 6 - 7
	if(generalTabList.size() == 0){
		//Vector Element 6
		if(i<result.size()){
			out.println(result.get(i++));
		}
%>
		<jsp:include flush="true" page="/buttonManager/buttonManagerPB1.jsp">
		<jsp:param name="module" value="<%=entityID%>"/>
		<jsp:param name="action" value="<%=buttonAction%>"/>
		</jsp:include>
<%		//Vector Element 7
		if(i<result.size()){
			out.println(result.get(i++));
		}
	}//End Normal Tab Element 6 - 7
%>
<%
	//Other Tab Element 8 - 9
	if(null != form.getCurrentTab()){ 
		//Vector Element 8
		if(i<result.size()){
			out.println(result.get(i++));
		}
%>
		<div id="moduleContainer" class="moduleContainer <%=form.getCurrentTab()%>_container">
			<jsp:include flush="true" page="moduleManager.jsp">
			<jsp:param name="CURRENT_TAB" value="<%=form.getCurrentTab()%>"></jsp:param>
			</jsp:include>
		</div>
<%		//Vector Element 9
		if(i<result.size()){
			out.println(result.get(i++));
		}
	}//End Other Tab Element 8 - 9 
	
	//Vector Element 10
	if(i<result.size()){
		out.println(result.get(i++));
	}
}%>
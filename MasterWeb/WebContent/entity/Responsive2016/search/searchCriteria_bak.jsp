<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager"%>
<%@ page import="com.master.form.EntityFormHandler"%>
<%@ page import="com.master.form.MasterFormHandler"%>
<%@ page import="com.master.model.ModuleFieldM"%>
<%@ page import="com.master.util.MasterConstant"%>
<%@ page import="com.master.util.MasterUtil"%>
<%@ page import="java.util.Vector"%>
<%
String entityID = (String)request.getSession().getAttribute("entityID");
String entitySession = entityID +"_session";
EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
if (form == null) {
	form = new EntityFormHandler();
	request.getSession().setAttribute(entitySession,form);
}		

String moduleSession = form.getMainModuleID() +"_session";
MasterFormHandler MasterForm = (MasterFormHandler)request.getSession().getAttribute(moduleSession);
if (MasterForm == null) {
	MasterForm = new MasterFormHandler();
	request.getSession().setAttribute(moduleSession,MasterForm);
}
FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");
if (formHandleManager == null) {
	request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
}
formHandleManager.setCurrentFormHandler(moduleSession);

//Main box
%>
<div class="paddingmother">
<div class="topictextbig"><%=MasterUtil.displayEntityName(form.getEntityM(), request)%></div>
<div class="boxboldbelow">
<%
Vector vSearchCriteria = MasterForm.getVMasterModelMs();
int visibleElementNum = vSearchCriteria.size();
int colNum = 1;
int previousElementGroup = 0;
int nextFieldGroup = 0;
String lastRowColSpan = "";
for (int i=0;i < visibleElementNum; i++) {
	ModuleFieldM prmModuleFieldM;
	if(i+1 != visibleElementNum){
		prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i+1);
		nextFieldGroup = prmModuleFieldM.getFieldGroup();
	}else{
		nextFieldGroup = 0;
	}
	
	prmModuleFieldM = new ModuleFieldM();
	prmModuleFieldM = (ModuleFieldM)vSearchCriteria.get(i);
	
	/* start pair of naming convention */
	String labelNamed = prmModuleFieldM.getModuleID() + "_" + prmModuleFieldM.getFieldID() + "_" + MasterConstant.NAMING.LABEL_FIELD;
	String htmlComponentNamed = prmModuleFieldM.getModuleID() + "_" + prmModuleFieldM.getFieldID() + "_" + MasterConstant.NAMING.INPUT_FIELD;
	/* end pair of naming convention */
	
	String tagShow = MasterUtil.displayManualTag(request, entityID, prmModuleFieldM.getFieldID(), MasterForm);
	
	//Show Hidden
	if (MasterConstant.HIDDEN.equalsIgnoreCase(prmModuleFieldM.getObjType()) ) {
		out.print(tagShow);
	}else{
		//colNum > 2 can make screen look bad casue 
		if(colNum == 1 || previousElementGroup != prmModuleFieldM.getFieldGroup()){
			%><div class="textbox1">
<%
		}
		if(nextFieldGroup != prmModuleFieldM.getFieldGroup() && colNum != prmModuleFieldM.getColumnCount()){
			int spanValue = 1 + 4*(prmModuleFieldM.getColumnCount() - colNum);
			lastRowColSpan = " colspan=\"" + Integer.toString(spanValue) + "\" ";
		}else{
			lastRowColSpan = "";
		}
		%>
<div class="textbox50left">
<div class="componentNameDiv" id="<%=labelNamed%>"><%=MasterUtil.displayFieldName(prmModuleFieldM,request)%></div>
<div class="componentDiv" id="<%=htmlComponentNamed%>"><%=tagShow%>
</div>
</div>
<%
		previousElementGroup = prmModuleFieldM.getFieldGroup();
		colNum++;
		//End column
		if((colNum-1) == prmModuleFieldM.getColumnCount() || !"".equalsIgnoreCase(lastRowColSpan)){
%>
</div>
<%
			previousElementGroup = 0;
			colNum = 1;
		}
	}
} //for loop
%>
</div>
</div>
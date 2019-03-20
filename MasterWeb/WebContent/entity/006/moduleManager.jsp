<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.master.form.EntityFormHandler" %>
<%@ page import="com.master.model.TabMouleM" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.oneweb.j2ee.pattern.view.form.FormHandleManager" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.master.model.TabM" %>
<%@ page import="com.master.util.MasterConstant" %>
<%@ page import="com.master.model.ModuleM" %>
<%@ page import="com.master.util.MasterUtil" %>
<%@ page import="com.master.model.ModuleActionM" %>
<%@ page import="com.master.form.MasterFormHandler" %>
<%@ page import="com.master.model.ModuleFieldM" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% 
	String preHtmlTemplate = "";
	String postHtmlTemplate = "";//"<table><tbody><tr><td align=\"center\" colspan=\"2\">MID_00041</td></tr><tr><td>MID_00042</td><td>MID_00082</td></tr><tr><td>MID_00043</td><td>MID_00122</td></tr></tbody></table>";

	String strJavaScript = "";
	String entityID = (String)request.getSession().getAttribute("entityID");
	String entitySession = entityID +"_session";
	EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
	if (form == null) {
		form = new EntityFormHandler();
		request.getSession().setAttribute(entitySession,form);
	}
	FormHandleManager formHandleManager=(FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");	
	if (formHandleManager == null) {
		request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
	}
	formHandleManager.setCurrentFormHandler(entitySession);
%>

<% 	
	Vector entityTabs =  form.getEntityM().getEntityTabs();
	HashMap hTabs = form.getTabHasMap();
	String currentTab = (String)request.getParameter("CURRENT_TAB");
%>

<div id="<%=entityID%>Error">
<%if (form.hasErrors()) {%>
	<table cellspacing="0" cellpadding="0" align ="center" width="100%" >
		<tr>
			<td>
<%
		Vector v = form.getFormErrors();
		for (int s = 0; s < v.size(); s++) {
			out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(s) + "</span><br>");
		}
%>
			</td>
		</tr>
	</table>
<%} %>
</div>

<% 
if(!"".equalsIgnoreCase(currentTab) && null != currentTab){
	 System.out.println("hTabs===>"+hTabs);  
	 System.out.println("form.getCurrentTab()===>"+form.getCurrentTab());  	 
	 TabM tabM = (TabM)hTabs.get(currentTab);
	 System.out.println("tabM===>"+tabM);  
	 postHtmlTemplate = tabM.getHtmlTemplate();
	 Vector vTabModuleMs = tabM.getTabModuleMs();
	 HashMap moduleHashMap =  form.getModuleHashMap();
	 String processMode = form.getCurrentMode();

	if(vTabModuleMs.size() > 0){
	 for(int i = 0;i < vTabModuleMs.size();i++) {
	 	 TabMouleM tabModuleM = (TabMouleM)vTabModuleMs.get(i);
	 	 ModuleM moduleM = (ModuleM)moduleHashMap.get(tabModuleM.getModuleID());	 	 
 	 	 
 	 	 // start - apply tabModule manual template to screen
 	 	 if(null != postHtmlTemplate && !"".equals(postHtmlTemplate)){
	 	 	 String[] htmlTemplateArray = postHtmlTemplate.split(tabModuleM.getModuleID());
	 	 	 preHtmlTemplate = htmlTemplateArray[0];
	 	 	 postHtmlTemplate = htmlTemplateArray[1];
	 	 	 System.out.println("---");
	 	 	 System.out.println("tabModuleM.getModuleID() -> " + tabModuleM.getModuleID());
	 	 	 System.out.println("htmlTemplateArray[0] -> " + htmlTemplateArray[0]);
	 	 	 System.out.println("htmlTemplateArray[1] -> " + htmlTemplateArray[1]);
	 	 	 System.out.println("---");
 	 	 }
 	 	 // end - apply tabModule manual template to screen
 	 	 
	 	 request.getSession().setAttribute("module",moduleM.getModuleID());	 	 	 	 
		 MasterFormHandler moduleForm = (MasterFormHandler)request.getSession().getAttribute(tabModuleM.getModuleID()+"_session");
		 if (MasterConstant.PROCESS_MODE_UPDATE.equalsIgnoreCase(form.getCurrentMode())){ 
		 	moduleForm.setUnEditManyFlag(moduleForm.getModuleM().isViewModeFlag());
		 }
		 String htmlModuleDivID = moduleM.getModuleID() + "_" + MasterConstant.NAMING.MODULE_SECTION;
%>

<%//hidden field here for manyRelation table sorting %>
<input type ="hidden" name = "<%=moduleM.getModuleID()%>_tableHeadNameFocus" value = "">
<input type ="hidden" name = "<%=moduleM.getModuleID()%>_tableHeadColFocus" value = "">

<%
	if(null != preHtmlTemplate && !"".equals(preHtmlTemplate)){
		out.println(preHtmlTemplate);
	}
%>

<%if(tabM.isGeneralTabFlag()){ %>
<li id="<%=htmlModuleDivID %>_li">
<%} %>
		<div id="<%=htmlModuleDivID %>" class="moduleDiv">
			<table width="100%" cellpadding="0" cellspacing="0" >
				<tr>
					<td class="moduleHeader" valign="bottom" nowrap>
				<%if("&nbsp;".equalsIgnoreCase(moduleForm.getModuleM().getModuleName())){%>
						
				<%}else{%>
						<div class="moduleIcon"></div>:::&nbsp;<font><%=moduleForm.getModuleM().getModuleName()%></font>
				<%}%>
					</td>
				</tr>
			</table>
			<table align = "center"  width="100%"  >
				<tr>
					<td align = "left"><div id="<%=moduleForm.getModuleM().getModuleID()%>Error">
<%
			if (moduleForm.hasErrors()) {
				Vector v = moduleForm.getFormErrors();
				for (int f = 0; f < v.size(); f++) {
					out.println("<span class =\"TextWarningNormal\">*&nbsp;" + v.elementAt(f) + "</span><br>");
				}
			} 
%>
					</div></td>
				</tr>
			</table>
		<div id ='<%=moduleM.getModuleID()%>MG' >	    

<% 			
	 	 ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(moduleM.getModuleActions(),processMode);
	 	 if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
	 	 	if (moduleActionM != null && (moduleActionM.getFilePath() != null  && !"".equals(moduleActionM.getFilePath()))) {
	 	 		String filePath = moduleActionM.getFilePath();
				System.out.println("filePath -> " + filePath);
				
				String manualContextPath = filePath.substring(filePath.indexOf("/"), filePath.indexOf("/", 1));
				String manualUrlPath = filePath.substring(filePath.indexOf("/", 1));
				System.out.println("manualContextPath -> " + manualContextPath);
				System.out.println("manualUrlPath -> " + manualUrlPath);
				
				pageContext.setAttribute("manualContextPath", manualContextPath);
				pageContext.setAttribute("manualUrlPath", manualUrlPath);
				
				if (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_INSERT) || (processMode.equalsIgnoreCase(MasterConstant.PROCESS_MODE_UPDATE))) {
						if (moduleActionM.isInnerIncludeFlag()) {
%>
							
							<jsp:include flush="true" page="<%=manualUrlPath%>"/>
							
<% 						
						} else {
%>
							<c:import context="${manualContextPath}" url="${manualUrlPath}" charEncoding="UTF-8"/>
<%		
						}		
				} 
	 	 	} else  { 
%>
	 	 		
	 	 		<jsp:include flush="true" page="oneRelation.jsp"/>
	 	 		 
<% 	 	 
	 	 	}
	 	 } else if ((MasterConstant.ENTITY_RELATION_TYPE_MANY.equalsIgnoreCase(tabModuleM.getRelationType()))){	
%>
		 	 		<jsp:include flush="true" page="manyRelation.jsp"/> 
<% 	 	 
		 	 	
		  } else if (MasterConstant.ENTITY_RELATION_TYPE_LIST.equalsIgnoreCase(tabModuleM.getRelationType())){
%>	 		 
	 	 		<jsp:include flush="true" page="manyRelation.jsp"/>
<% 	 	 		
	 	 } else if ((MasterConstant.ENTITY_RELATION_TYPE_ATTACHED.equalsIgnoreCase(tabModuleM.getRelationType())))  { 
%>	 	 
	 	  		<jsp:include flush="true" page="attachmentFile.jsp"/> 
<% 	 	 
	 	 }
%>
		</div>
<% 	 	 
	Vector vResult = moduleForm.getVMasterModelMs();	 
	Vector vAllDependencys = new Vector();
	for (int s=0;s < vResult.size();s++) {
		ModuleFieldM prmModuleFieldM = (ModuleFieldM)vResult.get(s);
		if (prmModuleFieldM.getVDependencyFields().size() > 0 ) {
			vAllDependencys.addElement(prmModuleFieldM);
		}
	}		
	
	if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
	 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
		strJavaScript += MasterUtil.getInstance().generateJavaScript(vAllDependencys,request);
	}
%>

<% 	 	 
		if  ((MasterConstant.ENTITY_RELATION_TYPE_ONE.equalsIgnoreCase(tabModuleM.getRelationType())) 
 	 	|| (MasterConstant.ENTITY_RELATION_TYPE_MAIN.equalsIgnoreCase(tabModuleM.getRelationType()))) {
			if (moduleActionM.getScriptFile() != null && !"".equals(moduleActionM.getScriptFile())) {				
%>
				<SCRIPT language="JavaScript" src="<%=moduleActionM.getScriptFile()%>"></SCRIPT>
<% 	 	 
	 	
			}
		}	
%>
		</div> <% /*-- end div class="moduleDiv" --*/ %>
<%if(tabM.isGeneralTabFlag()){ %>
</li>
<%} %>
<% 	 	
	 } /*-- end for --*/
%>
<%
	if(null != postHtmlTemplate && !"".equals(postHtmlTemplate)){
		out.print(postHtmlTemplate);
	}
%>
<%
	} /*-- end if --*/
}
%>


<%
	// For switch tab to dependency feature can do.
	if (strJavaScript != null) {
		out.print(strJavaScript);
	}	
	//---------------------------------------------
	

	//if(!"".equalsIgnoreCase(strJavaScript)) {
	//	request.getSession().setAttribute("endPageJavascript", strJavaScript);
	//}
%>
<SCRIPT language="JavaScript" >
jQuery(document).ready(function() {
	addScript2Uppercase(window.document.masterForm);
return false;
});


function addScript2Uppercase(form){
	var elements = form.elements;
	for(var i = 0; i < elements.length; i++){
		var element = elements[i];
		if(element.type == 'text'||element.type == 'textarea'){
			var eventOnBlur = element.onblur;
			var newFunction = "";
			if(eventOnBlur != null){
				var eventOnBlurStr = eventOnBlur.toString();
				newFunction = "change2Uppercase('" + element.name + "'); " + eventOnBlurStr.substring(eventOnBlurStr.indexOf("{") + 1, eventOnBlurStr.lastIndexOf("}")); 
			}else{
				newFunction = "change2Uppercase('" + element.name + "'); ";
			}
			var func = new Function(newFunction);
			element.onblur = func;
		}
	}
}

function change2Uppercase(textFieldName){
	var textField = eval("window.document.masterForm." + textFieldName);
	if(!isUndefined(textField)){
		var values = textField.value;
		textField.value = values.toUpperCase();
	}
}

function isUndefined(a) {
  	return typeof a == 'undefined';
} 
</SCRIPT>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.master.model.ModuleActionM"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.model.ModuleM"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page import="com.master.util.MasterConstant"%>
<% 

			String entityID = (String)request.getSession().getAttribute("entityID");
			String entitySession = entityID +"_session";
			EntityFormHandler form = (EntityFormHandler)request.getSession().getAttribute(entitySession);
 			String moduleID  = (String)request.getSession().getAttribute("module");	 	 	 	 
			MasterFormHandler moduleForm = (MasterFormHandler)request.getSession().getAttribute(moduleID+"_session");
			ModuleM prmModuleM = moduleForm.getModuleM();
			String processMode = form.getCurrentMode();
			
			ModuleActionM moduleActionM = MasterUtil.getInstance().getModuleActionFromModuleActions(prmModuleM.getModuleActions(),processMode);			
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
					<jsp:include flush="true" page="detailManyRelation.jsp"/>
<% 		 	 	
		 	 	}
%>		 	 	
		 	 	
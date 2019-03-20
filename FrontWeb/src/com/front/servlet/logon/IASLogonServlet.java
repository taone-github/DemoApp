package com.front.servlet.logon;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.avalant.service.LogService;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;

/**
 * Servlet implementation class IASLogonServlet
 */
public class IASLogonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static transient Logger logger = Logger.getLogger(IASLogonServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IASLogonServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
    		ConstantSystemM constantSystemM  = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.IAS_ROLE_EXCEPTION);
    		ConstantSystemM constantCASDS = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.CAS_DATASOURCE);
    		String iasRoleException = constantSystemM.getConStantValue();
    		//String casUser = (String)request.getSession().getAttribute(CASFilter.CAS_FILTER_USER);
    		String casUser = "System";
    		iasRoleException = "N";
    		request.getSession().setAttribute("userName", casUser);
    		/*logger.debug("casUser==>"+casUser);
    		UserProfileDAO userDao = UserProfileDAOFactory.getUserProfileDAO();
	        MasterUserM masterUserM = userDao.loadUserDetails(casUser, LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getJavaENV()+constantCASDS.getConStantValue());    	    
    		MenuMDAO dao = EJBDAOFactory.getMenuMDAO();
	    	logger.debug("<==IASLogonServlet==>");
			request.getSession().setAttribute("FrontUserDetails",masterUserM);
			StringBuffer str =new StringBuffer(); 
			for (int i = 0; i < masterUserM.getRoles().size();i++) {
				MasterRoleM tempFrontRoleM = (MasterRoleM)masterUserM.getRoles().get(i);			
				str.append(tempFrontRoleM.getRoleID());
				if ((i+1) < masterUserM.getRoles().size()) {
					str.append(",");
				}
			} 
			HashMap hMenu = new HashMap();  
			if ("Y".equalsIgnoreCase(iasRoleException)) {
				hMenu = dao.getExceptionMenuIDFromRole(str.toString());
			} else {
				hMenu = dao.getMenuIDFromRole(str.toString());
			}			
				
			
			saveActivityLog(request,response);
			
			logger.debug("hMenu===>"+hMenu);
			request.getSession().setAttribute("authenMenu", hMenu);		*/	
			response.sendRedirect("FrontController?action=LOAD_MENU");
    	} catch (Exception e) {
    		logger.error("ERROR",e);
    	}	    	
		
	}
    
	private void saveActivityLog(HttpServletRequest request, HttpServletResponse response){
		String browser = getBrowser(request.getHeader("User-Agent"));
		String os = getOS(request.getHeader("User-Agent"));
		String resorution = "";
		String session = request.getSession().getId();
		String user = (String)request.getSession().getAttribute("userName");
		String clientIP = request.getRemoteAddr();
		//String branch = (String)request.getSession().getAttribute("branchCode");
		String module = "Log in";
		LogService.saveAccessLog(user, module, "", "", "", clientIP, browser, os, resorution, session);
	} 
    
	private String getBrowser(String agentStr){
		String browserName = "Unknown Browser";
		String version = "";
		int nameOffset = 0;
		int verOffset = 0;
		// In Internet Explorer, the true version is after "MSIE" in userAgent 
		if ((verOffset=agentStr.indexOf("MSIE"))!=-1) { 
			browserName  = "Microsoft Internet Explorer";
			version = agentStr.substring(verOffset+5,verOffset+8);
		}
		// In Opera, the true version is after "Opera" 
		else if ((agentStr.indexOf("Opera"))!=-1) { 
			browserName  = "Opera"; 
			version = agentStr.substring(verOffset+6,verOffset+9);
		}
		// In most other browsers, "name/version" is at the end of userAgent 
		else if ( (nameOffset=agentStr.lastIndexOf(' ')+1) < (verOffset=agentStr.lastIndexOf('/')) ) { 
			browserName  = agentStr.substring(nameOffset,verOffset); 
			version = agentStr.substring(verOffset+1); 
		}
		return browserName+" "+version;		
	}
	private String getOS(String agentStr){
		String osName="Unknown OS"; 
		if (agentStr.indexOf("Win")!=-1) 
			osName="Windows"; 
		if (agentStr.indexOf("Mac")!=-1) 
			osName="MacOS"; 
		if (agentStr.indexOf("X11")!=-1) 
			osName="UNIX"; 
		if (agentStr.indexOf("Linux")!=-1) 
			osName="Linux";
		return osName; 
	}
	
	
}

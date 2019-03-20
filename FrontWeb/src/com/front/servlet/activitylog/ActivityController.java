package com.front.servlet.activitylog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avalant.service.LogService;
import com.front.utility.accesslog.AccessLogManager;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;
import com.master.util.EAFManualUtil;

/**
 * Servlet implementation class for Servlet: ActivityController
 *
 */
 public class ActivityController extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ActivityController() {
		super();
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		boolean accessLogEnable = EAFManualUtil.getConstantValue(ConstantSystem.ACCESS_LOG_ENABLE).equals("Y");
		if(accessLogEnable) {
			String browser ="";
			String os = "";
			String resorution = "";
			String session = "";
			String user = "";
			String description = "";
			String clientIP = "";
			String branch = "";
			String status = "C";
			String module = "Menu";
			String event = "";
			
			if( request.getParameter("browser") != null ) {
				browser = request.getParameter("browser");
			}
			if( request.getParameter("OS") != null ) {
				os = request.getParameter("OS");
			}
			if( request.getParameter("resorution") != null ) {
				resorution = request.getParameter("resorution");
			}
			if( request.getParameter("session") != null ) {
				session = request.getParameter("session");
			}
			if( request.getParameter("user") != null ) {
				user = request.getParameter("user");
				if("null".equals(user)){
					user = null;
				}
			}
			if( request.getParameter("desc") != null ) {
				description = new String(request.getParameter("desc").getBytes("ISO8859_1"),"UTF-8");
			}
			
	
			if( request.getParameter("event") != null ) {
				event = new String(request.getParameter("event").getBytes("ISO8859_1"),"UTF-8");
			}
			clientIP = request.getRemoteAddr();
			String userName = (String)request.getSession().getAttribute("userName");
//			ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.ACCESS_LOG_ENABLE); 
//			if ("Y".equalsIgnoreCase(constantSystemM.getConStantValue())) {
				LogService.saveAccessLog(userName, module, "", "", "", clientIP, browser, os, resorution, session);
//			}	
			//AccessLogManager.getInstatnce().insertAccessLog(user, branch, status, module, description, event, clientIP, browser, os, resorution, session);
		}
	}
}
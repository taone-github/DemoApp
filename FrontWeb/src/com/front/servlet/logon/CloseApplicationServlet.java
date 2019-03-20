package com.front.servlet.logon;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.avalant.iam.service.UserInfoService;
import com.master.util.MasterConstant;

/**
 * Servlet implementation class for Servlet: CloseApplicationServlet
 *
 */
 public class CloseApplicationServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   private final static transient Logger logger = Logger.getLogger(CloseApplicationServlet.class);
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public CloseApplicationServlet() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.debug("### Start call CloseApplicationServlet ###");
		
		
		if(("Y").equals(request.getSession().getAttribute("useIAM2"))){
			try {
				/* logout Access Token IAM2REST */
				UserInfoService iam2restService = new UserInfoService(request);
				String token = (String) request.getSession().getAttribute(MasterConstant.ACCESS_TOKEN);
				iam2restService.logoutService(token);
				
			} catch (Exception e) {
				logger.warn("", e);
			}
		}
		
		String closeAppStr = (String) request.getParameter("closeApp");
		logger.debug("closeAppStr -> " + closeAppStr);
		clearSession(request);
		
		response.setContentType("text/html;charset=windows-874");
		PrintWriter out = response.getWriter();
		StringBuffer strBuffer = new StringBuffer();
		
		strBuffer.append(" <script language=\"javascript\"> ");		
		strBuffer.append("		window.open('','_parent',''); ");
		strBuffer.append("		window.close(); ");
		strBuffer.append(" </script>");
		
		out.println(strBuffer.toString());
		out.flush();
		out.close();
		
		
		logger.debug("### End call CloseApplicationServlet ###");
	}
	
	private void clearSession(HttpServletRequest request){
		Enumeration attributeAll = request.getSession().getAttributeNames();
		logger.debug("### TRACE ALL SESSION ###");
		while(attributeAll.hasMoreElements()){
			String attributeName = (String) attributeAll.nextElement();
			logger.debug("attributeName -> " + attributeName);
			request.getSession().removeAttribute(attributeName);
		}
		logger.debug("session of '"+request.getContextPath()+"' invalidated -----");
		request.getSession().invalidate();
		
		/* check attributeAll after delete session */
		/*
		Enumeration attributeAllNew = request.getSession().getAttributeNames();
		if(attributeAllNew.hasMoreElements()){
			logger.debug("after delete all session, has more element");
			while(attributeAllNew.hasMoreElements()){
				String attributeNameNew = (String) attributeAll.nextElement();
				logger.debug("attributeNameNew -> " + attributeNameNew);
			}
		}else{
			logger.debug("after delete all session, dont have element");
		}
		*/
	}
}
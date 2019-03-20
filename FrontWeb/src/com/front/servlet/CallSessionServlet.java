package com.front.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.front.servlet.logon.LogonServlet;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;

import edu.yale.its.tp.cas.client.filter.CASFilter;

/**
 * Servlet implementation class CallSessionServlet
 */
public class CallSessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static transient Logger logger = LogManager.getLogger(CallSessionServlet.class);   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CallSessionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.debug("<==CallSessionServlet==>");
		response.setContentType ("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        request.setCharacterEncoding("UTF-8");	
        boolean checkPermission = checkPermission(request, response);
		response.getWriter().print((checkPermission ?  "Y" : "N"));
	}
	
	private boolean checkPermission(HttpServletRequest request, HttpServletResponse response) {
		boolean result = false;
		try {
			String permChkStr1 = request.getParameter("p1");
			String permChkStr2 = request.getParameter("p2");
			
			logger.debug(" === START CHECKING PERMISSION ===");
			logger.debug("check string 1 : " + permChkStr1);
			logger.debug("check string 12 : " + permChkStr2);
			
			String userName = (String) request.getSession().getAttribute("userName");
		    if(userName == null || "".equals(userName)) return false;
		    ArrayList visibleMenuIDs = (ArrayList)request.getSession().getAttribute("visibleMenuIDs");
		    if(visibleMenuIDs != null && visibleMenuIDs.contains(permChkStr1) && userName.equalsIgnoreCase(permChkStr2))
		    	result = true;
		    
		    logger.debug("result : " + (result ? "pass" : "fail"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}

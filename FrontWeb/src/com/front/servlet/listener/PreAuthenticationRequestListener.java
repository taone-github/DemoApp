package com.front.servlet.listener;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

/**
 * Application Lifecycle Listener implementation class PreAuthenticationRequestListener
 *
 */
public class PreAuthenticationRequestListener implements ServletRequestListener {
	private final static transient Logger logger = LogManager.getLogger(PreAuthenticationRequestListener.class);
	public static final String USERNAME_KEY = "USERNAME";
    public static final String PASSWORD_KEY = "PASSWORD";
    /**
     * Default constructor. 
     */
    public PreAuthenticationRequestListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletRequestListener#requestDestroyed(ServletRequestEvent)
     */
    public void requestDestroyed(ServletRequestEvent arg0)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletRequestListener#requestInitialized(ServletRequestEvent)
     */
    public void requestInitialized(ServletRequestEvent arg0)  { 

		// TODO Auto-generated method stub
    	HttpServletRequest request = (HttpServletRequest)arg0.getServletRequest();
        if (request.getRequestURI().contains("j_security_check")) {
            final String username = request.getParameter("j_username");
            final String password = request.getParameter("j_password");

            HttpSession session = request.getSession();
            session.setAttribute(USERNAME_KEY, username);
            session.setAttribute(PASSWORD_KEY, password);
        }
    }
	
}

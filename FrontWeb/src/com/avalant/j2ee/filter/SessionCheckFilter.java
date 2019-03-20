package com.avalant.j2ee.filter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.security.Principal;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.front.servlet.logon.IASOldLogonServlet;


public class SessionCheckFilter implements Filter {
	private static Logger logger = Logger.getLogger(SessionCheckFilter.class);
	private static final String FILE_TARGET_LOGOUT_THE_USER = "/logon_screen.jsp";//"/invalidUserSession.jsp";
	private static final String STATUS_INVALID = "invalid";
	private static final String STATUS_VALID = "valid";

	private static final String[] UNREQ_URL_VALIDATE= {"/FrontWeb/ValidateUserServlet",
		"/FrontWeb/css",
		"/FrontWeb/js",
		"/FrontWeb/screen_template/frame",//20100802 tunning Validate User.	
		"/FrontWeb/login.jsp",
		"/FrontWeb/login_screen.jsp",
		"/FrontWeb/logout.jsp",
		//"/FrontWeb/j_security_check"
		};
	private static final String[] UNREQ_URL_VALIDATE_TYPE= {".bmp",".jpg",".jpeg",".gif", ".js",".css"};
	private static final String LOGON_SERVLET = "/FrontWeb/LogonServlet";
	/*
	 * (non-Java-doc) 
	 * 
	 * @see java.lang.Object#Object()
	 */
	public SessionCheckFilter() {
		super();
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.Filter#init(FilterConfig arg0)
	 */
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.Filter#doFilter(ServletRequest arg0, ServletResponse
	 *      arg1, FilterChain arg2)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		
		
		HttpServletRequest req = (HttpServletRequest) request;
		
		Principal user = req.getUserPrincipal();
	    HttpSession session = req.getSession();
		if (user != null && session.getAttribute("user") == null) {
	        session.setAttribute("user", user);
		}
		
		logger.debug("################# [ doFilter ]   : URL = "+req.getRequestURI()+", call validate = "+(checkURI(req.getRequestURI()))+", req.getRemoteUser() = "+req.getRemoteUser());
		
		
		if(req.getRequestURI().endsWith("/j_security_check")) {
			chain.doFilter(request, response);
			return;
		}
		
		if(req.getRequestURI().endsWith(IASOldLogonServlet.class.getSimpleName())) {			
			chain.doFilter(request, response);
			return;
		}
		
		HttpSession httpSession = req.getSession(false);
		String username = req.getRemoteUser();
		String sessionId = null;		
		if(httpSession!=null)sessionId = httpSession.getId();
		
		String isValidSession = "";
		logger.debug("[ doFilter ]   : sessionId = "+sessionId);
		logger.debug("[ doFilter ]   : username = "+username);
		
		if(username!=null && sessionId!=null){
			logger.debug("mould req.getRequestURI() >>>>>>" + req.getRequestURI());
			if(checkURI(req.getRequestURI())){
				String type = "check";
				if(req.getRequestURI().equalsIgnoreCase(LOGON_SERVLET))
					type = "login";
				String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/FrontWeb/ValidateUserServlet?type="+type+"&username="+username+"&sessionId="+sessionId;
				logger.debug("mould path >>>>>>" + path);
				//isValidSession = readURL(new URL(path));
				logger.debug("isValidSession >>>>>>" + isValidSession);
			}
		}
		if(isValidSession.equalsIgnoreCase(STATUS_INVALID)){
			//logger.debug("[ doFilter ]   :  ************************************************ INVALID SESSION ************************************");
			//logger.debug("[ doFilter ]   :  invalid session for username = "+username);
			//request.getRequestDispatcher(FILE_TARGET_LOGOUT_THE_USER).forward(request, response);
		}
		chain.doFilter(request, response);
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
	
	public String readURL(URL url) throws IOException{	
		//logger.debug("[ readURL ]   : url = "+url);
        URLConnection urlConn = url.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                urlConn.getInputStream()));
        String inputLine = in.readLine();
        in.close();
        return inputLine; 
    }
	
	private boolean checkURI(String URI){
		boolean requiredValidate = true;
		for(int i=0;i<UNREQ_URL_VALIDATE.length;i++){
			if(URI.startsWith(UNREQ_URL_VALIDATE[i])){
				requiredValidate = false;
			}
		}
		//20100802 tunning Validate User.
		for(int i=0;i<UNREQ_URL_VALIDATE_TYPE.length;i++){
			//logger.debug("[ checkURI ]   : URI = "+URI+", UNREQ_URL_VALIDATE_TYPE["+i+"] = "+UNREQ_URL_VALIDATE_TYPE[i]);
			if(URI.endsWith(UNREQ_URL_VALIDATE_TYPE[i])){
				requiredValidate = false;
			}
		}
		return requiredValidate;
	}

}
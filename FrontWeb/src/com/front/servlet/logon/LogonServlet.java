package com.front.servlet.logon;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.front.constant.FrontMenuConstant;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;
import com.master.util.EAFManualUtil;
import com.oneweb.j2ee.system.LoadXML;

/**
 * @version 1.0
 * @author
 */
@WebServlet(urlPatterns={"/LogonServlet"})
public class LogonServlet extends HttpServlet {
	private final static transient Logger log = LogManager.getLogger(LogonServlet.class);

	public void init() throws ServletException {
		try {
			String config = getServletContext().getRealPath("/WEB-INF/struts-config.xml");
			LoadXML loadxml = new LoadXML(config, FrontMenuConstant.STRUT_NAME);
			ConstantSystem constantSystem = new ConstantSystem(ConstantSystem.SYSTEM_EAF, FrontMenuConstant.STRUT_NAME);
			ConstantSystemM constantSystemM = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.LOG_CONFIG_FRONT);
			// Configuration path
			String log4j = constantSystemM.getConStantValue();

			// load logger(Log4J)
			PropertyConfigurator.configure(log4j);

		} catch (Exception e) {
			log.fatal("Cannot load log4j.properties", e);
		}
	}

	/**
	 * @see javax.servlet.http.HttpServlet#void
	 *      (javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	/**
	 * @see javax.servlet.http.HttpServlet#void
	 *      (javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.info("# LogonServlet " + request.getRemoteUser());
		
		try {
			ConstantSystem constantSystem = new ConstantSystem("EAF", "FrontMenuStrut");
			ConstantSystemM constantSystemM = (ConstantSystemM) ConstantSystem.constantList.get("IAS_VERSION");
			ConstantSystemM constantIASM = (ConstantSystemM) ConstantSystem.constantList.get("USE_IAS");
			
			String useIAM2 = EAFManualUtil.getConstantValue(ConstantSystem.USE_IAM2);
			constantIASM.setConStantValue("Y");
			String useIAS = constantIASM.getConStantValue();

			double iasVersion = 0.0D;
			String userName = request.getParameter("userName");   
			String password = request.getParameter("password");
			request.getSession().setAttribute("userName", userName);
			request.getSession().setAttribute("password", password);
			//log.debug("LogonServlet username := " + userName);
			//log.debug("LogonServlet password := " + password);
			try {
				iasVersion = Double.parseDouble(constantSystemM.getConStantValue());
			} catch (Exception ex) {
				iasVersion = 0.0D;
			}

//			if("Y".equalsIgnoreCase(useIAS) || "Y".equalsIgnoreCase(useIAM2)) {
//				
//				if (StringUtils.isEmpty(userName)) {
//					IASOldLogonServlet.showErr(request, response, 0); // not fill username
//					response.sendRedirect("login.jsp");
//					return;
//				} else if (StringUtils.isEmpty(password)) {
//					IASOldLogonServlet.showErr(request, response, 1); // not fill password
//					response.sendRedirect("login.jsp");
//					return;
//				}
//					
//				try {
//					log.debug("LogonServlet username := " + userName);
//					
////					if(request.getRemoteUser() != null) {
//////						// logout first
//////						log.debug("loging out user " + request.getRemoteUser());
//////						request.getSession().invalidate();
//////						request.logout();
////					}
////						
////					boolean isServletAuthen = request.authenticate(response);
////					if(isServletAuthen){
//////						request.logout();
////					}
//					
//					// login
//					request.login(userName, password);
//					Principal principal = request.getUserPrincipal();
//		            log.debug("principal " + principal);
//		            
//		            request.getSession().setAttribute("principal", new EncryptUtil().enCrypt(userName).toCharArray());
//		            request.getSession().setAttribute("secret", new EncryptUtil().enCrypt(password).toCharArray());
//		                
//				} catch(ServletException ex) {
//					log.error("Login Failed with a ServletException.."  + ex.getMessage());
//					request.getSession().setAttribute("err", ex.getMessage());
//		            response.sendRedirect("login.jsp");
//		            return;
//				}
//			}
			
			log.debug("###### getRemoteUser: " + request.getRemoteUser());
			
			System.out.println("iasVersion >>>>>>" + iasVersion);
			System.out.println("useIAS >>>>>>" + useIAS);
			
			if ((iasVersion >= 4.0D) && ("Y".equalsIgnoreCase(useIAS))) {
				System.out.println("LogonServlet Security >>>>>>");
//				response.sendRedirect("IASOldLogonServlet?userName=" + userName + "&password=" + password);
				response.sendRedirect("IASOldLogonServlet");
				return;
			} else if ((iasVersion >= 3.0D) && ("Y".equalsIgnoreCase(useIAS))) {
				System.out.println("LogonServlet Not Security >>>>>>");
				response.sendRedirect("IASLogonServlet");
				return;
			}
			System.out.println("LogonServlet Security >>>>>>");
			response.sendRedirect("IASOldLogonServlet?userName=" + userName + "&password=" + password);
		} catch (Exception e) {
			log.error("ERROR", e);
			response.sendRedirect("login.jsp");
		}
	}
}

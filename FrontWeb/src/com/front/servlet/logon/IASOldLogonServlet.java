package com.front.servlet.logon;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.a2m.ejb.service.A2MProxy;
import com.a2m.service.proxy.ServiceProxyManager;
import com.avalant.iam.service.UserInfoService;
import com.eaf40.utils.StringUtils;
import com.front.constant.FrontMenuConstant;
import com.iam.model.ObjectM;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;
import com.master.util.Checker;
import com.master.util.EAFManualUtil;
import com.master.util.MasterConstant;
import com.oneweb.j2ee.pattern.util.XMLUtil;

/**
 * Servlet implementation class IASOldLogonServlet
 */
public class IASOldLogonServlet extends HttpServlet {
	private final static transient Logger log = LogManager.getLogger(IASOldLogonServlet.class);
	private static final long serialVersionUID = 1L;
	public static final String USERNAME_KEY = "USERNAME";
    public static final String PASSWORD_KEY = "PASSWORD";

	private static String LOGIN_SCREEN = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("loginScreen");
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public IASOldLogonServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init() throws ServletException {
		/*
		 * try { String config =
		 * getServletContext().getRealPath("/WEB-INF/struts-config.xml");
		 * LoadXML loadxml = new LoadXML(config); ConstantSystem constantSystem
		 * = new ConstantSystem(ConstantSystem.SYSTEM_EAF); ConstantSystemM
		 * constantSystemM =
		 * (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem
		 * .LOG_CONFIG_FRONT); //Configuration path String log4j =
		 * constantSystemM.getConStantValue();
		 * 
		 * 
		 * //load logger(Log4J) PropertyConfigurator.configure(log4j);
		 * 
		 * } catch (Exception e) { log.fatal("Cannot load log4j.properties", e);
		 * }
		 */
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doPost(request, response);
		throw new UnsupportedOperationException("IASOldLogonServlet.get");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.info("# IASOldLogonServlet " + request.getRemoteUser());
		log.info("# shooter " + request.getParameter("shooter"));
		
		if(!StringUtils.isEmpty(request.getParameter("shooter"))) {
			return;
		}
		
		// Sam add for security
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");

		ConstantSystem constantSystem = new ConstantSystem(ConstantSystem.SYSTEM_EAF, FrontMenuConstant.STRUT_NAME);
		ConstantSystemM constantSystemM = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.IAS_VERSION);

		ConstantSystemM iamUrl = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.WS_IAM_URL);
		ConstantSystemM iamUserName = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.WS_IAM_USERNAME);
		ConstantSystemM iamPassword = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.WS_IAM_PASSWORD);
		ConstantSystemM iamAuthen = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.WS_IAM_AUTHEN);
		//ConstantSystemM constantIASM = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.USE_IAS);
		//ConstantSystemM constantIAM2 = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.USE_IAM2);	
		//ConstantSystemM systemName = (ConstantSystemM) ConstantSystem.constantList.get(ConstantSystem.SYSTEM_NAME_FRONT);
		
		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		* FIX : 201710031041 : Check null in IASOldLogonServlet when get constant value
		* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		//String useIAS = constantIASM.getConStantValue();
		//String useIAM2 = constantIAM2 != null ? constantIAM2.getConStantValue() : "N";
		String useIAS = EAFManualUtil.getConstantValue(ConstantSystem.USE_IAS);
		String useIAM2 = EAFManualUtil.getConstantValue(ConstantSystem.USE_IAM2);
		if(StringUtils.isEmpty(useIAS)) {
			useIAS = "N";
		}
		if(StringUtils.isEmpty(useIAM2)) {
			useIAM2 = "N";
		}
		
		// Get IP Address via http(Not available with localhost)
		java.util.Enumeration e1 = ((HttpServletRequest) request).getHeaderNames();
		
				
		while (e1.hasMoreElements()) {
			String key = (String) e1.nextElement();
			String value = ((HttpServletRequest) request).getHeader(key);
			log.debug(" GET Client Side IP :" + key + ": " + value);
		}
		log.debug("in doPost");

		String userName = "";
		String password = "";
		try {
			userName = request.getRemoteUser();
			
			//char[] secret = (char[]) request.getSession().getAttribute("secret");
			
			//password = new EncryptUtil().deCrypt(new String(secret));
//			password = request.getParameter("password");
//			password = request.getParameter("j_password");
			password = (String)request.getSession().getAttribute(PASSWORD_KEY);
			request.getSession().removeAttribute(PASSWORD_KEY);
			/*******************************************
			 * PLEASE REMOVE
			 */
			
			Enumeration<String> paramNames = request.getParameterNames();
			
			log.debug("XXX " + request.getAttribute("XXX"));
			
			while (paramNames.hasMoreElements()) {
				String string = (String) paramNames.nextElement();
				log.debug("param name " + string);
				log.debug("param val " + request.getParameter(string));
			}
			
			Checker.ifNullOrEmpty(password, "Password is null", null);
			
		} catch (Exception e) {
			e.printStackTrace();
			showErr(request, response, 0); // not fill username
		}

		log.debug("userName getRemoteUser ==>" + userName);
		log.debug("useIAS==>" + useIAS);

		if ("Y".equalsIgnoreCase(useIAS) || "Y".equalsIgnoreCase(useIAM2)) {
			request.getSession().setAttribute("userName", userName);
//			request.getSession().setAttribute("password", password);
		} else {
			request.getSession().setAttribute("userName", "System");
		}
		log.debug(iamUrl);
		log.debug(iamUserName);
		// log.debug(ServiceConstant.WS_IAM_PASSWORD);
		log.debug(iamPassword);
		if ((userName == null || userName.equals("")) && ("Y".equalsIgnoreCase(useIAS))) {
			showErr(request, response, 0); // not fill username
		} else if ((password == null || password.equals("")) && ("Y".equalsIgnoreCase(useIAS))) {
			showErr(request, response, 1); // not fill password
		} else {
			// IAMServiceBeanProxy proxy = new
			// IAMServiceBeanProxy(ServiceConstant.WS_IAM_URL,
			// ServiceConstant.WS_IAM_USERNAME, ServiceConstant.WS_IAM_PASSWORD,
			// ServiceConstant.WS_IAM_AUTHEN);

			try {
				String authenStr = "";
				String roleName = "";
				String organizeID = "";
				HashMap hResult = new HashMap();
				Vector vObject = new Vector();
				if ("Y".equalsIgnoreCase(useIAS)) {
					log.debug("===> iamUserName.getConStantValue() =" + iamUserName.getConStantValue());
					log.debug("===> iamPassword.getConStantValue() =" + iamPassword.getConStantValue());
					log.debug("===> iamUrl.getConStantValue() =" + iamUrl.getConStantValue());
					/*
					 * IAMServiceBeanProxy proxy = new
					 * IAMServiceBeanProxy(iamUserName
					 * .getConStantValue(),iamPassword.getConStantValue());
					 */
					

					ServiceProxyManager proxy = A2MProxy.getServiceProxyManager();
					/*
					 * Change Lookup WebService to EJB IAMServiceBeanProxy proxy
					 * = new IAMServiceBeanProxy(); // mould
					 * proxy.setEndpoint(iamUrl.getConStantValue());
					 */

					// proxy.setEndpoint("http://localhost:9081/A2MWebService/services/IAMServiceBean");//
					// mould
					//String authenMessage = proxy.getAuthentication(userName, password);
					String authenMessage = "Logon Success";

					if (authenMessage.indexOf("Logon Success") != -1) {
						
						XMLUtil xmlUtil = new XMLUtil();
						// Vector vObj =
						// (Vector)xmlUtil.xml2Bean(proxy.getObjectInRolesByUserName(userName));
//							String result = proxy.getObjectInUser(userName, "IEAT");
						
						/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
						* FIX : 201710031041 : Check null in IASOldLogonServlet when get constant value
						* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
						String systemName = EAFManualUtil.getConstantValue(ConstantSystem.SYSTEM_NAME_FRONT);
						if(StringUtils.isEmpty(systemName)) {
							systemName = "PCMS";
						}
						//log.debug("===> systemName.getConStantValue() =" + systemName.getConStantValue());
						String result = proxy.getObjectInUser(userName, systemName);
//						String result = proxy.getObjectInUser(userName,"PCMS");
						
						StringTokenizer strPipe = new StringTokenizer(result, "|");
						// get logon message

						// Get current Role of user from A2M
						log.debug("===> countTokens =" + strPipe.countTokens());
						if (1 < strPipe.countTokens()) {
							vObject = (Vector) xmlUtil.xml2Bean((String) strPipe.nextElement());
							organizeID = (String) strPipe.nextElement();
						} else {
							vObject = (Vector) xmlUtil.xml2Bean((String) strPipe.nextElement());
						}

						log.debug("===> vObj =" + vObject);
						log.debug("===> organizeID =" + organizeID);

						for (int i = 0; i < vObject.size(); i++) {
							if (i > 0)
								roleName += ",";
							ObjectM object = (ObjectM) vObject.get(i);
							roleName += "'" + object.getObjectCode() + "'";
							vObject.remove(i);
							vObject.add(i, object.getObjectCode());
						}	
						
						log.debug("===> vObj2 =" + vObject);						
						authenMessage += "|" + roleName;						
						
					}

					// String authenMessage =
					// proxy.getAuthenticationForLogin(userName, password);
					log.debug("===> authenMessage =" + authenMessage);
					StringTokenizer strPipe = new StringTokenizer(authenMessage, "|");
					// get logon message

					// Get current Role of user from A2M
					log.debug("===> countTokens =" + strPipe.countTokens());
					if (1 < strPipe.countTokens()) {
						authenStr = (String) strPipe.nextElement();
						roleName = (String) strPipe.nextElement();
					} else {
						authenStr = (String) strPipe.nextElement();
					}

				} else if("Y".equalsIgnoreCase(useIAM2)){
					log.debug("useIAM2==>" + useIAM2);
					request.getSession().setAttribute("useIAM2", useIAM2);
					String authenMessage = "Logon Success";
					
					String accessToken = "";
					UserInfoService iam2restService = new UserInfoService(request);
					/*  get Access Token IAM2REST */
					
					if(null==request.getSession().getAttribute(MasterConstant.ACCESS_TOKEN) || "".equals(request.getSession().getAttribute(MasterConstant.ACCESS_TOKEN))){
//						response.sendRedirect("logon_error.jsp");
//						return;
						try {
							log.debug("<<<<<<< get Access Token IAM2REST >>>>>>");
							JSONObject data = new JSONObject();
								data.put("username", userName);
								data.put("password", password);
								data.put("system_id", "-99");
								data.put("system_secret", "1");
							accessToken = iam2restService.loginService(data);							
						} catch (Exception e) {
							log.warn("", e);
						}
					
						request.getSession().setAttribute(MasterConstant.ACCESS_TOKEN, accessToken);
						log.debug("Access-Token >>>>>>" + request.getSession().getAttribute(MasterConstant.ACCESS_TOKEN));
					}else{
						accessToken = (String)request.getSession().getAttribute(MasterConstant.ACCESS_TOKEN);
					}
					if (accessToken != null && !accessToken.isEmpty()) {
						/*  get Menu IAM2REST */
						log.debug("<<<<<<< get Menu IAM2REST >>>>>>");
						
						JSONObject jsonObject = iam2restService.getPermsService(accessToken);
						JSONArray object = jsonObject.getJSONArray("objectAccesses");
						
						for (int i = 0; i < object.length(); i++) {
							String object_type = object.getJSONObject(i).getString("object_type");
							
							if("Menu".equalsIgnoreCase(object_type)){
								String object_name = object.getJSONObject(i).getString("object_name");

								if((vObject.size() > 0) && !object_name.isEmpty()) roleName += ",";									
								roleName += "'" + object_name + "'";
								vObject.add(object_name);
							}
						}
						log.debug("===> vObj2 =" + vObject);						
						authenMessage += "|" + roleName;
						
						// String authenMessage =
						// proxy.getAuthenticationForLogin(userName, password);
						log.debug("===> authenMessage =" + authenMessage);
						StringTokenizer strPipe = new StringTokenizer(authenMessage, "|");
						// get logon message

						// Get current Role of user from A2M
						log.debug("===> countTokens =" + strPipe.countTokens());
						if (1 < strPipe.countTokens()) {
							authenStr = (String) strPipe.nextElement();
							roleName = (String) strPipe.nextElement();
						} else {
							authenStr = (String) strPipe.nextElement();
						}
					} 
				} else {
					authenStr = "Logon Success";
				}

				log.debug("===> authenStr =" + authenStr);
				log.debug("===> object =" + roleName);
				if (authenStr.indexOf("Logon Fail") == -1) {// "No Logon Fail"
					if (authenStr.indexOf("new password") > -1) {
						// saveActivityLog(request,response,"login success:"+authenStr,ServiceConstant.LogStatus.COMPLETE,branch);
						log.debug("in new password");
						showErr(request, response, 6); // Force change password
						response.sendRedirect("logon_error.jsp");
					} else {
						// saveActivityLog(request,response,"login success:"+authenStr,ServiceConstant.LogStatus.COMPLETE);
						if (authenStr.indexOf("Logon Success") == -1) {
							log.debug("in password warning");
							request.getSession().setAttribute("pwdWarnning", authenStr);
						}
						log.debug("===> in success ");
						// response.sendRedirect("FrontController?action=LOAD_MENU");
						// request.getSession().setAttribute("roleNameFromAD",
						// roleName);
						request.getSession().setAttribute("roleNameFromAD", vObject); // mould
						request.getSession().setAttribute("permChkStr3", organizeID); // mould

						response.sendRedirect("FrontController?action=LOAD_MENU");
					}
				} else { // "Logon Fail"
					log.debug("===> in fail ");
					authenStr = authenStr.substring(authenStr.indexOf("Logon Fail,") + 11, authenStr.length());
					// saveActivityLog(request,response,"Fail:"+authenStr,"I",branch);
					if (authenStr.indexOf("has been logged") != -1) {
						request.getSession().setAttribute("errorLogon", authenStr);
						showErr(request, response, 6); // Err in Authenitcate
														// from IAM
					} else if (authenStr.indexOf("You are not authorized") != -1) {
						request.getSession().setAttribute("errorLogon", authenStr);
						showErr(request, response, 7); // Err in Authenitcate
														// from IAM
					} else {
						request.getSession().setAttribute("errorLogon", authenStr);
						showErr(request, response, 5); // Err in Authenitcate
														// from IAM
					}
					//response.sendRedirect("logon_error.jsp");
				} 
			} catch (Exception e) {
				log.error("ERROR", e);
				showErr(request, response, 4); // Err in call IAM WebService
			}
		}
	}

	public static void showErr(HttpServletRequest request, HttpServletResponse response, int err) throws IOException {
		String logPage = request.getParameter("logPage");
		if ("logon".equals(logPage)) {
			request.getSession().setAttribute("err", "" + err);
			response.sendRedirect("index.jsp");
		} else if ("login".equals(logPage)) {
			request.getSession().setAttribute("err", "" + err);
			response.sendRedirect("index.jsp");
		} else {
			log.debug("err code=" + err);
			if (err == 0) {
				request.getSession().setAttribute("err", "Please fill in Username");
			} else if (err == 1) {
				request.getSession().setAttribute("err", "Please fill in Password");
			} else if (err == 6) {
				request.getSession().setAttribute("err", "This username has been logged into system");
			} else if (err == 7) {
				request.getSession().setAttribute("err", "You are not authorized to use this application");
			} else if (err == 8) {
				request.getSession().setAttribute("err", "You are not associated with any TISCO branch.");
			} else {
				request.getSession().setAttribute("err", "Your Username or Password is not correct. Please fill in again");
			}
//			response.sendRedirect("index.jsp");
			response.sendRedirect(LOGIN_SCREEN);
		}
	}

	private void saveActivityLog(HttpServletRequest request, HttpServletResponse response, String description) {
		String browser = getBrowser(request.getHeader("User-Agent"));
		String os = getOS(request.getHeader("User-Agent"));
		String resorution = "";
		String session = request.getSession().getId();
		String user = request.getParameter("userName");
		String clientIP = request.getRemoteAddr();
		// String branch =
		// (String)request.getSession().getAttribute("branchCode");
		String module = "Access Log";
		// AccessLogManager.getInstance().insertAccessLog(user, branch, status,
		// module, description, "Log In", clientIP, browser, os, resorution,
		// session);
	}

	private String getBrowser(String agentStr) {
		String browserName = "Unknown Browser";
		String version = "";
		int nameOffset = 0;
		int verOffset = 0;
		// In Internet Explorer, the true version is after "MSIE" in userAgent
		if ((verOffset = agentStr.indexOf("MSIE")) != -1) {
			browserName = "Microsoft Internet Explorer";
			version = agentStr.substring(verOffset + 5, verOffset + 8);
		}
		// In Opera, the true version is after "Opera"
		else if ((agentStr.indexOf("Opera")) != -1) {
			browserName = "Opera";
			version = agentStr.substring(verOffset + 6, verOffset + 9);
		}
		// In most other browsers, "name/version" is at the end of userAgent
		else if ((nameOffset = agentStr.lastIndexOf(' ') + 1) < (verOffset = agentStr.lastIndexOf('/'))) {
			browserName = agentStr.substring(nameOffset, verOffset);
			version = agentStr.substring(verOffset + 1);
		}
		return browserName + " " + version;
	}

	private String getOS(String agentStr) {
		String osName = "Unknown OS";
		if (agentStr.indexOf("Win") != -1)
			osName = "Windows";
		if (agentStr.indexOf("Mac") != -1)
			osName = "MacOS";
		if (agentStr.indexOf("X11") != -1)
			osName = "UNIX";
		if (agentStr.indexOf("Linux") != -1)
			osName = "Linux";
		return osName;
	}

}

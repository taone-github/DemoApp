package com.front.j2ee.pattern.control;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.eaf.properties.EAFProperties;
import com.front.constant.FrontMenuConstant;
import com.front.view.webaction.menu.LoadMenuWebAction;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;
import com.oneweb.j2ee.pattern.control.RequestProcessor;
import com.oneweb.j2ee.pattern.control.event.EventResponse;
import com.oneweb.j2ee.pattern.util.ErrorUtil;
import com.oneweb.j2ee.pattern.view.form.FormHandleManager;
import com.oneweb.j2ee.pattern.view.webaction.WebAction;
import com.oneweb.j2ee.system.LoadXML;
        
/**   
 * @author tarath
 *
 * To change this generated comment edit the template variable "typecomment":
 * Window>Preferences>Java>Templates.
 * To enable and disable the creation of type comments go to
 * Window>Preferences>Java>Code Generation.
 */
public class FrontController extends HttpServlet  {

    public static final int PAGE = 0;

    public static final int ACTION = 1;

    private static final String INDEX_PAGE = "index.jsp";

    //declare logger
    private final static transient Logger logger = Logger.getLogger(FrontController.class);

    private static String mappingXMLPath = "";
	public static ConstantSystem constantSystem = null;
    /*
	/* - check whether user login
	 * - if it only redirect( page parameter !=null ), redirect it. 
	 * - if it has form, validate form
	 * - create event
	 * - send event to Backend process
	 * - get response back from backend
	 * - map ModelManager to FormHandler 
	 * - screenFlowManager redirect to the next page
	 */

    /*
     * 1) Check whether user is logined
     */

    /*
     * 2) If redirect only, redirect to appropriate JSPs
     */

    /*
     * 3) If form, validate form
     */

    //initial class from xml file
	

	
    public void init() throws ServletException { 
        System.out.print("<====init===>");
        
        
        
        String config = getServletContext().getRealPath("/WEB-INF/struts-config.xml");
        LoadXML loadxml = new LoadXML(config, FrontMenuConstant.STRUT_NAME);
        System.out.println("LoadXML.getSchemaName() FrontWeb==>"+LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getSchemaName());
        constantSystem = new ConstantSystem(ConstantSystem.SYSTEM_EAF, FrontMenuConstant.STRUT_NAME);
        ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.LOG_CONFIG_FRONT);
        //Configuration path
//      String log4j = getServletContext().getRealPath("/WEB-INF/log4j.properties");
        String log4j = constantSystemM.getConStantValue();
        //SAM FOR TEST
        //log4j = "C:/jar/master/log4j.properties";

        /***********************************************************************
         * @param :mappingXMLPath
         * **********************
         *  It can be either the path of the process-config.xml or
         *  the content of the the process-config.xml
         * **********************
         * RUKYEE : 18 AUG 2004
         **********************************************************************/

        //load logger(Log4J)
        PropertyConfigurator.configure(log4j);

        logger.debug("..........[FrontController] init() :: mappingXMLPath is " + mappingXMLPath);

        logger.info("===================== initial XML ====================");
        
		
        logger.debug("loadxml.getSchemaName()==>"+loadxml.getSchemaName());

/*
        logger.info("================== build up cache ====================");
        try {
        	TableLookupCache.startup();
        } catch (SQLException e) {
        	logger.error(e.getMessage());
        }
*/
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	
    	request.getSession().setAttribute("front", "abc");

        //String servletString = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/FrontController?";
    	String servletString = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/FrontController?";

        String page = (String) request.getParameter("page");
        String action = (String) request.getParameter("action");
        String id = (String) request.getParameter("id");

        /** * Set Locale = Thai ** */
        Locale locale = Locale.getDefault();
        Locale.setDefault(new Locale("TH", "th"));

        if (id != null && !id.equals("") && !id.equals("undefined"))
            id = "?#" + id;
        else
            id = "";

        logger.info("FrontController>> start service===================================================");

        logger.debug("Server Name >> " + request.getServerName());
        ErrorUtil.clearErrorInSession(request);

        FrontScreenFlowManager screenFlowManager = (FrontScreenFlowManager) request.getSession(true).getAttribute("screenFlowManager");

        if (screenFlowManager == null) {
            screenFlowManager = new FrontScreenFlowManager(FrontMenuConstant.STRUT_NAME);
            request.getSession(true).setAttribute("screenFlowManager", screenFlowManager);
        }

        FormHandleManager formHandleManager = (FormHandleManager) request.getSession(true).getAttribute("formHandlerManager");

        if (formHandleManager == null) {
            request.getSession(true).setAttribute("formHandlerManager", new FormHandleManager());
        }

        // If the request type is PAGE
        logger.debug("page=" + page);

        if (page != null && !page.equals("") && screenFlowManager != null) {
            screenFlowManager.setNextScreenByPage(page);
        }

        logger.debug("getSession in screenFlowManager=" + request.getSession(true).getAttribute("screenFlowManager"));

        // If the request type is ACTION
        logger.debug("action=" + action);

        // ACTION = logout
        if (action != null && action.equalsIgnoreCase("logout")) {
            //clear Session
            request.getSession().invalidate();
        }

        WebAction webAction = null;
        boolean eventResponseResult = false;

        // ACTION = other actions
        if (action != null && !action.equals("")) {

            logger.debug("FormHandleManager:" + formHandleManager);

            boolean hasNoFormErrors = false;

            if (formHandleManager != null) {
                //    1. Validate form
                logger.debug("validating form");
                hasNoFormErrors = formHandleManager.processForm(request);
            } else {
                // 2. No FormHandler Manager in Session
                logger.debug("No FormhandlerManager in session");
                hasNoFormErrors = true;
            }

            logger.debug("hasNoFormErrors=" + hasNoFormErrors);

            if (hasNoFormErrors) {
            	try {
            		LoadMenuWebAction loadMenuWebAction = new LoadMenuWebAction();
            		logger.debug("New Class : ");
            	}catch(Exception e){ 
            		logger.debug("New Class : " + e.getMessage());
            	}
            	 
// *** Change Load For Jboss 27/02/2013          	
            	logger.debug("Get Remote action: " + action);
            	
            	String className = null;
        		HashMap actionClassName = LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getActionClassName();
        		
        		if (actionClassName != null){
                	if(actionClassName.get(action) != null)
                		 className = (String)actionClassName.get(action);
                }
            	
            	try {

            		webAction = (WebAction)Class.forName(className).newInstance();     		
            		
            		//webAction = (WebAction) WebActionFinder.find(action, FrontMenuConstant.STRUT_NAME);	
// *** END Change Load For Jboss 27/02/2013
            	}catch(Exception e){
            		logger.debug("New Class : " + e.getMessage());
            	}
                
                logger.debug("WebAction to be found :" + webAction);
                //logger.debug("Get Remote User: " + "wasadmin");
                logger.debug("Get Remote User: " + request.getRemoteUser());
                //Check Access Document
                //DocumentControl documentControl = new DocumentControl();
                //  2. Process action before calling model
               	webAction.setRequest(request);	
                
                boolean frontEndResult = webAction.preModelRequest();
                //  3. Process model request

                if (webAction.requiredModelRequest() && frontEndResult) {

                    //int vpdID = Integer.parseInt((String)request.getSession().getAttribute("brokerageID"));
                    EventResponse eventResp = (new RequestProcessor(request, FrontMenuConstant.STRUT_NAME)).processRequest(webAction);

                    if (eventResp == null) {
                        // There is error processing request in RequestProcessor object
                        // Do not set the next page, similar to the regular form error
                        logger.debug("EvenResponse is null");

                    } else {

                        // 4. Process response from model

                        boolean result = webAction.processEventResponse(eventResp);
                        eventResponseResult = result;
                        logger.debug("ProcessEventResponse: result is " + result);

                        if (screenFlowManager == null) {
                            screenFlowManager = new FrontScreenFlowManager(FrontMenuConstant.STRUT_NAME);
                            logger.info("about to call setNextScreenByAction but screenFlowManager == null. create new screenFlowManager in session");
                            request.getSession().setAttribute("screenFlowManager", screenFlowManager);

                        }
                        logger.debug("RESULT " + result);
                        screenFlowManager.setNextScreenByAction(action, result);
                    }

                } else {
                    // Set the next page
                    if (frontEndResult)
                        eventResponseResult = true;
                    else
                        eventResponseResult = false;

                    if (screenFlowManager == null) {
                        screenFlowManager = new FrontScreenFlowManager(FrontMenuConstant.STRUT_NAME);
                        logger.debug("about to call setNextScreenByAction but screenFlowManager == null. create new screenFlowManager in session");
                        request.getSession().setAttribute("screenFlowManager", screenFlowManager);
                    }
                    screenFlowManager.setNextScreenByAction(action, eventResponseResult);
                }
                
                

            } else {
                // There is form error. Do not set the next page. Stop here
                logger.debug("Form Error : hasNoFormErrors = false");
            }
        }

        // Default next activity is PAGE

        int nextActivityType = PAGE;

        if (webAction != null) {
            if (eventResponseResult) {
                // If result from EventProcessor is true or
                // if there is no Model Request for this Web Action
                nextActivityType = webAction.getNextActivityType();
            }
        }
        logger.debug("nextActivityType = " + nextActivityType);

        logger.info("end service==================================================");
        
        
        switch (nextActivityType) {
        case PAGE:
            logger.info(INDEX_PAGE + id);
            response.sendRedirect(INDEX_PAGE + id);
            break;
        case ACTION:
            String redirectedAction = webAction.getNextActionParameter();
            logger.info("FrontController>> redirecting....." + servletString + redirectedAction);
            response.sendRedirect(servletString + redirectedAction);
            break;
        default:
            response.sendRedirect(INDEX_PAGE + id);
            break;
        }
    }

}

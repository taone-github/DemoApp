package com.front.servlet.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.front.constant.FrontMenuConstant;
import com.front.dao.menu.MenuMDAO;
import com.front.form.menu.MenuHandlerManager;
import com.front.model.menu.MenuM;
import com.front.service.EJBDAOFactory;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;

import edu.yale.its.tp.cas.client.filter.CASFilter;

/**
 * Servlet implementation class CheckLeftMenuServlet
 * @author Kitti
 * Use for Check session of menu and userName if null then reload to session
 * on Project LIS it's session lost on timeout
 */

public class CheckLeftMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static transient Logger log = LogManager.getLogger(CheckLeftMenuServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckLeftMenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Vector<MenuM> vecMenus = (Vector<MenuM>)request.getSession().getAttribute("vecMenus");
		
		if(null == vecMenus){
			vecMenus = new Vector(); 
			String logonID = "";     
			ConstantSystem constantSystem = new ConstantSystem(ConstantSystem.SYSTEM_EAF, FrontMenuConstant.STRUT_NAME);
	        ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.IAS_VERSION);
	        ConstantSystemM constantIASM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.USE_IAS);
	        String useIAS = constantIASM.getConStantValue();
	        double iasVersion = 0;
	        
	        Vector menuStyle = new Vector();
			String roleNames = "";
	        try {
	        	iasVersion = Double.parseDouble(constantSystemM.getConStantValue());
	        } catch (Exception ex) {
	        	iasVersion = 0;
	        };
	        
	        if  (iasVersion >= 4 && "Y".equalsIgnoreCase(useIAS) ){
	        	logonID = (String)request.getRemoteUser();
	        } else if  (iasVersion >= 3 && "Y".equalsIgnoreCase(useIAS) ){
	        	logonID =  (String) request.getSession().getAttribute(CASFilter.CAS_FILTER_USER);	
	        } else if (iasVersion < 3 && "Y".equalsIgnoreCase(useIAS) ) {
	        	//logonID = (String)request.getSession().getAttribute("userName"); //getRequest().getRemoteUser();
	        	logonID = (String)request.getRemoteUser();
	        }        
	        
	        if(null == logonID || logonID.equalsIgnoreCase("")){
	        	logonID = (String)request.getParameter("username");
	        	request.getSession().setAttribute("USERNAME_GEN_LEFT", logonID);
	        }
	        try {
	        	log.info("logonID = "+logonID);
	            if (logonID != null) {
	                // get Menu
	    			Vector vtMenuID = new Vector();
	    			    		    			
	                MenuMDAO userMDao = EJBDAOFactory.getMenuMDAO();
	                
	                if ((iasVersion < 3 || iasVersion == 4) && "Y".equalsIgnoreCase(useIAS) ) {
						roleNames = (String)request.getSession().getAttribute("roleNameFromAD");
		            	log.info(" roleNames AD : "+roleNames);
						vecMenus = userMDao.loadMenus(roleNames);
	                	menuStyle = userMDao.loadMenuStyle(logonID);
	                } else {
	                	vecMenus = userMDao.loadMenus();
	                }
	                
	                MenuHandlerManager menuHandler = new MenuHandlerManager();
	        		ArrayList<MenuM> topLevelMenus = new ArrayList<MenuM>();
	        		HashMap<String,ArrayList<MenuM>> subMenus = new HashMap<String, ArrayList<MenuM>>();
	                if(vecMenus != null && !vecMenus.isEmpty()){
	        			for(MenuM menuM :vecMenus){
	        				if("1".equals(menuM.getMenuLevel())) {
	        					topLevelMenus.add(menuM);
	        					if("LABEL".equalsIgnoreCase(menuM.getMenuType().trim())) {
	            					subMenus.put(menuM.getMenuID(), new ArrayList<MenuM>());
	            				}
	        				} else {
	        					ArrayList<MenuM> subGroup = subMenus.get(menuM.getMenuReference());
	        					if(null != subGroup){
	        						subGroup.add(menuM);
	        					}	
	        					if("LABEL".equalsIgnoreCase(menuM.getMenuType().trim())) {
	            					subMenus.put(menuM.getMenuID(), new ArrayList<MenuM>());
	            				}
	        				}		
	        			}
	        		}
	        		menuHandler.setTopLevelMenus(topLevelMenus);
	        		menuHandler.setSubMenus(subMenus);
	        		log.debug("vecMenus==>"+vecMenus);
	                log.debug("vecMenus.size()==>"+vecMenus.size());
	                request.getSession(true).setAttribute("menuHandlerManager",menuHandler);
	                request.getSession().setAttribute("vecMenus", vecMenus);
	            }
	        }catch(Exception e){
	        	log.error(e.getMessage());
	        }
		}
	}
}



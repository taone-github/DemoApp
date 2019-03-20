/**
 * 
 */
package com.front.view.webaction.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Vector;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.avalant.iam.service.UserInfoService;
import com.oneweb.j2ee.pattern.control.event.Event;
import com.oneweb.j2ee.pattern.control.event.EventResponse;
import com.oneweb.j2ee.pattern.view.webaction.WebAction;
import com.oneweb.j2ee.pattern.view.webaction.WebActionHelper;
import com.front.constant.FrontMenuConstant;
import com.front.dao.menu.MenuMDAO;
import com.front.form.menu.MenuHandlerManager;
import com.front.j2ee.pattern.control.FrontController;
import com.front.j2ee.pattern.control.FrontScreenFlowManager;
import com.front.model.menu.MenuM;
import com.front.service.EJBDAOFactory;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;
import com.master.util.EAFManualUtil;
import com.master.util.MasterConstant;

import edu.yale.its.tp.cas.client.filter.CASFilter;

/**
 * @author user
 *
 */
public class LoadMenuWebAction extends WebActionHelper implements WebAction {
    private final static transient Logger log = LogManager.getLogger(LoadMenuWebAction.class);
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#getNextActivityType()
	 */
	public int getNextActivityType() {
        return FrontController.ACTION;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#preModelRequest()
	 */
	public boolean preModelRequest() {
		log.debug("Load Menu WebAction");
        String logonID = "";         
		ConstantSystem constantSystem = new ConstantSystem(ConstantSystem.SYSTEM_EAF, FrontMenuConstant.STRUT_NAME);

		/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		* FIX : 201703241129
		* Loading constant value from EAFManualUtil for avoid nullpointerexception when constant USE_IAM2 does not exists
		* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
		//        ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.IAS_VERSION);
//        ConstantSystemM constantIASM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.USE_IAS);
//        ConstantSystemM constantIAM2 = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.USE_IAM2);
//        String useIAS = constantIASM.getConStantValue();
        //String useIAM2 = constantIAM2.getConStantValue();
		String iasVersionStr = EAFManualUtil.getConstantValue(ConstantSystem.IAS_VERSION);
        String useIAS = EAFManualUtil.getConstantValue(ConstantSystem.USE_IAS);
        String useIAM2 = EAFManualUtil.getConstantValue(ConstantSystem.USE_IAM2);
        
        double iasVersion = 0;
        Vector<MenuM> vecMenus = new Vector<MenuM>(); 
        Vector menuStyle = new Vector();
		String roleNames = "";
		Vector vObject = new Vector();
		MenuHandlerManager menuHandler = new MenuHandlerManager();
		ArrayList<MenuM> topLevelMenus = new ArrayList<MenuM>();
		HashMap<String,ArrayList<MenuM>> subMenus = new HashMap<String, ArrayList<MenuM>>();
		
        try {
        	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        	* FIX : 201703241129
        	* Loading constant value from EAFManualUtil for avoid nullpointerexception when constant USE_IAM2 does not exists
        	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
        	//iasVersion = Double.parseDouble(constantSystemM.getConStantValue());
        	iasVersion = Double.parseDouble(iasVersionStr);
        } catch (Exception ex) {
        	iasVersion = 0;
        };
        if  (iasVersion >= 4 && "Y".equalsIgnoreCase(useIAS) ){
        	logonID = getRequest().getRemoteUser();
        } else if  (iasVersion >= 3 && "Y".equalsIgnoreCase(useIAS) ){
        	logonID =  (String) getRequest().getSession().getAttribute(CASFilter.CAS_FILTER_USER);	
        } else if (iasVersion < 3 && "Y".equalsIgnoreCase(useIAS) ) {
        	//logonID = (String)getRequest().getSession().getAttribute("userName"); //getRequest().getRemoteUser();
        	logonID = getRequest().getRemoteUser();
        } else if("Y".equalsIgnoreCase(useIAM2)) {
        	logonID = getRequest().getRemoteUser();
        }
        //this session use for generate menu only
        getRequest().getSession().setAttribute("USERNAME_GEN_LEFT",logonID);
	    System.out.println("LoadMenuWebAction iasVersion >>>>>>" + iasVersion);
	    System.out.println("LoadMenuWebAction useIAS >>>>>>" + useIAS);
	    System.out.println("LoadMenuWebAction useIAM2 >>>>>>" + useIAM2);
        try {
        	log.info("logonID = "+logonID);
            if (logonID != null) {
                // get Menu
    			Vector vtMenuID = new Vector();
    			    		    			
                MenuMDAO userMDao = EJBDAOFactory.getMenuMDAO();
                
                if ((iasVersion < 3 || iasVersion == 4) && "Y".equalsIgnoreCase(useIAS) ) {
					//roleNames = (String)getRequest().getSession().getAttribute("roleNameFromAD");
                	
                	vObject= (Vector)getRequest().getSession().getAttribute("roleNameFromAD");
	            	log.info(" roleNames AD : "+vObject);
					//vecMenus = userMDao.loadMenus(roleNames);
	            	vecMenus = userMDao.loadMenus(vObject);
//	            	vecMenus = userMDao.loadMenus();
                	menuStyle = userMDao.loadMenuStyle(logonID);
                } else if("Y".equalsIgnoreCase(useIAM2)){
            		//Get menu permissions from IAM
                	String accessToken = (String)getRequest().getSession().getAttribute(MasterConstant.ACCESS_TOKEN);
                	UserInfoService iam2restService = new UserInfoService(getRequest());
                	
                	ArrayList<String> menuPermList = iam2restService.getAccessList("Menu", accessToken);
                	if(menuPermList != null && !menuPermList.isEmpty()) {
                		vecMenus = userMDao.loadMenus();
                		Iterator<MenuM> menuIter = vecMenus.iterator();
                		//Filter vecMenu based on menuPermList
                		while(menuIter.hasNext()) {
                			MenuM menu = menuIter.next();
                			if(menuPermList.contains(menu.getMenuID())) {
                				continue;
                			} else {
                				menuIter.remove();
                			}
                		}
                	}
            	} else {
                	vecMenus = userMDao.loadMenus();
                }
                
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
                getRequest().getSession(true).setAttribute("menuHandlerManager",menuHandler);
                getRequest().getSession().setAttribute("vecMenus", vecMenus);                
                if(menuStyle == null || menuStyle.size() == 0){
                    getRequest().getSession().setAttribute("bgColor", "#FFF");
                    getRequest().getSession().setAttribute("font", "tahoma");
                    getRequest().getSession().setAttribute("fontColor", "#000");
                    getRequest().getSession().setAttribute("fontSize", "10px");
                    FrontScreenFlowManager screenFlowManager = (FrontScreenFlowManager) getRequest().getSession(true).getAttribute("screenFlowManager");
                    screenFlowManager.setCurrentScreenTemplate("screen_template/frame/default.jsp");
                }else{
                	if(menuStyle.elementAt(0)!=null && !"".equals(menuStyle.elementAt(0))){
                        getRequest().getSession().setAttribute("bgColor", menuStyle.elementAt(0));
                	}
                	if(menuStyle.elementAt(1)!=null && !"".equals(menuStyle.elementAt(1))){
                        getRequest().getSession().setAttribute("font", menuStyle.elementAt(1));
                	}
                	if(menuStyle.elementAt(2)!=null && !"".equals(menuStyle.elementAt(2))){
                        getRequest().getSession().setAttribute("fontColor", menuStyle.elementAt(2));
                	}
                	if(menuStyle.elementAt(3)!=null && !"".equals(menuStyle.elementAt(3))){
                        getRequest().getSession().setAttribute("fontSize", menuStyle.elementAt(3));
                	}
                	if(menuStyle.elementAt(4)!=null && !"".equals(menuStyle.elementAt(4))){
                        FrontScreenFlowManager screenFlowManager = (FrontScreenFlowManager) getRequest().getSession(true).getAttribute("screenFlowManager");
                        screenFlowManager.setCurrentScreenTemplate((String)menuStyle.elementAt(4));
                	}
                }
            }
			getRequest().getSession().removeAttribute("parentMenuSess");
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return true;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#processEventResponse(com.front.j2ee.pattern.control.event.EventResponse)
	 */
	public boolean processEventResponse(EventResponse response) {
		// TODO Auto-generated method stub
		return false;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#requiredModelRequest()
	 */
	public boolean requiredModelRequest() {
		// TODO Auto-generated method stub
		return false;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#toEvent()
	 */
	public Event toEvent() {
		// TODO Auto-generated method stub
		return null;
	}
    public String getNextActionParameter() {
        return "page=NEXT_SCREEN";
    }
	//@Override
	public Object getParameterObject() {
		// TODO Auto-generated method stub
		return null;
	}
	//@Override
	public boolean preModelRequest(Object arg0) {
		// TODO Auto-generated method stub
		return false;
	}
}

package com.front.ejb.activitylog;

import java.sql.Timestamp;
import java.util.HashMap;

import com.front.dao.log.MasterLogDAO;
import com.front.service.EJBDAOFactory;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;

/**
 * Bean implementation class for Enterprise Bean: ActivityLogManager
 */
public class ActivityLogManagerBean implements javax.ejb.SessionBean {
	//private static LoggingServiceEJBHome home = null;
	//private static LoggingServiceEJB ejb = null;
    private final static String WS_INITIAL_CONTEXT = "com.ibm.websphere.naming.WsnInitialContextFactory";
    private final static String JNDI_NAME = "mg/xpeap/homes/LoggingServiceEJBHome";

	static final long serialVersionUID = 3206093459760846163L;
	private javax.ejb.SessionContext mySessionCtx;
	/**
	 * getSessionContext
	 */
	public javax.ejb.SessionContext getSessionContext() {
		return mySessionCtx;
	}
	/**
	 * setSessionContext
	 */
	public void setSessionContext(javax.ejb.SessionContext ctx) {
		mySessionCtx = ctx;
	}
	/**
	 * ejbCreate
	 */

	public void ejbCreate() throws javax.ejb.CreateException {
     /*
		javax.naming.Context initialContext = null;
        try {
            Hashtable env = new Hashtable();
            env.put(Context.INITIAL_CONTEXT_FACTORY, WS_INITIAL_CONTEXT);
            env.put(Context.PROVIDER_URL, ServiceConstant.PROVIDER_URL);
            initialContext = new javax.naming.InitialContext(env);
            Object result = initialContext.lookup(JNDI_NAME);
            Object obj = javax.rmi.PortableRemoteObject.narrow(result, LoggingServiceEJBHome.class);
            
            home = (LoggingServiceEJBHome)obj;
			ejb = home.create();
        } catch (Exception e) {
			e.printStackTrace();
        } finally {
            try {
                initialContext.close();
            } catch (Exception ex) {
            }
        }
       */ 
	}
	/**
	 * ejbActivate
	 */
	public void ejbActivate() {
	}
	/**
	 * ejbPassivate
	 */
	public void ejbPassivate() {
	}
	/**
	 * ejbRemove
	 */
	public void ejbRemove() {
	}
	public boolean insertAccessLog(String userID, String userBranch, String theStatus, String theModule, String theRemark, String theEvent, String ipAddress, String browser, String os, String resorution, String session, Object newData, Object oldData){
		long now = System.currentTimeMillis();
		Timestamp lastUpdate = new Timestamp(now);
		HashMap map = new HashMap();
		map.put("User ID", userID);
		map.put("Last Update", lastUpdate);
		map.put("IP Address", ipAddress);
		map.put("Access", theEvent);
		map.put("Menu Name", theRemark);
		map.put("Session", session);
		map.put("Browser", browser);
		map.put("OS", os);
		map.put("Resorution", resorution);
		return insertAccessLog(map);
	}
	public boolean insertAccessLog(HashMap map){
		System.out.println("========== Start insertAccessLog ==========");
		boolean isSuccess = false;
		try{
	    	ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.ACCESS_LOG_ENABLE);
			if("Y".equals(constantSystemM.getConStantValue())){
				MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
				isSuccess = (dao.insertActivityLog(map)>0);
			}
		}catch(Exception e){
			isSuccess = false;
			e.printStackTrace();
			System.err.println("Error in inserAccessLog:"+e);
		}		
		System.out.println("========== End insertAccessLog ==========["+isSuccess+"]");
		return isSuccess;
	}
}

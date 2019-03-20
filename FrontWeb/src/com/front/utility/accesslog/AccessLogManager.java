package com.front.utility.accesslog;

import java.util.Hashtable;
import javax.naming.Context;

import com.front.ejb.activitylog.ActivityLogManager;
import com.front.ejb.activitylog.ActivityLogManagerBean;
import com.front.ejb.activitylog.ActivityLogManagerHome;
import com.front.service.ServiceConstant;

public class AccessLogManager {
	private static ActivityLogManagerHome home = null;
	private static ActivityLogManagerBean ejb = null;
	private static AccessLogManager alm = null;
    private final static String WS_INITIAL_CONTEXT = "com.ibm.websphere.naming.WsnInitialContextFactory";
    private final static String JNDI_NAME = "ejb/ActivityLogManagerHome";
	private AccessLogManager(){
		ejb = new ActivityLogManagerBean();
	}
	public static AccessLogManager getInstatnce(){
		if(alm==null){
			alm = new AccessLogManager();
		}
		return alm;
	}
	public boolean insertAccessLog(String userID, String userBranch, String theStatus, String theModule, String theRemark, String theEvent, String ipAddress, String browser, String os, String resorution, String session){
		System.out.println("========== Start insertAccessLog ==========");
		boolean isSuccess = false;
		if(ejb!=null){
			try{
				isSuccess = ejb.insertAccessLog(userID, userBranch, theStatus, theModule, theRemark, theEvent, ipAddress, browser, os, resorution, session, "", "");
			}catch(Exception e){
				isSuccess = false;
				e.printStackTrace();
				System.err.println("Error in inserAccessLog:"+e);
			}
		}else{
			System.err.println("!!!!!!!!!! LoggingServiceEJB = null !!!!!!!!!!");
		}
		System.out.println("========== End insertAccessLog ==========["+isSuccess+"]");
		return isSuccess;
	}
}

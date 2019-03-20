package com.front.ejb.activitylog;

import java.rmi.RemoteException;

import com.front.model.activitylog.ActivityLogM;

/**
 * Remote interface for Enterprise Bean: ActivityLogManager
 */
public interface ActivityLogManager extends javax.ejb.EJBObject {
	public boolean insertAccessLog(String userID, String userBranch, String theStatus, String theModule, String theRemark, String theEvent, String ipAddress, String browser, String os, String resorution, String session, Object newData, Object oldData) throws RemoteException;
	//public boolean insertAccessLog(CreateLoggingItem item) throws RemoteException;
	public boolean insertAccessLog(ActivityLogM activityLogM) throws RemoteException;
}

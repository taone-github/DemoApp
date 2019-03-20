package com.front.ejb.activitylog;

/**
 * Home interface for Enterprise Bean: ActivityLogManager
 */
public interface ActivityLogManagerHome extends javax.ejb.EJBHome {

	/**
	 * Creates a default instance of Session Bean: ActivityLogManager
	 */
	public com.front.ejb.activitylog.ActivityLogManager create() throws javax.ejb.CreateException, java.rmi.RemoteException;
}

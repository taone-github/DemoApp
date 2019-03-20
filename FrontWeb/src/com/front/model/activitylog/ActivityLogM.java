package com.front.model.activitylog;

import java.io.Serializable;
import java.util.Date;


public class ActivityLogM implements Serializable{
	private String userID;
	private Date actionDate;
	private String clientIP;
	private String clientSession;
	private String clientBrowser;
	private String clientOS;
	private String clientScreenSize;
	private String description;
	private String appCode;
	private String logType;
	private String logAction;
	private String logModule;
	private Object newData;
	private Object oldData;
	public Date getActionDate() {
		return actionDate;
	}
	public void setActionDate(Date actionDate) {
		this.actionDate = actionDate;
	}
	public String getClientBrowser() {
		return clientBrowser;
	}
	public void setClientBrowser(String clientBrowser) {
		this.clientBrowser = clientBrowser;
	}
	public String getClientIP() {
		return clientIP;
	}
	public void setClientIP(String clientIP) {
		this.clientIP = clientIP;
	}
	public String getClientOS() {
		return clientOS;
	}
	public void setClientOS(String clientOS) {
		this.clientOS = clientOS;
	}
	public String getClientScreenSize() {
		return clientScreenSize;
	}
	public void setClientScreenSize(String clientScreenSize) {
		this.clientScreenSize = clientScreenSize;
	}
	public String getClientSession() {
		return clientSession;
	}
	public void setClientSession(String clientSession) {
		this.clientSession = clientSession;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAppCode() {
		return appCode;
	}
	public void setAppCode(String appCode) {
		this.appCode = appCode;
	}
	public String getLogType() {
		return logType;
	}
	public void setLogType(String logType) {
		this.logType = logType;
	}
	public String getLogAction() {
		return logAction;
	}
	public void setLogAction(String logAction) {
		this.logAction = logAction;
	}
	public String getLogModule() {
		return logModule;
	}
	public void setLogModule(String logModule) {
		this.logModule = logModule;
	}
	public Object getNewData() {
		return newData;
	}
	public void setNewData(Object newData) {
		this.newData = newData;
	}
	public Object getOldData() {
		return oldData;
	}
	public void setOldData(Object oldData) {
		this.oldData = oldData;
	}
}

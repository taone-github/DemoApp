/*
 * @(#)ECSEJBServiceLocator.java        1.0 05/08/2005
 *
 * Copyright (c) 2004-2005 Avalant Co.,Ltd.
 * 3 Soi Saladaeng 1, Rama IV Road, Silom, Bangrak Bangkok 10500.
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of
 * Avalant Co.,Ltd. ("Confidential Information").  You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license agreement you entered into
 * with Avalant Co.,Ltd.
 **/
/*******************************************************************************
 * CERTIFIED HISTORY
 * Date : 29/03/2006 
 * Certified by : P.Surojjana
 ******************************************************************************/
package com.front.service;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import org.apache.log4j.Logger;

import com.front.constant.FrontMenuConstant;
import com.oneweb.j2ee.system.LoadXML;
public class EJBServiceLocator {
	public static EJBServiceLocator serviceLocator;
	private final static String WS_INITIAL_CONTEXT = "com.ibm.websphere.naming.WsnInitialContextFactory";
	private final static String EJB_ENV = "java:comp/env/ejb/";
	private final static String JAVA_ENV = LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getJavaENV();
	private final static transient Logger logger = Logger.getLogger(EJBServiceLocator.class);
	public static EJBServiceLocator getInstance() {
		if (serviceLocator == null) {
			serviceLocator = new EJBServiceLocator();
		}
		return serviceLocator;
	}
	public Object getHome(String ejbName) throws Exception {
		Object home = null;
		try {
			InitialContext initialContext = new InitialContext();
			// Look up using the service name from
			// defined constant
			Object objref = initialContext.lookup(JAVA_ENV + ejbName.substring(ejbName.lastIndexOf(".") + 1));
			// Narrow using the EJBHome Class from
			// defined constant
			Object obj = PortableRemoteObject.narrow(objref, Class.forName(ejbName));
			home = obj;
		} catch (NamingException ex) {
			logger.error(ex.getMessage());
			throw new Exception("Exception in getHome : " + ex.getMessage());
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new Exception("Exception in getHome : " + ex.getMessage());
		}
		return home;
	}
	/**
	 * Gets the EJBHome for the given service using the JNDI name and the
	 * Class for the EJBHome
	 * 
	 * @param String is EJB Name
	 * @param Class of EJB Home
	 * @return EJBHome
	 */
	public Object getHome(String ejbName, Class ejbClass) throws Exception {
		Object home = null;
		javax.naming.Context initialContext = null;
		try {
			Hashtable env = new Hashtable();
			//Set Initial Context
			env.put(Context.INITIAL_CONTEXT_FACTORY, WS_INITIAL_CONTEXT);
			//Set Provider URL
			env.put(Context.PROVIDER_URL, ServiceConstant.PROVIDER_URL);
			initialContext = new javax.naming.InitialContext(env);
			logger.info("initial context success");
			//Looh up JNDI Name
			Object result = initialContext.lookup(ServiceConstant.LOOK_UP_PATH + ejbName);
			logger.info("lookup success");
			//Narrow object to Home Object
			Object obj = javax.rmi.PortableRemoteObject.narrow(result, ejbClass);
			home = obj;
			//initialContext.close();
		} catch (NamingException ex) {
			logger.error(ex.getMessage());
			throw new Exception("Exception in getHome : " + ex.getMessage());
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new Exception("Exception in getHome : " + ex.getMessage());
		} finally {
			try {
				initialContext.close();
			} catch (Exception ex) {
				logger.error(ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		return home;
	}
}

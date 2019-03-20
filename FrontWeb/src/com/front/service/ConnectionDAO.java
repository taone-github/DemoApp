/*
 * @(#)ECSEJBConnectionDAO.java        1.0 11/08/2005
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
 */
/*
 * Created on Aug 10, 2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
/*
 ***********************CERTIFIED HISTORY*******************************
 Date : 23/03/2006
 Certified by :  P.Suntipap 
 Certified Description :
 1. add comment method
 ************************************************************************/
package com.front.service;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;


/**
 * @author Administrator To change the template for this generated type comment
 *         go to Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and
 *         Comments
 */
public class ConnectionDAO {
	private final static transient Logger logger = Logger.getLogger(ConnectionDAO.class);
	public final static int getVpdID(HttpServletRequest request) throws Exception {
		try {
			String brokerageID = (String) request.getSession().getAttribute("brokerageID");
			return Integer.parseInt(brokerageID);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception(e.getMessage());
		}
	}
	/**
	 * close database connection
	 * 
	 * @param conn
	 * 
	 * @throws Exception
	 */
	public static final void closeConnection(Connection con) throws Exception {
		try {
			con.commit();
		} catch (Exception e) {}
		try {
			con.close();
		} catch (Exception e) {}
		con = null;
	}
	/**
	 * close database connection
	 * 
	 * @param con
	 * @param stm
	 * 
	 * @throws Exception
	 */
	public static final void closeConnection(Connection con, Statement stm) {
		try {
			con.commit();
		} catch (Exception e) {}
		try {
			stm.close();
		} catch (Exception e) {}
		try {
			con.close();
		} catch (Exception e) {}
		stm = null;
		con = null;
	}
	/**
	 * close database connection
	 * 
	 * @param con
	 * @param rs
	 * @param ps
	 * 
	 * @throws Exception
	 */
	public static final void closeConnection(Connection con, ResultSet rs, Statement stm) {
		try {
			con.commit();
		} catch (Exception e) {}
		try {
			rs.close();
		} catch (Exception e) {}
		try {
			stm.close();
		} catch (Exception e) {}
		try {
			con.close();
		} catch (Exception e) {}
		rs = null;
		stm = null;
		con = null;
	}
	/**
	 * @param dbType
	 * 
	 * @return
	 */
	public static final Connection getConnection() {
		try {
			JDBCServiceLocator geService = JDBCServiceLocator.getInstance();
			return geService.getConnection(JDBCServiceLocator.MASTER_DB);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return null;
	}
	/**
	 * @param vpdID
	 * 
	 * @return
	 */
	public final Connection getConnection(int vpdID) {
		try {
			JDBCServiceLocator geService = JDBCServiceLocator.getInstance();
			return geService.getConnection(vpdID);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return null;
	}
	
	public static Connection getConnection(String jndiName) {
        try {
            JDBCServiceLocator geService = JDBCServiceLocator.getInstance();
            return geService.getConnection(jndiName);
        } catch (Exception e) {
            logger.error("ERROR", e);
        }
        return null;
    }
}

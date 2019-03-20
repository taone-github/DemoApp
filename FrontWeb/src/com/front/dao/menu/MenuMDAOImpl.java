/*
 * @(#)UserMDAOImpl.java        1.0 08/08/2005
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
 *
 ***********************CERTIFIED HISTORY*******************************
 *
 *Date : 21/03/2006
 *Certified by :  S.Suebpong
 *1. Variable name unclear naming
 *
 *Date : 29/03/2006
 *Certified by :  P.Suntipap 
 *Certified Description :
 * 	2. change import com.aacp.ecs.dao.userprofile.UserMException to com.aacp.ecs.dao.userprofile.exception.UserMException
 *
 *Date : 29/03/2006
 *Certified by :  P.Suntipap 
 *Certified Description :
 *	3. Select using filed only.  	
 ************************************************************************/
package com.front.dao.menu;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.front.constant.FrontMenuConstant;
import com.front.dao.menu.exception.MenuMException;
import com.front.model.menu.MenuM;
import com.front.service.ConnectionDAO;
import com.oneweb.j2ee.system.LoadXML;
/**
 * @version  1.00 08 March 2005
 * @author   Chartchai Taengpasulert
 */
public class MenuMDAOImpl extends ConnectionDAO implements MenuMDAO {
	private final static transient Logger logger = Logger.getLogger(MenuMDAOImpl.class);
	private String schemaName  = LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getSchemaName();
	
	public MenuMDAOImpl() {
		 if (schemaName != null && !"".equals(schemaName) ) {
			 schemaName = schemaName + ".";
		 }
	}
	
	public Vector loadMenus() throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Vector menus = new Vector();
		try {
			//conn = Get Connection
			conn = getConnection();
			StringBuffer sql = new StringBuffer("");
			sql.append("SELECT MENU_ID, DESCRIPTION, MENU_TYPE, MENU_LEVEL, SEQ, MENU_REFERENCE, ACTION_MAPPING, ACTION_TARGET , ICON ");
			sql.append("FROM "+this.schemaName+"M_PROCESS_MENU ");
			//Sam temporaly for demo app design
			//sql.append(" WHERE CREATE_BY = 'system' ");

			sql.append(" ORDER BY MENU_LEVEL,SEQ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);

			ps = conn.prepareStatement(dSql);
			rs = null;
			rs = ps.executeQuery();
			MenuM prmMenuM = null;			
			while (rs.next()) {			
				prmMenuM = new MenuM();
				prmMenuM.setMenuID(rs.getString(1));
				prmMenuM.setMenuName(rs.getString(2));
				prmMenuM.setMenuType(rs.getString(3).toUpperCase());
				prmMenuM.setMenuLevel(rs.getString(4));
				prmMenuM.setMenuSeq(rs.getString(5));
				prmMenuM.setMenuReference(rs.getString(6));
				prmMenuM.setMenuAction(rs.getString(7));
				prmMenuM.setMenuTarget(rs.getString(8));
				prmMenuM.setIcon(rs.getString("ICON"));
				menus.add(prmMenuM);
			}
			return menus;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}
	public Vector loadMenus(Vector vtMenuID) throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Vector menus = new Vector();
		try {
			//conn = Get Connection
			conn = getConnection();
			StringBuffer sql = new StringBuffer("");
			sql.append("SELECT MENU_ID, DESCRIPTION, MENU_TYPE, MENU_LEVEL, SEQ, MENU_REFERENCE, ACTION_MAPPING, ACTION_TARGET, ICON ");
			sql.append("FROM "+this.schemaName+"M_PROCESS_MENU ");
			sql.append(" WHERE (IAM_FILTER IS NOT NULL AND IAM_FILTER='Y' AND MENU_ID IN (''");
			for (int i = 0; i < vtMenuID.size(); i++) {
				String menuID = (String) vtMenuID.get(i);
				sql.append(",'");
				sql.append(menuID);
				sql.append("'");
			}
			sql.append(" )) OR IAM_FILTER ='N' ORDER BY MENU_LEVEL,SEQ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			rs = null;
			rs = ps.executeQuery();
			MenuM prmMenuM = null;
			while (rs.next()) {
				prmMenuM = new MenuM();
				prmMenuM.setMenuID(rs.getString(1));
				prmMenuM.setMenuName(rs.getString(2));
				prmMenuM.setMenuType(rs.getString(3));
				prmMenuM.setMenuLevel(rs.getString(4));
				prmMenuM.setMenuSeq(rs.getString(5));
				prmMenuM.setMenuReference(rs.getString(6));
				prmMenuM.setMenuAction(rs.getString(7));
				prmMenuM.setMenuTarget(rs.getString(8));
				prmMenuM.setIcon(rs.getString("ICON"));
				menus.add(prmMenuM);
			}
			return menus;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}
	public Vector loadMenuStyle(String username) throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			//conn = Get Connection
			conn = getConnection();
			StringBuffer sql = new StringBuffer("");
			sql.append("SELECT T1.BG_COLOR, T1.FONT, T1.FONT_COLOR, T1.FONT_SIZE, T2.TEMPLATE_PATH");
			sql.append(" FROM "+this.schemaName+"M_PERSONALIZE T1, "+this.schemaName+"M_SCREEN_TEMPLATE T2");
			sql.append(" WHERE T1.USERNAME=? AND T1.TEMPLATE_ID=T2.TEMPLATE_ID");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			Vector vt = new Vector();
			while (rs.next()) {
				vt.addElement(rs.getString("BG_COLOR"));
				vt.addElement(rs.getString("FONT"));
				vt.addElement(rs.getString("FONT_COLOR"));
				vt.addElement(rs.getString("FONT_SIZE"));
				vt.addElement(rs.getString("TEMPLATE_PATH"));
			}
			return vt;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}
	
	public HashMap getMenuIDFromRole(String roles) throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		HashMap result = new HashMap();
		try {
			conn = getConnection();
			StringBuffer sql = new StringBuffer("");
			sql.append(" select distinct object_id from "+this.schemaName+"m_object_role_mapping ");
			sql.append(" where role_id in ("+roles+") and STATUS = 'ACTIVE' and object_type = 'MENU'");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			rs = ps.executeQuery();
			Vector vt = new Vector();
			while (rs.next()) {
				result.put(rs.getString("object_id"), rs.getString("object_id"));
			}
			return result;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}
	
	public HashMap getExceptionMenuIDFromRole(String roles) throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		HashMap result = new HashMap();
		try {
			conn = getConnection();
			StringBuffer sql = new StringBuffer("");
			sql.append(" select distinct "+this.schemaName+"m_process_menu.MENU_ID from "+this.schemaName+"m_process_menu ");
			sql.append(" where  not exists "); 
			sql.append(" (select  "+this.schemaName+"m_object_role_mapping.OBJECT_ID ");
			sql.append(" from "+this.schemaName+"m_object_role_mapping ");
			sql.append(" where role_id in ("+roles+") and STATUS = 'ACTIVE' and object_type = 'MENU' "); 
			sql.append(" and "+this.schemaName+"m_object_role_mapping.OBJECT_ID = "+this.schemaName+"m_process_menu.MENU_ID ) "); 
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			rs = ps.executeQuery();
			Vector vt = new Vector();
			while (rs.next()) {
				result.put(rs.getString("MENU_ID"), rs.getString("MENU_ID"));
			}
			return result;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}	
	
	//Modify by sarayut 20090624 change signeger from Vector to String
	public Vector loadMenus(String vtMenuID) throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Vector menus = new Vector();
		try {
			//conn = Get Connection
			conn = getConnection();
			StringBuffer sql = new StringBuffer("");
			//sql.append("SELECT MENU_ID, DESCRIPTION, MENU_TYPE, MENU_LEVEL, SEQ, MENU_REFERENCE, ACTION_MAPPING, ACTION_TARGET FROM "+schemaName+"M_PROCESS_MENU ");
			//sql.append(" WHERE MENU_ID IN ("+vtMenuID+")");
			sql.append(" SELECT MENU_ID, DESCRIPTION, MENU_TYPE, MENU_LEVEL, SEQ, MENU_REFERENCE, ACTION_MAPPING, ACTION_TARGET, ICON ");
			sql.append(" FROM "+this.schemaName+"M_PROCESS_MENU MEM WHERE EXISTS(SELECT OBJ.OBJECT_ID FROM "+this.schemaName+"OBJECT_ROLE_ACCESS OBJ ");
			sql.append(" WHERE EXISTS(SELECT RL.ROLE_ID FROM "+this.schemaName+"ROLE RL WHERE RL.ROLE_NAME IN("+vtMenuID+") AND RL.ROLE_ID = OBJ.ROLE_ID) AND OBJ.OBJECT_ID = MEM.MENU_ID)");			
			//Modify by sarayut 20090624
			/*for (int i = 0; i < vtMenuID.size(); i++) {
				String menuID = (String) vtMenuID.get(i);
				sql.append(",'");
				sql.append(menuID);
				sql.append("'");
			}*/
			sql.append(" ORDER BY SEQ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			rs = null;
			rs = ps.executeQuery();
			MenuM prmMenuM = null;
			while (rs.next()) {
				prmMenuM = new MenuM();
				prmMenuM.setMenuID(rs.getString(1));
				prmMenuM.setMenuName(rs.getString(2));
				prmMenuM.setMenuType(rs.getString(3));
				prmMenuM.setMenuLevel(rs.getString(4));
				prmMenuM.setMenuSeq(rs.getString(5));
				prmMenuM.setMenuReference(rs.getString(6));
				prmMenuM.setMenuAction(rs.getString(7));
				prmMenuM.setMenuTarget(rs.getString(8));
				prmMenuM.setIcon(rs.getString("ICON"));
				menus.add(prmMenuM);
			}
			return menus;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}
	
	public Vector loadUserRoleDepartment(String username) throws MenuMException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Vector menus = new Vector();
		try {
			//conn = Get Connection
			conn = getConnection("jdbc/A2M");
			StringBuffer sql = new StringBuffer("");
			sql.append("select users.USER_NAME , users.DEPARTMENT, ");
			sql.append("users.THAI_FIRSTNAME, users.THAI_LASTNAME , users.POSITION, ");
			sql.append("role.ROLE_NAME,role.ROLE_ID ");
			sql.append(" from users , user_role , role where users.USER_NAME = user_role.USER_NAME ");
			sql.append(" and user_role.ROLE_ID = role.ROLE_ID");
			sql.append(" and users.USER_NAME = ?");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			ps.setString(1, username);
			rs = null;
			rs = ps.executeQuery();
			MenuM prmMenuM = null;			
			if (rs.next()) {			
				
				menus.add(rs.getString("USER_NAME"));
				menus.add(rs.getString("DEPARTMENT"));
				menus.add(rs.getString("THAI_FIRSTNAME"));
				menus.add(rs.getString("THAI_LASTNAME"));
				menus.add(rs.getString("POSITION"));
				menus.add(rs.getString("ROLE_NAME"));
				menus.add(rs.getString("ROLE_ID"));
			}
			return menus;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MenuMException(e.getMessage());
		} finally {
			closeConnection(conn, rs, ps);
		}
	}
}

/*
 * @(#)UserMDAO.java        1.0 08/08/2005
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
*
*Date : 29/03/2006
*Certified by :  P.Suntipap 
*Certified Description :
* 	1. change import com.aacp.ecs.dao.userprofile.UserMException to com.aacp.ecs.dao.userprofile.exception.UserMException
************************************************************************/


package com.front.dao.menu;

import java.util.HashMap;
import java.util.Vector;

/**End Cert. 1 */
import com.front.dao.menu.exception.MenuMException;


/**
 * @version  1.00 08 March 2005
 * @author   Chartchai Taengpasulert
 */
public interface MenuMDAO {
	public Vector loadMenus() throws MenuMException;
	public Vector loadMenus(Vector vtMenuID) throws MenuMException;
	public Vector loadMenuStyle(String username) throws MenuMException;
	public HashMap getMenuIDFromRole(String roles) throws MenuMException;
	public HashMap getExceptionMenuIDFromRole(String roles) throws MenuMException; 
	public Vector loadMenus(String vtMenuID) throws MenuMException;
	public Vector loadUserRoleDepartment(String username) throws MenuMException ;
}

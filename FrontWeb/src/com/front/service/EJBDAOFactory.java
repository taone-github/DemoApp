/*
 * @(#) ECSEJBDAOFactory.java 1.00 08/03/2005
 *
 * Copyright (c) 2004 - 2005 Avalant Co.,Ltd.
 * 3 Soi Saladaeng 1, Rama IV Road, Silom, Bangrak Bangkok 10500.
 * All rights reserved.
 *
 * This software is the confidential and prorietary infomation of
 * Avalant Co.,Ltd. ("Confidential Infomation"). You shall not
 * disclose such Confidential Infomation and shall use it only in
 * accordance with the terms of the license agreement you entered into
 * with Avalant Co.,Ltd.
 */
 /*
 ***********************CERTIFIED HISTORY*******************************
Date : 23/03/2006
Certified by :  P.Suntipap 
Certified Description :
	1. Add method getTrDAO
	
Date : 29/03/2006
Certified by :  P.Suntipap 
Certified Description :
 	2. change import com.aacp.ecs.dao.userprofile.UserMException to com.aacp.ecs.dao.userprofile.exception.UserMException
************************************************************************/
package com.front.service;


import com.front.dao.log.MasterLogDAO;
import com.front.dao.log.MasterLogDB2DAOImpl;
import com.front.dao.log.MasterLogOracleDAOImpl;
import com.front.dao.menu.MenuMDAO;
import com.front.dao.menu.MenuMDAOImpl;
import com.front.dao.menu.exception.MenuMException;
import com.master.constant.ConstantSystem;
import com.master.model.ConstantSystemM;
import com.master.util.MasterConstant;




/**
 * @version  1.00 08 March 2003
 * @author   Chartchai Taengpasulert
 */
public class EJBDAOFactory {

    /**
     * @return	MenuMDAO
     *
     * @throws  MenuMException
     */
    public static MenuMDAO getMenuMDAO() throws MenuMException {
        return new MenuMDAOImpl();
    } 
	
    public static MasterLogDAO getMasterLogDAO() {
    	
    	ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.DATABASE);
        String dbType = constantSystemM.getConStantValue(); 	    	
    	if (null != dbType && (MasterConstant.DATABASE_TYPE_DB2).equals(dbType)) {
    		return new MasterLogDB2DAOImpl();	
		}else{
			return new MasterLogOracleDAOImpl();
		}
    }
}

/*
 * Created on Sep 11, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.front.dao.log;

import com.master.constant.ConstantSystem;
import com.master.dao.log.MasterLogDAO;
import com.master.dao.log.MasterLogDB2DAOImpl;
import com.master.dao.log.MasterLogOracleDAOImpl;
import com.master.model.ConstantSystemM;
import com.master.util.MasterConstant;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MasterLogDAOFactory {
    public static MasterLogDAO getMasterDAO() {
    	
    	ConstantSystemM constantSystemM = (ConstantSystemM)ConstantSystem.constantList.get(ConstantSystem.DATABASE);
        String dbType = constantSystemM.getConStantValue(); 	    	
    	if (null != dbType && (MasterConstant.DATABASE_TYPE_DB2).equals(dbType)) {
    		return new MasterLogDB2DAOImpl();	
		}else{
			return new MasterLogOracleDAOImpl();
		}
    }
}

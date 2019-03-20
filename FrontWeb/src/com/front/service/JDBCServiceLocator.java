package com.front.service;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.front.constant.FrontMenuConstant;
import com.oneweb.j2ee.system.LoadXML;
import com.schedulerEAF.propertires.EAFSchedulerReadProperties;

public class JDBCServiceLocator {
    private final static transient Logger log = LogManager.getLogger(JDBCServiceLocator.class);
    public static JDBCServiceLocator serviceLocator;

    private final static String JAVA_ENV = LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getJavaENV();

    public final static int MASTER_DB = 0;

    public final static String MASTER_DATA_SOURCE = EAFSchedulerReadProperties.EAF_DATA_SOURCE;
    public final static String APPLICATION_DATA_SOURCE = "jdbc/application";

    public static synchronized JDBCServiceLocator getInstance() {
        if (serviceLocator == null) {
            serviceLocator = new JDBCServiceLocator();
        }
        return serviceLocator;
    }

    private JDBCServiceLocator() {
    }

    /**
     * 
     * @param dbType
     * @return DataSource.getConnection()
     * @throws Exception
     */
    public Connection getConnection(int dbType) throws Exception {
    	DataSource ds = null;
    	try{			 
			InitialContext ctx = new InitialContext();
			Object obj = null;
			switch(dbType){
				case MASTER_DB:
					ds = (DataSource)ctx.lookup(JAVA_ENV+MASTER_DATA_SOURCE); 
					break;
				default:
					obj = null;
				break;
			}
			return ds.getConnection();
		} catch(Exception e){
			e.printStackTrace();
			throw new Exception(e.toString());
		}
	}

    /**
	 * 
	 * @param jndiName (For example, "jdbc/master")
	 * @return DataSource.getConnection()
	 * @throws Exception
	 */
	public Connection getConnection(String jndiName) throws Exception{
		try{
			DataSource ds = null;
			InitialContext ctx = new InitialContext();
			Object obj = null;
			if(null != jndiName && !"".equalsIgnoreCase(jndiName)){
				ds = (DataSource)ctx.lookup(JAVA_ENV+jndiName);
			}else{
				obj = null;
			}
			return ds.getConnection();
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception(e.toString());
		}
	}
    
    public static String getPoolName(int dbType) {
        switch (dbType) {
        default:
            return MASTER_DATA_SOURCE;
        }
    }
}

/*
 * Created on Sep 11, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.front.dao.log;

import java.util.Date;
import java.util.HashMap;
import java.util.Vector;

import com.front.dao.log.exception.MasterLogException;



/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public interface MasterLogDAO {
	public int saveMasterLog(HashMap hLogging) throws Exception;
	public int insertActivityLog(HashMap map) throws MasterLogException;
	public Vector searchAccessLog(String username, String accessType, Date fromDate, Date toDate, int startRow, int endRow) throws MasterLogException;
	public int countSearchAccessLog(String username, String accessType, Date fromDate, Date toDate) throws MasterLogException;
	public Vector searchTransactionLog(String username, String actionType, String moduleName, Date fromDate, Date toDate, int startRow, int endRow) throws MasterLogException;
	public int countSearchTransactionLog(String username, String actionType, String moduleName, Date fromDate, Date toDate) throws MasterLogException;
	public HashMap loadAccessTypeList() throws MasterLogException;
	public HashMap loadActivityTypeList(String logType) throws MasterLogException;
	public HashMap loadActionTypeList(String logType) throws MasterLogException;
}

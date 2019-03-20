/*
 * Created on Sep 11, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.front.dao.log;

import java.beans.IntrospectionException;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Vector;

import org.apache.commons.betwixt.io.BeanWriter;
import org.apache.log4j.Logger;
import org.apache.xerces.parsers.DOMParser;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.front.constant.FrontMenuConstant;
import com.front.dao.log.exception.MasterLogException;
import com.master.connection.ConnectionService;
import com.master.connection.JDBCServiceLocator;
import com.oneweb.j2ee.system.LoadXML;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MasterLogDB2DAOImpl extends ConnectionService implements MasterLogDAO {  
	private final static transient Logger logger = Logger.getLogger(MasterLogDB2DAOImpl.class);
	private String schemaName  = LoadXML.getLoadXML(FrontMenuConstant.STRUT_NAME).getSchemaName();
	
	public MasterLogDB2DAOImpl() {
		 if (schemaName != null && !"".equals(schemaName) ) {
			 schemaName = schemaName + ".";
		 }else{
			 schemaName ="";
		 }
	}	 
	
	public int saveMasterLog(HashMap hLogging) throws MasterLogException {
		int result = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer();
			sql.append(" insert into "+schemaName+"m_entity_log( ");
			sql.append("REF_ID,APP_CODE,PROC_USER_ID,PROC_DT,LOG_ACTION,LOG_MODULE,IP_ADDRESS,NEW_DAT,OLD_DAT,LOG_TYPE");
			sql.append(" ) values ( ");
			sql.append("DEFAULT,?,?,CURRENT DATE,'ACCESS',?,?,?,?,'2'");
			sql.append(" ) ");

			String dsql = String.valueOf(sql);
			ps = conn.prepareStatement(dsql);
			ps.setString(1, (String) hLogging.get("APP_CODE"));
			ps.setString(2, (String) hLogging.get("UPDATE_BY"));
			ps.setString(3, (String) hLogging.get("MODULE_NAME"));
			ps.setString(4, (String) hLogging.get("IP_ADDRESS"));
			ps.setString(5, (String) hLogging.get("LOG_ITEMS"));
			ps.setString(6, (String) hLogging.get("LOG_OLD_ITEMS"));
			result = ps.executeUpdate();
		} catch (Exception e) {
			logger.error("ERROR", e);
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}

	public int insertActivityLog(HashMap map) throws MasterLogException {
		try{
			HashMap hLogging = new HashMap();
			hLogging.put("APP_CODE", "EAF");
			hLogging.put("LOG_ITEMS", hashmapToXML(map));
			hLogging.put("MODULE_NAME", map.get("Access"));
			hLogging.put("UPDATE_BY", map.get("User ID"));
			hLogging.put("IP_ADDRESS", map.get("IP Address"));

			return saveMasterLog(hLogging);
		}catch(Exception e){
			throw new MasterLogException(e.toString());
		}
	}

	public Vector searchAccessLog(String username, String accessType, Date fromDate, Date toDate, int startRow, int endRow) throws MasterLogException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
		String strFromDate = "";
		String strToDate = "";
		if (fromDate != null) {
			strFromDate = dateFormat.format(fromDate);
		}
		if (toDate != null) {
			strToDate = dateFormat.format(toDate);
		}
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Vector result = new Vector();
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT T2.* FROM ( ");
			sql.append(" SELECT ROW_NUMBER() OVER() AS ROW_NUM,T1.* FROM ( ");
			sql.append(" SELECT REF_ID,APP_CODE,PROC_DT,PROC_USER_ID, ");
			sql.append(" "+schemaName+"LOG_ACTION,"+schemaName+"LOG_MODULE, ");
			sql.append(" "+schemaName+"OLD_DAT,"+schemaName+"NEW_DAT,"+schemaName+"IP_ADDRESS ");
			sql.append(" FROM M_ENTITY_LOG ");
			sql.append(" WHERE LOG_TYPE='2' ");
			if (username != null && username.length() > 0) {
				sql.append(" AND PROC_USER_ID=? ");
			}
			if (accessType != null && accessType.length() > 0) {
				sql.append(" AND LOG_MODULE=? ");
			}
			if (fromDate != null) {
				sql.append(" AND PROC_DT>=? ");
			}
			if (toDate != null) {
				sql.append(" AND PROC_DT<=? ");
			}
			sql.append(" ORDER BY PROC_DT DESC ");
			sql.append(" ) T1) T2 ");
			sql.append(" WHERE T2.ROW_NUM >= ? and T2.ROW_NUM <= ? ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			int index = 1;
			if (username != null && username.length() > 0) {
				ps.setString(index++, username);
			}
			if (accessType != null && accessType.length() > 0) {
				ps.setString(index++, accessType);
			}
			if (fromDate != null) {
				ps.setTimestamp(index++, new Timestamp(fromDate.getTime()));
			}
			if (toDate != null) {
				ps.setTimestamp(index++, new Timestamp(toDate.getTime()));
			}
			ps.setInt(index++, startRow);
			ps.setInt(index++, endRow);
			rs = ps.executeQuery();
			while (rs.next()) {
				Vector item = new Vector();
				item.add(new SimpleDateFormat("dd/MM/yyyy :HH:mm:ss", Locale.US).format(rs.getTimestamp("PROC_DT")));
				item.add(rs.getString("PROC_USER_ID"));
				item.add(rs.getString("LOG_MODULE"));
				item.add(rs.getString("LOG_ACTION"));
				String detail = null;
				Clob newData = rs.getClob("NEW_DAT");
				if (newData != null) {
					long clobLength = newData.length();
					detail = newData.getSubString(1, (int) clobLength);
				}
				item.add(xmlToHashMap(detail));
				detail = null;
				Clob oldData = rs.getClob("OLD_DAT");
				if (oldData != null) {
					long clobLength = oldData.length();
					detail = oldData.getSubString(1, (int) clobLength);
				}
				item.add(xmlToHashMap(detail));
				result.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}

	public int countSearchAccessLog(String username, String accessType, Date fromDate, Date toDate) throws MasterLogException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
		String strFromDate = "";
		String strToDate = "";
		if (fromDate != null) {
			strFromDate = dateFormat.format(fromDate);
		}
		if (toDate != null) {
			strToDate = dateFormat.format(toDate);
		}
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT COUNT(*) ");
			sql.append(" FROM "+schemaName+"M_ENTITY_LOG ");
			sql.append(" WHERE LOG_TYPE='2' ");
			if (username != null && username.length() > 0) {
				sql.append(" AND PROC_USER_ID=? ");
			}
			if (accessType != null && accessType.length() > 0) {
				sql.append(" AND LOG_MODULE=? ");
			}
			if (fromDate != null) {
				sql.append(" AND PROC_DT>=? ");
			}
			if (toDate != null) {
				sql.append(" AND PROC_DT<=? ");
			}
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			int index = 1;
			if (username != null && username.length() > 0) {
				ps.setString(index++, username);
			}
			if (accessType != null && accessType.length() > 0) {
				ps.setString(index++, accessType);
			}
			if (fromDate != null) {
				ps.setTimestamp(index++, new Timestamp(fromDate.getTime()));
			}
			if (toDate != null) {
				ps.setTimestamp(index++, new Timestamp(toDate.getTime()));
			}
			rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return count;
	}

	public Vector searchTransactionLog(String username, String actionType, String moduleName, Date fromDate, Date toDate, int startRow, int endRow) throws MasterLogException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
		String strFromDate = "";
		String strToDate = "";
		if (fromDate != null) {
			strFromDate = dateFormat.format(fromDate);
		}
		if (toDate != null) {
			strToDate = dateFormat.format(toDate);
		}
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Vector result = new Vector();
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT T2.* FROM ( ");
			sql.append(" SELECT ROW_NUMBER() OVER() AS ROW_NUM,T1.* FROM ( ");
			sql.append(" SELECT REF_ID,APP_CODE,PROC_DT,PROC_USER_ID, ");
			sql.append(" "+schemaName+"LOG_ACTION,"+schemaName+"LOG_MODULE, ");
			sql.append(" "+schemaName+"OLD_DAT,NEW_DAT,"+schemaName+"IP_ADDRESS ");
			sql.append(" FROM M_ENTITY_LOG ");
			sql.append(" WHERE LOG_TYPE='1' ");
			if (username != null && username.length() > 0) {
				sql.append(" AND PROC_USER_ID=? ");
			}
			if (actionType != null && actionType.length() > 0) {
				sql.append(" AND LOG_ACTION=? ");
			}
			if (moduleName != null && moduleName.length() > 0) {
				sql.append(" AND LOG_MODULE=? ");
			}
			if (fromDate != null) {
				sql.append(" AND PROC_DT>=? ");
			}
			if (toDate != null) {
				sql.append(" AND PROC_DT<=? ");
			}
			sql.append(" ORDER BY PROC_DT DESC ");
			sql.append(" ) T1) T2 ");
			sql.append(" WHERE T2.ROW_NUM >= ? and T2.ROW_NUM <= ? ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			int index = 1;
			if (username != null && username.length() > 0) {
				ps.setString(index++, username);
			}
			if (actionType!= null && actionType.length() > 0) {
				ps.setString(index++, actionType);
			}
			if (moduleName != null && moduleName.length() > 0) {
				ps.setString(index++, moduleName);
			}
			if (fromDate != null) {
				ps.setTimestamp(index++, new Timestamp(fromDate.getTime()));
			}
			if (toDate != null) {
				ps.setTimestamp(index++, new Timestamp(toDate.getTime()));
			}
			ps.setInt(index++, startRow);
			ps.setInt(index++, endRow);
			rs = ps.executeQuery();
			while (rs.next()) {
				Vector item = new Vector();
				item.add(new SimpleDateFormat("dd/MM/yyyy :HH:mm:ss", Locale.US).format(rs.getTimestamp("PROC_DT")));
				item.add(rs.getString("PROC_USER_ID"));
				item.add(rs.getString("LOG_MODULE"));
				item.add(rs.getString("LOG_ACTION"));
				String detail = null;
				Clob newData = rs.getClob("NEW_DAT");
				if (newData != null) {
					long clobLength = newData.length();
					detail = newData.getSubString(1, (int) clobLength);
				}
				item.add(xmlToHashMap(detail));
				detail = null;
				Clob oldData = rs.getClob("OLD_DAT");
				if (oldData != null) {
					long clobLength = oldData.length();
					detail = oldData.getSubString(1, (int) clobLength);
				}
				item.add(xmlToHashMap(detail));
				result.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}

	public int countSearchTransactionLog(String username, String actionType, String moduleName, Date fromDate, Date toDate) throws MasterLogException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
		String strFromDate = "";
		String strToDate = "";
		if (fromDate != null) {
			strFromDate = dateFormat.format(fromDate);
		}
		if (toDate != null) {
			strToDate = dateFormat.format(toDate);
		}
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT COUNT(*) ");
			sql.append(" FROM "+schemaName+"M_ENTITY_LOG ");
			sql.append(" WHERE LOG_TYPE='1' ");
			if (username != null && username.length() > 0) {
				sql.append(" AND PROC_USER_ID=? ");
			}
			if (actionType != null && actionType.length() > 0) {
				sql.append(" AND LOG_ACTION=? ");
			}
			if (moduleName != null && moduleName.length() > 0) {
				sql.append(" AND LOG_MODULE=? ");
			}
			if (fromDate != null) {
				sql.append(" AND PROC_DT>=? ");
			}
			if (toDate != null) {
				sql.append(" AND PROC_DT<=? ");
			}
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			int index = 1;
			if (username != null && username.length() > 0) {
				ps.setString(index++, username);
			}
			if (actionType!= null && actionType.length() > 0) {
				ps.setString(index++, actionType);
			}
			if (moduleName != null && moduleName.length() > 0) {
				ps.setString(index++, moduleName);
			}
			if (fromDate != null) {
				ps.setTimestamp(index++, new Timestamp(fromDate.getTime()));
			}
			if (toDate != null) {
				ps.setTimestamp(index++, new Timestamp(toDate.getTime()));
			}
			rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return count;
	}

	public HashMap loadActivityTypeList(String logType) throws MasterLogException {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		HashMap map = new HashMap();
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT DISTINCT \"ID\",LIST_CODE,LIST_DESC FROM "+schemaName+"M90_SLLST WHERE LIST_TYPE = ? ORDER BY \"ID\" ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			ps.setString(1, logType);
			rs = ps.executeQuery();
			while (rs.next()) {
				map.put(rs.getString("LIST_CODE"), rs.getString("LIST_DESC"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return map;
	}

	public HashMap loadActionTypeList(String logType) throws MasterLogException {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		HashMap map = new HashMap();
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT DISTINCT LOG_ACTION FROM "+schemaName+"M_ENTITY_LOG WHERE LOG_TYPE = ? ORDER BY LOG_ACTION ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			ps.setString(1, logType);
			rs = ps.executeQuery();
			while (rs.next()) {
				map.put(rs.getString("LOG_ACTION"), rs.getString("LOG_ACTION"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return map;
	}

	public HashMap loadAccessTypeList() throws MasterLogException {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		HashMap map = new HashMap();
		try {
			conn = getConnection(JDBCServiceLocator.MASTER_DB);
			StringBuffer sql = new StringBuffer("");
			sql.append(" SELECT DISTINCT LOG_MODULE FROM "+schemaName+"M_ENTITY_LOG WHERE LOG_TYPE='2' ORDER BY LOG_MODULE ");
			String dSql = String.valueOf(sql);
			logger.debug("SQL = " + dSql);
			ps = conn.prepareStatement(dSql);
			rs = ps.executeQuery();
			while (rs.next()) {
				map.put(rs.getString("LOG_MODULE"), rs.getString("LOG_MODULE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MasterLogException(e.getMessage());
		} finally {
			try {
				closeConnection(conn, ps);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return map;
	}

	public static String hashmapToXML(HashMap map) throws IOException, SAXException, IntrospectionException {
		if (map == null) {
			return null;
		}
		StringWriter outputWriter = new StringWriter();
		BeanWriter beanWriter = new BeanWriter(outputWriter);
		beanWriter.enablePrettyPrint();
		beanWriter.getBindingConfiguration().setMapIDs(false);
		beanWriter.getXMLIntrospector().getConfiguration().setAttributesForPrimitives(false);
		beanWriter.write("map", map);
		return outputWriter.toString();
	}
	public HashMap xmlToHashMap(String s) throws SAXException, IOException{
		if(s==null)return null;
		DOMParser parser = new DOMParser();
		parser.parse(new InputSource(new StringReader("<?xml version=\"1.0\"?>"+s)));
		Document doc = parser.getDocument();
		return getHashMapValue(null, doc);
	}

	static String escapeXML(String s) {
		StringBuffer str = new StringBuffer();
		int len = (s != null) ? s.length() : 0;
		for (int i = 0; i < len; i++) {
			char ch = s.charAt(i);
			switch (ch) {
			case '<':
				str.append("&lt;");
				break;
			case '>':
				str.append("&gt;");
				break;
			case '&':
				str.append("&amp;");
				break;
			case '"':
				str.append("&quot;");
				break;
			case '\'':
				str.append("&apos;");
				break;
			default:
				str.append(ch);
			}
		}
		return str.toString();
	}

	public HashMap getHashMapValue(HashMap map, Node node){
		if(node.getNodeType()==Node.DOCUMENT_NODE){
			map = getHashMapValue(map, ((Document)node).getDocumentElement());
		}else{
			if("map".equals(node.getNodeName())){
				map = new HashMap();
			}else if("key".equals(node.getNodeName())){
				String key = node.getChildNodes().item(0).getNodeValue();
				Node sibling1 = node.getNextSibling();
				Node sibling2 = sibling1.getNextSibling();
				String value = null;
				if(sibling2.hasChildNodes()){
					value = sibling2.getChildNodes().item(0).getNodeValue();
				}
				map.put(key, value);
			}
			if(node.hasChildNodes()){
				NodeList children = node.getChildNodes();
				for(int i=0;i<children.getLength();i++){
					map = getHashMapValue(map,children.item(i));
				}
			}
		}
		return map;
	}

	public Connection getConnection(int vpdID) throws Exception {
		try {
			JDBCServiceLocator geService = JDBCServiceLocator.getInstance();
			return geService.getConnection(vpdID, FrontMenuConstant.STRUT_NAME);
		} catch (Exception e) {
			logger.error("getConnection :" + e);
			throw new Exception(e.getMessage());
		}
	}
}

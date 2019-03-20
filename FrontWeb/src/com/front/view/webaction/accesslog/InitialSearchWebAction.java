/**
 * 
 */
package com.front.view.webaction.accesslog;

import java.util.HashMap;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.avalant.cache.data.CacheDataM;
import com.front.dao.log.MasterLogDAO;
import com.front.dao.log.exception.MasterLogException;
import com.front.j2ee.pattern.control.FrontScreenFlowManager;
import com.front.service.EJBDAOFactory;
import com.front.view.form.accesslog.LogFormHandler;
import com.oneweb.j2ee.pattern.control.event.Event;
import com.oneweb.j2ee.pattern.control.event.EventResponse;
import com.oneweb.j2ee.pattern.util.DisplayFormatUtil;
import com.oneweb.j2ee.pattern.view.webaction.WebAction;
import com.oneweb.j2ee.pattern.view.webaction.WebActionHelper;

/**
 * @author user
 *
 */
public class InitialSearchWebAction extends WebActionHelper implements WebAction {
	private Logger logger = Logger.getLogger(this.getClass());
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#getNextActivityType()
	 */
	public int getNextActivityType() {
		return 0;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#preModelRequest()
	 */
	public boolean preModelRequest() {
		//String username = "wasadmin"; //getRequest().getParameter("userName");//getRequest().getRemoteUser();
		String username = getRequest().getRemoteUser();
		String branchCode = getRequest().getParameter("branchCode");
		Vector userRole = (Vector)getRequest().getSession().getAttribute("userRole");
		
		LogFormHandler form = new LogFormHandler(username, userRole,branchCode);
		MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
		HashMap hAccessLog=null;
		try {
			hAccessLog = dao.loadAccessTypeList();
		} catch (MasterLogException e) {
			e.printStackTrace();
		}
		HashMap hTransactionActionLog=null;
		try {
			hTransactionActionLog = dao.loadActionTypeList("1");
		} catch (MasterLogException e) {
			e.printStackTrace();
		}
		getRequest().getSession().setAttribute("logForm", form);
        FrontScreenFlowManager screenFlowManager = (FrontScreenFlowManager) getRequest().getSession(true).getAttribute("screenFlowManager");
        screenFlowManager.setCurrentScreenTemplate("screen_template/default/default.jsp");
        if("SEARCH_TRANSACTION_LOG".equals(getRequest().getParameter("s"))){
        	form.setAction("SEARCH_TRANSACTION_LOG");
            form.setTitle("Transaction Log");
        	form.setCriterialName1("Action Type:");
        	form.setCriterialList1(hTransactionActionLog);
        	form.setCriterialName2("Module Name:");
        	form.setCriterialValue2("");
        	String[] columnName = {"No","Date","Username","Module Name","Action Type","Detail"};
        	form.setColumnName(columnName);
        }else{
        	form.setAction("SEARCH_ACCESS_LOG");
        	form.setTitle("Access Log");
        	form.setCriterialName1("Access Type:");
        	form.setCriterialList1(hAccessLog);
        	String[] columnName = {"No","Date","Username","Access Type","Action Type","Detail"};
        	form.setColumnName(columnName);
        }
		return true;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#processEventResponse(com.front.j2ee.pattern.control.event.EventResponse)
	 */
	public boolean processEventResponse(EventResponse response) {
		// TODO Auto-generated method stub
		return false;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#requiredModelRequest()
	 */
	public boolean requiredModelRequest() {
		// TODO Auto-generated method stub
		return false;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#toEvent()
	 */
	public Event toEvent() {
		// TODO Auto-generated method stub
		return null;
	}
	public HashMap convertVectorToHashMap(Vector cacheDataVt) {
		logger.debug(" @@@@ convertVectorToHashMap @@@@ ");
		// TODO Auto-generated method stub
		HashMap map = new HashMap();
		CacheDataM obj = null;
		String value = "";
		String name = "";
		try{
			if(null != cacheDataVt && 0 < cacheDataVt.size()){
				logger.debug(" @@@@ In convertVectorToHashMap @@@@ ");
				for(int i=0;i<cacheDataVt.size();i++){
					obj = (CacheDataM) cacheDataVt.get(i);
					value = DisplayFormatUtil.displayHTML(obj.getCode()).trim();
					name = DisplayFormatUtil.displayHTML(obj.getShortDesc()).trim();
					map.put(value,name);
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return map;
		
	}
	//@Override
	public Object getParameterObject() {
		// TODO Auto-generated method stub
		return null;
	}
	//@Override
	public boolean preModelRequest(Object arg0) {
		// TODO Auto-generated method stub
		return false;
	}
}

/**
 * 
 */
package com.front.view.webaction.accesslog;

import java.util.Vector;

import com.front.dao.log.MasterLogDAO;
import com.front.service.EJBDAOFactory;
import com.front.view.form.accesslog.LogFormHandler;
import com.oneweb.j2ee.pattern.control.event.Event;
import com.oneweb.j2ee.pattern.control.event.EventResponse;
import com.oneweb.j2ee.pattern.view.webaction.WebAction;
import com.oneweb.j2ee.pattern.view.webaction.WebActionHelper;

/**
 * @author user
 *
 */
public class SearchTransactionLogWebAction extends WebActionHelper implements WebAction {
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#getNextActivityType()
	 */
	public int getNextActivityType() {
		// TODO Auto-generated method stub
		return 0;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.webaction.WebAction#preModelRequest()
	 */
	public boolean preModelRequest() {
		LogFormHandler logForm = (LogFormHandler)getRequest().getSession().getAttribute("logForm");		
		try{
			int start = 1 + (logForm.getCurrentPage()-1)*logForm.getPageSize();
			int end = logForm.getPageSize() + (logForm.getCurrentPage()-1)*logForm.getPageSize();
			MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
			Vector result = dao.searchTransactionLog(logForm.getUsername(), logForm.getCriterialValue1(), logForm.getCriterialValue2(), logForm.getFromDate(), logForm.getToDate(), start,end);
			int count = dao.countSearchTransactionLog(logForm.getUsername(), logForm.getCriterialValue1(), logForm.getCriterialValue2(), logForm.getFromDate(), logForm.getToDate());
			logForm.setResultList(result);
			logForm.setTotalResult(count);
		}catch(Exception e){
			e.printStackTrace();
			logForm.setResultList(new Vector());
			logForm.setTotalResult(0);
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
/*	private String getActivityType(String code){
		switch(Integer.parseInt(code)){
			case 0: return null;
			case 1: return "CLT";//"Collection";
			case 2: return "IWC";//"Inward Clearing";
			case 3: return "VIF";//"Validate Info";
			case 4: return "MIS";//"Mismatch FI Info";
			case 5: return "EXP";//"Export";
			case 6: return "IMP";//"Import";
			default: return null;
		}
	}
	private String getActionType(String code){
		switch(Integer.parseInt(code)){
			case 0: return null;
			case 1: return "A";//"Add";
			case 2: return "E";//"Edit";
			case 3: return "R";//"Delete";
			default: return null;
		}
	}*/
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

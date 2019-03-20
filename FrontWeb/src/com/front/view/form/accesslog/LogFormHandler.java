/**
 * 
 */
package com.front.view.form.accesslog;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.front.dao.log.MasterLogDAO;
import com.front.service.EJBDAOFactory;
import com.front.service.ServiceConstant;
import com.oneweb.j2ee.pattern.view.form.FormHandler;

/**
 * @author user
 *
 */
public class LogFormHandler extends FormHandler {
	private String username;
	private Date fromDate;
	private Date toDate;
	private Vector resultList;
	private int totalResult;
	private int currentPage;
	private int pageSize;
	
	private String action;
	private String title;
	private String criterialName1;
	private String criterialName2;
	private String criterialName3;
	private HashMap criterialList1;
	private HashMap criterialList3;
	private String criterialValue1;
	private String criterialValue2;
	private String criterialValue3;
	private String[] columnName;
	
	private static String IAMUsername = ServiceConstant.WS_IAM_USERNAME;
	private static String IAMPassword = ServiceConstant.WS_IAM_PASSWORD;
	private static String IAMURL = ServiceConstant.WS_IAM_URL;
	/**
	 * 
	 */
	private final static transient Logger logger = Logger.getLogger(LogFormHandler.class);
	public LogFormHandler() {
		this("", new Vector(),"");
	}
	public LogFormHandler(String logonUser, Vector userType,String theBranchCode) {
			try {
				MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
			} catch (Exception e) {
				logger.error("Cannot get MasterDAO", e);
			}
			username = logonUser;
			fromDate = null;
			toDate = null;
			resultList = null;
			currentPage = 1;
			pageSize = 20;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.form.FormHandler#clearForm()
	 */
	
	public void clearForm() {
	// TODO Auto-generated method stub
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.form.FormHandler#postProcessForm(javax.servlet.http.HttpServletRequest)
	 */
	
	public void postProcessForm(HttpServletRequest request) {
	// TODO Auto-generated method stub
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.form.FormHandler#setProperties(javax.servlet.http.HttpServletRequest)
	 */
	
	public void setProperties(HttpServletRequest request) {
		if(resultList==null||currentPage==Integer.parseInt(request.getParameter("pageNo"))){
			username = request.getParameter("userNameTextbox");
			fromDate = stringToDate(request.getParameter("fromDateTextbox"));
			toDate = stringToDate(request.getParameter("toDateTextbox"));
			criterialValue1 = request.getParameter("criterialSelectBox1");
			criterialValue2 = request.getParameter("criterialTextbox2");
			criterialValue3 = request.getParameter("criterialSelectBox3");
			totalResult = 0;
			currentPage = 1;
			pageSize = Integer.parseInt(request.getParameter("itemsPerPage"));
		}else{
			currentPage = Integer.parseInt(request.getParameter("pageNo"));
			pageSize = Integer.parseInt(request.getParameter("itemsPerPage"));
		}
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.form.FormHandler#validInSessionScope()
	 */
	
	public boolean validInSessionScope() {
		// TODO Auto-generated method stub
		return false;
	}
	/* (non-Javadoc)
	 * @see com.oneweb.j2ee.pattern.view.form.FormHandler#validateForm(javax.servlet.http.HttpServletRequest)
	 */

	public boolean validateForm(HttpServletRequest request) {
		Set errorMessage = new HashSet();
		this.clearAllErrors();
		if(resultList==null||currentPage==Integer.parseInt(request.getParameter("pageNo"))){
			if(fromDate==null && request.getParameter("fromDateTextbox")!=null && request.getParameter("fromDateTextbox").length()>0){
				errorMessage.add("Format is DD/MM/YYYY. (AD)");
			}else if(toDate==null && request.getParameter("toDateTextbox")!=null && request.getParameter("toDateTextbox").length()>0){
				errorMessage.add("Format is DD/MM/YYYY. (AD)");
			}
		}
		request.getSession().setAttribute("errorMessage", errorMessage);
		return errorMessage.isEmpty();
	}
	public HashMap loadActivityTypeList(String logType){
		HashMap map = new HashMap();
		try{
			MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
			map = dao.loadActivityTypeList(logType);
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	public HashMap loadActionTypeList(String logType){
		HashMap map = new HashMap();
/*		if("2".equals(logType)){
			map.put("A","Add");
			map.put("E","Edit");
			map.put("R","Delete");
		}else if("3".equals(logType)){
			map.put("A","Add");
			map.put("E","Edit");
			map.put("R","Delete");
			map.put("U","Authorized");
			map.put("C","Cancel");
		}*/
		try{
			MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
			map = dao.loadActionTypeList(logType);
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	public HashMap loadAccessTypeList(){
		HashMap map = new HashMap();
		try{
			MasterLogDAO dao = EJBDAOFactory.getMasterLogDAO();
			map = dao.loadAccessTypeList();
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}

	private boolean isNumeric(String sText){
        boolean isNumber = true;
        if(sText==null||sText.equals("")){
            isNumber = false;
        }
        for(int i=0;i<sText.length()&&isNumber;i++){
            if(!Character.isDigit(sText.charAt(i))){
                isNumber = false;
            }
        }
        return isNumber;
    }
	private Date stringToDate(String dateText){
		return stringToDate(dateText, null, null);
	}
	private Date stringToDate(String dateText, String dateFormat, Locale dateLocale){
		try{
			if(dateFormat == null){
				dateFormat = "dd/mm/yyyy";
			}
			if(dateText == null || dateText.length()!=dateFormat.length()){
				return null;
			}
			if(dateLocale == null){
				dateLocale = Locale.US;
			}
			if("dd/mm/yyyy".equalsIgnoreCase(dateFormat)){
				Calendar cal = Calendar.getInstance(dateLocale);
				int dd = Integer.parseInt(dateText.substring(0,2));
				int mm = Integer.parseInt(dateText.substring(3,5))-1;
				int yyyy = Integer.parseInt(dateText.substring(6,10));
				cal.set(yyyy, mm, dd);
				return cal.getTime();
			}else if("mm/dd/yyyy".equalsIgnoreCase(dateFormat)){
				Calendar cal = Calendar.getInstance(dateLocale);
				int dd = Integer.parseInt(dateText.substring(3,5));
				int mm = Integer.parseInt(dateText.substring(0,2))-1;
				int yyyy = Integer.parseInt(dateText.substring(6,10));
				cal.set(yyyy, mm, dd);
				return cal.getTime();
			}
		}catch(Exception e){}
		return null;
	}
	/**
	 * @return the fromDate
	 */
	public Date getFromDate() {
		return fromDate;
	}
	/**
	 * @param fromDate the fromDate to set
	 */
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	/**
	 * @return the toDate
	 */
	public Date getToDate() {
		return toDate;
	}
	/**
	 * @param toDate the toDate to set
	 */
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	/**
	 * @return the resultList
	 */
	public Vector getResultList() {
		return resultList;
	}
	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(Vector resultList) {
		this.resultList = resultList;
	}
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @return the currentPage
	 */
	public int getCurrentPage() {
		return currentPage;
	}
	/**
	 * @param currentPage the currentPage to set
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}
	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	/**
	 * @return the totalResult
	 */
	public int getTotalResult() {
		return totalResult;
	}
	/**
	 * @param totalResult the totalResult to set
	 */
	public void setTotalResult(int totalResult) {
		this.totalResult = totalResult;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the criterialName1
	 */
	public String getCriterialName1() {
		return criterialName1;
	}
	/**
	 * @param criterialName1 the criterialName1 to set
	 */
	public void setCriterialName1(String criterialName1) {
		this.criterialName1 = criterialName1;
	}
	/**
	 * @return the criterialName2
	 */
	public String getCriterialName2() {
		return criterialName2;
	}
	/**
	 * @param criterialName2 the criterialName2 to set
	 */
	public void setCriterialName2(String criterialName2) {
		this.criterialName2 = criterialName2;
	}
	/**
	 * @return the criterialName3
	 */
	public String getCriterialName3() {
		return criterialName3;
	}
	/**
	 * @param criterialName3 the criterialName3 to set
	 */
	public void setCriterialName3(String criterialName3) {
		this.criterialName3 = criterialName3;
	}
	/**
	 * @return the criterialList1
	 */
	public HashMap getCriterialList1() {
		return criterialList1;
	}
	/**
	 * @param criterialList1 the criterialList1 to set
	 */
	public void setCriterialList1(HashMap criterialList1) {
		this.criterialList1 = criterialList1;
	}
	/**
	 * @return the criterialList3
	 */
	public HashMap getCriterialList3() {
		return criterialList3;
	}
	/**
	 * @param criterialList3 the criterialList3 to set
	 */
	public void setCriterialList3(HashMap criterialList3) {
		this.criterialList3 = criterialList3;
	}
	/**
	 * @return the criterialValue1
	 */
	public String getCriterialValue1() {
		return criterialValue1;
	}
	/**
	 * @param criterialValue1 the criterialValue1 to set
	 */
	public void setCriterialValue1(String criterialValue1) {
		this.criterialValue1 = criterialValue1;
	}
	/**
	 * @return the criterialValue2
	 */
	public String getCriterialValue2() {
		return criterialValue2;
	}
	/**
	 * @param criterialValue2 the criterialValue2 to set
	 */
	public void setCriterialValue2(String criterialValue2) {
		this.criterialValue2 = criterialValue2;
	}
	/**
	 * @return the criterialValue3
	 */
	public String getCriterialValue3() {
		return criterialValue3;
	}
	/**
	 * @param criterialValue3 the criterialValue3 to set
	 */
	public void setCriterialValue3(String criterialValue3) {
		this.criterialValue3 = criterialValue3;
	}
	/**
	 * @return the action
	 */
	public String getAction() {
		return action;
	}
	/**
	 * @param action the action to set
	 */
	public void setAction(String action) {
		this.action = action;
	}
	/**
	 * @return the columnName
	 */
	public String[] getColumnName() {
		return columnName;
	}
	/**
	 * @param columnName the columnName to set
	 */
	public void setColumnName(String[] columnName) {
		this.columnName = columnName;
	}
	//@Override
	public void setPropertiesList(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		
	}
	//@Override
	public boolean validateFormList(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		return false;
	}
}

package com.manual;

import java.util.Date;
import java.util.HashMap;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.master.form.EntityFormHandler;
import com.master.util.EAFManualUtil;
import com.master.util.ProcessAction;
import com.master.util.ProcessHelper;

public class LeaveDetailManual extends ProcessHelper implements ProcessAction{
	private final static transient Logger logger = Logger.getLogger(LeaveDetailManual.class);
	@Override
	public boolean validateEntity() {
		// TODO Auto-generated method stub
		Vector vError = new Vector();
		try{
			String entityID = (String)getRequest().getSession().getAttribute("entityID");
			EntityFormHandler entityForm = (EntityFormHandler)getRequest().getSession().getAttribute(entityID+"_session");
			
			HashMap hData = EAFManualUtil.getDataHashMapFromSession(entityForm.getMainModuleID(), getRequest());
			
			String type = (String)hData.get("TYPE");
			Date startDate = (Date)hData.get("START_DATE");
			Date today = new Date();
			logger.debug("[LeaveDetailManual] : type="+type);
			logger.debug("[LeaveDetailManual] : startDate="+startDate);
			
			if("VAC".equals(type) || "REPLACE".equals(type)){
				if(startDate.compareTo(today) < 0){
					EAFManualUtil.addErrorMsg(entityForm.getMainModuleID(), "This leave type can't use in the past.", getRequest());
					vError.add("ERROR");
				}
			}
		
		} catch (Exception e) { 
			logger.error("leaveDetailManual", e);
		}
		return (vError.size()==0);
	}

}

package com.front.j2ee.pattern.control;

import com.oneweb.j2ee.pattern.control.ScreenFlowManager;

/**
 * @version 	1.0
 * @author
 */
public class FrontScreenFlowManager  extends ScreenFlowManager {
	
	private String currentScreenTemplate = "screen_template/default/default.jsp";
	
	public FrontScreenFlowManager() {}
	
	public FrontScreenFlowManager(String strutName) {
		super(strutName);
	}

	public String getCurrentScreenTemplate() {
		return currentScreenTemplate;
	}
	public void setCurrentScreenTemplate(String currentScreenTemplate) {
		this.currentScreenTemplate = currentScreenTemplate;
	}
}
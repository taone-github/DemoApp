package com.front.form.menu;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.front.model.menu.MenuM;

public class MenuHandlerManager implements Serializable,Cloneable{
	private static transient Logger logger = Logger.getLogger(MenuHandlerManager.class);
	public MenuHandlerManager(){
		super();
	}
	private ArrayList<MenuM> topLevelMenus;
	private HashMap<String,ArrayList<MenuM>> subMenus;
	public ArrayList<MenuM> getTopLevelMenus() {
		return topLevelMenus;
	}
	public void setTopLevelMenus(ArrayList<MenuM> topLevelMenus) {
		this.topLevelMenus = topLevelMenus;
	}
	public HashMap<String, ArrayList<MenuM>> getSubMenus() {
		return subMenus;
	}
	public void setSubMenus(HashMap<String, ArrayList<MenuM>> subMenus) {
		this.subMenus = subMenus;
	}	
}

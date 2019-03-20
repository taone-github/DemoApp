package com.front.utility;

import java.util.ArrayList;

import com.front.model.menu.MenuM;

public class CommonUtil {
	
	public static MenuM getMenuFromList(ArrayList<MenuM> menuList, String menuId) {
		if(menuList != null && !menuList.isEmpty()) {
			for(MenuM topMenu : menuList) {
				if(topMenu.getMenuID().equals(menuId)) {
					return topMenu;
				}
			}
		}
		return null;
	}

}

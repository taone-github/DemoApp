package com.front.model.menu;

import java.io.Serializable;

/** @modelguid {7F19787E-3ECD-4634-B3FD-FEBFE4BBB224} */
public class MenuM implements Cloneable,Serializable,Comparable<MenuM>{
	/** @modelguid {F8523AAC-A874-4C8F-A670-827DFA24C32F} */
	public static String PAGE = "2";

	/** @modelguid {4C9E625D-3054-4E0F-9BA8-CCF5EF73F17E} */
	public static String LABEL = "1";

	/** @modelguid {2D0E65BF-B932-458D-8381-3A42C2F1179F} */
	private String menuID;

	/** @modelguid {5A30DDE6-FBBC-4E56-A975-F25D3500BC0D} */
	private String menuName;

	/** @modelguid {F22BE780-40CC-4E63-8769-70B0001AC131} */
	private String menuType;

	/** @modelguid {4D1EC3E1-0759-4439-BBA5-DA00907E053A} */
	private String menuLevel;

	/** @modelguid {E8F48B28-0D68-43E0-B2D6-F8BE16997FFB} */
	private String menuSeq;

	/** @modelguid {ABBE6B86-7F2E-4290-8A07-BF2A0F09FBFE} */
	private String menuReference;

	/** @modelguid {CCE94E03-5B66-4D70-AEEF-65B54EE6C89F} */
	private String menuAction;

	private String menuTarget;
	
	private String icon;
	
    /**
     * @return Returns the lABEL.
     */
    public static String getLABEL() {
        return LABEL;
    }
    /**
     * @param label The lABEL to set.
     */
    public static void setLABEL(String label) {
        LABEL = label;
    }
    /**
     * @return Returns the pAGE.
     */
    public static String getPAGE() {
        return PAGE;
    }
    /**
     * @param page The pAGE to set.
     */
    public static void setPAGE(String page) {
        PAGE = page;
    }
    /**
     * @return Returns the menuAction.
     */
    public String getMenuAction() {
        return menuAction;
    }
    /**
     * @param menuAction The menuAction to set.
     */
    public void setMenuAction(String menuAction) {
        this.menuAction = menuAction;
    }
    /**
     * @return Returns the menuID.
     */
    public String getMenuID() {
        return menuID;
    }
    /**
     * @param menuID The menuID to set.
     */
    public void setMenuID(String menuID) {
        this.menuID = menuID;
    }
    /**
     * @return Returns the menuLevel.
     */
    public String getMenuLevel() {
        return menuLevel;
    }
    /**
     * @param menuLevel The menuLevel to set.
     */
    public void setMenuLevel(String menuLevel) {
        this.menuLevel = menuLevel;
    }
    /**
     * @return Returns the menuName.
     */
    public String getMenuName() {
        return menuName;
    }
    /**
     * @param menuName The menuName to set.
     */
    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }
    /**
     * @return Returns the menuReference.
     */
    public String getMenuReference() {
        return menuReference;
    }
    /**
     * @param menuReference The menuReference to set.
     */
    public void setMenuReference(String menuReference) {
        this.menuReference = menuReference;
    }
    /**
     * @return Returns the menuSeq.
     */
    public String getMenuSeq() {
        return menuSeq;
    }
    /**
     * @param menuSeq The menuSeq to set.
     */
    public void setMenuSeq(String menuSeq) {
        this.menuSeq = menuSeq;
    }
    /**
     * @return Returns the menuType.
     */
    public String getMenuType() {
        return menuType;
    }
    /**
     * @param menuType The menuType to set.
     */
    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }
	/**
	 * @return the menuTarget
	 */
	public String getMenuTarget() {
		return menuTarget;
	}
	/**
	 * @param menuTarget the menuTarget to set
	 */
	public void setMenuTarget(String menuTarget) {
		this.menuTarget = menuTarget;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIcon() {
		return icon;
	}
	@Override
	public int compareTo(MenuM o) {
		return Integer.parseInt(menuSeq==null?"0":menuSeq)- Integer.parseInt(o.menuSeq==null?"0":o.menuSeq);
	}
}


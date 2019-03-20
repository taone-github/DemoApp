package com.front.utility;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.front.model.menu.MenuM;

public class GenerateMenuProSilver {
	private final static transient Logger logger = Logger.getLogger(GenerateMenuProSilver.class);
	public static LinkedHashMap currentHash;
	public static int treeNumber = 0;
	/*
	 * This version support only MenuLevel 1 and 2 other level don't display
	 */
	public String getHtml(HttpServletRequest request){
		StringBuffer result = new StringBuffer();
		Vector vecMenus = (Vector)request.getSession().getAttribute("vecMenus");
		
		HashMap hAuthenMenu = (HashMap)request.getSession().getAttribute("authenMenu");
		ArrayList visibleMenuIDs = new ArrayList();
		boolean ias3Mode = true;
		if (hAuthenMenu == null ) {
			hAuthenMenu = new HashMap();
			ias3Mode = false;
		}
		
		HashMap menuLevel2Map = new HashMap();
		//HashMap menuLevel2 = new HashMap();
		
		int index =0;
		
		//Collect all Level 2
		/*for(int i=0;i<vecMenus.size();i++){	
			MenuM menuM = (MenuM)vecMenus.elementAt(i);
			if(2 == Double.parseDouble(menuM.getMenuLevel())){
				//menuLevel2.put(menuM.getMenuID(), menuM);
				if(!menuLevel2Map.containsKey(menuM.getMenuReference())){
					menuLevel2Map.put(menuM.getMenuReference(), new Vector());
				}
				Vector temp = (Vector)menuLevel2Map.get(menuM.getMenuReference());
				temp.add(menuM);
				menuLevel2Map.put(menuM.getMenuReference(), temp);
			}
		}*/
		
		//Create Hash MenuID:Model
		HashMap menuAll = new HashMap();
		for(int i=0;i<vecMenus.size();i++){	
			MenuM menuM = (MenuM)vecMenus.elementAt(i);
			menuAll.put(menuM.getMenuID(), menuM);
		}
		//Collect all level And sort order
		//Expect data
		// {LabelA:{{LabelB:{Menu1}},Menu2},Menu3}
		//	LabelA
		//		--LabelB
		//			Menu1
		//		--Menu2
		//	Menu3  don't collect Menu3 on level1 collect only label
		
		//First : add all Label to menuOrdered
		orderMenu(vecMenus,menuAll);
		
		//Collect all Level1 in case to hide all
		Vector labelLevel1 = new Vector();
		
		//Generate html
		logger.debug("currentHash : " + currentHash);
		for(int i=0;i<vecMenus.size();i++){	
			MenuM menuM = (MenuM)vecMenus.elementAt(i);
			if (hAuthenMenu.containsKey(menuM.getMenuID()) || (ias3Mode == false)) {
				if (ias3Mode == false) {
					index = i;
				}
				if(1 == Double.parseDouble(menuM.getMenuLevel())){
					//if(menuM.getMenuAction()!=null) menuM.setMenuAction(menuM.getMenuAction() + "&permChkStr1=" + menuM.getMenuID() + "&permChkStr2=" + userName);
					addParamToMenu(menuM,request);
					
					result.append("<dl class=\"dropdown\">");
					if("LABEL".equals(menuM.getMenuType())){
						//label
						//result.append("<dt id=\""+menuM.getMenuID()+"-ddheader\" class=\"upperdd\" onmouseover=\"ddMenu('"+menuM.getMenuID()+"',1);toggleLevel2();\" onmouseout=\"ddMenu('"+menuM.getMenuID()+"',-1);toggleLevel2();\">");
						result.append("<dt id=\""+menuM.getMenuID()+"-ddheader\" class=\"upperdd\" onclick=\"ddMenuEAF2('"+menuM.getMenuID()+"');\" >");
						
						labelLevel1.add(menuM.getMenuID());
						
						String labelIcon = "menu1";
						if(menuM.getMenuID().equals("MENU_130325152408623")){//menuM.getMenuName().equals("Setting")
							labelIcon ="menu2";
						}else if(menuM.getMenuID().equals("MENU_130312164726486")){
							labelIcon ="menu3";
						}
						
						//result.append("	<div class=\""+labelIcon+"\" ><div class=\"menutextmainpadding\">");
						//result.append("	<div class=\""+labelIcon+"\" ><div class=\"menutextmainpadding\">");
						result.append("	<div class=\""+labelIcon+"\"onmouseover=\"this.className='"+labelIcon+"over'\" onmouseout=\"this.className='"+labelIcon+"'\" ><div class=\"menutextmainpadding\">");
						
						//result.append("	<a href=\"#\">"+menuM.getMenuName()+"</a>");
						result.append("	<span>"+menuM.getMenuName()+"</span>");
						result.append("</div></div>");
						result.append("</dt>");
						//label have submenu
						//Process sub menu level2
						/*Vector temp = (Vector)menuLevel2Map.get(menuM.getMenuID());
						logger.debug("temp : " + temp);
						result.append(generateMenuLevel2(temp,menuM,visibleMenuIDs));*/
						
						//retrieve Vector menuM that under this menu
						Vector temp = new Vector(); 
						temp = retrieveVectorMenuM((LinkedHashMap)currentHash.get(menuM.getMenuID()),menuAll,temp);
						result.append(generateMenuLevel2Tree(temp,menuM,visibleMenuIDs,request,hAuthenMenu,ias3Mode));
					}else{
						result.append("<dt id=\""+menuM.getMenuID()+"-ddheader\" class=\"upperdd\">");
						result.append("	<div class=\"menu1\"><div class=\"menutextmainpadding\">");
						result.append("	<a target=\""+menuM.getMenuTarget()+"\" href=\""+menuM.getMenuAction()+"\">"+menuM.getMenuName()+"</a>");
						result.append("</div></div>");
						result.append("</dt>");
						visibleMenuIDs.add(menuM.getMenuID());
					}
					result.append("</dl>");
				}else{
					//for level 2 -> xx become tree on function  generateMenuLevel2Tree
				}
			}
		}
		
		//result.append(scriptHideAllLabel1(labelLevel1));
		//test build tree from level2
		
		for(int i=0;i<visibleMenuIDs.size();i++){
			logger.debug("visibleMenuIDs method : " + visibleMenuIDs.get(i));
		}
		request.getSession().setAttribute("visibleMenuIDs", visibleMenuIDs);
		return result.toString();
	}
	
	@Deprecated
	public String scriptHideAllLabel1(Vector labelLevel1){
		StringBuffer result=  new StringBuffer();
		result.append("<script type=\"text/javascript\">");
		result.append("var label1 = [];");
		for(int i=0;i<labelLevel1.size();i++){
			result.append("label1["+i+"] = '"+labelLevel1.get(i)+"';");
		}
		result.append("</script>");
		return result.toString();
	}
	@Deprecated
	public String generateTree(Vector temp){
		StringBuffer result=  new StringBuffer();
		result.append("<script type=\"text/javascript\">");
		result.append("var arrayobj = [];");
		result.append("d = new dTree('d');");
		result.append("for(a=0;a<parseInt(arrayobj.length);a++){");
		result.append("	d.add(arrayobj[a][0],arrayobj[a][1],arrayobj[a][2],arrayobj[a][3],arrayobj[a][2],arrayobj[a][4],arrayobj[a][5]);");
		result.append("}");
		result.append("document.write(d);");
		result.append("</script>");
		return result.toString();
	}
	@Deprecated
	public String generateMenuLevel2(Vector temp,MenuM menuM,ArrayList visibleMenuIDs){
		StringBuffer result=  new StringBuffer();
		if(null!=temp && (temp.size() > 0)){
			//result.append("<dd id=\""+menuM.getMenuID()+"-ddcontent\" onmouseover=\"cancelHide('"+menuM.getMenuID()+"');toggleLevel2();\" onmouseout=\"ddMenu('"+menuM.getMenuID()+"',-1);toggleLevel2();\">");
			//result.append("<dd id=\""+menuM.getMenuID()+"-ddcontent\" onmouseover=\"cancelHideEAF('"+menuM.getMenuID()+"');\" onmouseout=\"ddMenuEAF('"+menuM.getMenuID()+"',-1);\">");
			result.append("<dd id=\""+menuM.getMenuID()+"-ddcontent\" >");
			result.append(" <ul>");
			for(int j=0;j<temp.size();j++){
				MenuM menuLvl2M = (MenuM)temp.get(j);
				if("PAGE".equals(menuLvl2M.getMenuType())){
					String classMenu ="";
					if(j==0){
						classMenu = "class=\"firstMenu\"";
					}
					if(menuLvl2M.getMenuAction().indexOf("refreshMaster.jsp") > 0){
						result.append("<li "+classMenu+" >	<a href=\"#\" onclick=\"refreshCache();\">"+menuLvl2M.getMenuName()+"</a>");
					}else{
						result.append("<li "+classMenu+" >	<a target=\""+menuLvl2M.getMenuTarget()+"\" href=\""+menuLvl2M.getMenuAction()+"\">"+menuLvl2M.getMenuName()+"</a>");
					}
					
					result.append("</li>");
					visibleMenuIDs.add(menuLvl2M.getMenuID());
				}else{
					//label of level2
				}
			}
		    result.append("  </ul>");
		    result.append(" </dd>");
		}
		return result.toString();
	}
	
	public String generateMenuLevel2Tree(Vector temp,MenuM menuM,ArrayList visibleMenuIDs,HttpServletRequest request,HashMap hAuthenMenu,boolean ias3Mode){
		StringBuffer result=  new StringBuffer();
		if(null!=temp && (temp.size() > 0)){
			//result.append("<dd id=\""+menuM.getMenuID()+"-ddcontent\" onmouseover=\"cancelHide('"+menuM.getMenuID()+"');toggleLevel2();\" onmouseout=\"ddMenu('"+menuM.getMenuID()+"',-1);toggleLevel2();\">");
			//result.append("<dd id=\""+menuM.getMenuID()+"-ddcontent\" onmouseover=\"cancelHideEAF('"+menuM.getMenuID()+"');\" onmouseout=\"ddMenuEAF('"+menuM.getMenuID()+"',-1);\">");
			result.append("<dd id=\""+menuM.getMenuID()+"-ddcontent\" >");
			result.append(" <ul>");
			result.append("<li>");
			// 1 tree 1 drawMenuFunction
			treeNumber++;
			result.append("<script type=\"text/javascript\">");
			result.append("function drawMenu"+treeNumber+"(){");
			result.append("var arrayobj = [];");
			//root tree
			//result.append("arrayobj[0] = ['"+menuM.getMenuID()+"','-1','"+menuM.getMenuName()+"'];");
			//int index = 1;
			int index = 0;
			String treeName = "dt"+treeNumber;
			for(int j=0;j<temp.size();j++){
				MenuM menuLvl2M = (MenuM)temp.get(j);
				if (hAuthenMenu.containsKey(menuLvl2M.getMenuID()) || (ias3Mode == false)) {
					//if(menuLvl2M.getMenuAction()!=null) menuLvl2M.setMenuAction(menuLvl2M.getMenuAction() + "&permChkStr1=" + menuLvl2M.getMenuID() + "&permChkStr2=" + userName);
					addParamToMenu(menuLvl2M,request);
					
					String menuRef = menuLvl2M.getMenuReference();
					//level 2 become root
					if(menuLvl2M.getMenuLevel().equals("2")){
						menuRef = "-1";
					}
					if("LABEL".equals(menuLvl2M.getMenuType())){
						//label of level2
						result.append("arrayobj["+index+"] = ['"+menuLvl2M.getMenuID()+"','"+menuRef+"','"+menuLvl2M.getMenuName()+"'];");
						index++;
					}else{
						result.append("arrayobj["+index+"] = ['"+menuLvl2M.getMenuID()+"','"+menuRef+"','"+menuLvl2M.getMenuName()+"'");
						if(menuLvl2M.getMenuAction()!=null)result.append(",'"+menuLvl2M.getMenuAction()+"'");
						if(menuLvl2M.getMenuTarget()!=null)result.append(",'"+menuLvl2M.getMenuTarget()+"'");
						result.append("];");
						index++;
						visibleMenuIDs.add(menuLvl2M.getMenuID());
					}
				}
			}
			
			result.append(treeName+" = new dTree('"+treeName+"');");
			result.append("for(a=0;a<parseInt(arrayobj.length);a++){");
				/**add(id, pid, name, url, title, target, icon, iconOpen, open)**/
			result.append("	"+treeName+".add(arrayobj[a][0],arrayobj[a][1],arrayobj[a][2],arrayobj[a][3],arrayobj[a][2],arrayobj[a][4],arrayobj[a][5]);");
			result.append("}");
			result.append("document.write("+treeName+");");
			result.append("}");
			result.append("drawMenu"+treeNumber+"();");
			result.append("</script>");
			
			result.append("</li>");
		    result.append("  </ul>");
		    result.append(" </dd>");
		}
		return result.toString();
	}
	
	private void orderMenu(Vector vecMenus,HashMap menuAll){
		currentHash = new LinkedHashMap();
		for(int i=0;i<vecMenus.size();i++){
			MenuM menuM = (MenuM)vecMenus.elementAt(i);
			logger.debug("before add "+menuM.getMenuID()+" : "+ currentHash);
			currentHash = traverseAdd(menuM,currentHash,1,menuAll);
			logger.debug("after add "+menuM.getMenuID()+" : "+ currentHash);
		}
	}
	
	private LinkedHashMap traverseAdd(MenuM menuM,LinkedHashMap currentHash,int currentlevel,HashMap menuAll){
		boolean result = false;
		int menuLevel = Integer.parseInt(menuM.getMenuLevel());
		logger.debug("currentlevel : "+ currentlevel);
		logger.debug("menuM.getMenuLevel() : "+ menuLevel);
		logger.debug("currentHash : "+ currentHash);
		if(null!=currentHash){
			if(menuLevel == currentlevel){
				//on current level
				logger.debug("on current level : "+ menuM.getMenuID());
				if(!currentHash.containsKey(menuM.getMenuID())){
					if("LABEL".equals(menuM.getMenuType())){
						currentHash.put(menuM.getMenuID(),new LinkedHashMap());
					}else {
						currentHash.put(menuM.getMenuID(),menuM.getMenuID());
					}
				}
				logger.debug("after add : "+ currentHash);
			}else{
				if((currentlevel+1)==menuLevel){
					//Current level 1 this item level 2 find Parent
					logger.debug("Find Parent ");
					//Check Parent really exist, parent not exist not show
					if(menuAll.containsKey(menuM.getMenuReference())){
						LinkedHashMap childHash = null;
						if(currentHash.containsKey(menuM.getMenuReference())){
							//this level 1 hash already put
							childHash =(LinkedHashMap)currentHash.get(menuM.getMenuReference());
							// become same level add to childHash
							//logger.debug("traverseAdd ");
							childHash = traverseAdd(menuM,childHash,++currentlevel,menuAll);
							currentHash.put(menuM.getMenuReference(),childHash);
						}else{
							//no level 1 for this menu right now
							//this case not happend cause sort level , seq
							//childHash = new HashMap();
							//logger.debug("no parent ");
						}
					}
					
				}else{
					//Current level 1 this item level 3 go deep down
					// if there is no level 2 it not going down so this menu not show
					++currentlevel;
					//logger.debug("traverse level : " + currentlevel);
					for(Object key:currentHash.keySet()){
						if(currentHash.get(key).getClass() == LinkedHashMap.class){
							LinkedHashMap childHash =(LinkedHashMap)currentHash.get(key);
							childHash = traverseAdd(menuM,childHash,currentlevel,menuAll);
							currentHash.put(key,childHash);
						}
					}
				}
			}
		}
		return currentHash;
	}
	
	private Vector retrieveVectorMenuM(LinkedHashMap currentHash,HashMap menuAll,Vector result){
		for(Object key:currentHash.keySet()){
			if(currentHash.get(key).getClass() == LinkedHashMap.class){
				//this is label add label
				result.add(menuAll.get(key));
				//go in label
				result = retrieveVectorMenuM((LinkedHashMap)currentHash.get(key),menuAll,result);
			}else{
				//this is page
				result.add(menuAll.get(currentHash.get(key)));
			}
		}
		return result;
	}
	
	private MenuM addParamToMenu(MenuM menuM , HttpServletRequest request){
		String userName = (String) request.getSession().getAttribute("userName");
		String companyId = (String)request.getSession().getAttribute("companyId");
		if(menuM.getMenuAction()!=null) menuM.setMenuAction(menuM.getMenuAction() + "&menuId=" + menuM.getMenuID() + "&permChkStr1=" + menuM.getMenuID() + "&permChkStr2=" + userName +"&permChkStr3="+companyId);
		return menuM;
	}
}

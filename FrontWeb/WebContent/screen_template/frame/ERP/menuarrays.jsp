<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.front.model.menu.MenuM"%>
<%@page import="java.util.Vector"%>
var arrayobj = [];
<%
/**[MenuID, MenuReference, MenuName, MenuAction, MenuTarget, icon]**/
Vector vecMenus = (Vector)request.getSession().getAttribute("vecMenus");
String userName = (String) request.getSession().getAttribute("userName");
HashMap hAuthenMenu = (HashMap)request.getSession().getAttribute("authenMenu");
String permChkStr3 = "5";//(String) request.getSession().getAttribute("permChkStr3");
permChkStr3 = (permChkStr3 != null) ? permChkStr3 : "0";

String menuTest = "";
ArrayList visibleMenuIDs = new ArrayList();
boolean ias3Mode = true;
if (hAuthenMenu == null ) {
	hAuthenMenu = new HashMap();
	ias3Mode = false;
} 
int index =0;
out.println("arrayobj["+index+"] = ['RootMenu',-1,'Menu']");
index++;
for(int i=0;i<vecMenus.size();i++){	
	MenuM menuM = (MenuM)vecMenus.elementAt(i); 	
	com.master.util.Log4jUtil.log("menuM===>"+menuM);
	if (hAuthenMenu.containsKey(menuM.getMenuID()) || (ias3Mode == false)) {
		 
		/*if (ias3Mode == false) {
			index = i;
		}*/
			com.master.util.Log4jUtil.log("menuM.getMenuLevel()"+menuM.getMenuLevel());
			if("PAGE".equals(menuM.getMenuType())){
				
				menuTest+="|"+menuM.getMenuName();
				
				if(menuM.getMenuAction()!=null) menuM.setMenuAction(menuM.getMenuAction() + "&permChkStr1=" + menuM.getMenuID() + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3);
				//id, pid, name, url, title, target, icon
				//arrayobj[a][0],arrayobj[a][1],arrayobj[a][2],arrayobj[a][3],arrayobj[a][2],arrayobj[a][4],arrayobj[a][5])
				//name and title use same index
				//arrayobj[a][0],arrayobj[a][1],arrayobj[a][2]
				if(1 == Double.parseDouble(menuM.getMenuLevel())){
					com.master.util.Log4jUtil.log("menuM Level 1 ");
					out.print("arrayobj["+index+"] = ['"+menuM.getMenuID()+"','RootMenu','"+menuM.getMenuName()+"'");
				}else{
					com.master.util.Log4jUtil.log("menuM Level out 1 ");
					out.print("arrayobj["+index+"] = ['"+menuM.getMenuID()+"','"+menuM.getMenuReference()+"','"+menuM.getMenuName()+"'");
					
				}
				//arrayobj[a][3]
				String menuAction = "null";
				if(menuM.getMenuAction()!=null)menuAction = "'"+menuM.getMenuAction()+"'";
				out.print(","+menuAction);
				//arrayobj[a][4]
				String menuTarget = "null";
				if(menuM.getMenuTarget()!=null)menuTarget = "'"+menuM.getMenuTarget()+"'";
				out.print(","+menuTarget);
				//arrayobj[a][5]
				String menuIcon = "null";
				if(menuM.getIcon()!=null)menuIcon = "'"+menuM.getIcon()+"'";
				out.print(","+menuIcon);
				out.println("]");
				visibleMenuIDs.add(menuM.getMenuID());
			}else{ 
				com.master.util.Log4jUtil.log("menuM Level Action ");
				if(1== Double.parseDouble(menuM.getMenuLevel())){
					out.print("arrayobj["+index+"] = ['"+menuM.getMenuID()+"','RootMenu','"+menuM.getMenuName()+"'");
				}else{
					out.print("arrayobj["+index+"] = ['"+menuM.getMenuID()+"','"+menuM.getMenuReference()+"','"+menuM.getMenuName()+"'");
				}
				String menuIcon = "null";
				if(menuM.getIcon()!=null)menuIcon = "'"+menuM.getIcon()+"'";
				out.print(",null,null,"+menuIcon);
				out.println("]");
			}
			index++;
	}	
}
request.getSession().setAttribute("visibleMenuIDs", visibleMenuIDs);
com.master.util.Log4jUtil.log("Menu array Asset3");
%>
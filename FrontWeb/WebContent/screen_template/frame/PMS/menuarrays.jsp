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
ArrayList visibleMenuIDs = new ArrayList();
boolean ias3Mode = true;
if (hAuthenMenu == null ) {
	hAuthenMenu = new HashMap();
	ias3Mode = false;
}
int index =0;
for(int i=0;i<vecMenus.size();i++){	
	MenuM menuM = (MenuM)vecMenus.elementAt(i); 	
	System.out.println("menuM===>"+menuM);
	if (hAuthenMenu.containsKey(menuM.getMenuID()) || (ias3Mode == false)) {
		 
		if (ias3Mode == false) {
			index = i;
		}
			System.out.println("menuM.getMenuLevel()"+menuM.getMenuLevel());
			if("PAGE".equals(menuM.getMenuType())){		
				
				
				if(menuM.getMenuAction()!=null) menuM.setMenuAction(menuM.getMenuAction() + "&permChkStr1=" + menuM.getMenuID() + "&permChkStr2=" + userName);
				
				if(1 == Double.parseDouble(menuM.getMenuLevel())){
					System.out.println("menuM Level 1 ");	
					System.out.print("arrayobj["+index+"] = ['"+menuM.getMenuID()+"',-1,'"+menuM.getMenuName()+"'");
					if(menuM.getMenuAction()!=null)System.out.print(",'"+menuM.getMenuAction()+"'");
					if(menuM.getMenuTarget()!=null)System.out.print(",'"+menuM.getMenuTarget()+"'");
					System.out.println("]");
				}else{
					System.out.println("menuM Level out 1 ");
					System.out.print("arrayobj["+index+"] = ['"+menuM.getMenuID()+"','"+menuM.getMenuReference()+"','"+menuM.getMenuName()+"'");
					if(menuM.getMenuAction()!=null)System.out.print(",'"+menuM.getMenuAction()+"'");
					if(menuM.getMenuTarget()!=null)System.out.print(",'"+menuM.getMenuTarget()+"'");
					System.out.println("]");
				}
				visibleMenuIDs.add(menuM.getMenuID());
			}else{ 
				System.out.println("menuM Level Action ");
				if(1== Double.parseDouble(menuM.getMenuLevel())){
					System.out.println("arrayobj["+index+"] = ['"+menuM.getMenuID()+"',-1,'"+menuM.getMenuName()+"']");
				}else{
					System.out.println("arrayobj["+index+"] = ['"+menuM.getMenuID()+"','"+menuM.getMenuReference()+"','"+menuM.getMenuName()+"']");
				}
			}
			index++;
	}	
}
request.getSession().setAttribute("visibleMenuIDs", visibleMenuIDs);
//request.getSession().removeAttribute("authenMenu");
%>
<%--
var arrayobj = [];
arrayobj[0] = ['0','-1','Application Menu'];
<%
	/**[MenuID, MenuReference, MenuName, MenuAction, MenuTarget, icon]**/
	Vector vecMenus = (Vector)request.getSession().getAttribute("vecMenus");
	for(int i=0;i<vecMenus.size();i++){
		MenuM menuM = (MenuM)vecMenus.elementAt(i);
		if("PAGE".equals(menuM.getMenuType())){
			if("1".equals(menuM.getMenuLevel())){
				out.println("arrayobj["+(i+1)+"] = ['"+menuM.getMenuID()+"','0','"+menuM.getMenuName()+"','"+menuM.getMenuAction()+"','"+menuM.getMenuTarget()+"']");
			}else{
				out.println("arrayobj["+(i+1)+"] = ['"+menuM.getMenuID()+"','"+menuM.getMenuReference()+"','"+menuM.getMenuName()+"','"+menuM.getMenuAction()+"','"+menuM.getMenuTarget()+"']");
			}
		}else{
			if("1".equals(menuM.getMenuLevel())){
				out.println("arrayobj["+(i+1)+"] = ['"+menuM.getMenuID()+"','0','"+menuM.getMenuName()+"']");
			}else{
				out.println("arrayobj["+(i+1)+"] = ['"+menuM.getMenuID()+"','"+menuM.getMenuReference()+"','"+menuM.getMenuName()+"']");
			}
		}
	}
%>
arrayobj[<%=vecMenus.size()+1%>] = ['-2','0','Log Out','javascript:logOut()','','scripts/dtree/img/downloads-arrows.gif'];
--%>
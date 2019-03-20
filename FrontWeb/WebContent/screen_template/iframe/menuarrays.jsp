<%@page import="com.front.model.menu.MenuM"%> 
<%@page import="java.util.Vector"%>
/**[MenuName, MenuAction, MenuTarget, hasChild]**/
<%!
private String generateMainMenu(MenuM menuM, Vector vecMenus, boolean ckMenuIcon) throws Exception{
	String menuString = "";
	String _hasChild = hasChild(menuM.getMenuID(),vecMenus);
	if("LABEL".equals(menuM.getMenuType())){
		menuString += "[\""+menuM.getMenuName()+"\",\"\",\"\","+_hasChild+"]";
	}else {
		String target = (menuM.getMenuTarget()!=null)?menuM.getMenuTarget():"";
		menuString += "[\""+menuM.getMenuName()+"\",\""+menuM.getMenuAction()+"\",\""+target+"\","+_hasChild+"]";
	}
	return menuString;
}
private String generateSubMenu(MenuM menuM, Vector vecMenus, boolean ckMenuIcon, String objName, int objIndex) throws Exception{
	String menuString = "";
	menuString += generateSubMenu2(menuM, vecMenus, true, objName, objIndex);
	if ("1".equals(hasChild(menuM.getMenuID(),vecMenus))) {
		for(int i=0;i<vecMenus.size();i++){
			MenuM child = (MenuM)vecMenus.elementAt(i);
			if(menuM.getMenuID().equals(child.getMenuReference())){
				menuString += generateSubMenu(child, vecMenus, true, objName+objIndex+"_", i++);
			}
		}
	}
	return menuString;
}
private String generateSubMenu2(MenuM menuM, Vector vecMenus, boolean ckMenuIcon, String objName, int objIndex) throws Exception{
	String menuString = "";
	if("1".equals(hasChild(menuM.getMenuID(),vecMenus))){
		for(int i=0;i<vecMenus.size();i++){
			MenuM child = (MenuM)vecMenus.elementAt(i);
			if(menuM.getMenuID().equals(child.getMenuReference())){
				menuString += generateSubMenu3(child, vecMenus);
			}
		}
		if(menuString.length()>0){
			menuString = objName+objIndex+"=["+menuString.substring(0,menuString.length()-1)+"];\n";
			menuString += objName+objIndex+"objw=165;\n";
		}
	}
	menuString += objName+objIndex+"obj=null;\n";
	return menuString;
}
private String generateSubMenu3(MenuM menuM, Vector vecMenus) throws Exception{
	String menuString = "";
	String _hasChild = hasChild(menuM.getMenuID(),vecMenus);
	if("LABEL".equals(menuM.getMenuType())){
		menuString += "[\""+menuM.getMenuName()+"\",\"\",\"\","+_hasChild+"]";
	}else {
		String target = (menuM.getMenuTarget()!=null)?menuM.getMenuTarget():"";
		menuString += "[\""+menuM.getMenuName()+"\",\""+menuM.getMenuAction()+"\",\""+target+"\","+_hasChild+"],";
	}
	return menuString;
}
private String hasChild(String menuID, Vector vecMenus){
	for(int i=0;i<vecMenus.size();i++){
		MenuM menuM = (MenuM)vecMenus.elementAt(i);
		if(menuID.equals(menuM.getMenuReference())){
			return "1";
		}
	}
	return "0";
}
%>
<%
Vector vecMenus = (Vector)request.getSession().getAttribute("vecMenus");
String mainMenuString = "";
for(int i=0;i<vecMenus.size();i++){
	MenuM menuM = (MenuM)vecMenus.elementAt(i);
	if("2".equals(menuM.getMenuLevel())){
		mainMenuString += generateMainMenu(menuM, vecMenus, false)+",";
	}
}
mainMenuString = "tmp2hma_in0=["+ mainMenuString.substring(0,mainMenuString.length()-1)+"];\n";
mainMenuString += "tmp2hma_in0obj=null;\n";
out.print(mainMenuString);
int loopIndex = 0;
String arrayName = "tmp2ma_rr";
for(int i=0;i<vecMenus.size();i++){
	String subMenuString = "";
	MenuM menuM = (MenuM)vecMenus.elementAt(i);
	if("2".equals(menuM.getMenuLevel())){
		subMenuString = generateSubMenu(menuM, vecMenus, false, arrayName, loopIndex++);
	}
	out.print(subMenuString);
}
for(int i=0;i<vecMenus.size();i++){
	MenuM menuM = (MenuM)vecMenus.elementAt(i);
	out.println("//"+menuM.getMenuID());
}%>

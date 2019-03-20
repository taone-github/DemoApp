package com.front.servlet.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.front.form.menu.MenuHandlerManager;
import com.front.model.menu.MenuM;
import com.front.utility.CommonUtil;

/**
 * Servlet implementation class ReLoadMobileMenuServlet
 * @author Anu
 * Use for reloading the mobile menu on click of top level menu
 */

public class ReLoadMobileMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static transient Logger log = LogManager.getLogger(ReLoadMobileMenuServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReLoadMobileMenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = (String) request.getSession().getAttribute("userName");
		MenuHandlerManager menuHandler = (MenuHandlerManager)request.getSession().getAttribute("menuHandlerManager");
		ArrayList<MenuM> topLevelMenus = menuHandler.getTopLevelMenus();
		HashMap<String,ArrayList<MenuM>> subLevelMenus = menuHandler.getSubMenus();
		String topMenuId = (String)request.getParameter("topMenuId");
		
		if(topMenuId != null && !topMenuId.isEmpty()) {
			StringBuffer sb = new StringBuffer();
//			sb.append("	  <li class='treeview'>");
			
			String permChkStr3 = "5";//(String) request.getSession().getAttribute("permChkStr3");
			permChkStr3 = (permChkStr3 != null) ? permChkStr3 : "0";
			MenuM topLevelMenu = CommonUtil.getMenuFromList(topLevelMenus, topMenuId);
			if(topLevelMenu != null) {
				if("LABEL".equals(topLevelMenu.getMenuType())){
					/*sb.append("		<a href='javascript:void(0)'><img class='icon-menu' src='"+topLevelMenu.getIcon() +"'></img> ");*/
					sb.append("		<a href='javascript:void(0)'><div class='menu1-hide'><span class='wordwrap'>"+topLevelMenu.getMenuName()+"</span></div> ");
					sb.append("			<span class='wordwrap'>"+topLevelMenu.getMenuName()+"</span> <i class='fa fa-angle-left pull-right'></i>");
					sb.append("		</a>");
					sb.append("		<ul class='treeview-menu'>");
					
					if(subLevelMenus != null && !subLevelMenus.isEmpty()){
						ArrayList<MenuM> subMenus = subLevelMenus.get(topMenuId);
						Collections.sort(subMenus) ;
						for(MenuM subMenu: subMenus){	
							String menuId = subMenu.getMenuID();
							sb.append("	 <li>");
							if("LABEL".equals(subMenu.getMenuType())){
								/*sb.append("	<a href='javascript:void(0)'><div class='wordwrap-lv2'>"+subMenu.getMenuName()+"</div><i class='fa fa-angle-left pull-right'></i></a>");*/
								sb.append("	<a href='javascript:void(0)'><img class='icon-menu' src="+subMenu.getIcon()+"></img>");
								sb.append("	<span class='wordwrap-lv2'>"+subMenu.getMenuName()+"</span><i class='fa fa-angle-left pull-right'></i></a>");
								sb.append("	<ul class='treeview-menu addmenulv3-color'>");
								ArrayList<MenuM> subMenus2 = subLevelMenus.get(menuId);
					            if(subMenus2 != null && !subMenus2.isEmpty()) {
									Collections.sort(subMenus2) ;
									for(MenuM subMenu2: subMenus2){	
										String menuId2 = subMenu2.getMenuID();
										String url = subMenu2.getMenuAction()+"&menuId=" + menuId2 + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
										sb.append("	<li><a href='"+url+"' target='mainPage' onclick='callMenuLoad();'><i class='fa fa-angle-right'></i>");
										sb.append("	<span class='wordwrap-lv3'>"+subMenu2.getMenuName()+"</span></a></li>");
									}
					            }
					            sb.append("	 </ul>");
							} else {
								String url = subMenu.getMenuAction()+"&menuId=" + menuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
								/*sb.append("	<a href='"+url+"' target='mainPage' onclick='callMenuLoad();'><div class='wordwrap-lv2'> "+	subMenu.getMenuName()+"</div></a>");*/
								sb.append("	<a href='"+url+"' target='mainPage' onclick='callMenuLoad();'>");
								sb.append("	  <img class='icon-menu' src="+subMenu.getIcon()+"></img> ");
								sb.append("	  <span class='wordwrap-lv2'> "+ subMenu.getMenuName()+"</span></a>");
							}
							sb.append("	 </li>");
						}
					}
					sb.append("		</ul>");
				} else {
					String url = topLevelMenu.getMenuAction()+"&menuId=" + topMenuId + "&permChkStr2=" + userName + "&permChkStr3=" + permChkStr3;
					/*sb.append("	<a href='"+url+"' target='mainPage' onclick='callMenuLoad();'><img class='icon-menu' src='"+topLevelMenu.getIcon() +"'></img> <div class='wordwrap'>"+	
								topLevelMenu.getMenuName()+"</div></a>");*/
					sb.append("	<a href='"+url+"' target='mainPage' onclick='callMenuLoad();'>");
					sb.append("	   <div class='menu1-hide'><span class='wordwrap'>"+topLevelMenu.getMenuName()+"</span></div>");
					sb.append("	   <div class='wordwrap'>"+topLevelMenu.getMenuName()+"</div></a>");
				}
			}
//			sb.append("	  </li>");
			log.info(sb.toString());
			
			PrintWriter pw  = null;
			try{
				response.setContentType("text;charset=UTF-8");
				response.setHeader("Pragma", "No-cache");
				response.setHeader("Cache-Control","no-cache,no-store");
				response.setDateHeader("Expires", 0);
				pw = response.getWriter();
				
			    pw.write(sb.toString());
			}catch(Exception e){
				log.fatal("ERROR ",e);
			}finally{
				if(null != pw){
					pw.close();
				}
			}
			
		}
	}
}



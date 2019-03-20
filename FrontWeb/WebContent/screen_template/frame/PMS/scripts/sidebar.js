// sidebar.js
// Sidebar menu management.

function createSidebar()
{
	var sb = new sbSet();
	var m = sb.addMenu("Production Information", UTYPE_COMPANY);
	m.addSubMenu("Manage Monthly Information", "manage_prod.html");
	m.addSubMenu("Full Capacity", "manage_year_fullcap.html");
	m.addSubMenu("Export Forecast", "manage_year_eval.html");
	m.addSubMenu("<b>Add New Product</b>", "new_prod.html");
	m = sb.addMenu("Production Reports", UTYPE_COMPANY);
	m.addSubMenu("View Reports", "view_prod_rep.html");
	m = sb.addMenu("Production Reports", UTYPE_GUEST);
	m.addSubMenu("View Reports", "view_guest_rep.html");

	m = sb.addMenu("Production Information", UTYPE_ADMIN);
	m.addSubMenu("Manage Monthly Information", "staff_manage_prod.html");
	m.addSubMenu("Edit Exchange Rates", "staff_edit_rate.html");	
	m.addSubMenu("Full Capacity", "staff_manage_year_full.html");
	m.addSubMenu("Export Forecast", "staff_manage_year_eval.html");
	m = sb.addMenu("", UTYPE_ADMIN);
	m.addSubMenu("<b>Add New Product</b>", "staff_new_prod.html");
	

	m = sb.addMenu("Production Information", UTYPE_STAFF);
	m.addSubMenu("Manage Monthly Information", "staff_manage_prod.html");
	m.addSubMenu("Full Capacity", "staff_manage_year_full.html");
	m.addSubMenu("Export Forecast", "staff_manage_year_eval.html");
	m = sb.addMenu("Staff Jobs", UTYPE_STAFF);
	m.addSubMenu("<b>Add New Product</b>", "staff_new_prod.html");
	m.addSubMenu("Manage/Activate Company", "staff_manage_comp.html");

	m = sb.addMenu("Production Reports", UTYPE_STAFF);
	m.addSubMenu("View Reports", "staff_view_prod_rep.html");
	m.addSubMenu("View Negative/Positive List", "staff_view_neg_list.html");
	
	m = sb.addMenu("Data Center", UTYPE_STAFF);
	m.addSubMenu("Announcements", "annc_staff.html");
	m.addSubMenu("Edit Announcement", "staff_add_annc.html");
	
	m = sb.addMenu("Executive Information", UTYPE_EXECUTIVE);
	m.addSubMenu("View Reports", "exec_view_prod_rep.html");
	m.addSubMenu("View Negative/Positive List", "exec_view_neg_list.html");

	m = sb.addMenu("Production Reports", UTYPE_ADMIN);
	m.addSubMenu("View Reports", "exec_view_prod_rep.html");
		
	m = sb.addMenu("Administrative Jobs", UTYPE_ADMIN);
	m.addSubMenu("Manage User Account", "manage_user.html");
	m.addSubMenu("Manage/Activate Company", "manage_comp.html");
	m.addSubMenu("Manage Section", "manage_section.html");
	m.addSubMenu("Manage Categories/Subcategories", "manage_cat.html");
	m.addSubMenu("Verify Request Add User", "verify_add_user.html");
	m.addSubMenu("Verify Company Change Info", "verify_change.html");
	m.addSubMenu("View Negative/Positive List", "admin_view_neg_list.html");	
	m.addSubMenu("Track Information Update", "staff_track_update.html");

	m = sb.addMenu("Data Center", UTYPE_ADMIN);
	m.addSubMenu("Announcements", "annc.html");
	m.addSubMenu("My Preference", "pref.html");	
	m.addSubMenu("Internet Poll", "poll.html");
	m.addSubMenu("Edit Announcement", "admin_add_annc.html");
	m.addSubMenu("Edit Internet Poll", "admin_add_poll.html");

	m = sb.addMenu("Data Center", UTYPE_EXECUTIVE);
	m.addSubMenu("Announcements", "annc.html");
	m.addSubMenu("My Preference", "pref.html");	
	m.addSubMenu("Edit Announcement", "staff_add_annc.html");
	m.addSubMenu("Internet Poll", "poll_exec.html");


	m = sb.addMenu("Data Center", UTYPE_COMPANY);
	m.addSubMenu("Announcements", "annc.html");
	m.addSubMenu("Internet Poll", "poll.html");
	m.addSubMenu("My Preference", "pref.html");

	m = sb.addMenu("Data Center", UTYPE_GUEST);
	m.addSubMenu("Announcements", "annc.html");
	m.addSubMenu("Internet Poll", "poll.html");
	
	m = sb.addMenu("", UTYPE_ALL);
	m = sb.addMenu("", UTYPE_COMPANY);
	m.addSubMenu("Chage Profile", "comp_change_profile.html");
	m = sb.addMenu("", UTYPE_ALLSTAFF);
	m.addSubMenu("Change Password", "chpasswd.html");
	m = sb.addMenu("", UTYPE_ALLSTAFF);
	m.addSubMenu("<b>Logout</b>", "logout");
	m = sb.addMenu("", UTYPE_GUEST);
	m.addSubMenu("Back to Main", "logout");
	
	m = sb.addMenu("", UTYPE_ALL);
	m = sb.addMenu("", UTYPE_COMPANY);
	m.addSubMenu("<b>Contact Us</b>", "mail_to_boi.html");
	m = sb.addMenu("", UTYPE_EXECUTIVE);
	m.addSubMenu("<b>Contact Admin</b>", "mail_to_admin.html");	
	m = sb.addMenu("", UTYPE_STAFF);
	m.addSubMenu("<b>Contact Admin</b>", "mail_to_admin.html");	
	return sb;
}

function sbGenSubMenuHTML(callback)
{
	var html = "      <li class=kid_2>\n";
	html += "      <span id=" + this.id;
	html += " class=leaf style=\"cursor:hand\""
	html += " onclick=\"" + callback + "('" + this.id + "', 1);\"";
	html += " onmouseover=\"" + callback + "('" + this.id + "', 2);\"";
	html += " onmouseout=\"" + callback + "('" + this.id + "', 3);\"";
	html += ">" + this.title + "</span>\n";
	html += "      </li>\n";
	
	return html;
}

function sbGenMenuHTML(callback, uType)
{
	if((uType & this.userType) == 0)
		return "";
		
	var html = "<div id=" + this.id + " style=\"DISPLAY: inline\">\n";
	html += "  <ul class=main>\n";
	html += "    <li class=kid><B><font color=\"black\">" + this.title + "</font></B>\n";
	html += "    <ul class=hdn style=\"DISPLAY: inline\">\n<u>";
	for(var i=0 ; i < this.subMenuCount ; i++)
		html += this.subMenu[i].genHTML(callback);
	html += "</u>    </ul>\n";
	html += "    </li>\n";
	html += "  </ul>\n";
	html += "</div>\n";
	
	return html;
}

function sbGenHTML(callback, uType)
{
	var n = this.menuCount;
	var html = "";
	for(var i=0 ; i < n ; i++)
		html += this.menu[i].genHTML(callback, uType);
	return html;
}

function sbSet()
{
	this.menu = new Array();
	this.menuCount = 0;
	
	this.addMenu = sbAddMenu;
	this.getMenu = sbGetMenu;
	this.findMenu = sbFindMenu;
	this.findSubMenu = sbFindSubMenu;
	this.genHTML = sbGenHTML;
}

function sbMenu(id, title, uType)
{
	this.id = id;
	this.title = title;
	this.userType = uType;
	
	this.subMenu = new Array();
	this.subMenuCount = 0;
	
	this.addSubMenu = sbAddSubMenu;
	this.getSubMenu = sbGetSubMenu;
	this.genHTML = sbGenMenuHTML;
	this.getFirstActive = sbGetFirstActiveSubMenu;
}

function sbSubMenu(id, title, url)
{
	this.id = id;
	this.title = title;
	this.url = url;

	this.genHTML = sbGenSubMenuHTML;
}

function sbAddMenu(title, uType)
{
	var id = "sb_" + this.menuCount;
	var menu = new sbMenu(id, title, uType);
	this.menu[this.menuCount++] = menu;
	
	return menu;
}

function sbAddSubMenu(title, url)
{
	var id = this.id + "_" + this.subMenuCount;
	var subMenu = new sbSubMenu(id, title, url);
	this.subMenu[this.subMenuCount++] = subMenu;
	
	return subMenu;
}

function sbGetMenu(index)
{
	return (index >= 0 || index < this.menuCount)? this.menu[index] : null;
}

function sbGetSubMenu(index)
{
	return (index >= 0 || index < this.subMenuCount)? this.subMenu[index] : null;
}

function sbFindMenu(id)
{
	var re = /sb_(\d+)_(\d+)/;
	
	if(re.exec(id) != null)
		return this.menu[RegExp.$1];
	else 
		return null;
}

function sbFindSubMenu(id)
{
	var re = /sb_(\d+)_(\d+)/;
	
	if(re.exec(id) != null)
		return this.menu[RegExp.$1].subMenu[RegExp.$2];
	else 
		return null;
}

function sbGetFirstActiveSubMenu(uType)
{
	var n = this.menuCount;
	for(var i=0 ; i < n ; i++)
		if((uType & this.userType) != 0)
			break;
			
	return (mID < n)? "sb_" + mID + "_0" : "";
}


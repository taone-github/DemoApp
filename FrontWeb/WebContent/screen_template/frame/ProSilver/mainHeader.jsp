<%@page import="com.front.model.menu.MenuM"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<html>
<head>
<link rel="stylesheet" href="../../tabStyle.css" TYPE="text/css" MEDIA="screen">




<script type="text/javascript">
/* Optional: Temporarily hide the "tabber" class so it does not "flash"
   on the page as plain HTML. After tabber runs, the class is changed
   to "tabberlive" and it will appear.
*/
document.write('<style type="text/css">.tabber{display:none;}<\/style>');

var tabberOptions = {

  /* Optional: instead of letting tabber run during the onload event,
     we'll start it up manually. This can be useful because the onload
     even runs after all the images have finished loading, and we can
     run tabber at the bottom of our page to start it up faster. See the
     bottom of this page for more info. Note: this variable must be set
     BEFORE you include tabber.js.
  */
  'manualStartup':true,

  /* Optional: code to run after each tabber object has initialized */

 

  /* Optional: code to run when the user clicks a tab. If this
     function returns boolean false then the tab will not be changed
     (the click is canceled). If you do not return a value or return
     something that is not boolean false, */

  'onClick': function(argsObj) {

    var t = argsObj.tabber; /* Tabber object */
    var id = t.id; /* ID of the main tabber DIV */
    var i = argsObj.index; /* Which tab was clicked (0 is the first tab) */
    var e = argsObj.event; /* Event object */
    
    if (id == 'tab2') {
    	//alert("5555");
        var div = t.tabs[i].div; /* The tab content div */
        //div.innerHTML = "<p>Loading...<\/p>";
        var url = t.tabs[i].entity;
        //alert(url);
        //parent.mainframe.location = "/MasterWeb/FrontController?action=loadSearchEntity&entityID=ETTID_00095&tabID=TID_00037&searchForUpdate=Y&newRequestFlag=Y&permChkStr1=TB002&permChkStr2=System";
        parent.mainframe.location = url;
	    //var myAjax = new Ajax.Updater(div, url, {method:'get',target='mainframe'});
    }
  },
  
   'onLoad': function(argsObj) {
      argsObj.index = 0;
      this.onClick(argsObj);
  },
  
  /* Optional: set an ID for each tab navigation link */
  'addLinkId': true

};

</script>

<script src="tabber.js"></script>
<script src="tabberUtility.js"></script>

</head>
<body>

<%
	String menuId = request.getParameter("menuId");
	System.out.println("Welcome to main header :" + menuId);
	Vector tabVect = new Vector();
	Vector vecMenus = (Vector)request.getSession().getAttribute("vecMenus");
	String userName = (String) request.getSession().getAttribute("userName");
	Vector urlTabs = new Vector();
	if(vecMenus != null && vecMenus.size() > 0){
		MenuM menuM = null;
		for(int i=0;i<vecMenus.size();i++){	
			menuM = (MenuM)vecMenus.elementAt(i);
			if(menuId != null && menuId.equals(menuM.getMenuReference()) && ("TAB").equals(menuM.getMenuType())){
				tabVect.add(menuM.getMenuName());
				urlTabs.add(menuM.getMenuAction() + "&permChkStr1=" + menuM.getMenuID() + "&permChkStr2=" + userName);
			}
		}
	}
	
%>
<%if(tabVect.size() > 0){ %>
<div class="tabber" id="tab2">
	
       <% for(int i=0; i<tabVect.size(); i++){ %>
       	
       	
	     <div class="tabbertab" entity="<%=urlTabs.get(i)%>">
	   
		  <h2><%=tabVect.get(i) + " " %></h2>
		 
	     </div>
	  
	     
	 <%} %>

		    
</div>
		  
	

<script type="text/javascript">

/* Since we specified manualStartup=true, tabber will not run after
   the onload event. Instead let's run it now, to prevent any delay
   while images load.
*/
tabberAutomatic(tabberOptions);

</script>
<%} %>
</body>
</html>

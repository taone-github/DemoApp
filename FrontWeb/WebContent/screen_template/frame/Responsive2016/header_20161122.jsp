<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%
	String hostPrefix = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<script type="text/javascript">
	
	//function closeApp() {
<%-- 	window.open("<%=request.getContextPath()%>/logout.jsp","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1"); --%>
<%-- 	window.open("<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true","closeAppWin","width=1,height=1,left=2000,top=2000,status=1,toolbar=1"); --%>
	//}
	/* end detect closing browser */
	//window.onunload = window.onbeforeunload = closeApp;
	/* Logout on close */
	$(document).ready(function(){
//             $(window).bind('beforeunload', function(){
//             	closeApp();	
//             });
        	window.onunload = window.onbeforeunload = function() {
			    jQuery.ajax({
			        url: '<%=request.getContextPath()%>/CloseApplicationServlet?closeApp=true',
			        async: false
			    });
			};    
     });
	
	
function home(){
	top.document.getElementById("middleframeset").cols="180,*"
	top.document.getElementById("leftframeset").rows = "0,*";
	//parent.top.mainframe.document.location.href = "http://admin05:8080/FrontWeb/screen_template/frame/main.jsp";
	parent.top.mainframe.document.location.href = "<%=hostPrefix%>/FrontWeb/screen_template/frame/main.jsp";
}
function open1() {
	top.document.getElementById("middleframeset").cols="0,*"
	top.document.getElementById("leftframeset").rows = "0,*";
	//parent.top.mainframe.document.location.href = "http://admin05:8080/MasterWeb/manual/jsp/crmTab/collaboration.jsp";
	parent.top.mainframe.document.location.href = "http://localhost:8080/MasterWeb/manual/jsp/crmTab/collaboration.jsp";
}
	function open2() {
		w = window.open('http://192.168.0.217:8080/');
	}
	
	function open3() {
		w = window.open('http://192.168.0.54:8080/pentaho/');
	}
	
	function switchLocale(val){
		var dataString = "locale="+val;
		$.ajax({
		   type: "POST",
		   url: "<%=hostPrefix%>/MasterWeb/ManualServlet?className=com.avalant.feature.SwitchLanguage",
		   data: dataString,
		   async:   false,
		   success: function(data){
			top.mainframe.location.reload();
		   }
		});
	}
	var isThai = true;
	function switchLang(){
		if(isThai){
			isThai = false;
			$('.language').html('EN');
			switchLocale('en_US');
		}else{
			isThai = true;
			$('.language').html('TH');
			switchLocale('th_TH');
		}
	}
	
	
	$(window).resize(function() {
		console.log("width="+$(window).width());
		
		if(($(window).width()) <= 991){
			console.log($(window).width()+"<= 991");
			$('#notifications-id').css("padding-top",18);
			$('#notifications-id').css("padding-bottom",18);
		}else{
			console.log($(window).width()+" > 991");
			$('#notifications-id').css("padding-top",17);
			$('#notifications-id').css("padding-bottom",17);
		}
	});
	
	
</script>
<%-- <jsp:include page="scripts/swapFrame.jsp" flush="true"></jsp:include> --%>
<!-- </head> -->
<!-- <body background="" topmargin="0" leftmargin="0"> -->
<!-- 
	Sam add for Timeout 
	17/11/2011
 -->
<input type="hidden" id="sessiontimeout" name="sessiontimeout" value="<%=session.getMaxInactiveInterval()%>"> 

<!-- Logo -->
<a href="/MasterWeb/temp/index.html" target="mainPage" class="logo" onclick=showLoader()>
  	<!-- mini logo for sidebar mini 50x50 pixels -->
  	<span class="logo-mini"><!--<b>A</b>LT-->
  		<img src="screen_template/frame/Responsive2016/images/oneweb_small.svg">
  	</span>
 	<!-- logo for regular state and mobile devices -->
  	<span class="logo-lg"><!--<b>Process</b>Designer-->
  		<img src="screen_template/frame/Responsive2016/images/oneweb.svg">
 	</span>
</a>




<!-- Header Navbar -->
<nav class="navbar navbar-static-top" role="navigation">
	<div class="container-fluid">
	  <!-- Navbar Left Menu -->
	  <!-- <div class="navbar-header"> -->
	   	<!-- Sidebar toggle button-->
	   	<a href="#" class="sidebar-toggle desktop" data-toggle="offcanvas" role="button">
	   		<span class="sr-only">Toggle navigation</span>
	 	</a>
		<!-- Sidebar Toggle for mobile-->
		<a href="#" class="sidebarmobile" onclick="toggleMobileVersion()" role="button">
			<img src="screen_template/frame/Responsive2016/images/menumobile.svg">
    	</a>
    	
    	
    	<!-- search form -->
    	<!-- <form class="navbar-form pull-left" role="search">
            <div class="input-group stylish-input-group">               
               <div class="input-group-addon">
               	  <button type="button" id='btnSearch' class="btn btn-white btn-sm btn-block">
               	     <span class="fa fa-search"></span>
              	  </button>
               </div>
               <input type="text" id='navSearch' class="form-control" placeholder="Search">
            </div>
         </form> -->
         <!-- /.search form -->
          
      <!-- </div> -->  <!--/.Navbar Left Menu -->
      
            
        
      <!-- Navbar Right Menu -->
	    <div class="navbar-custom-menu">
	    	<ul class="nav navbar-nav navbar-right">
	            <!-- Notifications Menu -->
	            <li class="dropdown notifications-menu">
	                <!-- Menu toggle button -->
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="notifications-id" style="padding-top: 17px;padding-bottom: 17px;">
	                	<img src="screen_template/frame/Responsive2016/images/ic_notifications.png">
	                	<!-- <span class="notification">9</span> -->
	                  <!-- <i class="fa fa-bell-o"></i> -->
	                  <span class="label label-white">10</span>
	                </a>
	                <ul class="dropdown-menu shadow3">
	                  <li class="header">You have notifications</li>
	                  <li>
	                    <!-- Inner Menu: contains the notifications -->
	                    <ul class="menu">
	                      <li><!-- start notification -->
	                        <a href="#">
	                          <i class="fa fa-users text-aqua"></i> new members joined today
	                        </a>
	                      </li><!-- end notification -->
	                    </ul>
	                  </li>
	                 <li class="footer"><a href="/MasterWeb/FrontController?action=loadTodolist&userName=<%=request.getRemoteUser() %>" target="mainPage" onclick=showLoader()>View all</a></li>
	                 <!-- <li class="footer"><a href="/MasterWeb/FrontController?action=loadTodolistBPM&userName=<%=request.getRemoteUser() %>" target="mainPage">View all </a></li> -->
	                </ul>
	            </li>
	            
	            
	        	<!-- Messages: style can be found in dropdown.less-->
	            <!--  <li class="dropdown messages-menu">
	            	Menu toggle button
	                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="padding-top:18px;padding-bottom:18px;">
	                   <img src="screen_template/frame/Responsive2016/images/ic_comment.png">
	                   <span class="label label-white">4</span>
	                 </a>
	                 <ul class="dropdown-menu shadow3">
	                   <li class="header">You have messages</li>
	                   <li>
	                   inner menu: contains the messages
	                     <ul class="menu">
	                       <li> start message
	                         <a href="#">
	                           <div class="pull-left">
	                           User Image
	                       		<img src="screen_template/frame/scripts/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
	                           </div> Message title and timestamp
	                           <h4>
	                             Support Team
	                             <small><i class="fa fa-clock-o"></i> 5 mins</small>
	                           </h4> The message
	                           <p>Why not buy a new awesome theme?</p>
	                         </a>
	                       </li>end message
	                     </ul>/.menu
	                   </li>
	                   <li class="footer"><a href="#">See All Messages</a></li>
	                </ul>
	             </li> --> 
	             <!--/.messages-menu -->
	            
	            <!-- Tasks Menu -->
	<!--             <li class="dropdown tasks-menu"> -->
	<!--                 Menu Toggle Button -->
	<!--                 <a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
	<!--                   <i class="fa fa-flag-o"></i> -->
	<!-- <!--                   <span class="label label-danger">9</span> -->
	<!--                 </a> -->
	<!--                 <ul class="dropdown-menu shadow3"> -->
	<!--                   <li class="header">You have 9 tasks</li> -->
	<!--                   <li> -->
	<!--                     Inner menu: contains the tasks -->
	<!--                     <ul class="menu"> -->
	<!--                       <li>Task item -->
	<!--                         <a href="#"> -->
	<!--                           Task title and progress text -->
	<!--                           <h3> -->
	<!--                             Design some buttons -->
	<!--                             <small class="pull-right">20%</small> -->
	<!--                           </h3> -->
	<!--                           The progress bar -->
	<!--                           <div class="progress xs"> -->
	<!--                             Change the css width attribute to simulate progress -->
	<!--                             <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"> -->
	<!--                               <span class="sr-only">20% Complete</span> -->
	<!--                             </div> -->
	<!--                           </div> -->
	<!--                         </a> -->
	<!--                       </li>end task item -->
	<!--                     </ul> -->
	<!--                   </li> -->
	<!--                   <li class="footer"> -->
	<!--                     <a href="#">View all tasks</a> -->
	<!--                   </li> -->
	<!--                 </ul> -->
	<!--             </li> -->
	            
	            <!-- User Account Menu -->
	            <li class="dropdown user user-menu">
	                <!-- Menu Toggle Button -->
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                  <!-- The user image in the navbar-->
	                  <span class="hidden-xs"><%=request.getSession().getAttribute("userName") %></span>
	                  <img src="screen_template/frame/scripts/dist/img/user2-160x160.jpg" class="user-img-rounded" alt="User Image">
	                  <!-- hidden-xs hides the username on small devices so only the image appears. -->
	                </a>
	                <ul class="dropdown-menu shadow3">
	                  <!-- The user image in the menu -->
	                  <li class="user-header">
	                    <img src="screen_template/frame/scripts/dist/img/user2-160x160.jpg" class="img-rounded" alt="User Image">
	                    <p>
	                      <%=request.getSession().getAttribute("userName") %> - Web Developer
	                      <small>Member since Nov. 2012</small>
	                    </p>
	                  </li>
	                  <!-- Menu Body -->
					  <!--
	                  <li class="user-body">
	                  </li>-->
	                  <!-- Menu Footer-->
	                  <li class="user-footer">
	                    <div class="pull-left">
	                      <a href="#" class="btn btn-default btn-flat">Profile</a>
	                    </div>
	                    <div class="pull-right">
	                      <a href="#" class="btn btn-default btn-flat" onclick="logOut();">Sign out</a>
	                    </div>
	                  </li>
	                </ul>
	            </li>
	            <!-- Control Sidebar Toggle Button -->
	            <!-- <li>
	                <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
	              </li>-->
	        </ul>
         
      </div> <!-- /.navbar-collapse -->
        
        
        
		  
    
    </div>
</nav>
<!-- </body> -->
<!-- </html> -->
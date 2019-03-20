<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="tab-content">
   <!-- Home tab content -->
   <div class="tab-pane active" id="control-sidebar-home-tab">
    <!-- <h3 class="control-sidebar-heading">Recent Activity</h3>-->
     <ul class="control-sidebar-menu">
       <li>
				  
      	<aside class="main-sidebar">
			<section class="sidebar">
				<ul class='sidebar-menu'>
					<a data-toggle='control-sidebar' href='#' id="mainmenu">
						<li class='backmobilemenu'>
							<i class='fa fa-caret-left'></i>
							<span class='textback'>Main menu</span>
						</li>
					</a>
					<li class='treeview' id="sideBarMenuMobile">
					</li>
				</ul>
			</section>
	    </aside>				  
				  
              
        </li>
      </ul>
   </div>
</div>		
<!-- End Menu -->
<script>
function callMenuLoad() {
	$("#mainmenu").click();
	toggleMobileVersion();
	$('html,body').scrollTop(0);
	return false;
}
</script>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.front.utility.GenerateMenuProSilver"%>
<html>
<head>
<link rel="stylesheet" href="CSS/menuStyle.css" type="text/css">
<link rel="stylesheet" href="CSS/stylesheet.css" type="text/css">
<link rel="stylesheet" href="scripts/dtree/dtree.css" type="text/css">
<script language="JavaScript" src="scripts/dtree/dtree.js"></script>
<script language="JavaScript" src="javascript/flyout.js"></script>
<script language="JavaScript" src="../scripts/jquery-1.3.2.js"></script>
<script language="javascript" type="text/javascript">
function logOut() {
	top.logOut();
}
var level2=false;
function toggleLevel2(){
	if (level2) {
		top.document.getElementById("middleframeset").cols="80,*,0";
		level2=false;
	} else {
		top.document.getElementById("middleframeset").cols="430,*,0";
		level2=true;
	}
}

var menuTimer = 0;

function ddMenuEAF(menuId,num){
	ddMenu(menuId,num);
	clearInterval(menuTimer);
	if (num == 1) {
		//top.document.getElementById("middleframeset").cols="79,*,0";
		menuTimer = setInterval(function(){menuFadeShow()},33);
		//level2=false;
	} else {
		//top.document.getElementById("middleframeset").cols="300,*,0";
		menuTimer = setInterval(function(){menuFadeHide(430)},33);
		//level2=true;
	}
}
var currentMenuWidth = 80;
function menuFadeShow(){
  if(currentMenuWidth<420){
  	currentMenuWidth = currentMenuWidth+20;
  	top.document.getElementById("middleframeset").cols=currentMenuWidth+",*,0";
  }else{
  	currentMenuWidth = 430;
  	top.document.getElementById("middleframeset").cols="430,*,0";
  	clearInterval(menuTimer);
  }
}
function menuFadeHide(){
  if(currentMenuWidth>90){
  	currentMenuWidth = currentMenuWidth-20;
  	top.document.getElementById("middleframeset").cols=currentMenuWidth+",*,0";
  }else{
  	currentMenuWidth = 80;
  	top.document.getElementById("middleframeset").cols="80,*,0";
  	clearInterval(menuTimer);
  }
}

function cancelHideEAF(menuId){
	clearInterval(menuTimer);
	cancelHide(menuId);
}

function accessMenu(linkId){
	//alert(linkId);
	$(".dTreeNodeActive").removeClass("dTreeNodeActive").addClass("dTreeNode");
	$('#'+linkId).parent().removeClass("dTreeNode").addClass("dTreeNodeActive");
	$('#'+linkId).click();
	hideAllEAF();
	top.frames[$('#'+linkId).attr('target')].location.href = $('#'+linkId).attr('href'); 
}


//Sam Add Tab by menu target
var lvl1 = '';
$(document).ready(function() {
	$("a").each(function(index){
    	if($(this).attr('target') == 'mainframe'){
    		$(this).click(function(){
    			var lvl4 = $(this).html();
    			var lvl2 = $(this).parent().parent().prev('.dTreeFolder').find('.node').html();
    			paintYellow(lvl1+' > '+lvl2+' > '+lvl4);
    		});
    	}
    });
    
    
    $(".menutextmainpadding").each(function(index){
    	$(this).click(function(){
    			lvl1 = $(this).html();
    	});
    });
});

function paintYellow(data){
	top.frames['mainheader'].document.getElementById('yellowTab').innerHTML = data;
}
</script>
</head>
<body background="" topmargin="0" leftmargin="0">
<div id="leftcolumn" style="background-image:url(images/bgmenu.jpg); POSITION: absolute;height:100%;width:79px;">
<%GenerateMenuProSilver gmps = new GenerateMenuProSilver();%>
<%=gmps.getHtml(request)%>
</div>

<!-- Metas add for headtabtext -->
<div style="height:30px;width:100%;background-image:url('images/tabheadbg.png');">
</div>

<script language="javascript" type="text/javascript">
//function hide all come after array label1 on GenerateMenuProSilver
var oldMenuID = '';
function ddMenuEAF2(menuId){
	var num = 1;
	//old menu is on so off
	if(oldMenuID == menuId){
		num = -1;
		oldMenuID = '';
	}else{
		//new menu click hide old menu
		if(oldMenuID != ''){
			ddMenu(oldMenuID,-1);
		}
		oldMenuID = menuId;
	}
	ddMenu(menuId,num);
	clearInterval(menuTimer);
	if (num == 1) {
		//top.document.getElementById("middleframeset").cols="79,*,0";
		menuTimer = setInterval(function(){menuFadeShow()},33);
		//level2=false;
	} else {
		//top.document.getElementById("middleframeset").cols="300,*,0";
		menuTimer = setInterval(function(){menuFadeHide(300)},33);
		//level2=true;
	}
}

function hideAllEAF(){
	ddMenuEAF2(oldMenuID);
}
</script>
</body>
</html>
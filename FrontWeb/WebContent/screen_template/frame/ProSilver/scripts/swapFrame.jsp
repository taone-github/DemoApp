<%
	String appDesignUrl = "http://"+com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("appDesignHost")+"/EAFUIWeb/index.htm";
	String workFlowUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/MasterWeb/FrontController?action=loadToDoList&permChkStr1=MENU_130613140031254&permChkStr2=U001&permChkStr3=AVALANT_DEV";
	String leftWidth = com.avalant.feature.ExtendFeature.getInstance().getFrontProperty("menuWidth");
%>
<script type="text/javascript">
//Sam add App Designer Tab
var leftWidth = <%=leftWidth%>;
function hideDesignTab() {
	animateFadeHide(leftWidth,0);
}

function showDesignTab() {
	animateFadeShow(0,0);
}

var designopen = true;
var worklistopen = false;
function toggleDesignTab() {
	refreshCache();
	var oldCols = top.document.getElementById("middleframeset").cols;
	//if (designopen) {
	if(oldCols != "0,0,*"){
		hideDesignTab();
		designopen=false;
	} else {
		top.frames['designframe'].location.href = '<%=appDesignUrl%>'; 
		showDesignTab();
		designopen=true;
	}
}

function toggleWorklist(){
	var oldCols = top.document.getElementById("middleframeset").cols;
	//if (designopen) {
	if(oldCols != "0,0,*"){
		hideDesignTab();
		worklistopen=false;
	} else {
		top.frames['designframe'].location.href = '<%=workFlowUrl%>'; 
		showDesignTab();
		worklistopen=true;
	}
}

function animateFadeHide(leftF,rightF){
if(leftF>0){
  	leftF = leftF-10;
  }else{
  	leftF = 0;
  }
  rightF = rightF + 150;
  var colF = leftF+",*,"+rightF;
  //alert(colF);
  if(rightF > 1100){
  	colF = "0,0,*";
  	top.document.getElementById("middleframeset").cols=colF;	
  }else{
  	top.document.getElementById("middleframeset").cols=colF;
  	setTimeout("animateFadeHide("+leftF+","+rightF+")", 60);
  }
}


function animateFadeShow(leftF,centF){
  if(leftF<(leftWidth + 10)){
  	leftF = leftF+10;
  }else{
  	leftF = leftWidth;
  }
  centF = centF + 150;
  var colF = leftF+","+centF+",*";
  //alert(colF);
  if(centF > 1100){
  	colF = leftWidth+",*,0";
  	top.document.getElementById("middleframeset").cols=colF;	
  }else{
  	top.document.getElementById("middleframeset").cols=colF;
  	setTimeout("animateFadeShow("+leftF+","+centF+")", 60);
  }
}

function refreshCache(){
	var uri = "/MasterWeb/refreshMaster.jsp?1=1";
	jQuery.ajax({
		   type: "POST",
		   url: uri,
		   data: "",
		   async:   false, 		   
		   success: function(data){
		   }
		});
}
//End add appdesign
</script>
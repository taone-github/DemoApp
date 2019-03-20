/*------------------------------------------------------------------*/
jQuery(document).ready(function() {
	var loaderImg_W = 50;
	var loaderImg_H = 50;
	var loaderImg_L = (jQuery(document).width()/2) - (loaderImg_W/2);
	var loaderImg_T = (jQuery(document).height()/2) - (loaderImg_H/2);
	jQuery('#loaderDiv').html('<img id="waiting" src="./images/loader/pleaseWaitImage.gif" width="'+loaderImg_W+'" height="'+loaderImg_H+'" style="left: '+loaderImg_L+';top: '+loaderImg_T+';"/>');
	return false;
});

/*------------------------------------------------------------------*/
function blockScreen() {
	try{
		var blockUIDiv = document.createElement("div");
		blockUIDiv.setAttribute("name", "blockUIDiv");
		blockUIDiv.setAttribute("id", "blockUIDiv");
		document.body.appendChild(blockUIDiv);
		
		jQuery('#blockUIDiv').css({
			"display": "block",
			"opacity": "0.7",
			"width": jQuery(document).width(), 
			"height": jQuery(document).height(),
			"position": "absolute",
			"left": "0",
			"top": "0",
			"background": "#000",
			"z-index": "1"
		});
		
		var loaderImg_W = 50;
		var loaderImg_H = 50;
		var loaderImg_L = (jQuery(document).width()/2) - (loaderImg_W/2);
		var loaderImg_T = (jQuery(document).height()/2) - (loaderImg_H/2);
		
		jQuery("#loaderDiv").css({
			"position": "absolute",
			"display": "block",
			"width": loaderImg_W, 
			"height": loaderImg_H,
			"z-index": "1",
			"left": loaderImg_L,
			"top": loaderImg_T
		});
		
		//$('body').css({"overflow":"hidden"});
		jQuery('#blockUIDiv').click(function(){return;});
		
		document.body.style.cursor = "wait";
	}catch(err){}
}

/*------------------------------------------------------------------*/
function unblockScreen(){
	if(document.getElementById("blockUIDiv")){
		document.body.removeChild("blockUIDiv");
	}
	if(document.getElementById("loaderDiv")){
		jQuery('#loaderDiv').html('');
	}
	document.body.style.cursor = "default";
}

/*------------------------------------------------------------------*/
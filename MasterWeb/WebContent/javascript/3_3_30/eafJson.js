function rederCriteria(jsonCriteria){
	var result = '';
	for (var i = 1; i < jsonCriteria.length; i++) {// i = 0 css and hidden field , i = 1 left , i = 2 right , i = 3 boxThree
		result += "<div class=\"boxbold2\">";
		for (var j = 0; j < jsonCriteria[i].length; j++) {//each record
			result += "<div class=\"textbox1search\">";
			result += "<div class=\"boxsearch\" id=\""+jsonCriteria[i][j].boxId+"\">";
			result += "<div class=\"componentSelect\" ></div>";
			result += "<div class=\"componentNameDiv\" id=\""+jsonCriteria[i][j].labelNamed+"\">"+jsonCriteria[i][j].label+"</div>";
			result += "</div>";
			result += "<div class=\"componentDiv\" id=\""+jsonCriteria[i][j].htmlComponentNamed+"\">"+jsonCriteria[i][j].tagShow;
			result += "</div>";
			result += "</div>";
		}
		if(jsonCriteria[i].length < 2){//Max void box
			for(var j = 0; j < (2 - jsonCriteria[i].length); j++){
				//void box
				result +="<div class=\"textbox1search\">";
				result +="<div class=\"boxsearch\">";
				result +="<div class=\"componentNameDiv-boxsearch\"></div>";
				result +="</div>";
				result +="<div class=\"componentDiv-boxsearch\">";
				result +="</div>";
				result +="</div>";
			}
		}
		result +="</div>";
		if(i+1<jsonCriteria.length){
			result +="<div class=\"spaceboxbold\"></div><!--this line is the space between each boxs-->";
		}
	}
	result+=jsonCriteria[0].hidden;
	$('.searchCriteriaContainer').prepend(result);
	$('.content-center-search').css('height',jsonCriteria[0].gridHeight+'px');
	for (var k = 0; k < jsonCriteria[0].longLabelRow.length; k++) {
		$('#boxLeft_'+jsonCriteria[0].longLabelRow[k]).css('height','40px');
		$('#boxRight_'+jsonCriteria[0].longLabelRow[k]).css('height','40px');
		if(jsonCriteria.length == 4){
			$('#boxThree_'+jsonCriteria[0].longLabelRow[k]).css('height','40px');
		}
	}
	if(jsonCriteria.length == 4){ //have 3 criteria box
		$('.boxbold2').css('width','30%');
	}
}

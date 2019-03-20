function initRequest() {
	if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		isIE = true;
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
}

function ajax(url,handlerFunc){
	var req = initRequest();
	req.onreadystatechange = function() {
		if (req.readyState == 4) {				
			handlerFunc(req.responseText);
		}
	};	   
	var ran_number= Math.random()*4;
	//url=url+'&a='+ran_number;
	req.open("GET", url, true);
	req.send(null);
}
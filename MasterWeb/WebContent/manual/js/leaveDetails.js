function checkdateFromTo(fromFieldName, toFieldName) {
	var fromValue = $("[name='" + fromFieldName + "']").val();
	var toValue = $("[name='" + toFieldName + "']").val();	
	if((fromValue.length==10)&&(toValue.length==10)){
		if ((fromValue != '') && (toValue != '')) {
			var fromSprit = fromValue.split('/');
			var toSprit = toValue.split('/');
			var toInt = parseInt((toSprit[2] + toSprit[1] + toSprit[0]), 10);
			var fromInt = parseInt((fromSprit[2] + fromSprit[1] + fromSprit[0]), 10);
			if (fromInt > toInt) {
				var toFieldLabel = $("div [id *= '"+toFieldName+"_LabelField']").text().replace('*',"")
				var fromFieldLabel = $("div [id *= '"+fromFieldName+"_LabelField']").text().replace('*',"");
				alert(toFieldLabel + " cannot be less than " + fromFieldLabel);
				$("[name='"+ toFieldName + "']").val('');
				return false;
			}
			return true;
		}
	}
	return true;
}
$(document).ready( function() {
	$('[name=REASON]').blur(function() { 
			if($(this).val()==''){
				return;
			}else if($(this).val().length < 5){
				alert('Please specify more reason.');
			}
	});
});

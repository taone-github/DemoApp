
function assignHeighForModuleOne(){
	//Module one height for Safari
	/*var h2 = $('.boxboldbelow').css('height');
	$('.boxboldbelow').parent().css('height',h2);
	//console.log('Assign height');*/
	$('.boxboldbelow').each(function() {
		//var h2 = $(this).css('height');
		$(this).parent().css("overflow","hidden");
		$(this).parents(".moduleDiv:first").css("overflow","hidden");
		//console.log('Assign height');
	});
}
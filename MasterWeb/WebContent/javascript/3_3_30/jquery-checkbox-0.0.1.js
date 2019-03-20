(function($){
 
    	$.fn.extend({
         
        	checkboxButton: function(options) {

            	var defaults = {
                	divId: '#divId'
            	}
                 
            	var options =  $.extend(defaults, options);
 
				// keep mouse pointer
				var mouseX;
				var mouseY;
				$(document).mousemove( function(e) {
					mouseX = e.pageX; 
					mouseY = e.pageY;
				});
 
				var divId = options.divId;
				var radioArray = $(this).get();
				var radioDefault = radioArray[0];
				var isChecked = "";
				var checkedValue = "";
				var j = 0;
				// find radio checked
				for(var i=0; i<radioArray.length; i++) {
					if($(this[i]).is(':checked')) {
						radioDefault = this[i];
						isChecked = " checked ";
						checkedValue = $(radioDefault).attr('value');
						break;
					}
				}
				
				var name = $(radioDefault).attr('name');
				var labelName = name + '_Label';
				var id	 = $(radioDefault).attr('id');
				//id same as name
				id = name;
				var value = $(radioDefault).attr('value');
				var label 	= $(radioDefault).attr('label');
				
				var radioHtml = '<label id="' + labelName + '">' + '<input disabled type="checkbox" name="' + name + '" id="'+ id + '" value="' + value + '" ' + isChecked + '/> ' + label + '</label>';
				
				var radioUlId = name + '_UIID';
				var radioPopupLabel = name + '_PopupLabel';
				
				var radioPopupHtml = '<ul id="' + radioUlId + '" style="display: none;" class="popup">';
										
									for(var i=0; i<radioArray.length; i++) {
										
										//var radioName = name + '_radio';
										//var radioId	  = $(radioArray[i]).attr('id') + '_radio';
										var radioName = name; 
										//id same as name
										var radioId = radioName;
										var radioValue = $(radioArray[i]).attr('value');
										var radioLabel = $(radioArray[i]).attr('label');
										
										var checked = "";
										
										if($(radioArray[i]).is(':checked')) {
											checked = " checked ";
										}
										
									
										radioPopupHtml += '<li>' + '<input type="checkbox" class="' + radioPopupLabel + '" name="' + radioName + '" id="' + radioId + '" value="' + radioValue + '" label="' + radioLabel + '" ' + checked + '/> ' + radioLabel + '</li>';
									}
										
									radioPopupHtml += '</ul>';
				
				//$(divId).html(radioHtml + radioPopupHtml);
				$(divId).html(radioHtml);
				$(divId).closest('form').append(radioPopupHtml);
				
				$('#' + radioUlId).menu();
				
				$('#' + labelName).css('cursor', 'hand');
				$('#' + labelName).unbind('click').click(function() {
					//$('#' + radioUlId).css({'top':mouseY,'left':mouseX}).slideToggle();
					var offset_t = $('#' + labelName).offset().top + $("#container").scrollTop() + 20;
					var offset_l = $('#' + labelName).offset().left + $("#container").scrollLeft();
					var formName = $(divId).closest('form').attr('name');
					if(formName!="masterForm"){
						offset_t = $('#' + labelName).offset().top - $(divId).closest('form').offset().top + 20;
						offset_l = $('#' + labelName).offset().left - $(divId).closest('form').offset().left;
					}
					//closeAllSlideObject();
					$('#' + radioUlId).css({'top':offset_t,'left':offset_l}).slideToggle();

					//$('#' + radioUlId).css({'width':'150px'}).slideToggle();
					//$('#' + radioUlId).slideToggle();
				});
				$('.' + radioPopupLabel).click(function() {
					
					var valueL = $(this).attr('value');
					var labelL 	= $(this).attr('label');
					
					$('#' + labelName).html('<input disabled type="checkbox" name="' + name + '" value="' + valueL + '" checked/> ' + labelL);
				
					//$('#' + radioUlId).slideToggle();
				});	
        	}
    	});
    })(jQuery);
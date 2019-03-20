(function($){
 
    	$.fn.extend({
         
        	listbox: function(options) {

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
				// find radio checked
				for(var i=0; i<radioArray.length; i++) {
					if($(this[i]).is('.selected')) {
						radioDefault = this[i];
						//isChecked = " checked ";
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
				var listLabelClass 	= 'listboxtext';
				var arrow = '<a href="#" class="arrowblack"></a>';
				
//				var radioHtml = '<label id="' + labelName + '">' + '<input disabled type="text" name="' + name + '" id="'+ id + '" value="' + value + '" ' + isChecked + '/> ' + label + '</label>';
				var radioHtml = '<label id="' + labelName + '">' + '<div class="'+listLabelClass+'"><input type="hidden" name="' + name + '" id="'+ id + '" value="' + value + '" /> ' + label +'</div>' +arrow+ ' </label>';


				var radioUlId = name + '_UIID';
				var radioPopupLabel = name + '_PopupLabel';
				
				var radioPopupHtml = '<ul id="' + radioUlId + '" style="display: none;" class="popup">';
										
									for(var i=0; i<radioArray.length; i++) {
										
										var radioName = name + '_list';
										var radioId	  = $(radioArray[i]).attr('id') + '_list';
										//id same as name
										radioId = radioName;
										var radioValue = $(radioArray[i]).attr('value');
										var radioLabel = $(radioArray[i]).attr('label');
										
										var checked = "";
										
										if(checkedValue == radioValue) {
											checked = " checked ";
										}
									
										radioPopupHtml += '<li>' + '<div class="' + radioPopupLabel + '" name="' + radioName + '" id="' + radioId + '" value="' + radioValue + '" label="' + radioLabel + '" ' + checked + '> ' + radioLabel + '</div></li>';
									}
										
									radioPopupHtml += '</ul>';
				
				//$(divId).html(radioHtml + radioPopupHtml);
				$(divId).html(radioHtml);
				$(divId).closest('form').append(radioPopupHtml);
				//$(divId).parent().parent().parent().parent().append(radioPopupHtml);
				$('#' + radioUlId).menu();
				
				$('#' + labelName).css('cursor', 'hand');
				$('#' + labelName).unbind('click').click(function() {
					$('#' + labelName).find('.arrowblack').toggle();
					var offset_t = $('#' + labelName).offset().top + $("#container").scrollTop();
					var offset_l = $('#' + labelName).offset().left + $("#container").scrollLeft();
					var formName = $(divId).closest('form').attr('name');
					if(formName!="masterForm"){
						offset_t = $('#' + labelName).offset().top - $(divId).closest('form').offset().top;
						offset_l = $('#' + labelName).offset().left - $(divId).closest('form').offset().left;
					}
					closeAllSlideObject();
					$('#' + radioUlId).css({'top':offset_t,'left':offset_l}).slideToggle();
					//$('#' + radioUlId).css({'width':'150px'}).slideToggle();
					//$('#' + radioUlId).slideToggle();
				});
				$('.' + radioPopupLabel).unbind('click').click(function() {
					var valueL = $(this).attr('value');
					var labelL 	= $(this).attr('label');
					//var idL 	= $(this).attr('id');
					$('#' + labelName).html('<div class="'+listLabelClass+'"><input type="hidden" name="' + name + '" value="' + valueL + '"id="'+id+ '" /> ' + labelL +'</div>' +arrow+ "  ");
					//it's new arrow don't toggle
					//$('#' + labelName).find('.arrowblack').toggle();
					$('#' + radioUlId).slideToggle();
					//Sam execute dependency function
					
					//fail to bind manual event so use dynamic javascript instead
					//alert($('#' + labelName).find('input[name='+name+']').val());
					//$('input[name='+name+']').trigger('dependTrig');
					try{
						var moduleID = $('#' + labelName).parent().attr('id');
						moduleID = moduleID.split("_")[0];
					
						if(moduleID=='MD1131510659'){
							checkAsset();
						}
						//alert(moduleID+'dependencyaction'+name);
						window[moduleID+'dependencyaction'+name]();
					}catch(e){
						//alert(e);
					}
				});
        	}
    	});
    })(jQuery);
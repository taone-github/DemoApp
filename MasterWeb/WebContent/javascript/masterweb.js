/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 201612191556
* apply AdminLTE theme for responsive2016
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
if (typeof jQuery === "undefined") {
  throw new Error("MasterWeb requires jQuery");
}


$.MasterWeb = {
	
	_version : function () {
		var MAJORVERSION="@MAJORVERSION@";
		var MINORVERSION="@MINORVERSION@";
		var BUILDDATE="@BUILDDATE@";
		var BUILDID="@BUILDID@";
		var BANNER="@BANNER@";
		var MICROVERSION="@MICROVERSION@";
		
		// alert('Version: ' + MAJORVERSION + '.' + MINORVERSION + '.' +
		// MICROVERSION + '_r' + BUILDID + '\nDate: ' + BUILDDATE);
		return 
	},
	info : function () {
		var MAJORVERSION="@MAJORVERSION@";
		var MINORVERSION="@MINORVERSION@";
		var BUILDDATE="@BUILDDATE@";
		var BUILDID="@BUILDID@";
		var BANNER="@BANNER@";
		var MICROVERSION="@MICROVERSION@";
		var JQUERY_VERSION = $.fn.jquery;
		
		alert('Version: ' + MAJORVERSION + '.' + MINORVERSION + '.' + MICROVERSION + '_r' + BUILDID 
				+ '\nDate: ' + BUILDDATE
				+ '\njQuery Version ' + JQUERY_VERSION
				+ '\njQuery UI Version ' +  ($.ui ? $.ui.version || "pre 1.6" : 'jQuery-UI not detected')
		);
	},
	
	contextPath : CONTEXTPATH,
	
	/*
	 * 
	 * 
	 * SMART IMAGE VIEWER
	 * 
	 * 
	 */
	_smartData : {
		instance : null,
		inShow : true
	}, 
	
	reloadSmartImage : function(moduleID) {
		
		if($.MasterWeb._smartData.instance == null) {
			return;
		} 
		
		if($.MasterWeb._smartData.inShow) {
			$.MasterWeb.loading('#smart_data');
		}
			
		ajax(CONTEXTPATH + "/entity/image-viewer.jsp?actionModule=" + moduleID + '&' + $('form[name=masterForm]').serialize(), function(data) {
			$('#imageViewerEntityLeft').html(data)
			.css('min-height', $.MasterWeb.number(window.parent.$('.content-wrapper').css('height')) - $('.spacetop').outerHeight());
			
			$('#smart_data').css('height', $('#smart_data').parent().innerHeight());
			if($.MasterWeb._smartData.inShow) {
				$.MasterWeb.loading('remove');
			}
		});
	},
	toggleSmartImage : function () {
		$.MasterWeb._smartData.inShow = !$.MasterWeb._smartData.inShow;
		
		if($.MasterWeb._smartData.inShow) {
			$('#img-controller-colapse-collpased').css('display','none');
		}
		
		$('#imageViewerEntityLeft').toggle('slow', function() {
			if($.MasterWeb._smartData.inShow) {
				$('#imageViewerEntityRight').removeClass('col-md-12').addClass('col-md-6');
			} else {
				$('#imageViewerEntityRight').removeClass('col-md-6').addClass('col-md-12');
				$('#img-controller-colapse-collpased').css('display','block');
			}
		});
	},
	loading : function (elm) {
		if(!elm) {
			return;
		}
		
		if(elm === 'remove') {
			jQuery('#blockUIDiv').css("display", "none");
			jQuery('#loaderDiv').css("display", "none");
			
			jQuery("select").css("display", "");
			return;
		}
		
		var elmObj = $(elm);
		
		if(elmObj.length > 1) {
			alert('Multiple element are not supported.');
			return;
		}
		
		if(!elmObj.is(':visible')) {
			return;
		}
		
		jQuery('#blockUIDiv').css("display", "");
		jQuery('#blockUIDiv').css({
			"display": "block",
			"opacity": "0.7",
			"width": elmObj.width(), 
			"height": elmObj.height(),
			"position": "absolute",
			"left": "0",
			"top": "0",
			"background": "#000",
			"z-index": "330"
		});
		
		jQuery('#loaderDiv').css("display", "");
		jQuery("#loaderDiv").css({
			"position": "absolute",
			"display": "block",
			"width": 50, 
			"height": 50,
			"z-index": "330",
			"left": (elmObj.width()/2) - (50/2),
			"top": (elmObj.height()/2) - (50/2)
		});
	},
	
	/*
	 * 
	 * 
	 * 
	 * UTILITIES
	 * 
	 * 
	 */

	message : function(msg, params) {
		if(params && $.isArray(params) && params.length > 0) {
			for(var i=0; i<params.length; i++) {
				msg = msg.replace("${"+(i+1)+"}", params[i]);
			}
		}
		return msg;
	},
	
	number : function (val) {
		if(val != undefined && val != '' && val != null) {
			return val.replace(/[^-\d\.]/g, '');
		}
		return '';
	}
};

// ***** File Input By Buncha *****//
var hasFile = false;
FileInput = function (element, options) {
	var self = this;
	var fileNameTemp = "";
	var fileIDTemp = "";
	
	self.$element = $(element);
	self._init(options);
	self._listen();
};
FileInput.prototype = {
	constructor: FileInput,
	_init: function (options) {
		var self = this;
		fileNameTemp = "";
		fileIDTemp = "";
		hasFile = false;
		
		self.options = options;
		self.$container = self.$element.closest('.file-caption-main');
		self.$const = {
				uploadingClass: 	"fa fa-circle-o-notch fa-spin",
				downloadClass: 		"glyphicon glyphicon-download-alt",
				uploadedClass: 		"glyphicon glyphicon-ok",
				uploadFailClass: 		"glyphicon glyphicon-remove",
				uploadUrl:			$.MasterWeb.contextPath + "/web/rest/files/upload",
				downloadUrl:		$.MasterWeb.contextPath + "/web/rest/files/{id}/download?mimetype=",
		};
		
		var $container = self.$container, $caption = $container.find('.file-caption'),
			$btnGroup = $container.find('.input-group-btn'), $el = self.$element;
		self.$mfID = $el.attr("mf-id");
		self.$captionIcon = $caption.find('[obj=caption-icon]');
		self.$captionDiv = $caption.find('.caption-div');
		self.$removeBtn = $btnGroup.find('[button-name=remove-btn]');
		self.$downloadBtn = $btnGroup.find('[button-name=download-btn]');
		self.$uploadBtn = $btnGroup.find('[button-name=upload-btn]');
		self.$cancelBtn = $btnGroup.find('[button-name=cancel-btn]');
		self.$browseBtn = $btnGroup.find('[button-name=browse-btn]');
		self.$fileInput = $container.find('[mf-id='+self.$mfID+'][type=hidden]');
		
		if (self.$fileInput.val() != "") {
			self.$captionIcon.removeClass();
			self.$captionIcon.addClass(self.$const.downloadClass);
			self.$captionIcon.attr('title', 'Download');
			self.$captionIcon.on('click', $.proxy(self._downloadClick, self));
			self.$captionIcon.css('cursor','pointer');
			
			fileNameTemp = $('.caption-div').text();
			fileIDTemp = self.$fileInput.val();
			hasFile = true;
		}
	},
	_listen: function() {
		var self = this;
		self.$element.on('change', $.proxy(self._fileChange, self));
		self.$removeBtn.on('click', $.proxy(self._removeClick, self));
		self.$downloadBtn.on('click', $.proxy(self._downloadClick, self));
		self.$uploadBtn.on('click', $.proxy(self._uploadClick, self));
		self.$cancelBtn.on('click', $.proxy(self._closeDialog, self));
	},
	_fileChange: function() {
		var self = this, $el = self.$element, files, file ,dialogUpload;
		if($el) {
			if ($el.target) {
				files = $el.target.files || {};
			} else if ($el[0].files !== undefined) {
				files = $el[0].files || {};
			} else {
				files = $el.val() ? [{name: $el.val().replace(/^.+\\/, '')}] : [];
			}
			
			if (files.length == 0) {
				self._removeClick();
				return;
			}
			
			file = files[0];
			self.$files = files;
			self._reset();
			self.$captionDiv.html(file.name);
			self.$removeBtn.removeClass('hide');
			self.$uploadBtn.removeClass('hide');
			self.$cancelBtn.removeClass('hide');
			
			dialogUpload = $("#uploadFT041_dialog_"+self.$mfID);
			dialogUpload.dialog(options, { modal: true , close :  function(ev, ui) { self._closeDialog();}});
			
			unblockScreen();
		}
	},
	_uploadClick: function() {
		var self = this, fnSuccess, fnError, $el = self.$element , files, file;
		
		if ($el.target) {
			files = $el.target.files || {};
		} else if ($el[0].files !== undefined) {
			files = $el[0].files || {};
		} else {
			files = $el.val() ? [{name: $el.val().replace(/^.+\\/, '')}] : [];
		}
		file = files[0];

		self.$captionIcon.removeClass();
		self.$captionIcon.addClass(self.$const.uploadingClass);
		blockScreen();
		
		fnSuccess = function(data) {
			unblockScreen();
			if (data) {
				if(data.message=="SUCCESS"){		
					fileNameTemp = file.name;
					fileIDTemp = data.id;
					hasFile = true;
					
					self.$fileInput.val(fileIDTemp);
					self.$captionIcon.removeClass();
					self.$captionIcon.addClass(self.$const.uploadedClass);
					
					setTimeout(function(){
						self.$captionIcon.removeClass();
						$.proxy(self.$captionIcon.addClass(self.$const.downloadClass), self); 
					}, 1000);
					
					self.$captionIcon.attr('title', 'Download');
					self.$captionIcon.on('click', $.proxy(self._downloadClick, self));
					self.$captionIcon.css('cursor','pointer');
					
					self.$uploadBtn.addClass("hide");
					self.$cancelBtn.addClass("hide");
					$('#uploadFT041_dialog_'+self.$mfID).dialog('destroy');
					
					self.$element.val("");
				}else{
					self.$captionIcon.removeClass();
					$('#uploadFT041_error_'+self.$mfID).html("<font color='red'>"+data.message+"</font>");
					$('#uploadFT041_dialog_'+self.$mfID).dialog('option', 'position', 'center');
					
				}
				
				/* 20181025 Fix dialog move down to center */
				try{
					var myDiv = $("div.manyDialog");
					$('#'+myDiv.attr("id")).dialog('option', 'position', 'center');
				}catch(e){}	

			} else {
				self._showError("");
			}
			// self.$downloadBtn.removeClass('hide');
		};
		
		fnError = function(jqXHR, textStatus, errorThrown) {
			self._showError("Upload error mf-id="+self.$mfID+" "+jqXHR.status+" : "+jqXHR.statusText);
			self.$captionIcon.removeClass();
			self.$captionIcon.addClass(self.$const.uploadFailClass);
		};
		
		self._upload(fnSuccess, fnError);
	},
	_removeClick: function() {
		var self = this;
		self._reset();
		self.$element.val("");
		fileNameTemp = "";
		fileIDTemp = "";
		hasFile = false;
	},
	_downloadClick: function() {
		var self = this;
		console.log("Download FileId="+self.$fileInput.val());
		window.open(self.$const.downloadUrl.replace("{id}", self.$fileInput.val()));
	},
	_showError: function (msg, params, event) {
		console.error(msg);
	},
	_upload: function(fnSuccess, fnError) {
		var self = this, file = self.$files[0], formdata = new FormData();
		formdata.append("file", file, file.name);
		$.ajax({
			url: self.$const.uploadUrl,
			type: "POST",
			data: formdata,
			dataType: 'json',
            cache: false,
            processData: false,
            contentType: false,
			success: fnSuccess,
			error: fnError
		});
	},
	_reset: function() {
		var self = this;
		self.$captionIcon.removeClass();
		self.$captionDiv.html("");
		self.$removeBtn.addClass("hide");
		self.$downloadBtn.addClass("hide");
		self.$uploadBtn.addClass("hide");
		self.$cancelBtn.addClass("hide");
		self.$fileInput.val("");
		self.$captionIcon.off('click');
		
		// self.$element.val("");
	},
	_closeDialog : function() {
		var self = this;
		self._reset();
		self.$element.val("");
		if(hasFile){
			self.$captionDiv.html(fileNameTemp);
			self.$removeBtn.removeClass('hide');
			
			self.$fileInput.val(fileIDTemp);
			self.$captionIcon.addClass(self.$const.downloadClass);
			self.$captionIcon.on('click', $.proxy(self._downloadClick, self));
			
		}
		$('#uploadFT041_dialog_'+self.$mfID).dialog('destroy');
		$('#uploadFT041_error_'+self.$mfID).html("");
	},
	_clearDialog : function() {
		$('#uploadFT041_error_'+self.$mfID).html("");
	}
};
// **********//

(function($){
	
	$.datepicker.regional['th'] = {
			changeMonth: true,
			changeYear: true,
			buttonImageOnly: true,
			buttonImage: 'images/calendar.gif',
			dateFormat: 'dd/mm/yy',
			dayNames: ['\u0e2d\u0e32\u0e17\u0e34\u0e15\u0e22\u0e4c', '\u0e08\u0e31\u0e19\u0e17\u0e23\u0e4c', '\u0e2d\u0e31\u0e07\u0e04\u0e32\u0e23', '\u0e1e\u0e38\u0e18', '\u0e1e\u0e24\u0e2b\u0e31\u0e2a\u0e1a\u0e14\u0e35', '\u0e28\u0e38\u0e01\u0e23\u0e4c', '\u0e40\u0e2a\u0e32\u0e23\u0e4c'],
			dayNamesMin: ['\u0e2d\u0e32', '\u0e08', '\u0e2d', '\u0e1e', '\u0e1e\u0e24', '\u0e28', '\u0e2a'],
			monthNames: ['\u0e21\u0e01\u0e23\u0e32\u0e04\u0e21', '\u0e01\u0e38\u0e21\u0e20\u0e32\u0e1e\u0e31\u0e19\u0e18\u0e4c', '\u0e21\u0e35\u0e19\u0e32\u0e04\u0e21', '\u0e40\u0e21\u0e29\u0e32\u0e22\u0e19', '\u0e1e\u0e24\u0e29\u0e20\u0e32\u0e04\u0e21', '\u0e21\u0e34\u0e16\u0e38\u0e19\u0e32\u0e22\u0e19', '\u0e01\u0e23\u0e01\u0e0e\u0e32\u0e04\u0e21', '\u0e2a\u0e34\u0e07\u0e2b\u0e32\u0e04\u0e21', '\u0e01\u0e31\u0e19\u0e22\u0e32\u0e22\u0e19', '\u0e15\u0e38\u0e25\u0e32\u0e04\u0e21', '\u0e1e\u0e24\u0e28\u0e08\u0e34\u0e01\u0e32\u0e22\u0e19', '\u0e18\u0e31\u0e19\u0e27\u0e32\u0e04\u0e21'],
			monthNamesShort: ['\u0e21.\u0e04.', '\u0e01.\u0e1e.', '\u0e21\u0e35.\u0e04.', '\u0e40\u0e21.\u0e22.', '\u0e1e.\u0e04.', '\u0e21\u0e34.\u0e22.', '\u0e01.\u0e04.', '\u0e2a.\u0e04.', '\u0e01.\u0e22.', '\u0e15.\u0e04.', '\u0e1e.\u0e22.', '\u0e18.\u0e04.'],
			constrainInput: true,
			yearRange: '-400:+100',
			buttonText: '\u0e40\u0e25\u0e37\u0e2d\u0e01',
			yearOffSet:543,
			showButtonPanel: false,
			prevText: '&laquo;&nbsp;\u0e22\u0e49\u0e2d\u0e19', prevStatus: '',
			prevJumpText: '&#x3c;&#x3c;', prevJumpStatus: '',
			nextText: '\u0e16\u0e31\u0e14\u0e44\u0e1b&nbsp;&raquo;', nextStatus: '',
			nextJumpText: '&#x3e;&#x3e;', nextJumpStatus: '',
			currentText: '\u0e27\u0e31\u0e19\u0e19\u0e35\u0e49', currentStatus: '',
			todayText: '\u0e27\u0e31\u0e19\u0e19\u0e35\u0e49', todayStatus: '',
			clearText: '-', clearStatus: '',
			closeText: '\u0e1b\u0e34\u0e14', closeStatus: '',
			yearStatus: '', monthStatus: '',
			weekText: 'Wk', weekStatus: '',
			showOn: "button",
	        buttonImage: 'images/calendar_new.png',
			beforeShow: function(input, inst) {
				inst.dpDiv.css({/*
								 * marginTop: -input.offsetHeight + 'px',
								 * marginLeft: input.offsetWidth + 'px',
								 */ 'font-size':'12px'});
				// $('.ui-datepicker-title').css({'white-space':'nowrap
				// !important'});
			},
			onSelect: function(dateText, inst) {
				$(this).focus();
			},
			onClose: function () {
				// $(this).datepicker('destroy');
		    }
		};
		
		$.datepicker.regional['en'] = {
			changeMonth: true,
			changeYear: true,
			buttonImageOnly: true,
			dateFormat: 'dd/mm/yy',
			constrainInput: true,
			yearRange: '-400:+100',
			yearOffSet:0,
			showButtonPanel: false,
			showOn: "button",
	        buttonImage: 'images/calendar_new.png',
			onSelect: function(dateText, inst) {
				$(this).focus();
			},
			onClose: function () {
				// $(this).datepicker('destroy');
		    }
		};
		
		// ***** File Input By Buncha *****//
		$.fn.fileinput = function (option) {
			this.each(function () {
				new FileInput(this, option);
			});
		}
		// **********//
		
		$('.rightcontent').ready(function () {
			$('.100ScreenHeight').css('min-height', $.MasterWeb.number(window.parent.$('.content-wrapper').css('height')) - $('.spacetop').outerHeight());
			
			$('#smart_data').css('height', $('#smart_data').parent().innerHeight());
		});
		
		$(document).keydown(function (e) {  
	    	// block F5
	        return (e.which || e.keyCode) != 116;  
	    }); 
		
})(jQuery);

function displayJSON(data){
	try{
		var $JSON = $.parseJSON(data);
		if($.isEmptyObject($JSON)){
			return;
		}
		$.map($JSON, function(item){
			try{
//				set element by ID
				var elementID = document.getElementById(item.id);
				if(elementID != null){
					if (elementID.type!== undefined){
						switch(elementID.type.toLowerCase()) {
							case "input": break;
							case "hidden": $(elementID).val(item.value); break;
							case "select": $(elementID).val(item.value); break;
							case "select-one": $(elementID).val(item.value); break;
							case "textarea": break;
							case "text": $(elementID).val(item.value); break;
							case "checkbox": break;
							case "radio": break;
						}
					}else{
						$("[id$="+item.id+"]").each(function () {
						    switch(this.tagName.toLowerCase()) {
								case "table": $(elementID).append(item.value); break;
								case "div": $(elementID).html(item.value); break;
								case "td": $(elementID).html(item.value); break;
								case "tr": $(elementID).html(item.value); break;
								case "span": $(elementID).html(item.value); break;
								case "textarea": $(elementID).html(item.value); break;
						    }
						});
					}
				}else{
					var element = $("[name='"+item.id+"']");
					var tag = element.prop("tagName").toLowerCase();
					if(tag != undefined){
						if(tag == 'input'){
							if (element.attr('type') !== undefined){
								switch(element.attr('type').toLowerCase()) {
									case "input": break;
									case "hidden": $("[name='"+item.id+"']").val(item.value); break;
									case "select": $("[name='"+item.id+"']").val(item.value); break;
									case "select-one": $("[name='"+item.id+"']").val(item.value); break;
									case "textarea": break;
									case "text": $("[name='"+item.id+"']").val(item.value); break;
									case "textbox": $("[name='"+item.id+"']").val(item.value); break;
									case "checkbox": break;
									case "radio": $("input[name='"+item.id+"'][value='"+item.value+"']").prop("checked",true);
								}
							}
						}else if(tag == 'select'){
							$("[name='"+item.id+"']").val(item.value);
						}else if(tag == 'textarea'){
							$("[name='"+item.id+"']").html(item.value);
						}
					}
				}
			}catch(e){}
		});
	}catch(e){		
	}
}

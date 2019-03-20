/*!
 * Smart Data Entry v0008
 *
 * Design and Develop by Top
 * Date: 2016-12-206T08:20:32.820Z
 */
$(function($){
	'use strict';

	//Constant
	var NAMESPACE = 'smartData';
	
	//Events
	var EVENT_WHEEL = 'wheel mousewheel DOMMouseScroll';
	var EVENT_SMART_FIELD = 'focus click';
	var EVENT_CANCEL_SMART_FIELD = 'blur';
	var EVENT_MOUSE_DOWN = 'mousedown';
	var EVENT_CLICK = 'click';
	
	
	//Private method
	function toArray(obj, offset) {
		var args = [];
		// This is necessary for IE8
		if (typeof offset === "number") {
		  args.push(offset);
		}
		return args.slice.apply(obj, args);
	}
	
	function getRotationDegrees(obj) {
		var matrix = obj.css("-webkit-transform") ||
		obj.css("-moz-transform")    ||
		obj.css("-ms-transform")     ||
		obj.css("-o-transform")      ||
		obj.css("transform");
		var angle = 0;
		if(matrix !== 'none') {
			var values = matrix.split('(')[1].split(')')[0].split(',');
			var a = values[0];
			var b = values[1];
			angle = Math.round(Math.atan2(b, a) * (180/Math.PI));
		} else {angle = 0; }
		return (angle < 0) ? angle + 360 : angle;
	}

	function getScaleFromMatrix(obj){
		var matrix = obj.css("-webkit-transform") ||
		obj.css("-moz-transform")    ||
		obj.css("-ms-transform")     ||
		obj.css("-o-transform")      ||
		obj.css("transform");
		if(matrix !== 'none') {
			var matrixRegex = /matrix\((-?\d*\.?\d+),\s*0,\s*0,\s*(-?\d*\.?\d+),\s*0,\s*0\)/,
			matches = matrix.match(matrixRegex);
			if(matches && matches.length){
				return {"scaleX": matches[1],"scaleY": matches[2]};
			}
		}
		return {};
	}
	
	function getImageDataByPageNo(images, pageNo){
		if(!images || !images.length || (pageNo != 0 && pageNo != "0" && !pageNo) ) return null;

		for(var i = 0, l = images.length; i < l; i++){
			var data = images[i];
			if(!data)continue;
			if(data.pageNo == parseInt(pageNo))
				return data;
		}
		return null;
	}
	
	function printElement(element, watermark){
		if(!element || !element.length){
			return;
		}
		var clone = element.clone().css({width:'645px', height :'auto'});
		var printContent = clone[0].outerHTML;
		
		var docType = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html>";  
	    var disp_setting = "toolbar=yes,location=no,directories=yes,menubar=yes,";  
	    disp_setting += "scrollbars=yes,width=800, height=800, left=50, top=25,_blank";  
	    if (navigator.appName != "Microsoft Internet Explorer")  
	        disp_setting = "";  
	  
	    var docprint = window.open("", "", disp_setting);  
	    docprint.document.open();  
	  
	    docprint.document.write(docType);  
	    docprint.document.write('<head><title></title>');  
	  
	    docprint.document.write('</head><body style="padding:0;margin-top:0 !important;margin-bottom:0!important;"   onLoad="self.print();self.close();">');  
	  
	    docprint.document.write(printContent);  
	    docprint.document.write('</body></html>');  
	    docprint.document.close();  
	    docprint.focus(); 
		

        return false;
	}
	
	function buildController(settings, smartData){
		if(!$.isPlainObject(settings)){
			return;
		}
		var container =  smartData.container;
		var controllerBox = $('.img-controller',container).html('');
		if(settings.zoomBar){
			var range = $('<div class="slider">');
			var defaultRatio = smartData.defaultRatio;
			var op = {
				value : 20,
				slide : function(e, ui){
					var val = ui.value;					
					var zoomRatio = (val - 20)/10*defaultRatio;
					smartData.zoom(defaultRatio + zoomRatio);
				}
			};
			range.slider(op);
			range.appendTo(controllerBox);
			
		}
		if(settings.zoomIn){
			var zoomIn = $('<div class="zoom-in">');
			var button = $('<button type="button" data-method="zoomIn"><i class="fa fa-plus fa-fw"/></button>');
			zoomIn.append(button).appendTo(controllerBox);
		}
		if(settings.zoomOut){
			var zoomOut = $('<div class="zoom-out">');
			var button = $('<button type="button" data-method="zoomOut"><i class="fa fa-minus fa-fw"/></button>');
			zoomOut.append(button).appendTo(controllerBox);
		}
		if(settings.reset){
			var reset = $('<div class="rotate90">');
			var button = $('<button type="button" data-method="reset"><i class="fa fa-refresh fa-fw"/></button>');
			reset.append(button).appendTo(controllerBox);
		}
		if(settings.rotate90){
			var rotate = $('<div class="rotate90">');
			var button = $('<button type="button"  data-method="rotate" data-option="90"><i class="fa fa-rotate-right fa-fw"/>90</button>');
			rotate.append(button).appendTo(controllerBox);
		}
		if(settings.rotate_90){
			var rotate = $('<div class="rotate-90">');
			var button = $('<button type="button" data-method="rotate" data-option="-90"><i class="fa fa-rotate-left fa-fw"/>-90</button>');
			rotate.append(button).appendTo(controllerBox);
		}
		if(settings.rotate180){
			var rotate = $('<div class="rotate180">');
			var button = $('<button type="button" data-method="rotate" data-option="180"><i class="fa fa-rotate-right fa-fw"/>180</button>');
			rotate.append(button).appendTo(controllerBox);
		}		
		if(settings.lock){
			var rotate = $('<div class="lock unlocked">');
			var button = $('<button type="button"><i class="fa fa-unlock fa-fw"/></button>');
			rotate.append(button).appendTo(controllerBox);
			button.on(EVENT_MOUSE_DOWN, function(e){
				e.preventDefault();
				smartData.toggleLock.call(smartData);
			});
		}

//		var print = $('<div class="print">');
//		var printButton = $('<button type="button"><i class="fa fa-print fa-fw"/></button>');
//		if(settings.print){
//			printButton.click(function(){
//				var isPrintableActiveImage = $('.thumbnail-widget.active',container).attr('data-printable') == 'true';
//				if(isPrintableActiveImage){
//					printElement(smartData.image);
//				}					
//			});
//		}
//		print.append(printButton).appendTo(controllerBox);
		return controllerBox;
	}
	
//	function buildThumbnail(images, smartData){
//		if(!images || !images.length){
//			return null;
//		}
//		var container =  smartData.container;
//		var thumbnailBox = $('.thumbnail-container',container).html('');
//		var cacheBox = $('<div class="thumbnail-cache">').appendTo(thumbnailBox).hide();
//		
//		for(var i = 0, l = images.length; i < l; i++){
//			var image = images[i];
//			var widget = $('<div class="thumbnail-widget">'+
//							'<div class="header"></div>'+
//							'<div class="body"><img class="thumbnail-img" style="width:100%"/></div>'+
//							'<div class="footer"><span class="personal-type"></span><span class="page-no"></span></div>'+
//						'</div>');
//			widget.attr('data-page-no', image.pageNo);
//			widget.attr('data-printable', image.printable);
//			widget.attr('data-src', image.url);
//			widget.find('.thumbnail-img').attr('src', image.thumbnailUrl);
//			var headText = $('<span>').text(image.docTypeDesc);
//			widget.find('.header').append(headText);
//			widget.find('.page-no').text(i+1);
//			widget.find('.personal-type').text(image.personalTypeDesc);
//			//Append
//			thumbnailBox.append(widget);
//			$('<img>').attr('src',image.url).appendTo(cacheBox);
//		}
//		return thumbnailBox;
//	}
	
	function buildThumbnail(images, smartData){
		
		var container =  smartData.container;
		var thumbnailBox = $('.thumbnail-container',container).html('');
		var cacheBox = $('<div class="thumbnail-cache">').appendTo(thumbnailBox).hide();
		
		if(images && images.length) {
			for(var i = 0, l = images.length; i < l; i++){
				var image = images[i];
				var widget = $('<div class="thumbnail-widget">'+
								'<div class="header"></div>'+
								'<div class="body"><img class="thumbnail-img" style="width:100%"/></div>'+
								'<div class="footer"><span class="personal-type"></span><span class="page-no"></span></div>'+
							'</div>');
				widget.attr('data-page-no', image.pageNo);
				widget.attr('data-printable', image.printable);
				widget.attr('data-src', image.url);
				widget.find('.thumbnail-img').attr('src', image.thumbnailUrl);
				var headText = $('<span>').text(image.docTypeDesc);
				//widget.find('.header').append(headText);
				widget.find('.page-no').text(i+1);
				//widget.find('.personal-type').text(image.personalTypeDesc);
				//Append
				thumbnailBox.append(widget);
				$('<img>').attr('src',image.url).appendTo(cacheBox);
			}
		}
		
		return thumbnailBox;
	}
	
	// Declare Smart Data Class
	function SmartData(element, options){
		this.$element = $(element);
		this.options = $.extend({}, SmartData.DEFAULTS, $.isPlainObject(options) && options);
		this.defaultRatio = 1;
		this.currentRatio = 1;
		this.isRotated = false;
		this.isLocked = false;
		this.isBuilt = false;
		this.wheeling = false;
		this.container = null;
		this.imageContainer = null;
		this.controllerContainer = null;
		this.thumbnailContainer = null;
		this.image = null;
		this.canvas = null;
		this.decorator = null;
		this.selectBox = null;
		this.eventTagId = null;
		this.init();
	}
	
	SmartData.prototype = {
		constructor: SmartData,
		init : function(){
			this.build();			
						
			//Bind events
			this.bind();
		},
		build : function(){
			this.isBuilt = false;
			var container = this.container = this.$element.html(SmartData.TEMPLATE);
			this.canvas = $('.img-canvas', container);
			this.image = $('.main-image',container);
			this.imageContainer = $('.img-container',container);
			this.decorator = $('.img-decorator', container);
			this.selectBox = $('.select-box',container);
			
			//Build controller
			this.controllerContainer = buildController(this.options.controller, this);
			
			//Build thumbnail
			this.thumbnailContainer = buildThumbnail(this.options.images, this);			
			
			//Set default image
			this.setImageByPageNo(this.options.images && this.options.images[0] && this.options.images[0].pageNo);
			
			//Lastly
			this.isBuilt = true;
		},
		reset : function(){
			var img = this.image;
			var canvas = this.canvas;
			var archetypeWidth, archetypeHeight, containerWidth, containerHeight, ratio, left;
						
			archetypeWidth = img.data("archetypeWidth")||img.width()||2480;
			archetypeHeight = img.data("archetypeHeight")||img.height()||3507;
			containerHeight = this.imageContainer.height()||669;
			containerWidth = this.imageContainer.width()||723;
			
			if(archetypeWidth<archetypeHeight){
				ratio = containerWidth/archetypeWidth;
				left = (containerWidth-(archetypeWidth*ratio))/2;
			}else{
				ratio = containerHeight/archetypeHeight;
				left = (containerHeight-(archetypeHeight*ratio))/2;
			}
			
			canvas.css({"transform":'scale('+ratio+','+ratio+')', "left" : left, "top" : "0px"});
			
			//Save current image ratio
			this.defaultRatio = ratio;
			
			//Back to 0 degree
			this.rotate();
			
			//Clear select box
			this.hideDecorator();
			
		},
		bind : function(){
			var self = this;
			var options = this.options;
			
			//Bind draggable
			this.canvas.draggable({disabled:false});
			
			//Bind mouse scroll
			this.imageContainer.on(EVENT_WHEEL, $.proxy(this.wheel, this));
			
			//Bind thumbnail event
			this.thumbnailContainer.on(EVENT_CLICK, '.thumbnail-widget',function(){
				var widget = $(this);
				var pageNo = parseInt(widget.attr('data-page-no'));
				self.setImageByPageNo(pageNo);
			});
			
			//Bind smart field select
			if(options.smartField){
				$(document).on(EVENT_SMART_FIELD, options.smartField, function(e){
					self.smartField($(this));
				});
			}
			
			//Bind controller
			this.controllerContainer.on(EVENT_CLICK, '[data-method]',function(e){
				e.preventDefault();
				var button = $(this),
				data = button.data(),				
				fn = self[data.method];
				
				if($.isFunction(fn)){
					fn.call(self, data.option);
				}
			});
		},
		unbind : function(){
			var self = this;
			var options = this.options;
			
			//Unbind draggable
			this.canvas.draggable('disable');
			
			//Unbind mouse scroll
			this.imageContainer.off(EVENT_WHEEL);
			
			//Unbind thumbnail event
			this.thumbnailContainer.off(EVENT_CLICK, '.thumbnail-widget');
			
			//Unbind smart field select
			if(options.smartField){
				$(document).off(EVENT_SMART_FIELD, options.smartField);
			}
			
			//Unbind controller
			this.controllerContainer.off(EVENT_CLICK);
		},
		hideDecorator : function(){
			var dec = this.decorator;
			var unlocked = this.image && !this.image.hasClass('locked');
			if(dec && unlocked)
				dec.hide();
		},
		showDecorator : function(){
			var dec = this.decorator;
			if(dec)
				dec.show();
		},
		setImageByPageNo : function(pageNo,targetField) {
			var self = this;
			var img = this.image;
			if(pageNo == parseInt(img.attr('data-page-no'))) {
				this.rotate();
				if(targetField){
					self.setCanvasData(targetField.canvas);
					self.setSelectBoxData(targetField.selectBox);	
				}
				return true;
			}
			
			$.MasterWeb.loading('.img-container');
			
			var opts = this.options;
			var images = opts.images;
			var imageData =  getImageDataByPageNo(images, pageNo);
			if(!imageData) {
				this.hideDecorator();
				
				$.MasterWeb.loading('remove');
				
				return false;
			}
			
			//$(img).attr('src',imageData.url).load(function(){
			$(img).attr('src',imageData.url).on('load', function(){
				if(!imageData.archetypeWidth||!imageData.archetypeHeight){
					imageData.archetypeWidth = this.naturalWidth;
					imageData.archetypeHeight = this.naturalHeight;
				}
				img.attr('data-page-no',pageNo).data({"archetypeWidth":imageData.archetypeWidth, "archetypeHeight":imageData.archetypeHeight});
				img.css({"width": imageData.archetypeWidth ,"height": imageData.archetypeHeight});
				self.setThumbnailByPageNo(pageNo);
				self.reset();
				if(targetField){
					self.setCanvasData(targetField.canvas);
					self.setSelectBoxData(targetField.selectBox);	
				}
				
				$.MasterWeb.loading('remove');
			});
			
			return true;
		},
		setThumbnailByPageNo : function(pageNo){
			if(pageNo != 0 && !pageNo)return;
			var widget = $('.thumbnail-container [data-page-no="'+pageNo+'"]');
			if(!widget.length)return;
			
			//Set active class
			widget.siblings().removeClass('active');
			widget.addClass('active');
			
			//Scroll to offset
			var container = $('.thumbnail-container').scrollLeft(0),
			cWidth = container.width(),
			cOffsetLeft = container.offset().left,
			widgetWidth = widget.width(), 
			wOffsetLeft = widget.offset().left, 
			scrollPos = wOffsetLeft - (cWidth/2 - widgetWidth/2) - cOffsetLeft;
			// container.animate({scrollLeft : scrollPos}, '500', 'swing');
			container.scrollLeft(scrollPos);
		},
		getCanvasData : function(){
			var canvas = this.canvas;
			var scale = getScaleFromMatrix(canvas);
			var result = {};			
			result.width = canvas.width();
			result.height = canvas.height();
			result.scaleX = scale.scaleX;
			result.scaleY = scale.scaleY;
			return result;
		},
		setCanvasData : function(data){
			if(!data)return;
			var canvas = this.canvas;
			var img = this.image;
			var archetypeWidth = img.data("archetypeWidth")||img.width()||800;
			var ratio = data.width / archetypeWidth,
			left = data.left,
			top = data.top;
			
			//Set scale and position
			if(ratio)
				canvas.css({"transform":'scale('+ratio+','+ratio+')', "left" : ''+left+'px', "top" : ''+top+'px'});
		},
		getSelectBoxData : function(){
			return "Not supported yet";
		},
		setSelectBoxData : function(data){
			if(!data || !(data.width && data.height))return;
			var box = this.decorator;
			var canvasData = this.getCanvasData();
			var selectBox = this.selectBox;
			var ratio = canvasData.scaleX;
			var strokeWidth = this.options.selectBoxStrokeWidth;
			selectBox.attr('x',data.x);
			selectBox.attr('y',data.y);
			selectBox.attr('width',data.width);
			selectBox.attr('height',data.height);
			
			//Set dynamic stroke width
			selectBox.attr('stroke-width', parseInt(strokeWidth/ratio));

			
			//Display box
			box.show();
		},
		smartField : function(input){
			var fieldId = $(input).attr('id')||$(input).closest('.selectize-control').siblings(':input:first').attr('id');
			//if(this.eventTagId == fieldId)return;
			this.eventTagId = fieldId;
			console.log('smartField : '+fieldId);
			this.hideDecorator();
			if(input && this.options.sensitiveSmartField){
				$(input).one(EVENT_CANCEL_SMART_FIELD, $.proxy(this.hideDecorator, this));
			}
			if(!fieldId){
				return;
			}
			this.smartFieldById(fieldId);
		},
		smartFieldById : function(id){
			if(!id){
				return;
			}
			var options = this.options;
			var fields = options.fields;
			if(!fields){
				return;
			}
			var targetField = fields[id];
			if(!targetField){
				return;
			}
			if(!targetField.pageNo){
				this.rotate();
				return;
			}
			//Set image
			this.setImageByPageNo(targetField.pageNo,targetField);
		},
		rotate : function(deg){
			if(typeof deg === "string"){
				deg = parseInt(dec);
			}
			if(typeof deg !== "number"){
				deg = 0;
			}
			var img = this.image;
			var decorator = this.decorator;
			if(!deg){//Reset rotation
				img.css("transform","rotate(0deg)");
				decorator.css("transform","rotate(0deg)");
				return;
			}
			var currentDeg = getRotationDegrees(img)||0;
			var toDeg = currentDeg + deg;
			this.isRotated = toDeg % 360 == 0?false:true;
			
			img.css("transform","rotate("+toDeg+"deg)");
			decorator.css("transform","rotate("+toDeg+"deg)");			
		},
		wheel : function(event){			
			event.preventDefault();
			var originalEvent = event.originalEvent;
			var options = this.options;
			var delta = 0;
			var ratio;
			
			//Preven scrolling too fast
			if(this.wheeling){
				return;
			}
			this.wheeling = true;
			
			setTimeout($.proxy(function () {
				this.wheeling = false;
			}, this), 50);
			
			
			if(originalEvent){
				delta = originalEvent.deltaY < 0 ? 1 : -1;
			}
			ratio = 1 + (delta * options.wheelZoomRatio);
			this.zoomTo(ratio, event);
			
		},
		zoomIn : function(){
			this.zoomTo(1 + this.options.wheelZoomRatio);
		},
		zoomOut : function(){
			this.zoomTo(1 - this.options.wheelZoomRatio);
		},
		//Zoom to relative ratio
		zoomTo : function(ratio, e){
			var canvasData = this.getCanvasData();			
			var archetypeWidth = canvasData.width;
			var width = archetypeWidth * canvasData.scaleX;
			var absoluteRatio = width * ratio/archetypeWidth;
			this.zoom(absoluteRatio, e);
		},
		//Zoom to absolute ratio
		zoom : function(ratio, e){
			var options = this.options;
			var canvas = this.canvas;
			var canvasData = this.getCanvasData();
			var archetypeWidth = canvasData.width;
			var archetypeHeight = canvasData.height;
			var originalEvent = null;
			var width = archetypeWidth * canvasData.scaleX;
			var height = archetypeHeight * canvasData.scaleY;
			var newWidth;
			var newHeight;
			var offset;
			var center;
			var left;
			var top;
		  
			//calculate absolute ratio
			//ratio = width * ratio/archetypeWidth;
			if(ratio > options.maxZoomRatio){//Set limit
				// ratio = 5;
				return false;
			}else if(ratio < options.minZoomRatio){
				// ratio = 0.1;
				return false;
			}

			//Set up new width
			newWidth = archetypeWidth * ratio;
			newHeight = archetypeHeight * ratio;

			if (e) {
				originalEvent = e.originalEvent;
			}
			var canvasPosition = canvas.position();
			left = canvasPosition.left;
			top = canvasPosition.top;

			if(originalEvent){
				offset = this.imageContainer.offset();
					center = {
					pageX: e.pageX || originalEvent.pageX || 0,
					pageY: e.pageY || originalEvent.pageY || 0,
					offsetX: e.offsetX || originalEvent.offsetX || 0,
					offsetY: e.offsetY || originalEvent.offsetY || 0,
				};

				// Zoom from the triggering point of the event
				left -= (newWidth - width) * (
					((center.pageX - offset.left) - left) / width
				);
				top -= (newHeight - height) * (
					((center.pageY - offset.top) - top) / height
				);
			}else{
				left -= (newWidth - width) / 2;
				top -= (newHeight - height) / 2;
			}

		 
		  //Set position
			canvas.css({"transform" : "scale("+ratio+","+ratio+")","left": ''+left+'px', "top": ''+top+'px'});
			
			//Record curren ratio
			this.currentRatio = ratio;
		},
		getDefaultRatio : function(){
			return this.defaultRatio;
		},
		toggleLock : function(){
			var container = this.container,
			img = this.image,
			box = this.selectBox,
			canvas = this.canvas;
			
			if(!this.isLocked){
				this.unbind();
				img.addClass('locked');
				this.isLocked = true;
			}else{
				this.bind();
				img.removeClass('locked');
				this.isLocked = false;
			}
			var button = this.controllerContainer.find('.lock button');
			button.toggleClass('locked unlocked');
			$('.fa', button).toggleClass('fa-lock fa-unlock');
		}
	};
	
	SmartData.DEFAULTS = {
		images : [{"pageNo":1, "url":"images/app_form_p1.png","thumbnailUrl":"images/17ffed2060072c95583b3844da54540f3b8649ee9b42497abe8f4aaa3a14078c.png", "archetypeWidth":2480, "archetypeHeight":3507}],
		
		fields : {
			"max_education":{
				"pageNo": 1,
				"canvas": {
					"left": 37.495926726444495,
					"top": -302.88849580214503,
					"width": 1259.7098453477524,
					"height": 1781.371946626842,
					"naturalWidth": 2480,
					"naturalHeight": 3507
				},
				"selectBox": {
					"x": 99.51194376111553,
					"y": 928.2228553723241,
					"width": 1100.3389851915076,
					"height": 52.76135631189906,
					"rotate": 0,
					"scaleX": 1,
					"scaleY": 1
				}
			}
		},
		
		//Default controller button
		controller : {"zoomBar" : false, "zoomIn" : true, "zoomOut" : true, "reset" : true, "rotate90" : true, "rotate_90" : true, "rotate180" : true, "lock" : true, "print" : true},
		
		//Element to trigger smart field highlight
		smartField : ':input:not(button)',
		
		//When the field blurred, select box will disappear
		sensitiveSmartField : true,
		
		//Default wheel zoom scale
		wheelZoomRatio : 0.2,
		
		//Maximum zoom scale
		maxZoomRatio : 5,
		
		//Minimum zoom scale
		minZoomRatio : 0.05,
		
		//Base select box width
		selectBoxStrokeWidth : 4,
		
		//Base container height
		containerHeight : 700
	};
	
	SmartData.TEMPLATE = $(
		'<div class="smart-container">'+
			'<div class="img-controller-container">' +
				'<div class="img-controller">'+
				'</div>'+
				'<div class="img-controller-colapse"><div class="colapse"><button type="button" onclick="$.MasterWeb.toggleSmartImage()"><i class="fa fa-bars fa-fw"></i></button></div></div>' +
			'</div>'+
//			'<hr style="margin: 0; border-top: 2px solid #ddd !important" />'+
			'<div class="img-container">'+
				'<div class="img-canvas">'+
					'<img class="main-image" src=""/>'+
					'<svg class="img-decorator" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" '+
					'xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="basic" xml:space="preserve" xmlns:xml="http://www.w3.org/XML/1998/namespace">'+
						'<rect class="select-box" x="40" y="210" width="900" height="60" style="fill:transparent;stroke:red;stroke-width:4;stroke-opacity:0.3">'+
					'</svg>'+
				'</div>'+
			'</div>'+
//			'<div class="img-controller">'+
//			'</div>'+			
//			'<hr style="margin: 0; border-top: 2px solid #ddd !important">'+
			'<div class="thumbnail-container">'+
			'</div>'+
		'</div>'
	);
	
	  // Register as jQuery plugin
	$.fn.smartData = function (option) {
		var args = toArray(arguments, 1);
		var result = null;

		this.each(function () {
			var $this = $(this);
			var data = $this.data(NAMESPACE);
			var options;
			var fn;

			if (!data) {
				options = $.extend({}, $this.data(), $.isPlainObject(option) && option);
				$this.data(NAMESPACE, (data = new SmartData(this, options)));
			}

			if (typeof option === 'string' && $.isFunction(fn = data[option])) {
				result = fn.apply(data, args);
			}
		});
		return typeof result == "undefined" ? this : result;
	};
	  

});
var SmartInitializer = {
		"templateId" : "OverrideThis",
		"images" : [],
		"fields" : {
			
		},
		"container" : "",
		"init" : function(templateId,images,container,callBack){
			this.templateId = templateId;
			this.container = $(container);
			
			if(!templateId){
				this.displayErrorMessage("Template ID is not valid");
				return;
			}
			//var fieldsCallback = $.proxy(this.populateAsyncFields, this, templateId);
			
			//Populate images then fields
			this.populateAsyncImages(templateId, images,callBack);
			
			// 20170426
			return this;
		},
		populateAsyncImages : function(templateId, images, callBack){
			$.ajax({
				url : CONTEXTPATH + "/smartdata/api/data",
				type : "POST",
				data : JSON.stringify({
					"templateId" : templateId,
					"images" : images
				}),
				cache : false,
//				async:false,
				contentType: "application/json; charset=utf-8",
				error : function(xhr, status) {
					console.log(xhr.responseText);
					SmartInitializer.displayErrorMessage('Unable to retrieve images with templateId : '+templateId);
				},
				success : function(result, status, xhr) {
					console.log("Result : ", result);
					if(result.images.length == 0) {
						SmartInitializer.displayErrorMessage('No image display');
					}
					
		            var images = result.images;
		            var fields = result.fields;
		            SmartInitializer.images = SmartInitializer.mapSmartImage(images);
		            SmartInitializer.fields = SmartInitializer.mapSmartField(fields);
		            if(SmartInitializer.images && SmartInitializer.fields){
		            	SmartInitializer.buildSmartDataEnvironment();
		            }
		            if($.isFunction(callBack)){
		            	callBack();
		            }
				}
			});
		},
		buildSmartDataEnvironment : function(){
//			var forceHeight = $(window).height() - $('.navbar-fixed-top').height() - $('#footer-nav').height();
			var options = {
				"images" : this.images,
				"fields" : this.fields,
				"smartField" : ':input:not(button), .selectize-input, .input-group-addon',
				"sensitiveSmartField" : false
			};
			console.log("SmartData Options : ",options);
			this.container.smartData(options);//Bind smart data plug-i65n
		},
		mapSmartImage : function(rawImages) {
			
			if(!rawImages)return;
			var result = [];
			for(var i = 0, l = rawImages.length; i < l; i++){
				var rawImage = rawImages[i];
				var image = {
					"pageNo" : rawImage.smartPageNo,
					"url" : rawImage.imgpath,
					"thumbnailUrl" : rawImage.imgthumbpath,
					"docTypeId" : rawImage.doctypeid,
					"docTypeDesc" : rawImage.docTypeDesc,
					"personalTypeDesc" : rawImage.personalTypeDesc,
					"archetypeWidth" : rawImage.naturalWidth,
					"archetypeHeight" : rawImage.naturalHeight,
					"printable" : rawImage.print
				};
				result.push(image);
			}
			return result;
		},
		mapSmartField : function(rawFields){
			if(!rawFields)return;
			var result = {};
			for(var i = 0, l = rawFields.length; i < l; i++){
				var rawField = rawFields[i];
				var field = {
					"pageNo" : rawField.pagenumber,
					"canvas": {
						"left": rawField.canvasLeft,
						"top": rawField.canvasTop,
						"width": rawField.canvasWidth,
						"height": rawField.canvasHeight,
						"naturalWidth": rawField.canvasNaturalWidth,
						"naturalHeight": rawField.canvasNaturalHeight
					},
					"selectBox": {
						"x": rawField.boxX,
						"y": rawField.boxY,
						"width": rawField.boxWidth,
						"height": rawField.boxHeight,
						"rotate": rawField.boxRotate,
						"scaleX": rawField.boxScaleX,
						"scaleY": rawField.boxScaleY
					}
				};
				result[rawField.fieldid] = field;
			}
			return result;
		},
		displayErrorMessage : function(msg) {
			var con = this.container;
			var box = $('<div>').css({
				"padding": "5px",
			    "margin": "300px 50px 0",
			    "border": "2px dashed red",
			    "border-radius": "10px 10px 10px"
			});
			con.append(box.text(msg));//Temporarily disable
		}
};

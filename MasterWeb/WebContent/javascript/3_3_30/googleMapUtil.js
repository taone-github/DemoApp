//function initMap(mapId) {
//    var mapOptions = {
//      center: new google.maps.LatLng(13.741164, 100.522156),
//      zoom: 8,
//      mapTypeId: google.maps.MapTypeId.ROADMAP
//    };
//    var map = new google.maps.Map(document.getElementById("map_canvas"),
//        mapOptions);
//}


	var GoogleMap = function (divObj, moduleID, mfID, fieldID) {
		this.divObj = divObj;
		this.moduleID = moduleID;
		this.mfID = mfID;
		this.fieldID = fieldID;
		this.map;
		this.searchBox;
		this.markers = {};
		this.infowindow;
	};
	
	
	function initialize() {
		
	}
	function initAutocomplete()  {
		
		$('[name=GoogleMapDIV]').each(function () {
			if(!$(this).hasClass('map-initilized')) {
				var map = new GoogleMap(this, $(this).attr('EAFModule'), $(this).attr('EAFModuleField'), $(this).attr('EAFFieldID'));
				map.create();
				$(this).addClass('map-initilized');
			}
		});
	}

	GoogleMap.prototype.create = function() {
		var googleMap = this;
		this.map = new google.maps.Map(this.divObj, {
			zoom: 13,
			center: { lat: 13.764934, lng: 100.5382955 },
			zoomControl: true,
			scaleControl: true,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
		
		// Create the search box and link it to the UI element.
		var searchBoxObj = document.createElement('input');
		searchBoxObj.type = 'text';
		searchBoxObj.placeholder='Search Box';
		searchBoxObj.className = 'map-controls';
		$(this.divObj).before(searchBoxObj);
		
		this.searchBox = new google.maps.places.SearchBox(searchBoxObj);
		this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBoxObj);
		
		// Bias the SearchBox results towards current map's viewport.
		this.map.addListener('bounds_changed', function() {
			googleMap.searchBox.setBounds(googleMap.map.getBounds());
		});
		
		var markers = [];
		// [START region_getplaces]
		// Listen for the event fired when the user selects a prediction and retrieve
		// more details for that place.
		this.searchBox.addListener('places_changed', function() {
			var places = googleMap.searchBox.getPlaces();
			
			if (places.length == 0) {
				return;
			}
			
			// Clear out the old markers.
			markers.forEach(function(marker) {
				marker.setMap(null);
			});
			markers = [];
			
			// For each place, get the icon, name and location.
			var bounds = new google.maps.LatLngBounds();
			places.forEach(function(place) {
				var icon = {
					url: place.icon,
					size: new google.maps.Size(71, 71),
					origin: new google.maps.Point(0, 0),
					anchor: new google.maps.Point(17, 34),
					scaledSize: new google.maps.Size(25, 25)
				};
				
				// Create a marker for each place.
				markers.push(new google.maps.Marker({
					map: googleMap.map,
					icon: icon,
					title: place.name,
					position: place.geometry.location
				}));
				
				if (place.geometry.viewport) {
					// Only geocodes have viewport.
					bounds.union(place.geometry.viewport);
				} else {
					bounds.extend(place.geometry.location);
				}
			});
			
			googleMap.map.fitBounds(bounds);
		});
		// [END region_getplaces]
		
		// Create the DIV to hold the control and call the CenterControl() constructor
		// passing in this DIV.
		var centerControlDiv = document.createElement('div');
		googleMap.addControlBtn(centerControlDiv, googleMap.map);

		centerControlDiv.index = 1;
		googleMap.map.controls[google.maps.ControlPosition.TOP_RIGHT].push(centerControlDiv);
		
		if($('[name='+googleMap.moduleID + '_' + googleMap.fieldID+']').length > 0) {
			var bounds = new google.maps.LatLngBounds();
			$('[name='+googleMap.moduleID + '_' + googleMap.fieldID+']').each(function () {
				if($(this).val() != '' && $(this).val().indexOf(',') != -1) {
					var lat = $(this).val().split(',')[0];
					var lng = $(this).val().split(',')[1];
					var mkrId = $(this).attr('id').replace(googleMap.moduleID + '_' + googleMap.fieldID + '_', '');
					
					var marker = googleMap.addMarker(lat, lng, mkrId);
					bounds.extend(marker.getPosition());
				}
			});
			this.map.fitBounds(bounds);
		}
	};

	GoogleMap.prototype.addControlBtn = function(controlDiv, map) {
		var googleMap = this;
		
		// Set CSS for the control border.
		var controlUI = document.createElement('div');
		controlUI.className = 'addMarkerButton';
		controlUI.style.backgroundColor = '#fff';
	  
		controlUI.style.borderRadius = '3px';
		controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
		controlUI.style.cursor = 'pointer';
		//controlUI.style.marginBottom = '22px';
		controlUI.style.marginRight = '10px';
		controlUI.style.marginTop = '10px';
		controlUI.style.textAlign = 'center';
		controlUI.title = 'Click to add new marker';
		controlDiv.appendChild(controlUI);
		
		// Set CSS for the control interior.
		var controlText = document.createElement('div');
		controlText.style.color = 'rgb(25,25,25)';
		controlText.style.lineHeight = '30px';
		controlText.style.paddingLeft = '5px';
		controlText.style.paddingRight = '5px';
		
		controlText.innerHTML = 'Add Marker';
		//controlText.onclick = addMyMarker;
		controlUI.appendChild(controlText);
		
		// Setup the click event listeners: simply set the map to Chicago.
		controlUI.addEventListener('click', function () { googleMap.addMarker() });
		controlUI.addEventListener('mouseover',function () { 
			this.style.backgroundColor = 'rgb(235,235,235)'
		});
		controlUI.addEventListener('mouseout',function () { 
			this.style.backgroundColor = '#fff'
		});
		
	};

	GoogleMap.prototype.addMarker = function(prmLat, prmLng, prmMkrId) {

		var googleMap = this;

		var position = googleMap.map.getCenter();
		if(prmLat != undefined && prmLng != undefined) {
			position = new google.maps.LatLng(prmLat, prmLng);
		}
		
		var marker = new google.maps.Marker({
			position: position,
	        map: googleMap.map,
	        draggable:true,
	        animation: google.maps.Animation.DROP
	    });
		
		// set id to marker
		id = 'mkr' + 0;
		if(prmMkrId != undefined) {
			id = prmMkrId;
		} else {
			for(i=0; (this.markers['mkr' + i] != undefined && this.markers['mkr' + i] != null); i++) {
				id = 'mkr' + (i + 1);
			}
		}
		
	    this.markers[id] = marker;
		marker.metadata = {id: id};
		
		// add EAF hidden field
		if($('#' + googleMap.moduleID + '_' + googleMap.fieldID + '_' + marker.metadata.id).length == 0) {
			var EAFinputObj = document.createElement('input');
			EAFinputObj.type = 'hidden';
			EAFinputObj.name = googleMap.moduleID + '_' + googleMap.fieldID;
			EAFinputObj.id = googleMap.moduleID + '_' + googleMap.fieldID + '_' + id;
			EAFinputObj.value = marker.getPosition().lat() + ',' + marker.getPosition().lng();
			googleMap.divObj.appendChild(EAFinputObj);
		}
		
		// add right click event to delete
		google.maps.event.addListener(marker, 'rightclick', function (point) { googleMap.deleteMarker( marker.metadata.id  ) });
		google.maps.event.addListener(marker, 'dblclick', function() {
			googleMap.infowindow = new google.maps.InfoWindow({
				content: "<div id=content class=locationInfo>"
						+ "<span class='item br locPosition'>"
						+ "<strong>Lat:</strong> "
						+ "<input type=number id=content_lat_"+marker.metadata.id+" value='"+marker.getPosition().lat()+"'>"
						+ "<br>"
						+ "<strong>Lng:</strong> "
						+ "<input type=number id=content_lng_"+marker.metadata.id+" value='"+marker.getPosition().lng()+"'>"
						+ "</span>"
						+ "</div>"
			});
			googleMap.infowindow.open(googleMap.map, marker);
		});
		google.maps.event.addListener(marker, 'dragend', function (event) {
			if(googleMap.infowindow) {
				$('#content_lat_'+marker.metadata.id).val(marker.getPosition().lat());
				$('#content_lng_'+marker.metadata.id).val(marker.getPosition().lng());
			}
			
			document.getElementById(googleMap.moduleID + '_' + googleMap.fieldID + '_' + marker.metadata.id).value = marker.getPosition().lat() + ',' + marker.getPosition().lng();
			
		});
		return marker;
	};

	GoogleMap.prototype.deleteMarker = function(id) {
		if(!confirm('Delete ?')) return;
	    marker = this.markers[id]; 
	    marker.setMap(null);
		this.markers[id] = null;
		
		// delete EAF hidden field
		var EAFinputObj = document.getElementById(this.moduleID + '_' + this.fieldID + '_' + id);
		$(EAFinputObj).remove();
		//this.divObj.removeChild(EAFinputObj);
	};
	
	try {
		if(google) {
			google.maps.event.addDomListener(window, "load", initAutocomplete);
		}
	} catch (e) {
		
	}
	

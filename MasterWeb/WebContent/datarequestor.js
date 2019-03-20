/**
 *    DataRequestor Class v: 1.5b - Feb 13, 2006
 *
 *	      Copyright 2005 - Mike West - http://mikewest.org/
 *
 *        This software is licensed under the CC-GNU LGPL <http://creativecommons.org/licenses/LGPL/2.1/>
 *
 *        This class wraps the XMLHttpRequest object with a friendly API
 *        that makes complicated data requests trivial to impliment in
 *        your application.
 *
 *        USAGE:
 *            ----
 *            BASIC
 *            To instantiate the object, simply call it as a constructor:
 * 
 *                var req = new DataRequestor();
 *
 *            Once you have the object instantiated, your usage will depend
 *            on your needs.  
 *
 *			  RETURNING TEXT
 *            If you want to grab data, and shove it wholesale into an element 
 *            on the page (which I do 90% of the time), then tell the DataRequestor
 *            object where to stick the info by passing setObjToReplace an
 *            element ID or object reference, and call getURL to complete the
 *            process:
 *
 *                req.setObjToReplace('objID');
 *                req.getURL(url);
 *
 *
 *            RETURNING A DOM OBJECT
 *            By default, the contents of the requested file will be passed in as
 *            plaintext, which can be simpler to work with than a real DOM object.
 *            If you'd like a DOM object to work with, then call getURL with
 *            _RETURN_AS_DOM as the second argument:
 *
 *                req.getURL(url, _RETURN_AS_DOM);
 *
 *            To avoid irritating problems, make sure you're sending a Content-type header
 *            of "text/xml" when you'd like your data processed as a DOM object.  IE gets
 *            confused otherwise.
 *
 *            RETURNING A JSON OBJECT
 *            If you've no idea what JSON is, visit http://www.json.org/
 *
 *            To get a JavaScript object back from DataRequestor, call getURL with
 *            with _RETURN_AS_JSON as the second parameter.
 *
 *                req.getURL(url, _RETURN_AS_JSON);
 *
 *            This, of course, assumes that you've generated a JSON string correctly
 *            at the URL you've requested.
 *            ----
 *            ARGUMENTS
 *
 *            To pass in GET or POST variables along with your request, use the
 *            addArg method:
 *
 *                req.addArg(argType, argName, argValue);
 *                e.g.
 *                req.addArg(_GET, "argument_number", "1");
 *
 *            addArg will automatically call escape() on the name and value to
 *            ensure they are URL escaped correctly.
 *            
 *            ARGUMENTS FROM A FORM
 *
 *            To pass in all the arguments from a form, use the `addArgsFromForm`
 *            method.  This will automatically call `addArg` on each of the form
 *            elements using the `method` attribute of the form to set the request 
 *            method for the arguments.  Each form element *must* have an ID for this
 *            method to function correctly.
 *
 *                req.addArgsFromForm(formID);
 *                e.g.
 *                req.addArgsFromForm("myFormName");
 *            ----
 *            EVENT HANDLERS
 *
 *                ON LOAD
 *
 *                To take action when the data loads successfully, set onload to a function that
 *                takes two arguments: data, and obj.  This will be called upon successful retrieval
 *                of the requested information, and will be passed the data retrieves and the object
 *                that will be replaced (or null if no replacement has been requested).
 *
 *                    req.onload = function (data, obj) {
 *                        alert("Callback handler called with the following data: \n" + data);
 *                    }
 *
 *                The first parameter (`data`) will be one of three things:
 *                    - text:  If getURL was called without a second argument, or _RETURN_AS_TEXT,
 *                      then `data` contains the raw text returned by the page that you loaded.
 *                    
 *                    - DOM object: If getURL was called with _RETURN_AS_DOM as the second argument, then
 *						`data` contains a DOM object, with blank whitespace nodes removed in order to 
 *                      provide a consistant experience between browsers that support the DOM standard
 *                      and IE.
 *
 *                    - JavaScript object: If getURL was called with _RETURN_AS_JSON as the second argument,
 *                      then `data` contains a JavaScript object generated from the JSON text that was returned
 *                      by the page you loaded.
 *
 *                ON REPLACE
 *                
 *                If you requested a replacement by setting an `objToReplace`, then this handler will
 *                be called directly after the replacement occurs, and will be passed the same variables
 *                as the `onload` method.
 *
 *                    req.onreplace = function (data, obj) {
 *                        alert("Callback handler called with the following data: \n" + data);
 *                    }
 *
 *                ERROR HANDLING
 *
 *                If the request fails, the XMLRequestor object defaults to simply throwing
 *                an error.  If that's not a great solution for you, then assign a function
 *                to onfail that accepts a single variable: the XMLHttpRequest status
 *                code.  Do with it what you will:
 *
 *                    req.onfail = function (status) {
 *                        alert("The handler died with a status of " + status);
 *                    }
 *
 *                PROGRESS
 *
 *                In Mozilla, it's possible to dynamically retrieve the amount of data that
 *                has been downloaded so far.  If you'd like to take an action on that data
 *                (e.g. set up some sort of progress bar) then set an onprogress handler that
 *                accepts two arguments, currentLength and totalLength.  Curiously enough,
 *                these arguments will be populated with the current amount of data that's been
 *                retrieved and the total size (or -1 if it can't be detected)
 *
 *                    req.onprogress = function (current, total) {
 *                        alert(current + " of " + total + " = " + ((total - current)/total) + "%");
 *                    }
 *
 */
var _RETURN_AS_JSON = 2;
var _RETURN_AS_TEXT = 1;
var _RETURN_AS_DOM  = 0;

var _POST           = 0;
var _GET            = 1;

var _CACHE           = 0;
var _NO_CACHE        = 1;
var _DATA_REPLATER   = 0;

function DataRequestor() {
    var self = this;  // workaround for scope errors: see http://www.crockford.com/javascript/private.html
    /**
     *  Create XMLHttpRequest object: handles branching between
     *  versions of IE and other browers.  Inital version from:
     *  http://jibbering.com/2002/4/httprequest.html (GREAT resource)
     *
     *  later version adapted from:
     *  http://jpspan.sourceforge.net/wiki/doku.php?id=javascript:xmlhttprequest:behaviour:httpheaders
     *
     *  @return     the XMLHttpRequest object
     */
    this.getXMLHTTP = function() {
    	alert('this.getXMLHTTP  >>');
        var xmlHTTP = null;

        try {
        	alert('this.getXMLHTTP  Step New ');
            xmlHTTP = new XMLHttpRequest();
        } catch (e) {
            try {
            	alert('this.getXMLHTTP  Step Exception ');
                xmlHTTP = new ActiveXObject("Msxml2.XMLHTTP")
            } catch(e) {
                var success = false;
                var MSXML_XMLHTTP_PROGIDS = new Array(
                    'Microsoft.XMLHTTP',
                    'MSXML2.XMLHTTP',
                    'MSXML2.XMLHTTP.5.0',
                    'MSXML2.XMLHTTP.4.0',
                    'MSXML2.XMLHTTP.3.0'
                );
                for (var i=0;i < MSXML_XMLHTTP_PROGIDS.length && !success; i++) {
                    try {
                        xmlHTTP = new ActiveXObject(MSXML_XMLHTTP_PROGIDS[i]);
                        success = true;
                    } catch (e) {
                        xmlHTTP = null;
                    }
                }
            }

        }
        self._XML_REQ = xmlHTTP;
        alert('this.getXMLHTTP  Step Before Return '+self._XML_REQ);
        return self._XML_REQ;
    }

    /**
     *   Starts the request for a url.  XMLHttpRequest will call
     *   the default callback method when the request is complete
     *   @param     url     the URL to request: absolute or relative will work
     *   @param     return  optional arg: defaults to _RETURN_AS_TEXT.  if set to _RETURN_AS_DOM, will return a DOM object instead of a string
     *   @return    true
     */
    this.getURLForThai = function(url) { 
    	alert('this.getURLForThai arguments[1] >>'+arguments[1]);  
        self.userModifiedData = "";  // clear user modified data;
        // DID THE USER WANT A DOM OBJECT, OR JUST THE TEXT OF THE REQUESTED DOCUMENT?
			switch (arguments[1]) {
				case _RETURN_AS_DOM:
				case _RETURN_AS_TEXT:
				case _RETURN_AS_JSON:
					self.returnType = arguments[1];
					break;
				
				default:
					self.returnType = _RETURN_AS_TEXT;
			}

		// CLEAR OUT ANY CURRENTLY ACTIVE REQUESTS
            if ((typeof self._XML_REQ.abort) != "undefined" && self._XML_REQ.readyState!=0) { // Opera can't abort().
                self._XML_REQ.abort();
            }

        // SET THE STATE CHANGE FUNCTION
            self._XML_REQ.onreadystatechange = self.callback;

        // GENERATE THE POST AND GET STRINGS
            var requestType = "GET";
            var getUrlString = (url.indexOf("?") != -1)?"&":"?";
            for (var i in self.argArray[_GET]) {
				for(var j in self.argArray[_POST][i]){
					getUrlString += i + "=" + self.argArray[_GET][i][j] + "&";
				}
                //getUrlString += i + "=" + self.argArray[_GET][i] + "&";
            }
            var postUrlString = "";
            var reg1=/(^[A-Z,a-z,\-,\s,0-9,\.]*$)/ ;
            for (i in self.argArray[_POST]) {
				for(var j in self.argArray[_POST][i]){
					var str = self.argArray[_POST][i][j];
					if(!reg1.test(str) && str != ''){
						//str = escape(str);
						str=encodeURIComponent(str);
						//alert(str);
					}
					postUrlString += i + "=" + str + "&";
				}
                //postUrlString += i + "=" + self.argArray[_POST][i] + "&";
            }
            if (postUrlString != "") {
                requestType = "POST";  // Only POST if we have post variables
            }
         // alert(postUrlString);   
        // MAKE THE REQUEST

            self._XML_REQ.open(requestType, url + getUrlString, true);
	    if ((typeof self._XML_REQ.setRequestHeader) != "undefined") { // Opera can't setRequestHeader()
                if (self.returnType == _RETURN_AS_DOM && typeof self._XML_REQ.overrideMimeType == "function") {
                    self._XML_REQ.overrideMimeType('text/xml');  // Make sure we get XML if we're trying to process as DOM
                }
                self._XML_REQ.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
            }
            self._XML_REQ.send(postUrlString);
            //self._XML_REQ.send(postUrlString);
       return true;
    }
    
    this.getURL = function(url) {
	    alert('this.getURL arguments[1] >>'+url); 
        self.userModifiedData = "";  // clear user modified data;
        // DID THE USER WANT A DOM OBJECT, OR JUST THE TEXT OF THE REQUESTED DOCUMENT?
			switch (arguments[1]) {
				case _RETURN_AS_DOM:
				case _RETURN_AS_TEXT:
				case _RETURN_AS_JSON:
					self.returnType = arguments[1];
					break;
				
				default:
					self.returnType = _RETURN_AS_TEXT;
			}

		// CLEAR OUT ANY CURRENTLY ACTIVE REQUESTS
            if ((typeof self._XML_REQ.abort) != "undefined" && self._XML_REQ.readyState!=0) { // Opera can't abort().
                self._XML_REQ.abort();
            }

        // SET THE STATE CHANGE FUNCTION
            self._XML_REQ.onreadystatechange = self.callback;

        // GENERATE THE POST AND GET STRINGS
            var requestType = "GET";
            var getUrlString = (url.indexOf("?") != -1)?"&":"?";
            for (var i in self.argArray[_GET]) {
				for(var j in self.argArray[_POST][i]){
					getUrlString += i + "=" + self.argArray[_GET][i][j] + "&";
				}
                //getUrlString += i + "=" + self.argArray[_GET][i] + "&";
            }
            var postUrlString = "";
            for (i in self.argArray[_POST]) {
				for(var j in self.argArray[_POST][i]){
					var str = self.argArray[_POST][i][j];
					postUrlString += i + "=" + str + "&";
				}
                //postUrlString += i + "=" + self.argArray[_POST][i] + "&";
            }
            if (postUrlString != "") {
                requestType = "POST";  // Only POST if we have post variables
            }

        // MAKE THE REQUEST
			alert('this.getURL Request On XMLREQ ONEN requestType >>'+requestType); 
			alert('this.getURL Request On XMLREQ ONEN url  >>'+url); 
			alert('this.getURL Request On XMLREQ ONEN getUrlString  >>'+getUrlString); 
			alert('this.getURL Request On XMLREQ ONEN postUrlString  >>'+postUrlString); 			
			
            self._XML_REQ.open(requestType, url + getUrlString, true);
	    if ((typeof self._XML_REQ.setRequestHeader) != "undefined") { // Opera can't setRequestHeader()
                if (self.returnType == _RETURN_AS_DOM && typeof self._XML_REQ.overrideMimeType == "function") {
                    self._XML_REQ.overrideMimeType('text/xml');  // Make sure we get XML if we're trying to process as DOM
                }
                self._XML_REQ.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
            }
            self._XML_REQ.send(postUrlString);
            //self._XML_REQ.send(postUrlString);
       return true;
    }

    /**
     *  The default callback method: this is called when the XMLHttpRequest object
     *  changes state.
     *  - If the readystate == 4 (done) and the status == 200 (OK), then
     *    the request was successful, and we take some action:
     *      - If the user has set an object to replace, we check to see if we recieved plaintext (default)
     *        or if the text should be run through eval first.
     *
     *          - If we recieved plaintext, we simply replace the relevant object on the page with the
     *            text we received.
     *
     *          - If we recieved text to evaluate, we call eval() on it, and then replace the object
     *            wholesale with _DOM_OBJ (which resulted from the eval) using replaceChild() on
     *            self.objToReplace's parentNode.
     *
     *      - If the user has set an onLoad method, we call it.  If they requested a DOM object, we
     *        pass it responseXML with blank text nodes stripped (to normalize between mozilla and
     *        IE.  If not, we pass them back plaintext.
     *
     *  - Else if the readystate is 3 (loading), and the user has set an onProgress handler, and
     *    we're not in IE (which has a broken readyState 3: http://jpspan.sourceforge.net/wiki/doku.php?id=javascript:xmlhttprequest:behaviour)
     *    then call it with two arguments: the current number of bytes we've downloaded, and the total size (or -1 if we can't tell).
     *
     *  - Else if the readystate is 4, and the status isn't 200 (not OK), then we failed
     *    somehow, so we either call the callbackFailure method, or throw an error.
     */
    this.callback = function() {
     	alert('this.callback >'); 
        if (self.onLoad) {
        	alert('If this.callback > self.onLoad'); 
            self.onload     = self.onLoad;
        }
        if (self.onReplace) {
        	alert('If this.callback > self.onreplace'); 
            self.onreplace  = self.onReplace;
        }
        if (self.onProgress) {
        	alert('If this.callback > self.onProgress');	
            self.onprogress = self.onProgress;
        }
        if (self.onFail) {
	        alert('If this.callback > self.onFail');	
            self.onfail     = self.onFail;
        }
		alert('this.callback >self._XML_REQ.readyState'+self._XML_REQ.readyState);
        if (
            (self._XML_REQ.readyState == 4 && self._XML_REQ.status == 200)
            ||
            (self._XML_REQ.readyState == 4 && self._XML_REQ.status == 0) // Uncomment for local (non-hosted files)
            
            
/*            || 
            (self._XML_REQ.readyState == 4 && (typeof self._XML_REQ.status) == 'undefined') /* Safari 2.0/1.3 has a strange bug related to not returning the correct status */
           ) {
           	alert('this.callback >Before self.getObjToReplace');
            var obj = self.getObjToReplace();
            alert('this.callback >> self.getObjToReplace() >>>'+self.getObjToReplace()); 
            alert('this.callback >> self.onload >>>'+self.onload); 
            alert('this.callback >> self.returnType >>>'+self.returnType); 
            if (self.onload) {            	
            	switch (self.returnType) {	            	
            		case _RETURN_AS_TEXT:
            			// We want text back, so send responseText
	                    self.onload(self._XML_REQ.responseText, obj);
	                    break;
	                    
	                case _RETURN_AS_DOM:
	                	// We want a DOM object back, so send a normalized responseXML
	                    self.onload(self.normalizeWhitespace(self._XML_REQ.responseXML), obj);
	                    break;
	                    
	                case _RETURN_AS_JSON:
	                	// We want a javascript object back, so give it:
	                	self.onload(eval('(' + self._XML_REQ.responseText + ')'), obj);
	                	break;
            	}
            }
            alert('this.callback >> obj  >>>'+obj);
            if (obj) {
                // We're going to replace obj's content with the text returned from the XML_REQ.
                // The old content will be stored in self.objOldContent, the new content in 
                // self.objNewContent
                
				// We treat TEXTAREA and INPUT nodes differently (because IE crashes if you 
				// try to adjust a TEXTAREA's innerHTML).
				alert('this.callback >> obj.nodeName  Check IF >>>'+obj.nodeName);
				if (obj.nodeName == "TEXTAREA" || obj.nodeName == "INPUT") {
					alert('this.callback >> TEXTAREA >>>>>>>>>>'+obj.innerHTML);
				    self.objOldContent = obj.value;
					obj.value          = (self.userModifiedData)?self.userModifiedData:self._XML_REQ.responseText;
					self.objNewContent = obj.value;					
				} else {		
					alert('this.callback >> OLD obj.innerHTML >>>>>>>>>>'+obj.innerHTML);						
				    self.objOldContent = obj.innerHTML;
				    alert('this.callback >> OLD obj.innerHTML >>>>>>>>>>'+obj.innerHTML);	
					obj.innerHTML      = (self.userModifiedData)?self.userModifiedData:self._XML_REQ.responseText;
					self.objNewContent = obj.innerHTML;
					alert('this.callback >> NEW obj.innerHTML >>>>>>>>>>'+self.objNewContent);					
				}
                if (self.onreplace) {
                	alert('this.callback >> self.onreplace >>>>>>>>>>');
                	alert('this.callback >> self.objOldContent >>>>>>>>>>'+self.objOldContent);
                	alert('this.callback >> self.objNewContent >>>>>>>>>>'+ self.objNewContent);
                    self.onreplace(obj, self.objOldContent, self.objNewContent);
                }
            }else{
            	if(self._DATA_REPLATER = 1){
            		alert('this.callback >> self._XML_REQ.responseText >>>>>>>>>>'+self._XML_REQ.responseText);
            		var test = 'Akanit';
            		var textName = 'CLIENT_REF';
            		document.getElementById(textName).value = test;
            		alert('this.callback >> document.getElementById'+document.getElementById(textName).value);
            	}
            }
        } else if (self._XML_REQ.readyState == 3) {
            if (self.onprogress && !document.all) { // This would throw an error in IE.
                var contentLength = 0;
                // Depends on server.  If content-length isn't set, catch the error
                try {
                    contentLength = self._XML_REQ.getResponseHeader("Content-Length");
                } catch (e) {
                    contentLength = -1;
                }
                self.onprogress(self._XML_REQ.responseText.length, contentLength);
            }

        } else if (self._XML_REQ.readyState == 4) {
            if (self.onfail) {
                self.onfail(self._XML_REQ.status);
            } else {
                throw new Error("Data Request failed with an HTTP status of " + self._XML_REQ.status + "\nresponseText = " + self._XML_REQ.responseText);
            }
        }
        alert('this.callback finish '); 
    }


    /**
     *  Normalizes whitespace between mozilla and IE
     *    - removes blank text nodes (where "blank" is defined as "containing no non-space characters")
     *  @param  domObj    the root of the DOM object to normalize
     */
    this.normalizeWhitespace = function (domObj) {
        // with thanks to the kind folks in this thread: 
        //    http://www.codingforums.com/archive/index.php/t-7028
        alert('this.normalizeWhitespace ');
        if (document.createTreeWalker) {
            var filter = {
                acceptNode: function(node) {
                    if (/\S/.test(node.nodeValue)) {
                        return NodeFilter.FILTER_SKIP;
                    }
                    return NodeFilter.FILTER_ACCEPT;
                }
            }
            var treeWalker = document.createTreeWalker(domObj, NodeFilter.SHOW_TEXT, filter, true);
            while (treeWalker.nextNode()) {
                treeWalker.currentNode.parentNode.removeChild(treeWalker.currentNode);
                treeWalker.currentNode = domObj;
            }
            return domObj;
        } else {
            return domObj;
        }
    }
    
    this.commitData = function (newData) {
	    alert('this.commitData ');
        self.userModifiedData = newData;
    }

    /**
     *  Sets the object to replace.  If passed a string, it sets objToReplaceID, which
     *  is evaluated at runtime.  Else, it sets objToReplace to the object reference
     *  it was passed.
     *  @param  obj             a reference to the object to replace, or the object's ID
     */
    this.setObjToReplace = function(obj) {
    alert('this.setObjToReplace ');
        if (typeof obj == "object") {
            self.objToReplace = obj;
        } else if (typeof obj == "string") {
            self.objToReplaceID = obj;

        }
    }

    /**
     *  Returns a reference to the object set by objToReplace
     */
    this.getObjToReplace = function() {
   		 alert('this.getObjToReplace ');
        if (self.objToReplaceID != "") {
            self.objToReplace = document.getElementById(self.objToReplaceID);
            self.objToReplaceID = "";
        }
        return self.objToReplace;
    }

    /**
     *  Adds an argument to the GET or POST strings.
     *  @param  type    _GET or _POST
     *  @param  name    the argument's name
     *  @param  value   the argument's value
     */
    this.addArg = function(type, name, value) {
    	alert('this.addArg type >>>>>>'+type);
    	alert('this.addArg name >>>>>>'+name);
    	alert('this.addArg value >>>>>'+value);    	    	
		var tagObj =  self.argArray[type][name];
		//alert("before tag ->" + self.argArray[type][name]);
		if(typeof tagObj == 'undefined'){
			tagObj = new Array();
			self.argArray[type][name] = tagObj;
			tagObj[0] = escape(value);
		}else{
			alert('this.addArg escape(value) >>>>>>'+escape(value));
			alert('this.addArg tagObj[tagObj.length] >>>>>>'+tagObj[tagObj.length]);
			tagObj[tagObj.length] = escape(value);
		}
		
		if (name == 'REP_DATA') {
			alert('REP_DATA');
			self._DATA_REPLATER = 1;
		}
		//self.argArray[type][name] = escape(value);
		//alert("after tag ->" + self.argArray[type][name]);
    }

    /**
     *  Clears the argument lists
     */
    this.clearArgs = function() {
    	alert('this.clearArgs ');
        self.argArray[_POST] = new Array();
        self.argArray[_GET]  = new Array();
    }

    /**
     *  Adds all the variables from an HTML form to the GET or 
     *  POST strings, based on the `method` attribute` of the 
     *  form
     *  @param  formID  the ID of the form to be added
     */
    this.addArgsFromForm = function(formID) {
    	alert('this.addArgsFromForm ');
        var theForm = document.getElementById(formID);
        //alert(theForm.name);
        // Get form method, default to GET
        var submitMethod = (theForm.getAttribute('method').toLowerCase() == 'post')?_POST:_GET;
        
        // Get all form elements and use `addArg` to add them to the GET/POST string
        for (var i=0; i < theForm.elements.length; i++) {
            var theNode = theForm.elements[i];
			if (theNode.type!==undefined) {
				//alert("type = "+theNode.type+" : name = "+theNode.name+" : value = "+theNode.value);
				switch(theNode.type.toLowerCase()) {
					case "input":
					case "hidden":
					case "select":
					case "select-one":
					case "textarea":
					case "text":
						//alert("submitMethod = "+submitMethod+" : name = "+theNode.name+" : value = "+theNode.value);    
						this.addArg(submitMethod, theNode.name, theNode.value);
						break;
					case "checkbox":
						if (theNode.checked) {
							this.addArg(submitMethod, theNode.name, theNode.value);
						}
						break;
					case "radio":
						if (theNode.checked) {
							this.addArg(submitMethod, theNode.name, theNode.value);
						}
						break;
				}
			}
        }
    }

    /**
     *  Resets everything to defaults
     */
    this.clear = function() {
    	alert('this.clear ');
        self.returnType      = _RETURN_AS_TEXT;
        self.argArray        = new Array();

        self.objToReplace    = null;
        self.objToReplaceID  = "";

        self.onload          = null;
        self.onfail          = null;
        self.onprogress      = null;
        self.cache           = new Array();
        this.clearArgs();
    }



    // ENSURE THAT WE'VE GOT AN XMLHttpRequest OBJECT AVALIABLE
    if (!this.getXMLHTTP()) {
        throw new Error("Could not load XMLHttpRequest object");
    }

    this.clear();
}

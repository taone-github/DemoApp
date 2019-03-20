/**
 * Web Storage
 * LocalStorage for Application
 * @author Norrapat Nimmanee
 * @version initial
 */

var webStorage = {
	checkSupport: function() {
		if(typeof(Storage) !== "undefined") {
		    //console.log("Web Storage : Browser supported.");
		    return true;
		} else {
			console.log("Web Storage : Browser NOT supported!.");
		    return false;
		}
	},
	getStorage: function() {
		if(this.checkSupport()) {
			return localStorage;
		} else {
			return undefined;
		}
	},
	getSessStorage: function() {
		if(this.checkSupport()) {
			return sessionStorage;
		} else {
			return undefined;
		}
	}
};

webStorage.checkSupport();
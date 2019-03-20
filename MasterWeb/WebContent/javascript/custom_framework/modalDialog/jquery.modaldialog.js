/*
 * jQuery Modal Dialog plugin 1.0
 * Released: July 14, 2008
 * 
 * Copyright (c) 2008 Chris Winberry
 * Email: transistech@gmail.com
 * 
 * Original Design: Michael Leigeber
 * http://www.leigeber.com/2008/04/custom-javascript-dialog-boxes/
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * @license http://www.opensource.org/licenses/mit-license.php
 * @license http://www.gnu.org/licenses/gpl.html
 * @project jquery.modaldialog
 */
(function($) {
	var modaldialog = { };

	// Creates and shows the modal dialog
	function showDialog (msg, options) {
		// Make sure the dialog type is valid. If not assign the default one (the first)
		if(!$.inArray(options.type, modaldialog.DialogTypes)) {
			options.type = modaldialog.DialogTypes[0];
		};

		// Merge default title (per type), default settings, and user defined settings
		var settings = $.extend({ title: modaldialog.DialogTitles[options.type] }, modaldialog.defaults, options);

		// If there's no timeout, make sure the close button is show (or the dialog can't close)
		settings.timeout = (typeof(settings.timeout) == "undefined") ? 0 : settings.timeout;
		settings.showClose = ((typeof(settings.showClose) == "undefined") | !settings.timeout) ? true : !!settings.showClose;

		// Check if the dialog elements exist and create them if not
		if (!document.getElementById('dialog')) {
			dialog = document.createElement('div');
			dialog.id = 'dialog';
			$(dialog).html(
				"<div id='dialog-header'>" +
					"<div id='dialog-title'></div>" +
					"<div id='dialog-close'></div>" +
				"</div>" +
				"<div id='dialog-content'>" +
					"<div id='dialog-content-inner' />" +
					"<div id='dialog-button-container'>" +
						"<input type='button' id='dialog-button' value='Close'>" +
					"</div>" +
				"</div>"
				);
			
			dialogmask = document.createElement('div');
			dialogmask.id = 'dialog-mask';
			
			$(dialogmask).hide();
			$(dialog).hide();
			
			document.body.appendChild(dialogmask);
			document.body.appendChild(dialog);

			// Set the click event for the "x" and "Close" buttons			
			$("#dialog-close").click(modaldialog.hide);
			$("#dialog-button").click(modaldialog.hide);
		}

		var dl = $('#dialog');
		var dlh = $('#dialog-header');
		var dlc = $('#dialog-content');
		var dlb = $('#dialog-button');

		$('#dialog-title').html(settings.title);
		$('#dialog-content-inner').html(msg);

		// Center the dialog in the window but make sure it's at least 25 pixels from the top
		// Without that check, dialogs that are taller than the visible window risk
		// having the close buttons off-screen, rendering the dialog unclosable 

		var scrollTopPos = f_scrollTop();
		var scrollLeftPos = f_scrollLeft();

		dl.css('width', settings.width);
		var dialogTop = Math.abs(scrollTopPos + ($(window).height()/2) - (dl.height()/2));
		dl.css("position", "absolute");
		dl.css('left', (scrollLeftPos + ($(window).width()/2) - (dl.width()/2)));
		dl.css('top', (dialogTop >= 25) ? dialogTop : 25);

		// fix - dropDownList z-index
		jQuery(".searchScreen").hide();
		jQuery(".centeredPanel").hide();

		// Clear the dialog-type classes and add the current dialog-type class		
		$.each(modaldialog.DialogTypes, function () { dlh.removeClass(this + "header") });
		dlh.addClass(settings.type + "header")
		$.each(modaldialog.DialogTypes, function () { dlc.removeClass(this) });
		dlc.addClass(settings.type);
		$.each(modaldialog.DialogTypes, function () { dlb.removeClass(this + "button") });
		dlb.addClass(settings.type + "button")

		if (!settings.showClose) {
			$('#dialog-close').hide();
			$('#dialog-button-container').hide();
		} else {
			$('#dialog-close').show();
			$('#dialog-button-container').show();
		}

		if (settings.timeout) {
			// fix - dropDownList z-index
			window.setTimeout("$('#dialog').fadeOut('slow', 0); $('#dialog-mask').fadeOut('normal', 0); jQuery('.searchScreen').fadeIn('normal'); jQuery('.centeredPanel').fadeIn('normal');", (settings.timeout * 1000));
		}
		
		dl.fadeIn("slow");
		$('#dialog-mask').fadeIn("normal");
	};

	modaldialog.error = function $$modaldialog$error (msg, options) {
		if (typeof(options) == "undefined") {
			options = { };
		}
		options['type'] = "error";
		return(showDialog(msg, options));
	}
	modaldialog.warning = function $$modaldialog$error (msg, options) {
		if (typeof(options) == "undefined") {
			options = { };
		}
		options['type'] = "warning";
		return(showDialog(msg, options));
	}
	modaldialog.success = function $$modaldialog$error (msg, options) {
		if (typeof(options) == "undefined") {
			options = { };
		}
		options['type'] = "success";
		return(showDialog(msg, options));
	}
	modaldialog.prompt = function $$modaldialog$error (msg, options) {
		if (typeof(options) == "undefined") {
			options = { };
		}
		options['type'] = "prompt";
		return(showDialog(msg, options));
	}

	modaldialog.hide = function $$modaldialog$hide () {
		$('#dialog').fadeOut("slow", function () { $(this).hide(0); });
		$('#dialog-mask').fadeOut("normal", function () { $(this).hide(0); });
	};

	modaldialog.DialogTypes = new Array("error", "warning", "success", "prompt");
	modaldialog.DialogTitles = {
		"error": "!! Error !!"
		, "warning": "Warning!"
		, "success": "Success"
		, "prompt": "Please Choose"
	};

	modaldialog.defaults = {
		timeout: 0
		, showClose: true
		, width: 525
	};

	$.extend({ modaldialog: modaldialog });
})(jQuery);

function f_scrollLeft() {
	return f_filterResults (
		window.pageXOffset ? window.pageXOffset : 0,
		document.documentElement ? document.documentElement.scrollLeft : 0,
		document.body ? document.body.scrollLeft : 0
	);
}

function f_scrollTop() {
	return f_filterResults (
		window.pageYOffset ? window.pageYOffset : 0,
		document.documentElement ? document.documentElement.scrollTop : 0,
		document.body ? document.body.scrollTop : 0
	);
}

function f_filterResults(n_win, n_docel, n_body) {
	var n_result = n_win ? n_win : 0;
	if (n_docel && (!n_result || (n_result > n_docel)))
		n_result = n_docel;
	return n_body && (!n_result || (n_result > n_body)) ? n_body : n_result;
}
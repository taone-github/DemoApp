/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 201612191556
* apply AdminLTE theme for responsive2016
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
if (typeof jQuery === "undefined") {
  throw new Error("FrontWeb requires jQuery");
}

MASTERWEB_CONTEXTES = ['/MasterWeb'];
MASTERWEB_CTX = '/MasterWeb';

//customizing AdminLTE
if($.AdminLTE) {
	
	// enableBSToppltip = false =>  disabled auto tooltip
	$.AdminLTE.options.enableBSToppltip = false;
}

/*
 * bootstrap-formhelpers.js v2.3.0
 */
var BFHCountriesList = {
		  'AF': 'Afghanistan',
		  'AL': 'Albania',
		  'DZ': 'Algeria',
		  'AS': 'American Samoa',
		  'AD': 'Andorra',
		  'AO': 'Angola',
		  'AI': 'Anguilla',
		  'AQ': 'Antarctica',
		  'AG': 'Antigua and Barbuda',
		  'AR': 'Argentina',
		  'AM': 'Armenia',
		  'AW': 'Aruba',
		  'AU': 'Australia',
		  'AT': 'Austria',
		  'AZ': 'Azerbaijan',
		  'BH': 'Bahrain',
		  'BD': 'Bangladesh',
		  'BB': 'Barbados',
		  'BY': 'Belarus',
		  'BE': 'Belgium',
		  'BZ': 'Belize',
		  'BJ': 'Benin',
		  'BM': 'Bermuda',
		  'BT': 'Bhutan',
		  'BO': 'Bolivia',
		  'BA': 'Bosnia and Herzegovina',
		  'BW': 'Botswana',
		  'BV': 'Bouvet Island',
		  'BR': 'Brazil',
		  'IO': 'British Indian Ocean Territory',
		  'VG': 'British Virgin Islands',
		  'BN': 'Brunei',
		  'BG': 'Bulgaria',
		  'BF': 'Burkina Faso',
		  'BI': 'Burundi',
		  'CI': 'Côte d\'Ivoire',
		  'KH': 'Cambodia',
		  'CM': 'Cameroon',
		  'CA': 'Canada',
		  'CV': 'Cape Verde',
		  'KY': 'Cayman Islands',
		  'CF': 'Central African Republic',
		  'TD': 'Chad',
		  'CL': 'Chile',
		  'CN': 'China',
		  'CX': 'Christmas Island',
		  'CC': 'Cocos (Keeling) Islands',
		  'CO': 'Colombia',
		  'KM': 'Comoros',
		  'CG': 'Congo',
		  'CK': 'Cook Islands',
		  'CR': 'Costa Rica',
		  'HR': 'Croatia',
		  'CU': 'Cuba',
		  'CY': 'Cyprus',
		  'CZ': 'Czech Republic',
		  'CD': 'Democratic Republic of the Congo',
		  'DK': 'Denmark',
		  'DJ': 'Djibouti',
		  'DM': 'Dominica',
		  'DO': 'Dominican Republic',
		  'TP': 'East Timor',
		  'EC': 'Ecuador',
		  'EG': 'Egypt',
		  'SV': 'El Salvador',
		  'GQ': 'Equatorial Guinea',
		  'ER': 'Eritrea',
		  'EE': 'Estonia',
		  'ET': 'Ethiopia',
		  'FO': 'Faeroe Islands',
		  'FK': 'Falkland Islands',
		  'FJ': 'Fiji',
		  'FI': 'Finland',
		  'MK': 'Former Yugoslav Republic of Macedonia',
		  'FR': 'France',
		  'FX': 'France, Metropolitan',
		  'GF': 'French Guiana',
		  'PF': 'French Polynesia',
		  'TF': 'French Southern Territories',
		  'GA': 'Gabon',
		  'GE': 'Georgia',
		  'DE': 'Germany',
		  'GH': 'Ghana',
		  'GI': 'Gibraltar',
		  'GR': 'Greece',
		  'GL': 'Greenland',
		  'GD': 'Grenada',
		  'GP': 'Guadeloupe',
		  'GU': 'Guam',
		  'GT': 'Guatemala',
		  'GN': 'Guinea',
		  'GW': 'Guinea-Bissau',
		  'GY': 'Guyana',
		  'HT': 'Haiti',
		  'HM': 'Heard and Mc Donald Islands',
		  'HN': 'Honduras',
		  'HK': 'Hong Kong',
		  'HU': 'Hungary',
		  'IS': 'Iceland',
		  'IN': 'India',
		  'ID': 'Indonesia',
		  'IR': 'Iran',
		  'IQ': 'Iraq',
		  'IE': 'Ireland',
		  'IL': 'Israel',
		  'IT': 'Italy',
		  'JM': 'Jamaica',
		  'JP': 'Japan',
		  'JO': 'Jordan',
		  'KZ': 'Kazakhstan',
		  'KE': 'Kenya',
		  'KI': 'Kiribati',
		  'KW': 'Kuwait',
		  'KG': 'Kyrgyzstan',
		  'LA': 'Laos',
		  'LV': 'Latvia',
		  'LB': 'Lebanon',
		  'LS': 'Lesotho',
		  'LR': 'Liberia',
		  'LY': 'Libya',
		  'LI': 'Liechtenstein',
		  'LT': 'Lithuania',
		  'LU': 'Luxembourg',
		  'MO': 'Macau',
		  'MG': 'Madagascar',
		  'MW': 'Malawi',
		  'MY': 'Malaysia',
		  'MV': 'Maldives',
		  'ML': 'Mali',
		  'MT': 'Malta',
		  'MH': 'Marshall Islands',
		  'MQ': 'Martinique',
		  'MR': 'Mauritania',
		  'MU': 'Mauritius',
		  'YT': 'Mayotte',
		  'MX': 'Mexico',
		  'FM': 'Micronesia',
		  'MD': 'Moldova',
		  'MC': 'Monaco',
		  'MN': 'Mongolia',
		  'ME': 'Montenegro',
		  'MS': 'Montserrat',
		  'MA': 'Morocco',
		  'MZ': 'Mozambique',
		  'MM': 'Myanmar',
		  'NA': 'Namibia',
		  'NR': 'Nauru',
		  'NP': 'Nepal',
		  'NL': 'Netherlands',
		  'AN': 'Netherlands Antilles',
		  'NC': 'New Caledonia',
		  'NZ': 'New Zealand',
		  'NI': 'Nicaragua',
		  'NE': 'Niger',
		  'NG': 'Nigeria',
		  'NU': 'Niue',
		  'NF': 'Norfolk Island',
		  'KP': 'North Korea',
		  'MP': 'Northern Marianas',
		  'NO': 'Norway',
		  'OM': 'Oman',
		  'PK': 'Pakistan',
		  'PW': 'Palau',
		  'PS': 'Palestine',
		  'PA': 'Panama',
		  'PG': 'Papua New Guinea',
		  'PY': 'Paraguay',
		  'PE': 'Peru',
		  'PH': 'Philippines',
		  'PN': 'Pitcairn Islands',
		  'PL': 'Poland',
		  'PT': 'Portugal',
		  'PR': 'Puerto Rico',
		  'QA': 'Qatar',
		  'RE': 'Reunion',
		  'RO': 'Romania',
		  'RU': 'Russia',
		  'RW': 'Rwanda',
		  'ST': 'São Tomé and Príncipe',
		  'SH': 'Saint Helena',
		  'PM': 'St. Pierre and Miquelon',
		  'KN': 'Saint Kitts and Nevis',
		  'LC': 'Saint Lucia',
		  'VC': 'Saint Vincent and the Grenadines',
		  'WS': 'Samoa',
		  'SM': 'San Marino',
		  'SA': 'Saudi Arabia',
		  'SN': 'Senegal',
		  'RS': 'Serbia',
		  'SC': 'Seychelles',
		  'SL': 'Sierra Leone',
		  'SG': 'Singapore',
		  'SK': 'Slovakia',
		  'SI': 'Slovenia',
		  'SB': 'Solomon Islands',
		  'SO': 'Somalia',
		  'ZA': 'South Africa',
		  'GS': 'South Georgia and the South Sandwich Islands',
		  'KR': 'South Korea',
		  'ES': 'Spain',
		  'LK': 'Sri Lanka',
		  'SD': 'Sudan',
		  'SR': 'Suriname',
		  'SJ': 'Svalbard and Jan Mayen Islands',
		  'SZ': 'Swaziland',
		  'SE': 'Sweden',
		  'CH': 'Switzerland',
		  'SY': 'Syria',
		  'TW': 'Taiwan',
		  'TJ': 'Tajikistan',
		  'TZ': 'Tanzania',
		  'TH': 'Thailand',
		  'BS': 'The Bahamas',
		  'GM': 'The Gambia',
		  'TG': 'Togo',
		  'TK': 'Tokelau',
		  'TO': 'Tonga',
		  'TT': 'Trinidad and Tobago',
		  'TN': 'Tunisia',
		  'TR': 'Turkey',
		  'TM': 'Turkmenistan',
		  'TC': 'Turks and Caicos Islands',
		  'TV': 'Tuvalu',
		  'VI': 'US Virgin Islands',
		  'UG': 'Uganda',
		  'UA': 'Ukraine',
		  'AE': 'United Arab Emirates',
		  'GB': 'United Kingdom',
		  'US': 'United States',
		  'UM': 'United States Minor Outlying Islands',
		  'UY': 'Uruguay',
		  'UZ': 'Uzbekistan',
		  'VU': 'Vanuatu',
		  'VA': 'Vatican City',
		  'VE': 'Venezuela',
		  'VN': 'Vietnam',
		  'WF': 'Wallis and Futuna Islands',
		  'EH': 'Western Sahara',
		  'YE': 'Yemen',
		  'ZM': 'Zambia',
		  'ZW': 'Zimbabwe'
		};

var BFHLanguagesList = {
		  'om': 'Afaan Oromoo',
		  'aa': 'Afaraf',
		  'af': 'Afrikaans',
		  'ak': 'Akan',
		  'an': 'aragonés',
		  'ig': 'Asụsụ Igbo',
		  'gn': 'Avañe\'ẽ',
		  'ae': 'avesta',
		  'ay': 'aymar aru',
		  'az': 'azərbaycan dili',
		  'id': 'Bahasa Indonesia',
		  'ms': 'bahasa Melayu',
		  'bm': 'bamanankan',
		  'jv': 'basa Jawa',
		  'su': 'Basa Sunda',
		  'bi': 'Bislama',
		  'bs': 'bosanski jezik',
		  'br': 'brezhoneg',
		  'ca': 'català',
		  'ch': 'Chamoru',
		  'ny': 'chiCheŵa',
		  'sn': 'chiShona',
		  'co': 'corsu',
		  'cy': 'Cymraeg',
		  'da': 'dansk',
		  'se': 'Davvisámegiella',
		  'de': 'Deutsch',
		  'nv': 'Diné bizaad',
		  'et': 'eesti',
		  'na': 'Ekakairũ Naoero',
		  'en': 'English',
		  'es': 'español',
		  'eo': 'Esperanto',
		  'eu': 'euskara',
		  'ee': 'Eʋegbe',
		  'to': 'faka Tonga',
		  'mg': 'fiteny malagasy',
		  'fr': 'français',
		  'fy': 'Frysk',
		  'ff': 'Fulfulde',
		  'fo': 'føroyskt',
		  'ga': 'Gaeilge',
		  'gv': 'Gaelg',
		  'sm': 'gagana fa\'a Samoa',
		  'gl': 'galego',
		  'sq': 'gjuha shqipe',
		  'gd': 'Gàidhlig',
		  'ki': 'Gĩkũyũ',
		  'ha': 'Hausa',
		  'ho': 'Hiri Motu',
		  'hr': 'hrvatski jezik',
		  'io': 'Ido',
		  'rw': 'Ikinyarwanda',
		  'rn': 'Ikirundi',
		  'ia': 'Interlingua',
		  'nd': 'isiNdebele',
		  'nr': 'isiNdebele',
		  'xh': 'isiXhosa',
		  'zu': 'isiZulu',
		  'it': 'italiano',
		  'ik': 'Iñupiaq',
		  'pl': 'polski',
		  'mh': 'Kajin M̧ajeļ',
		  'kl': 'kalaallisut',
		  'kr': 'Kanuri',
		  'kw': 'Kernewek',
		  'kg': 'KiKongo',
		  'sw': 'Kiswahili',
		  'ht': 'Kreyòl ayisyen',
		  'kj': 'Kuanyama',
		  'ku': 'Kurdî',
		  'la': 'latine',
		  'lv': 'latviešu valoda',
		  'lt': 'lietuvių kalba',
		  'ro': 'limba română',
		  'li': 'Limburgs',
		  'ln': 'Lingála',
		  'lg': 'Luganda',
		  'lb': 'Lëtzebuergesch',
		  'hu': 'magyar',
		  'mt': 'Malti',
		  'nl': 'Nederlands',
		  'no': 'Norsk',
		  'nb': 'Norsk bokmål',
		  'nn': 'Norsk nynorsk',
		  'uz': 'O\'zbek',
		  'oc': 'occitan',
		  'ie': 'Interlingue',
		  'hz': 'Otjiherero',
		  'ng': 'Owambo',
		  'pt': 'português',
		  'ty': 'Reo Tahiti',
		  'rm': 'rumantsch grischun',
		  'qu': 'Runa Simi',
		  'sc': 'sardu',
		  'za': 'Saɯ cueŋƅ',
		  'st': 'Sesotho',
		  'tn': 'Setswana',
		  'ss': 'SiSwati',
		  'sl': 'slovenski jezik',
		  'sk': 'slovenčina',
		  'so': 'Soomaaliga',
		  'fi': 'suomi',
		  'sv': 'Svenska',
		  'mi': 'te reo Māori',
		  'vi': 'Tiếng Việt',
		  'lu': 'Tshiluba',
		  've': 'Tshivenḓa',
		  'tw': 'Twi',
		  'tk': 'Türkmen',
		  'tr': 'Türkçe',
		  'ug': 'Uyƣurqə',
		  'vo': 'Volapük',
		  'fj': 'vosa Vakaviti',
		  'wa': 'walon',
		  'tl': 'Wikang Tagalog',
		  'wo': 'Wollof',
		  'ts': 'Xitsonga',
		  'yo': 'Yorùbá',
		  'sg': 'yângâ tî sängö',
		  'is': 'Íslenska',
		  'cs': 'čeština',
		  'el': 'ελληνικά',
		  'av': 'авар мацӀ',
		  'ab': 'аҧсуа бызшәа',
		  'ba': 'башҡорт теле',
		  'be': 'беларуская мова',
		  'bg': 'български език',
		  'os': 'ирон æвзаг',
		  'kv': 'коми кыв',
		  'ky': 'Кыргызча',
		  'mk': 'македонски јазик',
		  'mn': 'монгол',
		  'ce': 'нохчийн мотт',
		  'ru': 'русский язык',
		  'sr': 'српски језик',
		  'tt': 'татар теле',
		  'tg': 'тоҷикӣ',
		  'uk': 'українська мова',
		  'cv': 'чӑваш чӗлхи',
		  'cu': 'ѩзыкъ словѣньскъ',
		  'kk': 'қазақ тілі',
		  'hy': 'Հայերեն',
		  'yi': 'ייִדיש',
		  'he': 'עברית',
		  'ur': 'اردو',
		  'ar': 'العربية',
		  'fa': 'فارسی',
		  'ps': 'پښتو',
		  'ks': 'कश्मीरी',
		  'ne': 'नेपाली',
		  'pi': 'पाऴि',
		  'bh': 'भोजपुरी',
		  'mr': 'मराठी',
		  'sa': 'संस्कृतम्',
		  'sd': 'सिन्धी',
		  'hi': 'हिन्दी',
		  'as': 'অসমীয়া',
		  'bn': 'বাংলা',
		  'pa': 'ਪੰਜਾਬੀ',
		  'gu': 'ગુજરાતી',
		  'or': 'ଓଡ଼ିଆ',
		  'ta': 'தமிழ்',
		  'te': 'తెలుగు',
		  'kn': 'ಕನ್ನಡ',
		  'ml': 'മലയാളം',
		  'si': 'සිංහල',
		  'th': 'ไทย',
		  'lo': 'ພາສາລາວ',
		  'bo': 'བོད་ཡིག',
		  'dz': 'རྫོང་ཁ',
		  'my': 'ဗမာစာ',
		  'ka': 'ქართული',
		  'ti': 'ትግርኛ',
		  'am': 'አማርኛ',
		  'iu': 'ᐃᓄᒃᑎᑐᑦ',
		  'oj': 'ᐊᓂᔑᓈᐯᒧᐎᓐ',
		  'cr': 'ᓀᐦᐃᔭᐍᐏᐣ',
		  'km': 'ខ្មែរ',
		  'zh': '中文 (Zhōngwén)',
		  'ja': '日本語 (にほんご)',
		  'ii': 'ꆈꌠ꒿ Nuosuhxop',
		  'ko': '한국어 (韓國語)'
		};
/* LANGUAGES HELPERS
 * ============== */
String.prototype.toProperCase = function () {
  return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};

$.fn.languagesList = function () {
	return this.each(function () {
		$this = $(this);
		$options = $this.find('[role=option]');
		
		$options.each(function () {
			$this = $(this);
			$language = $this.attr('lang');
			$country = $this.attr('country');
			
			//$this.html('<i class="glyphicon bfh-flag-' + $country + '"></i> ' + BFHLanguagesList[$language].toProperCase());
			//MD request remove flag
			$this.html('<span style="margin:5px"></span>'+BFHLanguagesList[$language].toProperCase());
		});
	});
}

$.FrontWeb = {
	_resizeMainPage : function () {
		var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
		var window_height = $(window).height();
		var mobileMenu_height = 0;//$('#mobileMenu').is(':visible') ? $('#mobileMenu').outerHeight() : 0;
		var initH = window_height - neg - mobileMenu_height;
		$('#mainPage').attr("height", initH);
		$('.sidebar-menu').attr('style','height:'+initH+'px');
		
		console.log('initial height window_height:' + window_height + ' main-header:' +$('.main-header').outerHeight()  + ' height:' + (initH));
	},
	
	_fix : function () {
		var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
		var window_height = $(window).height();
		var mobileMenu_height = 0;//$('#mobileMenu').is(':visible') ? $('#mobileMenu').outerHeight() : 0;
		
		$(".content-wrapper, .right-side").css('height', window_height - neg - mobileMenu_height);
	},
	
	_pageloader : {
		show : function () {
			//$('#mainPage').css( "opacity", 0.5 )
			$('#mainPage').fadeOut('fast');
			
			//$('#app-loader').css({
			//	'top': $(document).scrollTop() + ($('#mainPage').height()/4)+ 'px',
			//	'left': $('div.content-wrapper').offset().left + ($('div.content-wrapper').width()/2) - 55 + 'px'
			//})
			
			$('#app-loader').fadeIn();
		},
		hide : function () {
			$('#mainPage').fadeIn();
			//$('#mainPage').css( "opacity", 1)
		    $('#app-loader').css('display', 'none');
		}
	},
	
	_version : function () {
		var MAJORVERSION="@MAJORVERSION@";
		var MINORVERSION="@MINORVERSION@";
		var BUILDDATE="@BUILDDATE@";
		var BUILDID="@BUILDID@";
		var BANNER="@BANNER@";
		var MICROVERSION="@MICROVERSION@";
		
		alert('Version: ' + MAJORVERSION + '.' + MINORVERSION + '.' + MICROVERSION + '_r' + BUILDID + '\nDate: ' + BUILDDATE);
	},
	
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * FIX : 201802151405 : when chage language then redirect current page to first page of current menu
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	_switchLanguage: function (locale, obj) {
		var i = 0;
		
		var $activeMenu = $(".treeview .active");
		
		var el = document.getElementById('mainPage');
		console.log("action="+el.contentWindow.switch_lang_action);
		if(el.contentWindow.switch_lang_action=='PAGE'){
			showLoader();
		}else{
			if($activeMenu.length != 1) {
				showLoader();
			} else {
				var confirmMessage = "";
				if(el.contentWindow) {
					confirmMessage = el.contentWindow.ONEWEB_SYSTEM_MSG.CONFIRM_CHANGE_LANG;
				} else if(el.contentDocument) {
					confirmMessage = el.contentDocument.ONEWEB_SYSTEM_MSG.CONFIRM_CHANGE_LANG;
				}
				if(confirmMessage && confirmMessage.length > 0 && !confirm(confirmMessage)) {
					return;
				}
			}
		}
		
		$(MASTERWEB_CONTEXTES).each(function() {
			$.ajax({
				   type: "GET",
				   url: this + '/ManualServlet?className=manual.eaf.lang.SwitchLangServlet&localLang=' + locale,
				   data: null,
				   async:   false,
				   success: function(data) {
					   
					   i++;
					   
					   if(i == MASTERWEB_CONTEXTES.length) {
							$('#defaltLang').html($(obj).html())
							//top.mainPage.location.reload();
							if(el.contentWindow.switch_lang_action=='PAGE'){
								top.mainPage.location.reload();
							}else{
								if($activeMenu.length == 1) {
									top.mainPage.location = $activeMenu.find('a').attr('href');
									showLoader();
								} else {
									top.mainPage.location.reload();
								}
							}
					   }
				   }
				});
		});
		if(el.contentWindow.switch_lang_action=='PAGE'){
			hideLoader();
		}else{
			if($activeMenu.length != 1) {
				hideLoader();
			}
		}
	}
};

showLoader = function() {
	$.FrontWeb._pageloader.show();
};

hideLoader = function() {
	$.FrontWeb._pageloader.hide();
};

$(function () {
	"use strict";
	
	// initial side menu tooltip
	$('.sidebar-menu .treeview a').tooltip({
		position: {
			my: "left+10 top-5",
			at: "left bottom",
			collision: "flipfit flipfit"
		}
	});
	
	$('.langs-menu').languagesList();
	
	// resize iframe#mainPage to fit window size
	$.FrontWeb._resizeMainPage();
	
	// resize iframe#mainPage to fit window size 
	// (when resizing window)
	$(window, ".wrapper").resize(function () {
		setTimeout(function(){
			$('#mainPage').attr("height", '0px');
			$(".content-wrapper, .right-side").css('height', '0px').css('min-height', '0px');
			
			var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
			var window_height = $(window).height();
			var mobileMenu_height = 0;//$('#mobileMenu').is(':visible') ? $('#mobileMenu').outerHeight() : 0;
			var height = window_height - neg - mobileMenu_height;
			
			$(".content-wrapper, .right-side").css('height', height);
			$('#mainPage').attr("height", height);
			$('.sidebar-menu').attr('style','height:'+height+'px');
			
			console.log('adjust height window_height:' + window_height + ' main-header:' +$('.main-header').outerHeight()  + ' height:' + height);
			
		}, 100);
	});
	
	
	$('#mainPage').ready(function () {
		hideLoader();
	});

	$('#mainPage').load(function () {
		hideLoader();
	});
	
	$(document).keydown(function (e) {  
    	//block F5
        return (e.which || e.keyCode) != 116;  
    });  

});

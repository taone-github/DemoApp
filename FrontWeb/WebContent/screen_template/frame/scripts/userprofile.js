// userprofile.js
// user profile management.

var UTYPE_ADMIN = 1;
var UTYPE_STAFF = 2;
var UTYPE_COMPANY = 4;
var UTYPE_EXECUTIVE = 8;
var UTYPE_GUEST = 128;
var UTYPE_ALLSTAFF = UTYPE_ADMIN + UTYPE_STAFF + UTYPE_COMPANY + UTYPE_EXECUTIVE;
var UTYPE_ALL = UTYPE_ALLSTAFF + UTYPE_GUEST;

var profileList = new Array();
profileList["admin"] = new profile("0001", "Administrator", UTYPE_ADMIN);
profileList["motif"] = new profile("0403", "Motif Technology", UTYPE_COMPANY);
profileList["staff"] = new profile("2005", "Staff", UTYPE_STAFF);
profileList["exec"] = new profile("0026", "Executive", UTYPE_EXECUTIVE);
profileList["guest"] = new profile("9999", "Guest", UTYPE_GUEST);

function profile(id, fullname, type)
{
	this.userID = id;
	this.fullName = fullname;
	this.userType = type;
}

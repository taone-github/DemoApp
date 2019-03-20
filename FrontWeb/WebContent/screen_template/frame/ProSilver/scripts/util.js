// Utility file.
var undefined;

function SetCookie(sName, sValue)
{
  document.cookie = sName + "=" + escape(sValue) + ";";
}

function GetCookie(sName)
{
  // cookies are separated by semicolons
  var aCookie = document.cookie.split(";");
  for (var i=0; i < aCookie.length; i++)
  {
    // a name/value pair (a crumb) is separated by an equal sign
    var aCrumb = aCookie[i].split("=");
    var aA = aCrumb[0].split(" ");
    if (sName == aA[0] || (aA.length > 1 && sName == aA[1]))
      return unescape(aCrumb[1]);
  }

  // a cookie with the requested name does not exist
  return null;
}

var SEARCHLOCATION = '';
var SEARCHBRANCH = "";
var SEARCHDISTRICT = "";
var SEARCH = "";
var DOMAIN = "";

/**
 * setCookie
 */
function setCookie(name, value){ 
	var argv = setCookie.arguments;
	var argc = setCookie.arguments.length;
	//此处可暂时不理会,便于cookie存活周期。
	var expires = "ck";
	if(expires!=null)
	{
		var LargeExpDate = new Date ();
		LargeExpDate.setTime(LargeExpDate.getTime() + (1000*3600*24*7));
	}
	// document.cookie = name + "=" + encodeURI(value)+((expires == null) ? "" : ("; expires=" +LargeExpDate.toGMTString()))+";
	// path =/;domain="+DOMAIN;
	document.cookie = name + "=" + encodeURI(value)+((expires == null) ? "" : ("; expires=" +LargeExpDate.toGMTString()))+";path =/";
}

/**
 * getCookie
 */
function getCookie(Name) {   
	var search = Name + "=";
	if(document.cookie.length > 0)
	{
		offset = document.cookie.indexOf(search);
		if(offset != -1){
			offset +=  search.length;
			end = document.cookie.indexOf(";", offset);
			if(end == -1) end = document.cookie.length;
			//转码并且过滤双引号
			return decodeURI(document.cookie.substring(offset, end)).replace(/\"/g, '');
		}
		else return "";
	}else{
		return "";
	}
}

/**
 * deleteCookie
 * 
 */   
function deleteCookie(name) {
	var expdate = new Date();
	expdate.setTime(expdate.getTime() - (86400 * 1000 * 1));
	setCookie(name, "", expdate);
}
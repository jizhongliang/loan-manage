String.prototype.trim = function () {
	return this.replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
}

FsUtils = function() {
	
}

FsUtils.isEmpty = function() {
	if (arguments.length == 0) {
		return true;
	}
	for (var i = 0; i < arguments.length; i++) {
		var val = arguments[i];
		if (val == null || val == undefined || val == "undefined") {
			return true;
		}
		if(val instanceof Array){
			return false;
		}
		if (val.toString().trim() == "") {
			return true;
		}
	}
	return false;
}

FsUtils.progressStarting = function() {
	$.messager.progress({title:'请稍候',msg:'努力加载中',interval:1000});
}

FsUtils.progressClose = function() {
	$.messager.progress('close');
}


FsUtils.formatDate = function(date, fmt) {
	var o = {
		"M+" : date.getMonth() + 1, // 月份
		"d+" : date.getDate(), // 日
		"h+" : date.getHours(), // 小时
		"m+" : date.getMinutes(), // 分
		"s+" : date.getSeconds(), // 秒
		"q+" : Math.floor((date.getMonth() + 3) / 3), // 季度
		"S" : date.getMilliseconds()
	// 毫秒
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

var Dates = {};
FsUtils.now = function(timestamp, format){
    var De = new Date((timestamp|0) ? function(tamp){
            return tamp < 86400000 ? (+new Date + tamp*86400000) : tamp;
        }(parseInt(timestamp)) : +new Date);
    return Dates.parse(
        [De.getFullYear(), De.getMonth()+1, De.getDate()],
        [De.getHours(), De.getMinutes(), De.getSeconds()],
        format
    );
};

Dates.parse = function(ymd, hms, format){
    ymd = ymd.concat(hms); // [year, month, day, hour, minute, second]
    format = format || (Dates.options ? Dates.options.format : config.format);
    return format.replace(/YYYY|MM|DD|hh|mm|ss/g, function(str, index){
        var pos = -1;
        if (str === 'YYYY') {
            pos = 0;
        } else if (str === 'MM') {
            pos = 1;
        } else if (str === 'DD') {
            pos = 2;
        } else if (str === 'hh') {
            pos = 3;
        } else if (str === 'mm') {
            pos = 4;
        } else if (str === 'ss') {
            pos = 5;
        }
        return Dates.digit(ymd[pos]);
    });
};
//补齐数位
Dates.digit = function(num){
    return num < 10 ? '0' + (num|0) : num;
};
FsUtils.arrayShift = function(array, srcIndex, toIndex) {
	if (FsUtils.isEmpty(array, srcIndex, toIndex)) {
		return;
	}
	var srcObj = array[srcIndex];
	var toObj = array[toIndex];
	array[srcIndex] = toObj;
	array[toIndex] = srcObj;
}

FsUtils.arrayForward = function(array, srcIndex) {
	if (srcIndex < 1) {
		return;
	}
	FsUtils.arrayShift(array, srcIndex, srcIndex - 1);
}

FsUtils.arrayAfterward = function(array, srcIndex) {
	if (srcIndex < 1) {
		return;
	}
	FsUtils.arrayShift(array, srcIndex, srcIndex - 1);
}

FsUtils.arrayRemove = function(array, index) {
	if (FsUtils.isEmpty(array, index)) {
		return;
	}
	if (index < 0 || index >= array.length) {
		return;
	}
	var newArray = new Array();
	var ni = 0;
	for (var i = 0; i < array.length; i++) {
		if (i == index) {
			continue;
		}
		newArray[ni] = array[i];
		ni++;
	}
	array.pop();
	for (var i = 0; i < newArray.length; i++) {
		array[i] = newArray[i];
	}
}

FsUtils.dateAdd=function(date,value){
	var newDate=new Date(date.valueOf()+(value*1000));
}

function tounicode(str){
    var unStr ="";
    if(!FsUtils.isEmpty(str)){
        var res=[];
        for(var i=0;i < str.length;i++){
            res[i]=("00"+str.charCodeAt(i).toString(16)).slice(-4);
        }
        unStr = "\\u"+res.join("\\u");
    }
    return unStr;
}

function decodeUnicode(str) {
    str = str.replace(/\\/g, "%");
    return unescape(str);
}

	/**
	 * 当前时间+1天
	 * @param d2
	 * @returns {String}
	 */
	function DateNextDay(str)
    {
    //slice返回一个数组
       	var  d  =  new  Date(str);  
        var  d3  =  new  Date(d.getFullYear(),  d.getMonth(),  d.getDate()+1); 
        var   month=returnMonth(d3.getMonth());   
        var day=d3.getDate();
        day=day<10?"0"+day:day;   
        var str2=d3.getFullYear()+"-"+month+"-"+day;
        return str2;
    }
	
	function DateNextDaySMS(str)
    {
    //slice返回一个数组
       	var  d  =  new  Date(str);  
        var  d3  =  new  Date(d.getFullYear(),  d.getMonth(),  d.getDate()+1); 
        var   month=returnMonth(d3.getMonth());   
        var day=d3.getDate();
        var hour = d.getHours();
        var mini = d.getMinutes();
        var sed= d.getSeconds();
        day=day<10?"0"+day:day;   
        var str2=d3.getFullYear()+"-"+month+"-"+day +" "+hour+":"+mini+":"+sed;
        return str2;
    }
    //返回月份
	function  returnMonth(num){   
	  var   str="";   
	  switch(num){   
	  case   0:   str="01";   break;   
	  case   1:   str="02";   break;   
	  case   2:   str="03";   break;   
	  case   3:   str="04";   break;   
	  case   4:   str="05";   break;   
	  case   5:   str="06";   break;   
	  case   6:   str="07";   break;   
	  case   7:   str="08";   break;   
	  case   8:   str="09";   break;   
	  case   9:   str="10";   break;   
	  case   10:  str="11";   break;   
	  case   11:  str="12";   break;   
	  }   
	  return   str;   
	}

	/**
     * 获取上一个月
     *
     * @date 格式为yyyy-mm-dd的日期，如：2014-01-25
     */
    function getPreMonth(date) {
        var arr = date.split('-');
        var year = arr[0]; //获取当前日期的年份
        var month = arr[1]; //获取当前日期的月份
        var day = arr[2]; //获取当前日期的日
        var days = new Date(year, month, 0);
        days = days.getDate(); //获取当前日期中月的天数
        var year2 = year;
        var month2 = parseInt(month) - 1;
        if (month2 == 0) {
            year2 = parseInt(year2) - 1;
            month2 = 12;
        }
        var day2 = day;
        var days2 = new Date(year2, month2, 0);
        days2 = days2.getDate();
        if (day2 > days2) {
            day2 = days2;
        }
        if (month2 < 10) {
            month2 = '0' + month2;
        }
        var t2 = year2 + '-' + month2 + '-' + day2;
        return t2;
    }


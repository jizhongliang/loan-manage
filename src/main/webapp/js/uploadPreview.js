/*
*插件作者:周祥
*发布时间:2014年12月12日
*插件介绍:图片上传本地预览插件 兼容浏览器(IE 谷歌 火狐) 不支持safari 当然如果是使用这些内核的浏览器基本都兼容
*插件网站:http://jquery.decadework.com
*作  者QQ:200592114
*使用方法:
*界面构造(IMG标签外必须拥有DIV 而且必须给予DIV控件ID)
* <div id="imgdiv"><img id="imgShow" width="120" height="120" /></div>
* <input type="file" id="up_img" />
*调用代码:
* new uploadPreview({ upField: "up_img", divShow: "imgdiv", imgShow: "imgShow" });
*参数说明:
*upField:选择文件控件ID;
*divShow:DIV控件ID;
*imgShow:图片控件ID;
*width:预览宽度;
*height:预览高度;
*imgType:支持文件类型 格式:["jpg","png"];
*callback:选择文件后回调方法;

*版本:v1.4
更新内容如下:
1.修复回调.

*版本:v1.3
更新内容如下:
1.修复多层级框架获取路径BUG.
2.去除对jquery插件的依赖.
*/

/*
*author:周祥
*date:2014年12月12日
*work:图片预览插件
*/
var uploadPreview = function(setting) {
    /*
    *author:周祥
    *date:2014年12月11日
    *work:this(当前对象)
    */
    var _self = this;
    var DEDAULT_UPLOAD_IMG="images/upload.png";
    /*
    *author:周祥
    *date:2014年12月11日
    *work:判断为null或者空值
    */
    _self.IsNull = function(value) {
        if (typeof (value) == "function") { return false; }
        if (value == undefined || value == null || value == "" || value.length == 0) {
            return true;
        }
        return false;
    }
    /*
    *author:周祥
    *date:2014年12月11日
    *work:默认配置
    */
    _self.DefautlSetting = {
        upField: "",
        divShow: "",
        imgShow: "",
		upBtnSize:32,
		rootpath:"",
        width: 100,
        height: 100,
        imgType: ["gif", "jpeg", "jpg", "bmp", "png"],
        errMsg: "选择文件错误,图片类型必须是(gif,jpeg,jpg,bmp,png)中的一种",
		defaultSrc:"",
        callback: function() { }
    };
    /*
    *author:周祥
    *date:2014年12月11日
    *work:读取配置
    */
    _self.Setting = {
        upField: _self.IsNull(setting.upField) ? _self.DefautlSetting.upField : setting.upField,
        upFieldName:setting.upFieldName,
		upBtn:null,
		rootpath:_self.IsNull(setting.rootpath)?_self.DefautlSetting.rootpath:setting.rootpath,
		upBtnSize:_self.IsNull(setting.upBtnSize) ? _self.DefautlSetting.upBtnSize : setting.upBtnSize,
        divShow: _self.IsNull(setting.divShow) ? _self.DefautlSetting.divShow : setting.divShow,
        imgShow: _self.IsNull(setting.imgShow) ? _self.DefautlSetting.imgShow : setting.imgShow,
        width: _self.IsNull(setting.width) ? _self.DefautlSetting.width : setting.width,
        height: _self.IsNull(setting.height) ? _self.DefautlSetting.height : setting.height,
        imgType: _self.IsNull(setting.imgType) ? _self.DefautlSetting.imgType : setting.imgType,
        errMsg: _self.IsNull(setting.errMsg) ? _self.DefautlSetting.errMsg : setting.errMsg,
		defaultSrc:_self.IsNull(setting.defaultSrc) ? _self.DefautlSetting.defaultSrc : setting.defaultSrc,
        callback: _self.IsNull(setting.callback) ? _self.DefautlSetting.callback : setting.callback
    };
	_self.build=function(){
		if(_self.Setting.divShow==null||_self.Setting.divShow==undefined){
			console.log("没有指定 divShow 的容器。");
		}
		var timestamp = (new Date()).valueOf();
		_self.Setting.imgShow="imgShow_"+timestamp;
		_self.Setting.upField="upField_"+timestamp;
		_self.Setting.upBtn="upBtn_"+timestamp;
		$("#"+_self.Setting.divShow).css({
			width:_self.Setting.width+"",
			height:_self.Setting.height+""
		});
		$("#"+_self.Setting.divShow).css("position","relative");
		$("#"+_self.Setting.divShow).append("<img id='"+_self.Setting.imgShow+"'/>");
		$("#"+_self.Setting.divShow).append("<div id='"+_self.Setting.upBtn+"' title='点击选择要上传的图片' style='position:absolute; z-index:2; bottom:0; right:0;width:"+_self.Setting.upBtnSize+"px;height:"+_self.Setting.upBtnSize+"px; background-image:url("+_self.Setting.rootpath+DEDAULT_UPLOAD_IMG+"); background-size:100% 100%'></div>");
		$("#"+_self.Setting.divShow).append("<input type='file' id='"+_self.Setting.upField+"' style=' visibility:hidden' />");
		$("#"+_self.Setting.imgShow).attr({
			width:_self.Setting.width+"",
			height:_self.Setting.height+""
		});
		if(!_self.IsNull(_self.Setting.upFieldName)){
			$("#"+_self.Setting.upField).attr("name",_self.Setting.upFieldName);
		}
		if(!_self.IsNull(_self.Setting.defaultSrc)){
			$("#"+_self.Setting.imgShow).attr("src",_self.Setting.defaultSrc);
		}
		$("#"+_self.Setting.upBtn).click(function(){
			$("#"+_self.Setting.upField).click();
		});
		$("#"+_self.Setting.upBtn).mouseover(function(){
			$(this).css('cursor','hand');
		});
		$("#"+_self.Setting.upBtn).mouseout(function(){
			$(this).css('cursor','pointer');
		});
		$("#"+_self.Setting.upField).change(file_changed);
	}
    /*
    *author:周祥
    *date:2014年12月11日
    *work:获取文本控件URL
    */
    _self.getObjectURL = function(file) {
        var url = null;
        if (window.createObjectURL != undefined) {
            url = window.createObjectURL(file);
        } else if (window.URL != undefined) {
            url = window.URL.createObjectURL(file);
        } else if (window.webkitURL != undefined) {
            url = window.webkitURL.createObjectURL(file);
        }
        return url;
    }
    
	var file_changed=function() {
            if (this.value) {
                if (!RegExp("\.(" + _self.Setting.imgType.join("|") + ")$", "i").test(this.value.toLowerCase())) {
                    alert(_self.Setting.errMsg);
                    this.value = "";
                    return false;
                }
                if (navigator.userAgent.indexOf("MSIE") > -1) {
                    try {
                        document.getElementById(_self.Setting.imgShow).src = _self.getObjectURL(this.files[0]);
                    } catch (e) {
                        var div = document.getElementById(_self.Setting.divShow);
                        this.select();
                        top.parent.document.body.focus();
                        var src = document.selection.createRange().text;
                        document.selection.empty();
                        document.getElementById(_self.Setting.imgShow).style.display = "none";
                        div.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                        div.style.width = _self.Setting.width + "px";
                        div.style.height = _self.Setting.height + "px";
                        div.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = src;
                    }
                } else {
                    document.getElementById(_self.Setting.imgShow).src = _self.getObjectURL(this.files[0]);
                }
                _self.Setting.callback();
            }
        }
		
	if(_self.Setting.upField!=null&&_self.Setting.upField!=undefined){
		$("#"+_self.Setting.upField).change(file_changed);
	}
}
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@include file="/common/common.jspf"%>
	<link rel="stylesheet" href="${path}/common/plugins/webuploader/webuploader.css"/>
	<script type="text/javascript" src="${path}/common/plugins/webuploader/webuploader.min.js"></script>
	<style type="text/css">
		body {background-color: #fff; min-width:350px; font-size: 13px;}
        .table{ text-align: left;}
        .table > div {
            padding: 8px;
            border: none;
            line-height: 30px;
        }
        label{
            display: inline-block;width: 80px;
            border: none;
        }
	</style>
</head>
<body>
<div style="padding: 1em 2em;">
    <form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" onkeydown="if(event.keyCode==13){return false;}">
        <input type="hidden" name="id" id="id" value="${id}">
        <input type="hidden" name="userId" id="userId" value="${userId}">
        <input type="hidden" name="cat" id="cat" value="${cat}">
        <div class="table">
            <%--<div>--%>
                <%--<label for="cat">证明类型:</label>--%>
                <%--<select class="input-leg" name="cat" id="cat"></select>--%>
            <%--</div>--%>
            <div>
                <div><label>图片证明:</label></div>
                <div>
                    <div class="show_img">
                        <ul class="filelist filelist-banner" id="thelist">
                        </ul>
                    </div>
                    <div class="upload-img-banner" id="filePicker"></div>
                    <input type="hidden" name="picUrl" id="picUrl">
                </div>
            </div>
            <div style="text-align: center;clear: both">
                <input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="button" style=" font-size: 13px" data-loading-text="正在保存..." value=" 保 存  ">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name);
    $(function () {
        var id = $("#id").val();
        var userId = $("#userId").val();
        var cat = $("#cat").val();
        $.ajax({
            type: "POST",
            url:"${path}/riskMana/mortgageUser.shtml",
            data:{id:id},
            error: function(request) {
                layer.msg("网络异常，操作失败 ");
            },
            success: function(ret) {
                if(ret.success == true){
                    var data = ret.data;
                    var user = data.userImg;
                    var other = data.otherImg;
                    if (cat == "U"){
                        for (var i=0; i<user.length; i++){
                            initImage(user[i],i);
                        }
                    }else if (cat == "O"){
                        for (var i=0; i<other.length; i++){
                            initImage(other[i],i);
                        }
                    }

                }else{
                    layer.msg("获取失败, "+ret.message);
                }
            }
        });

        $("#submitbtn").click(function () {
            var ele = $(this);
            var img_list = "";
            $('#thelist img').each(function(_i) {
                var val = $(this).attr("data-src");
                if(!FsUtils.isEmpty(val)){
                    var val_str = val+",";
                    img_list += val_str;
                }
            });
            if (FsUtils.isEmpty(img_list)) {
                parent.layer.msg("请上传图片");
                return false;
            }
            $("#picUrl").val(img_list);
            change_Btn_submit(ele);
            $.ajax({
                type: "POST",
                data:$('#form-add').serialize(),
                url:"${path}/riskMana/mortgageUpImage.shtml",
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败");
                    restore_Btn_submit(ele);
                },
                success: function(ret) {
                    if(ret.success==true) {
                        parent.reloadAjax();
                        parent.layer.msg("操作成功!");
                        parent.layer.close(index);
                    }else{
                        parent.layer.msg("操作失败! "+ret.message);
                        restore_Btn_submit(ele);
                    }
                }
            });
        });

        layui.use(['laydate', 'layer'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;
        });
    });

    function change_Btn_submit(_index) {
        _index.attr('disabled', true);
        var _loading = _index.attr('data-loading-text');
        _index.val(_loading);
    }
    function restore_Btn_submit(_index) {
        _index.attr('disabled', false);
        _index.val(' 保 存 ');
    }

    //展示图显示大图
    $(document).on('click', '.pre_img', function(_event) {
        var img_path = $(this).attr("data-src")+"?x-oss-process=image/resize,m_fill,w_178";
        layer.open({
            type: 1,
            title: false,
            closeBtn: 1,
            area: ["355px", '200px'],
            skin: 'layui-layer-nobg', //没有背景色
            shadeClose: true,
            content:"<img src="+img_path+">"
        });
    });

    /*上传图片*/
    var $list=$("#thelist");
    var thumbnailWidth = 80;
    var thumbnailHeight = 80;
    var percentages = {};
    var uploader = WebUploader.create({
        // 选完文件后，是否自动上传。
        auto: true,

        fileSingleSizeLimit: 1*1024*1024,

        duplicate:true,

        // swf文件路径
        swf: '${path}/common/plugins/webuploader/Uploader.swf',

        // 文件接收服务端。
        server: '${path}/uploadMana/uploadMortgageImage.shtml',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker',

        // 只允许选择图片文件。
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/gif,image/jpeg,image/jpg,image/png'
        },
        method:'POST',
    });

    // 当有文件添加进来的时候
    uploader.on( 'fileQueued', function( file ) {
        var $li = $(
            '<li id="' + file.id + '" class="file-item thumbnail">' +
            '<div class="img-single"><p><img></p>' +
            '</div></li>'
            ),
            $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span></div>').appendTo( $li ),
            $img = $li.find('img');

        // $list为容器jQuery实例
        $list.append( $li );

        // 创建缩略图
        // 如果为非图片文件，可以不用调用此方法。
        // thumbnailWidth x thumbnailHeight 为 100 x 100
        uploader.makeThumb( file, function( error, src ) {   //webuploader方法
            if ( error ) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }

            $img.attr( 'src', src );
        }, thumbnailWidth, thumbnailHeight );

        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            var index = $(this).index(),
                deg;

            switch ( index ) {
                case 0:
                    uploader.removeFile( file );
                    removeFile( file );
                    return;

                case 1:
                    file.rotation += 90;
                    break;

                case 2:
                    file.rotation -= 90;
                    break;
            }

            if ( supportTransition ) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
            }


        });
    });
    // 文件上传过程中创建进度条实时显示。
    uploader.on( 'uploadProgress', function( file, percentage ) {
        var $li = $( '#'+file.id ),
            $percent = $li.find('.progress span');

        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<p class="progress"><span></span></p>')
                .appendTo( $li )
                .find('span');
        }

        $percent.css( 'width', percentage * 100 + '%' );
    });

    // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    uploader.on( 'uploadSuccess', function( file,ret ) {
        var $file = $('#' + file.id);
        var $up_img = $file.find('img');
        try {
            var responseText = (ret._raw || ret),
                json = JSON.parse(responseText);
            if (json.state == true) {
                var path = json.url;
                //_this.imageList.push(json);
                $file.append('<span class="success"></span>');
                $up_img.attr("data-width",json.width);
                $up_img.attr("data-height",json.height);
                //$up_img.attr("height","80px");
                //$up_img.attr("width","80px");
                $up_img.attr("src",(path+"?x-oss-process=image/resize,w_100"));
                $up_img.attr("data-src",(path));
            } else {
                var $li = $( '#'+file.id ),
                    $error = $li.find('div.error');
                // 避免重复创建
                if ( !$error.length ) {
                    $error = $('<p class="error"></p>').appendTo( $li );
                }
                $error.text(json.msg);
            }
        } catch (e) {
            var $li = $( '#'+file.id ),
                $error = $li.find('div.error');

            // 避免重复创建
            if ( !$error.length ) {
                $error = $('<p class="error"></p>').appendTo( $li );
            }

            $error.text('上传失败1');
        }
    });

    // 文件上传失败，显示上传出错。
    uploader.on( 'uploadError', function( file ) {
        var $li = $( '#'+file.id ),
            $error = $li.find('div.error');
        // 避免重复创建
        if ( !$error.length ) {
            $error = $('<p class="error"></p>').appendTo( $li );
        }

        $error.text('上传失败');
    });

    uploader.on( 'error', function( handler ) {
        if (handler == "Q_EXCEED_NUM_LIMIT" ){
            parent.layer.msg("最多只能上传1张图片");
        }else if (handler == "F_EXCEED_SIZE"){
            parent.layer.msg("图片不能大于1M");
        }else if (handler == "Q_TYPE_DENIED"){
            parent.layer.msg("图片格式不对");
        }
    });

    // 完成上传完了，成功或者失败，先删除进度条。
    uploader.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').remove();
    });

    // 负责view的销毁
    function removeFile( file ) {
        var $li = $('#'+file.id);
        //delete percentages[ file.id ];
        //updateTotalProgress();
        $li.off().find('.file-panel').off().end().remove();
        //File.remove(file);
    }

    //动态绑定SKU选中
    $(document).on('click','.code_box',function (_event) {
        _event.stopPropagation();
        var _target = _event.currentTarget;
        if(_target.nodeName.toLowerCase() == 'p'){
            selectCode($(_target));
        }
    });

    function initImage(previews,i){
        var $li = $(
            '<li id="show_img_' + i + '" class="file-item thumbnail">' +
            '<div class="img-single"><p><img src="'+previews+'?x-oss-process=image/resize,w_100" data-src="'+previews+'" class="pre_img"></p>' +
            '</div></li>'
            ),
            $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span></div>').appendTo( $li );
        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            $li.remove();

        });
        $("#thelist").append( $li );
    }
</script>

</body>
</html>
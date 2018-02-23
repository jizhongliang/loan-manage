<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/common/common.jspf"%>

    <style type="text/css">
        body {background-color: #fff; min-width:350px; font-size: 13px;}
        .table{ text-align: left;}
        .table > div {
            padding: 8px;
            border: none;
            line-height: 30px;
        }
        label{
            display: inline-block;width: 85px;
            border: none;
            padding-left: 15px;
        }
        [data-level="1"]{
            padding-left: 10px;
        }
    </style>
</head>
<body>
<div style="padding: 1em 2em;">
    <form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" onkeydown="if(event.keyCode==13){return false;}">
        <input type="hidden" name="id" id="id" value="${id}">
        <div class="table">

            <div>
                <label for="name">菜单名称<em class="required" aria-required="true">*</em></label>
                <input type="text" name="name" id="name" value="" class="input-leg">
            </div>
            <div>
                <label for="pcode">父节点</label>
                <select name="pcode" id="pcode" class="select-leg">
                    <option  value='0' data-level='0'>根目录</option>
                </select>
            </div>
            <div>
                <label for="ismenu">是否菜单</label>
                <select name="ismenu" id="ismenu" class="select-leg">
                    <option value='1'>是</option>
                    <option value='0'>否</option>
                </select>
            </div>
            <div>
                <label for="code">标识<em class="required" aria-required="true">*</em></label>
                <input type="text" name="code" id="code" value="" class="input-leg">
            </div>
            <div id="iconShow">
                <label for="icon">图标<em class="required" aria-required="true">*</em></label>
                <input type="text" name="icon" id="icon" value="" class="input-leg">
            </div>
            <div id="urlShow">
                <label for="url">地址<em class="required" aria-required="true">*</em></label>
                <input type="text" name="url" id="url" value="" class="input-leg">
            </div>
            <div>
                <label for="tips">备注</label>
                <input type="text" name="tips" id="tips" value="" class="input-leg">
            </div>
            <div>
                <label for="status">排序</label>
                <input type="text" name="status" id="status" value="1" class="input-sm" >
            </div>
            <div style="text-align: center;">
                <input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="button" style=" font-size: 13px" data-loading-text="正在保存..." value=" 保 存  ">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name);
    $(function () {
        $.ajax({
            type: "POST",
            url:"${path}/menuMana/searchMenuList.shtml",
            data:{},
            async: false,
            error: function(request) {
                layer.msg("网络异常，操作失败 ");
            },
            success: function(ret) {
                if(ret){
                    var pcode = $("#pcode");
                    $.each(ret.data, function(i,e) {
                        if(e.levels == 1){
                            var html = "<option value='" + e.code +"' data-level='" + e.levels +"'>&nbsp;&nbsp;" + e.name + "</option>";
                            var option = $(html);
                            pcode.append(option);
                        }
                        level(0);
                    });
                }else{
                    parent.layer.msg("获取失败, "+ret.message);
                }
            }
        });

        $("#pcode").change(function () {
            var a = $("#pcode option:selected").attr("data-level");
            level(a);
        });

        var id = $("#id").val();

        if(!FsUtils.isEmpty(id)){
            $.ajax({
                type: "POST",
                url:"${path}/menuMana/getOneMenu.shtml",
                data:{id:id},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success==true){
                        $("#name").val(ret.data.name);
                        $("#pcode").val(ret.data.pcode);
                        $("#status").val(ret.data.status);
                        $("#code").val(ret.data.code);
                        $("#tips").val(ret.data.tips);
                        $("#icon").val(ret.data.icon);
                        $("#ismenu").val(ret.data.ismenu);
                        $("#url").val(ret.data.url);
                        level(ret.data.levels-1);
                        $("#code").attr("readonly","readonly");
                    }else{
                        parent.layer.msg("获取失败, "+ret.message);
                    }
                }
            });
        }else {

        }

        $("#submitbtn").click(function () {

            var level = $("#pcode option:selected").attr("data-level");
            var ele = $(this);
            var name = $("#name").val();
            var icon = $("#icon").val();
            var href = $("#url").val();
            var url = "";

            if(level == 0){
                if (FsUtils.isEmpty(icon)) {
                    parent.layer.msg("一级菜单需显示图标");
                    return false;
                }
            }else if(level == 1){
                if (FsUtils.isEmpty(href)) {
                    parent.layer.msg("请输入二级菜单地址");
                    return false;
                }
            }
            if (!FsUtils.isEmpty(name)) {
                if(!FsUtils.isEmpty(id)){
                    url = "${path}/menuMana/editMenu.shtml"
                }else {
                    url = "${path}/menuMana/addMenu.shtml"
                }
                change_Btn_submit(ele);
                $.ajax({
                    type: "POST",
                    data:$('#form-add').serialize(),
                    url:url,
                    async: false,
                    error: function(request) {
                        parent.layer.msg("网络异常，操作失败");
                        restore_Btn_submit(ele);
                    },
                    success: function(ret) {
                        if(ret.success==true){
                            parent.reloadAjax();
                            parent.layer.msg("操作成功!");
                            parent.layer.close(index);
                        }else{
                            parent.layer.msg("操作失败! "+ret.message);
                            restore_Btn_submit(ele);
                        }
                    }
                });
            } else {
                parent.layer.msg("请输入菜单名称");
            }
        });
    });

    function level(a) {
        if(a == 0){
            $("#urlShow").hide();
            $("#iconShow").show();
            $("#url").val("");
        }else if(a == 1){
            $("#iconShow").hide();
            $("#urlShow").show();
            $("#icon").val("");
        }
    }

    function change_Btn_submit(_index) {
        _index.attr('disabled', true);
        var _loading = _index.attr('data-loading-text');
        _index.val(_loading);
    }
    function restore_Btn_submit(_index) {
        _index.attr('disabled', false);
        _index.val(' 保 存 ');
    }
</script>

</body>
</html>
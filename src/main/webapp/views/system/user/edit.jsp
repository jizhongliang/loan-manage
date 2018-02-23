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
            display: inline-block;width: 80px;
            border: none;
        }
    </style>
</head>
<body>
<div style="padding: 1em 2em;">
    <form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" onkeydown="if(event.keyCode==13){return false;}">
        <input type="hidden" name="id" id="id" value="${id}">
        <div class="table">

            <div>
                <label for="account">用户账号 <em class="required" aria-required="true">*</em></label>
                <input type="text" name="account" id="account" value="" class="input-leg">
            </div>
            <div>
                <label for="name">用户昵称 <em class="required" aria-required="true">*</em></label>
                <input type="text" name="name" id="name" value="" class="input-leg">
            </div>
            <div>
                <label for="roleid">角色</label>
                <select name="roleid" id="roleid" class="select-leg"></select>
            </div>
            <div>
                <label for="status">排序</label>
                <input type="text" name="status" id="status" value="1" class="input-sm">
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
            url:"${path}/roleMana/searchRoleList.shtml",
            data:{},
            async: false,
            error: function(request) {
                layer.msg("网络异常，操作失败 ");
            },
            success: function(ret) {
                if(ret){
                    var roleid = $("#roleid");
                    $.each(ret.data, function(i,e) {
                        var html = "<option value='" + e.id +"'>" + e.name + "</option>";
                        var option = $(html);
                        roleid.append(option);
                    });
                }else{
                    parent.layer.msg("获取失败, "+ret.message);
                }
            }
        });

        var id = $("#id").val();

        if(!FsUtils.isEmpty(id)){
            $.ajax({
                type: "POST",
                url:"${path}/sysUserMana/getOneUser.shtml",
                data:{id:id},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success==true){
                        $("#name").val(ret.data.name);
                        $("#roleid").val(ret.data.roleid);
                        $("#status").val(ret.data.status);
                        $("#account").val(ret.data.account);
                    }else{
                        parent.layer.msg("获取失败, "+ret.message);
                    }
                }
            });
        }else {

        }

        $("#submitbtn").click(function () {
            var ele = $(this);
            var name = $("#name").val();
            var account = $("#account").val();
            if (!FsUtils.isEmpty(name) && !FsUtils.isEmpty(account)) {
                change_Btn_submit(ele);
                $.ajax({
                    type: "POST",
                    data:$('#form-add').serialize(),
                    url:"${path}/sysUserMana/editUser.shtml",
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
            } else if (FsUtils.isEmpty(name)) {
                parent.layer.msg("请输入用户昵称");
            } else {
                parent.layer.msg("请输入用户账号");
            }
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
</script>

</body>
</html>
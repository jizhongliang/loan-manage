<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/common/common.jspf"%>

    <style type="text/css">
        body {background-color: #fff; min-width:350px; font-size: 13px;}
        .table td { text-align: left;}
        .table > thead > tr > th,
        .table > tbody > tr > th,
        .table > tfoot > tr > th,
        .table > thead > tr > td,
        .table > tbody > tr > td,
        .table > tfoot > tr > td {
            padding: 8px;
            border-top: none;
            line-height: 30px;
        }
    </style>
</head>
<body>
<div style="padding: 1em 2em;">
    <form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" onkeydown="if(event.keyCode==13){return false;}">
        <input type="hidden" name="id" id="id" value="${id}">
        <table class="table" style="text-align: center;">
            <tr>
                <td>角色名称<em class="required" aria-required="true">*</em></td>
                <td>
                    <input type="text" name="name" id="name" value="" class="input-leg">
                </td>
            </tr>
            <tr>
                <td>标签<em class="required" aria-required="true">*</em></td>
                <td>
                    <input type="text" name="tips" id="tips" value="" class="input-leg">
                </td>
            </tr>
            <tr>
                <td>排序</td>
                <td>
                    <input type="text" name="num" id="num" value="1" class="input-sm">
                </td>
            </tr>
            <tr>
                <td style="text-align: center;" colspan="2">
                    <input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="button" style=" font-size: 13px" data-loading-text="正在保存..." value=" 保 存  ">
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name);
    $(function () {
        var id = $("#id").val();

        if(!FsUtils.isEmpty(id)){
            $.ajax({
                type: "POST",
                url:"${path}/roleMana/getOneRole.shtml",
                data:{id:id},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success==true){
                        $("#name").val(ret.data.name);
                        $("#num").val(ret.data.num);
                        $("#tips").val(ret.data.tips);
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
            var tips = $("#tips").val();
            if (!FsUtils.isEmpty(name) && !FsUtils.isEmpty(tips)) {
                change_Btn_submit(ele);
                $.ajax({
                    type: "POST",
                    data:$('#form-add').serialize(),
                    url:"${path}/roleMana/editRole.shtml",
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
            } else if (FsUtils.isEmpty(name)) {
                parent.layer.msg("请输入角色名");
            } else {
                parent.layer.msg("请输入角色标签");
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
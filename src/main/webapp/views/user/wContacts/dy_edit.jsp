<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/common/common.jspf"%>

    <script src="${path}/js/jquery.validate.min.js"></script>
    <script src="${path}/js/messages_cn.js"></script>
    <style type="text/css">
        body {background-color: #fff; min-width:350px; font-size: 13px;}
        .table{ text-align: left;}
        .table > div {
            padding: 8px;
            border: none;
            line-height: 30px;
        }
        label{width: 130px!important;}
    </style>
</head>
<body>
<div style="padding: 1em 2em;">
    <form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" onkeydown="if(event.keyCode==13){return false;}">
        <input type="hidden" name="id" id="id" value="${id}">
        <div class="table">
            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label"><em class="required" aria-required="true">*</em>用户姓名：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-leg" id="name" name="name"></span>
                    </div>
                </div>
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label"><em class="required" aria-required="true">*</em>手机号：</label>
                    <div class="col-xs-7">
                        <span><input type="tel" class="input-leg" id="phone" name="phone"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-6 control-label"><em class="required" aria-required="true">*</em>个人年收入(万元)：</label>
                    <div class="col-xs-6">
                        <span><input type="text" class="input-leg" id="personIncome" name="personIncome"></span>
                    </div>
                </div>
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label"><em class="required" aria-required="true">*</em>项目地址：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-leg" id="dyCity" name="dyCity"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-6 control-label"><em class="required" aria-required="true">*</em>楼盘名称：</label>
                    <div class="col-xs-6">
                        <span><input type="text" class="input-leg" id="liveCommunity" name="liveCommunity"></span>
                    </div>
                </div>
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label"><em class="required" aria-required="true">*</em>车位估价(万元)：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-leg" id="dyValue" name="dyValue"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-6 control-label"><em class="required" aria-required="true">*</em>折扣率(%)：</label>
                    <div class="col-xs-6">
                        <span><input type="text" class="input-leg" id="dyValueDiscount" name="dyValueDiscount"></span>
                    </div>
                </div>
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label"><em class="required" aria-required="true">*</em>预设额度(万元)：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-leg" id="borrowQuota" name="borrowQuota"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-6 control-label"><em class="required" aria-required="true">*</em>预设利率(%)：</label>
                    <div class="col-xs-6">
                        <span><input type="text" class="input-leg" id="borrowRate" name="borrowRate"></span>
                    </div>
                </div>
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label"><em class="required" aria-required="true">*</em>额度期限(月)：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-leg" id="quotaExpire" name="quotaExpire"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label">学历：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-leg" id="education" name="education"></span>
                    </div>
                </div>
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-6 control-label">单位性质：</label>
                    <div class="col-xs-6">
                        <span><input type="text" class="input-leg" id="companyType" name="companyType"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 user-info-group">
                    <label class="col-xs-5 control-label">工作单位：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-xxl" id="companyName" name="companyName"></span>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-xs-12 user-info-group">
                    <label class="col-xs-5 control-label">家庭住址：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-xxl" id="liveAddr" name="liveAddr"></span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 user-info-group">
                    <label class="col-xs-5 control-label">单位住址：</label>
                    <div class="col-xs-7">
                        <span><input type="text" class="input-xxl" id="companyAddr" name="companyAddr"></span>
                    </div>
                </div>
            </div>

            <div style="text-align: center;">
                <input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="submit" style=" font-size: 13px" data-loading-text="正在保存..." value=" 保 存  ">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name);
    $(function () {
        var id = $("#id").val();
        if(!FsUtils.isEmpty(id)){
            $.ajax({
                type: "POST",
                url:"${path}/wContactsMana/getOneWContacts.shtml",
                data:{id:id},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success==true){
                       var user = ret.data;
                       allPrpos(user);
                    }else{
                        parent.layer.msg("获取失败, "+ret.message);
                    }
                }
            });
        }else {

        }

        $("#form-add").validate({
            rules:{
                name:{
                    required:true
                },
                phone:{
                    required:true,
                    isPhone: true
                },
                borrowQuota:{
                    required:true,
                    min: 0.01,
                    minNumber: $("#borrowQuota").val(),
                    number: true
                },
                borrowRate:{
                    required:true,
                    number: true,
                    min: 0.01,
                    minNumber: $("#borrowRate").val(),
                    range:[0.01,99.99]
                },
                personIncome:{
                    required:true,
                    min: 0.01,
                    minNumber: $("#personIncome").val(),
                    number: true
                },
                quotaExpire:{
                    required:true,
                    min: 1,
                    minNumber: $("#quotaExpire").val(),
                    number: true
                },
                dyValueDiscount:{
                    required:true,
                    min: 0.01,
                    minNumber: $("#dyValueDiscount").val(),
                    number: true,
                    range:[0.01,100.00]
                },
                dyCity:{
                    required:true
                },
                dyValue:{
                    required:true,
                    min: 0.01,
                    minNumber: $("#dyValue").val(),
                    number: true
                },
                liveCommunity:{
                    required:true
                }
            },
            messages:{
                name:{
                    required:"请输入用户姓名"
                },
                phone:{
                    required:"请输入手机号",
                    digits: "请正确输入手机号"
                },
                borrowQuota:{
                    required:"请输入预设额度",
                    min: "输入最小额度为0.01",
                    length: "输入数字最多小数点后两位"
                },
                borrowRate:{
                    required:"请输入预设利率",
                    min: "输入最小利率为0.01",
                    length: "输入数字最多小数点后两位",
                    range:"利率应不超过100%"
                },
                personIncome:{
                    required:"请输入个人年收入",
                    min: "输入最小收入为0.01",
                    length: "输入数字最多小数点后两位"
                },
                quotaExpire:{
                    required:"请输入额度限期",
                    min: "输入最小限期为1",
                    length: "输入数字最多小数点后两位"
                },
                dyValueDiscount:{
                    required:"请输入折扣率",
                    min: "输入最小折扣率为0.01",
                    length: "输入数字最多小数点后两位"
                },
                dyCity:{
                    required:"请输入	项目地址"
                },
                dyValue:{
                    required:"请输入车位估价",
                    min: "输入最小估价为0.01",
                    length: "输入数字最多小数点后两位"
                },
                liveCommunity:{
                    required:"请输入楼盘名称"
                }

            },
            errorPlacement: function(error, element) {
                error.appendTo(element.parent());
            },
            submitHandler: function(form) {
                var ele = $("#submitbtn");
                $.ajax({
                    type: "post",
                    url:"${path}/wContactsMana/editWContacts.shtml",
                    data:$('#form-add').serialize(),
                    error: function(request) {
                        parent.layer.msg("网络异常，操作失败");
                        restore_Btn_submit(ele);
                    },
                    success:function(ret){
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
            }
        });
    });

    function allPrpos(obj,type) {
        // 用来保存所有的属性名称和值
        var props = "";
        // 开始遍历
        for(var p in obj){
            // 方法
            if(typeof(obj[p])=="function"){
                obj[p]();
            }else{
                var _value = obj[p];
                $("#"+p).val(_value);
            }
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
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
	<div style="padding: 1em;">
		<form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" onkeydown="if(event.keyCode==13){return false;}">
			<input type="hidden" id="id" name="id" value="${id}">
			<input type="hidden" id="types" name="types" value="${type}">
			<table class="table" style="text-align: center;">
				<tr>
					<td>编号</td>
					<td>
						<input type="text" class="input-leg" id="code" name="code" value="${code}">
					</td>
				</tr>
			<tr>
				<td>参数名</td>
				<td>
					<input type="text" class="input-leg" name="name" id="name" value="">
				</td>
			</tr>
			<tr>
				<td>参数值</td>
				<td>
					<input type="text" class="input-leg" id="value" name="value" value="">
				</td>
			</tr>
			<tr>
				<td>参数类型</td>
				<td>
					<select class="select-leg" id="type" name="type">
					</select>
				</td>
			</tr>
			<tr>
				<td>状态</td>
				<td>
					<select class="select-leg" id="state" name="state">
						<option value="1">启用</option>
						<option value="0">停用</option>
					</select>
				</td>
			</tr>
				<tr>
					<td>备注说明</td>
					<td>
						<input type="text" class="input-leg" id="remark" name="remark" value="" >
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
	$(function(){
        $.ajax({
            type: "POST",
            url:"${path}/baseCodeMana/searchBaseCodeList.shtml",
            data:{cat:"sys_catalog",length:10000},
            async: false,
            error: function(request) {
                parent.layer.msg("网络异常，操作失败 ");
            },
            success: function(ret) {
                if(ret.success == "true") {
                    var type = $("#type");
                    $.each(ret.data, function(i,e) {
                        var html = "<option value='" + e.code +"'>" + e.descript + "</option>";
                        var option = $(html);
                        type.append(option);
                    });
                }else{
                    parent.layer.msg("获取失败");
                }
            }
        });
		var index = parent.layer.getFrameIndex(window.name);
        var code = $("#code").val();
        var types = $("#types").val();
        var id = $("#id").val();
        var url="";

        if(!FsUtils.isEmpty(id)){
			url="${path}/configMana/updateConfig.shtml";

            $.ajax({
                type: "POST",
                url:"${path}/configMana/searchConfigList.shtml",
                data:{code:code,type:types,length:10000},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success == "true"){
                        var data = ret.data;
                        $.each(data,function (i,e) {
                            $("#state").val(e.state);
                            $("#value").val(e.value);
                            $("#name").val(e.name);
                            $("#type").val(e.type);
                            $("#remark").val(e.remark);
                            $("#code").attr("readonly",true);
                        })
                    }else{
                        parent.layer.msg("获取失败");
                    }
                }
            });
        }else {
            url="${path}/configMana/addConfig.shtml";
        }


        $("#submitbtn").click(function(){
            var ele = $(this);
            change_Btn_submit(ele);
            $.ajax({
                type: "POST",
                url:url,
                data:$('#form-add').serialize(),
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                    restore_Btn_submit(ele);
                },
                success: function(data) {
                    if(data.success == true){
                        parent.reloadAjax();
                        parent.layer.msg("操作成功!");
                        parent.layer.close(index);
                    }else{
                        parent.layer.msg("操作失败! "+data.msg);
                        restore_Btn_submit(ele);
                    }
                }
            });
        });
		
		
	});
	
	function change_Btn_submit(_index){
		_index.attr('disabled',true);
		var _loading = _index.attr('data-loading-text');
		_index.val(_loading);
	}
	function restore_Btn_submit(_index){
		_index.attr('disabled',false);
		_index.val(' 保 存 ');
	}
	</script>
</body>
</html>
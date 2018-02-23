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
		<table class="table" style="text-align: center;">
			<tr>
				<td>数据分类</td>
				<td>
					<input type="text" class="input-leg" name="cat" id="cat" value="${cat}">
				</td>
			</tr>
			<tr>
				<td>代码</td>
				<td>
					<input type="text" class="input-leg" id="code" name="code" value="${code}"></span>
				</td>
			</tr>
			<tr>
				<td>中文描述</td>
				<td>
					<input type="text" class="input-leg" id="descript" name="descript" value="" ></span>
				</td>
			</tr>
			<tr>
				<td>是否停用</td>
				<td>
					<select class="select-leg" id="halt" name="halt">
						<option value="F">否</option>
						<option value="T">是</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>是否系统代码</td>
				<td>
					<select class="select-leg" id="sys" name="sys">
						<option value="T">是</option>
						<option value="F">否</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>排序</td>
				<td>
					<input type="text" class="input-leg" id="seq" name="seq" value="1" ></span>
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
		var index = parent.layer.getFrameIndex(window.name);
        var cat = $("#cat").val();
        var code = $("#code").val();
        var url="";
        if(!FsUtils.isEmpty(cat) && !FsUtils.isEmpty(code)){
			url="${path}/baseCodeMana/updateBaseCode.shtml";

            $.ajax({
                type: "POST",
                url:"${path}/baseCodeMana/searchBaseCodeList.shtml",
                data:{cat:cat,code:code,length:10000},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success == "true"){
                        var data = ret.data;
                        $.each(data,function (i,e) {
                            $("#halt").val(e.halt);
                            $("#descript").val(e.descript);
                            $("#seq").val(e.seq);
                            $("#sys").val(e.sys);
                            $("#code").attr("readonly",true);
                            $("#cat").attr("readonly",true);
                        })
                    }else{
                        parent.layer.msg("获取失败");
                    }
                }
            });
        }else {
            $("#cat").val('');
            $("#code").val("");
            url="${path}/baseCodeMana/addBaseCode.shtml";
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
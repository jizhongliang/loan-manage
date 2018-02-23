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
                <label for="name">定时名称 <em class="required" aria-required="true">*</em></label>
                <input type="text" name="name" id="name" value="" class="input-leg">
            </div>
            <div>
                <label for="code">定时code <em class="required" aria-required="true">*</em></label>
                <input type="text" name="code" id="code" value="" class="input-leg">
            </div>
            <div>
                <label for="cycle">cron配置 <em class="required" aria-required="true">*</em></label>
                <input type="text" name="cycle" id="cycle" value="" class="input-leg">
            </div>
            <div>
                <label for="className">执行类 <em class="required" aria-required="true">*</em></label>
                <input type="text" name="className" id="className" value="" class="input-leg">
            </div>
           
            <div style="text-align: center;">
                <input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="button" style=" font-size: 13px" data-loading-text="正在保存..." value=" 保 存  ">
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name);
	var id = $("#id").val();
	$(function () {
		//编辑查询
		queryQuartz();
		
		initQuartz();
		
		$("#submitbtn").click(function(){
			var ele = $(this);
            var name = $("#name").val();
            var code = $("#code").val();
            var cycle = $("#cycle").val();
            var className = $("#className").val();
            if(FsUtils.isEmpty(name)){
	       		 parent.layer.msg("请输入定时名称");
	       		 return
	       	}
            if(FsUtils.isEmpty(cycle)){
	       		 parent.layer.msg("请输入cron配置");
	       		 return
	       	}
            if(!id){
            	if(FsUtils.isEmpty(className)){
	           		 parent.layer.msg("请输入定时执行类");
	           		 return
	           	}
           	if(FsUtils.isEmpty(code)){
	           		 parent.layer.msg("请输入定时code");
	           		 return
	           	}
            }
            var url="";
            if(id){
            	url="${path}/quartzMana/editQuartz.shtml";
            }else{
            	url="${path}/quartzMana/addQuartz.shtml";
            }
            change_Btn_submit(ele);
            $.ajax({
                type: "POST",
                data:$('#form-add').serialize(),
                url:url,
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
		})
	});
	
	
	
	function queryQuartz(){
		if(!FsUtils.isEmpty(id)){
			$.ajax({
	            type: "POST",
	            url:"${path}/quartzMana/queryQuartzById.shtml",
	            data:{id:id},
	            async: false,
	            error: function(request) {
	            	parent.layer.msg("网络异常，操作失败 ");
	            },
	            success: function(ret) {
	            	if(ret.success==true){
                		var data=ret.data;
                		$("#name").val(data.name);
                		$("#code").val(data.code);
                		$("#cycle").val(data.cycle);
                		$("#className").val(data.className);
	            	}else{
	                    parent.layer.msg("获取失败, "+ret.message);
	                }
	            }
	        });
		}
	}
	
	function initQuartz(){
		if(id){
			$("#code").attr('disabled',"true");
			$("#className").attr('disabled',"true");
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

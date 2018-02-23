<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@include file="/common/common.jspf"%>
	<!-- page scripts & css -->
	<script src="${path}/common/plugins/jquery.dataTables.min.js"></script>
	<script src="${path}/common/plugins/jquery.dataTables.bootstrap.js "></script>

	<style>
		body{font-size: 12px; line-height: 1.5em; background-color: #FFFFFF; min-width:100%;}
		textarea{width: 625px;margin:0 5px;padding: 5px;height: 60px}
	</style>
</head>
<body>
<input type="hidden" id="id" name="id" value="${id}">
<div class="layui-tab-content">
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
		<div class="layui-tab-content">

			<blockquote class="h-elem-quote">抵押信息</blockquote>

			<div class="loan-user-box  assetsImg userImg otherImg" style="width: 100%; padding-left: 20px;">

			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">抵押物面积：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="dyArea" name="dyArea" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">购买年份：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="dyBuyYear" name="dyBuyYear" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">购买价格：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="dyBuyPrice" name="dyBuyPrice" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">抵押物所在城市：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="dyCity" name="dyCity" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">抵押物所在社区：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="dyCommunity" name="dyCommunity" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">要借款额度：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="borrowAmount" name="borrowAmount" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label">抵押物所在地址：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-xxl" style="width: 625px" id="dyAddress" name="dyAddress" disabled></span>
					</div>
				</div>
			</div>

			<blockquote class="h-elem-quote">人工审核</blockquote>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">审核操作：</label>
					<div class="col-xs-7">
						<select class="select-leg" id="status" name="status">
							<option value="${status}">审核通过</option>
							<option value="60">审核拒绝</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row" style="margin-bottom: 80px">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label">备注说明：</label>
					<div class="col-xs-7">
						<span><textarea id="remark" name="remark" ></textarea></span>
					</div>
				</div>
			</div>

			<div style="text-align:center;position:fixed;bottom:0;left:0;width:100%;z-index:10;line-height:50px;height:50px;border-top:solid 1px #f2f2f2;background: #fff;">
				<input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="button" style=" font-size: 13px" data-loading-text="正在审核中..." value=" 确 认 ">
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
    var index = parent.layer.getFrameIndex(window.name);
    $(function(){
        var id = $("#id").val();
        layui.use(['laydate', 'layer', 'element'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;

            //日期范围
            laydate.render({
                elem: '#showTime',
                range: "~"
            });

            if(!FsUtils.isEmpty(id)){
                $.ajax({
                    type: "POST",
                    url:"${path}/riskMana/mortgageUser.shtml",
                    data:{id:id},
                    error: function(request) {
                        layer.msg("网络异常，操作失败 ");
                    },
                    success: function(ret) {
                        if(ret.success == true){
//                            console.log(ret);
                            var user = ret.data;
//                            $("#remark").val(user.borrowAmount)
                            if (!FsUtils.isEmpty(user)){
                                allPrpos(user);
                            }
                            $("#status option:first").attr("selected",true);
                        }else{
                            layer.msg("获取失败, "+ret.message);
                        }
                    }
                });
            }
        });

        $("#submitbtn").click(function () {
            var ele = $(this);
            var remark = $("#remark").val();
            var status = $("#status").val();
            var url = "";
            var c=${status};

            if(c == 20){
                url = "${path}/riskMana/mortgageTrial.shtml";
            }else if(c == 30){
                url = "${path}/riskMana/mortgageReviewList.shtml";
            }else if(c == 40){
                url = "${path}/riskMana/mortgageFinalList.shtml";
            }

            if (!FsUtils.isEmpty(status)) {
                change_Btn_submit(ele);
                var layerUpload = parent.layer.msg('正在审核中...', {
                    icon: 16,
                    time: 60*1000*60,
                    shade:0.2,
                    success: function(){
                    }
                });
                $.ajax({
                    type: "POST",
                    data:{id:id,remark:remark,status:status},
                    url:url,
                    error: function(request) {
                        parent.layer.msg("网络异常，操作失败");
                        restore_Btn_submit(ele);
                    },
                    success: function(ret) {
//                        console.log(ret);
                        if(ret.success==true){
                            parent.layer.close(layerUpload);
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
                parent.layer.msg("请输入审核结果");
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
            }else if (typeof(obj[p])=="object"){
                var l = obj[p].length;
                for ( var i=0 ; i<l;i++){
                    $("."+p).append('<div class="img"><a href="javascript:;" onclick=img(\"'+obj[p][i]+'\");><img src="'+obj[p][i]+'"></a></div>');
				}
			}else{
                var _value = obj[p];
				$("#"+p).val(_value);
            }
        }
    }

    function img(src){
        layer.open({
            type: 1,
            title: false,
            closeBtn: 1,
            area: ["50%",'auto'],
            skin: 'layui-layer-nobg', //没有背景色
            shadeClose: true,
            content:"<img src="+src+" style='max-width:100%;'>"
        });
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

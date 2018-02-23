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

			<blockquote class="h-elem-quote">订单信息</blockquote>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">订单号：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="orderNo" name="orderNo" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款人姓名：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="userName" name="userName" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">手机号码：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="mobile" name="mobile" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">申请时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="applyDate" name="applyDate" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">放款时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="created" name="created" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">订单状态：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="status" name="status" disabled></span>
					</div>
				</div>
			</div>

				<div class="row">
					<div class="col-xs-6 user-info-group">
						<label class="col-xs-5 control-label">最终审核额度：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="realQuota" name="realQuota" disabled></span>
						</div>
					</div>
					<div class="col-xs-6 user-info-group">
						<label class="col-xs-5 control-label">最终核定利率：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="realRate" name="realRate" disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-12 user-info-group">
						<label class="col-xs-5 control-label">人工审核备注：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-xxl" style="width: 625px" id="remark" name="remark" disabled></span>
						</div>
					</div>
				</div>

			<%--<blockquote class="h-elem-quote">其他认证信息</blockquote>--%>

			<%--<div class="loan-user-box otherImg" style="width: 100%; padding-left: 20px;">--%>

			<%--</div>--%>

		</div>
	</div>
</div>
<script type="text/javascript">
    $(function(){
        layui.use(['laydate', 'layer'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;

            //日期范围
            laydate.render({
                elem: '#showTime',
                range: "~"
            });
            var id = $("#id").val();
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
                            var user = ret.data;
                            if (!FsUtils.isEmpty(user)){
                                allPrpos(user);
                            }
                        }else{
                            layer.msg("获取失败, "+ret.message);
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
            }else if (typeof(obj[p])=="object"){
                var l = obj[p].length;
                for ( var i=0 ; i<l;i++){
                    $("."+p).append('<div class="img"><a href="javascript:;" onclick=img(\"'+obj[p][i]+'\");><img src="'+obj[p][i]+'"></a></div>');
				}
			}else{
                var _value = obj[p];
				if (_value=='10'){
					$("#"+p).val('新申请');
				}else if (_value=='20'){
					$("#"+p).val('通过初审');
				}else if (_value=='30'){
					$("#"+p).val('通过复审');
				}else  if(_value=='40'){
					$("#"+p).val('终审通过');
				}else if (_value=='50'){
					$("#"+p).val('已提现');
				}else if (_value=='60'){
					$("#"+p).val('审核被拒绝');
				}else  if(_value=='70'){
					$("#"+p).val('冻结');
				}else {
                    $("#"+p).val(_value);
				}
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

</script>
</body>
</html>

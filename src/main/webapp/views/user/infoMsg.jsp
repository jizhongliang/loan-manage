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
		.layui-table th {
			font-weight: bold;
		}
		.layui-table td, .layui-table th{
			padding: 16px 8px;
			word-break: break-all;
		}
		.layui-table tbody tr:hover, .layui-table-hover{
			background-color: #eaf8fe!important;
		}
		.layui-table[lay-skin=line] {
			border: 0px solid #e2e2e2;
		}
		.layui-table[lay-skin=line] tr {
			border-radius: 6px 6px 0 0;
		}
	</style>
</head>
<body>
<input type="hidden" id="userId" value="${id}">
<div class="layui-tab-content">
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
		<div class="layui-tab-content">

			<blockquote class="h-elem-quote">订单信息</blockquote>
			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">订单号：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="order" name="order" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">借款人姓名：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="realName" name="realName" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">手机号码：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="phone" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label"  style="text-align:right">借款期限(天)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="age" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">借款所在地：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-xxl" id="registerAddr"  disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label">借款所在经纬度：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-xxl" id="registerCoordinate"  disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款金额(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="Coordinate"  disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">综合费用(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="bankPhone" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">平台服务费(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="registerClient" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">信息流量费(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">征信审核费(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款利息(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="registTime"  disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">实际到账(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg"  disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="unionid" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">放款时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">逾期天数(天)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" value="0" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">逾期金额(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" value="0" id="name_10" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">实际还款时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="phone_10" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">应还总额(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="name_20"  disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">已还总额(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="phone_20" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label">人工审核备注：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-xxl" id="bankCardState" disabled></span>
					</div>
				</div>
			</div>

			<blockquote class="h-elem-quote">分期信息</blockquote>
			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款分期数：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">每期应还(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg"  disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">本金(元/期)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">利息(元/期)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg"  disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">还款进度(期)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">本期状态：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg"  disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">逾期金额(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">逾期时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg"  disabled></span>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
    $(function(){

        layui.use(['laydate', 'layer', 'element'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;

            //日期范围
            laydate.render({
                elem: '#showTime',
                range: "~"
            });
            var id = $("#userId").val();
            if(!FsUtils.isEmpty(id)){
                $.ajax({
                    type: "POST",
                    url:"${path}/userMana/getUserDetail.shtml",
                    data:{id:id},
                    error: function(request) {
                        layer.msg("网络异常，操作失败 ");
                    },
                    success: function(ret) {
                        if(ret.success == true){
//                            console.log(ret);
                            var user = ret.data;
                            var userbase = user.userbase;
							if (!FsUtils.isEmpty(userbase)){
                                allPrpos(userbase);
							}
                            var userOtherInfo = user.userOtherInfo;
                            if (!FsUtils.isEmpty(userOtherInfo)){
                                allPrpos(userOtherInfo);
                            }
                            var userEmerList = user.userEmerList;
							if (!FsUtils.isEmpty(userEmerList)){
							    for (var i=0; i < userEmerList.length; i++){
							        var emer = userEmerList[i];
							        $("#name_" + emer.type).val(emer.name);
                                    $("#phone_" + emer.type).val(emer.phone);
                                    $("#relation_" + emer.type).val(emer.relation);
								}
							}
                            var userAuth = user.userAuth;
                            if (!FsUtils.isEmpty(userAuth)){
                                allPrpos(userAuth,1);
                            }
                            var userOtherInfo = user.userOtherInfo;
                            if (!FsUtils.isEmpty(userOtherInfo)){
                               $("#cat").val(userOtherInfo.cat);
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
            }else{
                var _value = obj[p];
                if (type == 1){
					if (_value=='10'){
                        $("#"+p).val('未认证');
					}else if (_value=='20'){
                        $("#"+p).val('认证中');
                    }else if (_value=='30'){
                        $("#"+p).val('已认证');
                    }
				}else {
                    $("#"+p).val(_value);
				}
            }
        }
    }

</script>
</body>
</html>

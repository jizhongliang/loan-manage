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

			<blockquote class="h-elem-quote">订单信息</blockquote>
			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">订单号：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="orderNo" name="orderNo" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">借款人姓名：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="name" name="name" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">手机号码：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="mobile" name="mobile" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">消费场景：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="scenes" name="scenes" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">可借款金额(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="amount" name="amount" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">分期数：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="periods" name="periods" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款利息(元)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="interest" name="interest" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款日利率(%)：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="rate" name="rate" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">借款时间：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="createTime" name="createTime" disabled></span>
					</div>
				</div>
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">当前状态：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-leg" id="state" name="state" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label" style="text-align:right">借款地址：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-xxl" style="width: 625px" id="address" name="address" disabled></span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label">备注：</label>
					<div class="col-xs-7">
						<span><input type="text" class="input-xxl" style="width: 625px" id="remark" name="remark" disabled></span>
					</div>
				</div>
			</div>

			<blockquote class="h-elem-quote">人工审核</blockquote>

			<div class="row">
				<div class="col-xs-6 user-info-group">
					<label class="col-xs-5 control-label">审核操作：</label>
					<div class="col-xs-7">
						<span><select class="select-leg" id="status" name="status">
							<option value="26" selected>审核通过</option>
							<option value="27">审核拒绝</option>
						</select></span>
					</div>
				</div>
			</div>
			<div class="row" style="margin-bottom: 80px">
				<div class="col-xs-12 user-info-group">
					<label class="col-xs-5 control-label">备注说明：</label>
					<div class="col-xs-7">
						<span><textarea id="remarks" name="remarks" ></textarea></span>
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
        });

        if(!FsUtils.isEmpty(id)){
            $.ajax({
                type: "POST",
                url:"${path}/riskMana/creditBorrowDetail.shtml",
                data:{id:id},
                error: function(request) {
                    layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success == true){
//                      console.log(ret);
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

        $("#submitbtn").click(function () {
            var ele = $(this);
            var remark = $("#remarks").val();
            var status = $("#status").val();

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
                    url:"${path}/riskMana/creditBorrowAudit.shtml",
                    error: function(request) {
                        parent.layer.msg("网络异常，操作失败");
                        restore_Btn_submit(ele);
                    },
                    success: function(ret) {
//                        console.log(ret);
                        if(ret.success==true){
                            parent.reloadAjax();
                            parent.layer.close(layerUpload);
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
            }else if (typeof(obj[p])=="boolean"){
                if (obj[p]==true){
                    $("#"+p).val("是");
				}else if (obj[p]==false){
                    $("#"+p).val("否");
                }
			}else{
                var _value = obj[p];
                if (obj[p]=="22"){
                    $("#"+p).val("待人工审核");
                }else if (obj[p]=="27"){
                    $("#"+p).val("人工审核失败");
                }else if (obj[p]=="30"){
                    $("#"+p).val("人工审核成功");
                }else if (obj[p]=="31"){
                    $("#"+p).val("放款失败");
                }else if (obj[p]=="40"){
                    $("#"+p).val("已还款");
                }else if (obj[p]=="41"){
                    $("#"+p).val("减免还款");
                }else if (obj[p]=="50"){
                    $("#"+p).val("已逾期");
                }else if (obj[p]=="90"){
                    $("#"+p).val("坏账");
                }else {
                    $("#"+p).val(_value);
				}
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

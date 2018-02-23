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
		.layui-table td, .layui-table th{
			padding: 10px 8px;
			font-size: 8px;
			word-break: break-all;
		}

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
			<blockquote class="h-elem-quote">还款计划</blockquote>
			<div>
				<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
					<thead class="h-table-head">
					<tr>
						<th>还款金额(元)</th>
						<th>应还本金(元)</th>
						<th>应还利息(元)</th>
						<th>逾期天数</th>
						<th>逾期金额(元)</th>
						<th>实际还款(元)</th>
						<th>剩余本金(元)</th>
						<th>还款日期</th>
						<th>期数</th>
						<th>状态</th>
					</tr>
					</thead>
				</table>
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
        $.ajax({
            type: "POST",
            data:{id:id},
            url:"${path}/repayMana/repaymentDetail.shtml",
            async: false,
            error: function(request) {
                parent.layer.msg("网络异常，操作失败");
                restore_Btn_submit(ele);
            },
            success: function(ret) {
                if(ret.success==true){
//                    console.log(ret);
                    var data = ret.data;
                    var plans = data.plans;
                    var searchtable =  $('#table_list').dataTable({
                        "bSort":false,
                        "searching": false,
                        "bLengthChange": false,
                        "iDisplayLength":10,
                        "data": plans,
                        "columns": [
                            { "data": "amount","sClass":"txt-cen" },
                            { "data": "realAmount","sClass":"txt-cen" },
                            { "data": "interest","sClass":"txt-cen" },
                            { "data": "penaltyDay","sClass":"txt-cen" },
                            { "data": "penaltyAmout","sClass":"txt-cen" },
                            { "data": "repayAmount","sClass":"txt-cen" },
                            { "data": "realAmountBalance","sClass":"txt-cen" },
                            { "data": "repayDate","sClass":"maxWidth" },
                            { "data": "seq","sClass":"txt-cen" },
                            { "data": "state" }
                        ],
                        "aoColumnDefs": [
                            {
                                sDefaultContent: '',
                                aTargets: [ '_all' ]
                            }
                        ],
                        "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                            var d=new Date(aData.repayDate)
                            var date = formatDate(d)
                            $('td:eq(7)', nRow).html(date);
                            if(aData.state == "10"){
                                $('td:eq(9)', nRow).html('已还款');
                            }else if(aData.state == "20"){
                                $('td:eq(9)', nRow).html('<span class="font-red">未还款</span>');
                            }
                        },
                        'language': {
                            'search': ''
                        }
                    });

                }else{
                    parent.layer.msg("操作失败! "+ret.message);
                    restore_Btn_submit(ele);
                }
            }
        });

    });

    function  formatDate(now){
        var year=now.getFullYear();
        var month=now.getMonth()+1;
        var date=now.getDate();
        var hour=now.getHours();
        var minute=now.getMinutes();
        var second=now.getSeconds();
        return year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
    }

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
                }else if (obj[p]=="26"){
                    $("#"+p).val("人工审核成功");
                }else if (obj[p]=="27"){
                    $("#"+p).val("人工审核失败");
                }else if (obj[p]=="30"){
                    $("#"+p).val("放款成功");
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

    function restore_Btn_submit(_index) {
        _index.attr('disabled', false);
        _index.val(' 保 存 ');
    }

</script>
</body>
</html>

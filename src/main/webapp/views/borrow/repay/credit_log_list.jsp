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
		body{min-width: 1000px; font-size: 12px; line-height: 1.5em; background-color: #f2f2f2; }
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
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<ul class="layui-tab-title hwc-nav-ul">
		<li class="layui-this">信用还款记录</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="search-list">
						<form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
							<p class="ml40 mb10">
								<label class="f-12">还款方式：</label>
								<select class="select-normal"  name="repayWay" id="repayWay">
									<option value="">全部</option>
									<option value="10">代扣</option>
									<option value="20">银行卡转账</option>
									<option value="30">支付宝转账</option>
								</select>
								<label class="f-12">订单号：</label>
								<input type="text" class="input-normal" id="orderNo" name="orderNo"/>
								<label class="f-12 ml15">手机号码：</label>
								<input type="text" class="input-normal" id="mobile" name="mobile"/>
								<label class="f-12 ml15">还款日期：</label>
								<input type="text" name="showTime" id="showTime" class="input-leg key-order-text" placeholder="开始日期 ~ 结束日期" readonly>
								<span>
									<a href="javascript:;" class="btn btn-small btn-blue ml15" id="search" style="font-size: 13px">搜索</a>
									<a class="btn btn-small btn-green-w" href="javascript:location.replace(location.href);" title="刷新" style="font-size: 13px"><i class="fa fa-refresh" aria-hidden="true"></i></a>
								</span>
							</p>
						</form>
					</div>
					<div style="clear: both"></div>
				</div>
				<div style="position: relative; border-radius: 6px 6px 0 0;">
					<div class="h-table-processing" id="processing" style="display: none;"></div>
					<div>
						<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
							<thead class="h-table-head">
							<tr>
								<th>订单号</th>
								<th>姓名</th>
								<th>手机号</th>
								<th>借款金额(元)</th>
								<th>分期数</th>
								<th>应还金额(元)</th>
								<th>逾期天数</th>
								<th>逾期金额(元)</th>
								<th>应还总金额(元)</th>
								<th>应还期数</th>
								<th>还款账号</th>
								<th>还款方式</th>
								<th>借款日期</th>
								<th>还款日期</th>
							</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    var searchtable;
    $(function(){
        searchtable =  $('#table_list').dataTable({
            "bSort":false,
            "searching": false,
            "processing": true,
            "serverSide": true,
            "bFilter": true,
            "bLengthChange": false,
            "iDisplayLength":10,
            "ajax": {
                "url": "${path}/repayMana/withholdCreditList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.orderNo=$("#orderNo").val();
                requestData.mobile=$("#mobile").val();
                requestData.repayWay=$("#repayWay").val();
                requestData.showTime=$("#showTime").val();
            },
            "columns": [
                { "data": "orderNo" },
                { "data": "name" },
                { "data": "mobile" },
                { "data": "borrowAmount","sClass":"txt-cen" },
                { "data": "periods","sClass":"txt-cen" },
                { "data": "repayAmount","sClass":"txt-cen" },
                { "data": "penaltyDay","sClass":"txt-cen" },
                { "data": "penaltyAmout","sClass":"txt-cen" },
                { "data": "repayTotalAmount","sClass":"txt-cen" },
                { "data": "repay_period","sClass":"txt-cen" },
                { "data": "repayAccount" },
                { "data": "repayWay" },
                { "data": "repayTime" },
                { "data": "payTime" }
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                if(aData.repayWay == "10"){
                    $('td:eq(11)', nRow).html('代扣');
                }else if(aData.repayWay == "20"){
                    $('td:eq(11)', nRow).html('银行卡转账');
                }else if(aData.repayWay == "30"){
                    $('td:eq(11)', nRow).html('支付宝转账');
                }

            },
            'language': {
                'search': ''
            }
        });

        // 搜索
        $("#search").click(function(){
            searchtable.fnDraw();
        });

        layui.use(['laydate', 'layer'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;

            //日期范围
            laydate.render({
                elem: '#showTime',
                range: "~"
            });
        });
    });
</script>
</body>
</html>

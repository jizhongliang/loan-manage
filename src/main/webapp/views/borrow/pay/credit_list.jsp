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
		<li class="layui-this">信用支付</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="search-list">
						<form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
							<p class="ml40 mb10">
								<label class="f-12">手机号码：</label>
								<input type="text" class="input-normal" id="mobile" name="mobile"/>
								<label class="f-12 ml15">订单号：</label>
								<input type="text" class="input-normal" id="orderNo" name="orderNo"/>
								<label class="f-12 ml15">业务场景：</label>
								<select class="select-normal"  name="scenes" id="scenes">
									<option value="">全部</option>
									<option value="10">放款</option>
									<option value="11">分润</option>
									<option value="12">退还</option>
									<option value="20">还款</option>
									<option value="21">补扣</option>
								</select>
								<label class="f-12  ml15">支付状态：</label>
								<select class="select-normal"  name="state" id="state">
									<option value="">全部</option>
									<option value="10">待支付</option>
									<option value="15">待审核</option>
									<option value="20">审核通过</option>
									<option value="30">审核不通过</option>
									<option value="40">支付成功</option>
									<option value="50">支付失败</option>
								</select>
							</p>
							<p class="ml40">
								<label class="f-12">借款时间：</label>
								<input type="text" name="showTime" id="showTime" class="input-leg key-order-text" placeholder="开始日期 ~ 结束日期">
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
								<th>收款人姓名</th>
								<th>手机号码</th>
								<%--<th>流水号</th>--%>
								<th>借款金额</th>
								<th>收款人银行卡</th>
								<th>借款时间</th>
								<th>打款时间</th>
								<th>业务场景</th>
								<th>支付状态</th>
								<th>反馈</th>
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
                "url": "${path}/payMana/creditlogList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.mobile=$("#mobile").val();
                requestData.showTime=$("#showTime").val();
                requestData.state=$("#state").val();
                requestData.scenes=$("#scenes").val();
                requestData.orderNo=$("#orderNo").val();
            },
            "columns": [
                { "data": "orderNo" },
                { "data": "name" },
                { "data": "mobile"},
//                { "data": "mobile"},
                { "data": "amount","sClass":"txt-cen"},
                { "data": "bankCardNo" },
                { "data": "borrowTime" },
                { "data": "payTime" },
                { "data": "scenes","sClass":"txt-cen" },
                { "data": "state" },
                { "data": "remark","sClass":"maxWidth" }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {

                if (aData.state =='10'){
                    $('td:eq(9)', nRow).html("待支付");
                }else if (aData.state =='15'){
                    $('td:eq(9)', nRow).html("待审核");
                }else if (aData.state =='20'){
                    $('td:eq(9)', nRow).html("审核通过");
                }else if (aData.state =='30'){
                    $('td:eq(9)', nRow).html("审核不通过");
                }else if (aData.state =='40'){
                    $('td:eq(9)', nRow).html("支付成功");
                }else{
                    $('td:eq(9)', nRow).html("<span class='font-red'>支付失败</span>");
                }
                if (aData.scenes =='10'){
                    $('td:eq(8)', nRow).html("放款");
                }else if (aData.scenes =='11'){
                    $('td:eq(8)', nRow).html("分润");
                }else if (aData.scenes =='12'){
                    $('td:eq(8)', nRow).html("退还");
                }else if (aData.scenes =='20'){
                    $('td:eq(8)', nRow).html("还款");
                }else{
                    $('td:eq(8)', nRow).html("补扣");
                }
            },
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
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

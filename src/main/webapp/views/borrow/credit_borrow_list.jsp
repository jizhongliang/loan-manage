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
		.layui-table tr:last-child td {
			max-width: 180px;
		}
	</style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<ul class="layui-tab-title hwc-nav-ul">
		<li class="layui-this">信用借款订单</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="search-list">
						<form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
							<p class="ml40 mb10">
								<label class="f-12">订单状态：</label>
								<select class="select-normal"  name="state" id="state">
									<option value="">全部</option>
									<option value="22">待人工复审</option>
									<option value="26">人工复审通过</option>
									<option value="27">人工复审不通过</option>
									<option value="30">放款成功</option>
									<option value="31">放款失败</option>
									<option value="40">已还款</option>
									<option value="41">减免还款</option>
									<option value="50">已逾期</option>
									<option value="90">坏账</option>
								</select>
								<label class="f-12 ml15">订单号：</label>
								<input type="text" class="input-normal" id="orderNo" name="orderNo"/>
								<label class="f-12 ml15">手机号码：</label>
								<input type="text" class="input-normal" id="mobile" name="mobile"/>
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
								<th>用户姓名</th>
								<th>手机号</th>
								<th>借款金额(元)</th>
								<th>借款期限(天)</th>
								<th>分期数(月)</th>
								<th>借款利率(%)</th>
								<th>利息(元)</th>
								<th>申请时间</th>
								<th>状态</th>
								<th>备注</th>
								<th>操作</th>
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
                "url": "${path}/borrowMana/borrowCreditList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.state=$("#state").val();
                requestData.orderNo=$("#orderNo").val();
                requestData.mobile=$("#mobile").val();
                requestData.showTime=$("#showTime").val();
            },
            "columns": [
                { "data": "orderNo"},
                { "data": "name"},
                { "data": "mobile"},
                { "data": "amount","sClass":"txt-cen"},
                { "data": "timeLimit","sClass":"txt-cen"},
                { "data": "periods","sClass":"txt-cen"},
                { "data": "rate","sClass":"txt-cen"},
                { "data": "interest","sClass":"txt-cen"},
                { "data": "createTime"},
                { "data": "state"},
                { "data": "remark","sClass":"maxWidth"},
                { "data": ""}
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                var a = {
                    'editTable':
                    '<a href="javascript:;" onclick=info(\"'+aData.id+'\")>详细信息</a>'
                }
                $('td:eq(11)', nRow).html(a.editTable);
                if (aData.state =='22'){
                    $('td:eq(9)', nRow).html('待人工复审');
                }else if (aData.state =='27'){
                    $('td:eq(9)', nRow).html('人工复审不通过');
                }else if (aData.state =='26'){
                    $('td:eq(9)', nRow).html('人工复审通过');
                }else if (aData.state =='30'){
                    $('td:eq(9)', nRow).html('放款成功');
                }else if (aData.state =='31'){
                    $('td:eq(9)', nRow).html('放款失败');
                }else if (aData.state =='40'){
                    $('td:eq(9)', nRow).html('已还款');
                }else if (aData.state =='41'){
                    $('td:eq(9)', nRow).html('减免还款');
                }else if (aData.state =='50'){
                    $('td:eq(9)', nRow).html('已逾期');
                }else{
                    $('td:eq(9)', nRow).html('坏账');
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

    function info(id){
        layer.open({
            type: 2,
            title: '订单信息',
            area: ['1000px', '85%'],
            fix: true, //不固定
            resize: false,
            maxmin: false,
            content: "${path}/borrowMana/creditBorrowInfoPage.shtml?id="+id
        });
    }


</script>
</body>
</html>

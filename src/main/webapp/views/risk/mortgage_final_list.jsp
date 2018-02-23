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
		<li class="layui-this">车位终审</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="search-list">
						<form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
							<p class="ml40">
								<label class="f-12">订单号：</label>
								<input type="text" class="input-leg" id="orderNo" name="orderNo"/>
								<label class="f-12 ml15">手机号码：</label>
								<input type="text" class="input-normal" id="mobile" name="mobile"/>
								<label class="f-12 ml15">订单状态：</label>
								<select class="select-normal"  name="status" id="status">
									<option value="30">待终审订单</option>
									<option value="40">终审通过</option>
									<option value="50">已提现</option>
									<option value="60">审核被拒绝</option>
									<option value="70">冻结订单</option>
								</select>
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
								<th>借款额度</th>
								<th>申请时间</th>
								<th>抵押物城市</th>
								<th>抵押物地址</th>
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
                "url": "${path}/riskMana/mortgageTrialList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.status=$("#status").val();
                requestData.orderNo=$("#orderNo").val();
                requestData.mobile=$("#mobile").val();
            },
            "columns": [
                { "data": "orderNo"},
                { "data": "userName"},
                { "data": "mobile"},
                { "data": "borrowAmount","sClass":"txt-cen"},
                { "data": "applyDate"},
                { "data": "dyCity"},
                { "data": "dyAddress"},
                { "data": "status"},
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
                    '<a onclick=audit(\"' + aData.id + '\");>人工审核</a> | <a onclick=upload(\"' + aData.id + '\",\"' + aData.userId + '\");>上传用户证明</a> '
                }

                if (aData.status =='10'){
                    $('td:eq(7)', nRow).html('新申请');
                }else if (aData.status =='20'){
                    $('td:eq(7)', nRow).html('通过初审');
                }else if (aData.status =='30'){
                    $('td:eq(7)', nRow).html('待终审');
                    $('td:eq(9)', nRow).html(a.editTable);
                }else if (aData.status =='40'){
                    $('td:eq(7)', nRow).html('终审通过');
                }else if (aData.status =='50'){
                    $('td:eq(7)', nRow).html('已提现');
                }else if (aData.status =='60'){
                    $('td:eq(7)', nRow).html('审核被拒绝');
                }else{
                    $('td:eq(7)', nRow).html('冻结 ');
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
        });
    });

    //上传图片
    function upload(id,userId){
        layer.open({
            type: 2,
            title: '上传图片证明',
            area: ['600px', '450px'],
            fix: true, //不固定
            resize: false,
            maxmin: false,
            content: "${path}/riskMana/mortgageUpImagepage.shtml?cat=O&userId="+userId+"&id="+id
        });
    }

    //审核操作
    function audit(id){
        layer.open({
            type: 2,
            title: '人工审核',
            area: ['900px', '70%'],
            fix: true, //不固定
            resize: false,
            maxmin: false,
            content: "${path}/riskMana/mortgageAuditPage.shtml?status=40&id="+id
        });
    }

    function reloadAjax(){
        var table = $("#table_list").DataTable();
        table.ajax.reload(null,false);
    }
</script>
</body>
</html>

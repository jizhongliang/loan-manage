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
<input type="hidden" name="type" id="type" value="${param.type}">
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<ul class="layui-tab-title hwc-nav-ul">
		<li class="layui-this">认证信息</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="search-list">
						<form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
							<p class="ml25">
								<label class="f-12" style="margin-left: 3px;">银行卡状态：</label>
								<select class="select-sm" id="bankCardState" name="bankCardState">
									<option value="">全部</option>
									<option value="10">未认证</option>
									<option value="20">认证中</option>
									<option value="30">已认证</option>
								</select>
								<label class="ml15 f-12">紧急联系人状态：</label>
								<select class="select-sm" id="contactState" name="contactState">
									<option value="">全部</option>
									<option value="10">未完善</option>
									<option value="20">完善中</option>
									<option value="30">已认证</option>
								</select>
								<label class="ml15 f-12" style="margin-left: 3px;">身份证认证状态：</label>
								<select class="select-sm" id="idState" name="idState">
									<option value="">全部</option>
									<option value="10">未认证</option>
									<option value="20">认证中</option>
									<option value="30">已认证</option>
								</select>
								<%--<label class="ml15 f-12">工作认证状态：</label>--%>
								<%--<select class="select-sm" id="workInfoState" name="workInfoState">--%>
									<%--<option value="">全部</option>--%>
									<%--<option value="10">未完善</option>--%>
									<%--<option value="20">完善中</option>--%>
									<%--<option value="30">已认证</option>--%>
								<%--</select>--%>
								<label class="ml15 f-12">人行征信状态：</label>
								<select class="select-sm" id="creditState" name="creditState">
									<option value="">全部</option>
									<option value="10">未认证</option>
									<option value="20">认证中</option>
									<option value="30">已认证</option>
								</select>
							</p>
							<p class="mt10 ml40">
								<label class="f-12">真实姓名：</label>
								<input type="text" class="input-sm key-order-text" id="realName" name="realName"/>
								<label class="f-12" style="margin-left: 51px">手机号码：</label>
								<input type="text" class="input-sm key-order-text" id="phone" name="phone"/>
								<span>
									<a href="javascript:;" class="btn btn-small btn-blue ml15" id="search" style="font-size: 13px">搜索</a>
									<a href="javascript:;" class="btn btn-small btn-red" id="clearForm" style="font-size: 13px">清空条件</a>
									<a class="btn btn-small btn-green-w" href="javascript:location.replace(location.href);" title="刷新" style="font-size: 13px"><i class="fa fa-refresh" aria-hidden="true"></i></a>
								</span>
							</p>
						</form>
					</div>
					<div style="clear: both"></div>
				</div>
				<div style="position: relative;">
					<div class="h-table-processing" id="processing" style="display: none;"></div>
					<div>
						<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
							<thead class="layui-table-head">
							<tr>
								<th>真实姓名</th>
								<th>手机号码</th>
								<th>用户类型</th>
								<th>银行卡状态</th>
								<th>紧急联系人状态</th>
								<th>身份认证状态</th>
								<%--<th>工作认证状态</th>--%>
								<th>人行征信状态</th>
							</tr>
							</thead>
						</table>
					</div>
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
                "url": "${path}/userMana/searchUserAuthList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.realName=$("#realName").val();
                requestData.phone=$("#phone").val();
                requestData.bankCardState=$("#bankCardState").val();
                requestData.contactState=$("#contactState").val();
                requestData.idState=$("#idState").val();
                requestData.workInfoState=$("#workInfoState").val();
                requestData.creditState=$("#creditState").val();
                requestData.type=$("#type").val();
            },
            "columns": [
                { "data": "realName" },
                { "data": "phone" },
                { "data": "cat" },
                { "data": "bankCardState" },
                { "data": "contactState" },
                { "data": "idState" },
//                { "data": "workInfoState" },
                { "data": "creditState" },
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                if (aData.cat =='10'){
                    $('td:eq(2)', nRow).html('信用分期');
                }else if (aData.cat =='20'){
                    $('td:eq(2)', nRow).html('车位分期');
                }
                if (aData.bankCardState =='10'){
                    $('td:eq(3)', nRow).html('未认证');
                }else if (aData.bankCardState =='20'){
                    $('td:eq(3)', nRow).html('认证中');
                }else if (aData.bankCardState =='30'){
                    $('td:eq(3)', nRow).html('已认证');
				}
                if (aData.contactState =='10'){
                    $('td:eq(4)', nRow).html('未完善');
                }else if (aData.contactState =='20'){
                    $('td:eq(4)', nRow).html('完善中');
                }else if (aData.contactState =='30'){
                    $('td:eq(4)', nRow).html('已完善');
                }
                if (aData.idState =='10'){
                    $('td:eq(5)', nRow).html('未认证');
                }else if (aData.idState =='20'){
                    $('td:eq(5)', nRow).html('认证中');
                }else if (aData.idState =='30'){
                    $('td:eq(5)', nRow).html('已认证');
                }
//                if (aData.workInfoState =='10'){
//                    $('td:eq(6)', nRow).html('未完善');
//                }else if (aData.workInfoState =='20'){
//                    $('td:eq(6)', nRow).html('完善中');
//                }else if (aData.workInfoState =='30'){
//                    $('td:eq(6)', nRow).html('已完善');
//                }
                if (aData.creditState =='10'){
                    $('td:eq(6)', nRow).html('未认证');
                }else if (aData.creditState =='20'){
                    $('td:eq(6)', nRow).html('认证中');
                }else if (aData.creditState =='30'){
                    $('td:eq(6)', nRow).html('已认证');
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
        $("#clearForm").click(function(){
            $("#order-filter-form")[0].reset();
        });
    });

    function reloadAjax(){
        var table = $("#table_list").DataTable();
        table.ajax.reload(null,false);
    }
</script>
</body>
</html>

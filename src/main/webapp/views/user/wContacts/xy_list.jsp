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
		<li class="layui-this">信用白名单</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="search-list">
						<form class="f-12" id="order-filter-form" onsubmit="return false;" autocomplete="off">
							<p class="ml40">
								<label class="f-12">真实姓名：</label>
								<input type="text" class="input-leg key-order-text" id="realName" name="realName"/>
								<label class="ml15 f-12">手机号码：</label>
								<input type="text" class="input-leg key-order-text" id="phone" name="phone"/>
								<label class="ml15 f-12">证件号码：</label>
								<input type="text" class="input-leg key-order-text" id="idNo" name="idNo"/>
							</p>
							<p class="mt10 ml40">
								<label class="f-12">名单类型：</label>
								<select class="select-leg" id="registerClient" name="registerClient" disabled>
									<option value="">全部</option>
									<option value="xy" <c:if test="${param.type == null || param.type == '10'}">selected</c:if>>信用分期</option>
									<option value="dy" <c:if test="${param.type == '20'}">selected</c:if>>车位分期</option>
								</select>
								<label class="ml15 f-12">名单来源：</label>
								<input type="text" class="input-leg key-order-text">
								<%--<label class="ml15 f-12">导入时间：</label>--%>
								<%--<input type="text" name="showTime" id="showTime" class="input-leg key-order-text" placeholder="开始日期 ~ 结束日期" readonly>--%>
								<span>
									<a href="javascript:;" class="btn btn-small btn-blue ml15" id="search" style="font-size: 13px">搜索</a>
									<a href="javascript:;" class="btn btn-small btn-red" id="clearForm" style="font-size: 13px">清空条件</a>
									<a href="javascript:;" class="btn btn-small btn-pink" id="import" style="font-size: 13px">导入</a>
									<a href="http://caiwei.oss-cn-hangzhou.aliyuncs.com/static/excelTemp/%E4%BF%A1%E7%94%A8%E5%88%86%E6%9C%9F%E7%99%BD%E5%90%8D%E5%8D%95%E6%A8%A1%E6%9D%BF.xlsx" target="_blank" class="btn btn-small btn-cyan" style="font-size: 12px"><i class="fa fa-cloud-download" aria-hidden="true"></i> 下载信用模板</a>
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
								<th>真实姓名</th>
								<th>手机号码</th>
								<th>提示号码</th>
								<th>学历</th>
								<th>个人年收入(万元)</th>
								<th>工作单位</th>
								<th>单位性质</th>
								<th>职业</th>
								<th>楼盘名称</th>
								<th>按揭贷款期限</th>
								<th>按揭贷款额</th>
								<th>按揭月还款额</th>
								<th>按揭贷款余额</th>
								<th>按揭已还利息</th>
								<th>还款来源</th>
								<th>风险等级</th>
								<th>预设额度</th>
								<th>预设利率(%)</th>
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
                "url": "${path}/wContactsMana/searchWContactsList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.idNo=$("#idNo").val();
                requestData.realName=$("#realName").val();
                requestData.phone=$("#phone").val();
                requestData.registerClient=$("#registerClient").val();
                requestData.channelId=$("#channelId").val();
                requestData.cat=$("#cat").val();
                requestData.showTime=$("#showTime").val();
                requestData.type=$("#type").val();
            },
            "columns": [
                { "data": "name" },
                { "data": "phone" },
                { "data": "tipsPhone" },
                { "data": "education" },
                { "sClass":"txt-cen","data": "personIncome" },
                { "data": "companyName" },
                { "data": "companyType" },
                { "data": "vocation" },
                { "data": "liveCommunity" },
                { "sClass":"txt-cen","data": "quotaExpire" },
                { "sClass":"txt-cen","data": "creditLines" },
                { "sClass":"txt-cen","data": "monthRepayBalance" },
                { "sClass":"txt-cen","data": "unuseBorrowBalance" },
                { "sClass":"txt-cen","data": "oldRepayRate" },
                { "sClass":"txt-cen","data": "src" },
                { "sClass":"txt-cen","data": "riskLevel" },
                { "sClass":"txt-cen","data": "borrowQuota" },
                { "sClass":"txt-cen","data": "borrowRate" },
                { "data": "" },
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
                    '<a href="javascript:;" onclick="updata('+aData.id+');">编辑</a>'
                }
                $('td:eq(18)', nRow).html(a.editTable);
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

        // 重置
        $("#clearForm").click(function(){
            $("#order-filter-form")[0].reset();
        });

        // 导入
        $("#import").click(function(){
            var type = $("#type").val(),str='';
            if(type=='20'){
                str ="车位分期";
			}else {
                str ="信用分期";
			}
            layer.open({
                type: 2,
                title: '导入【<span class="font-red">'+str+'</span>】白名单',
                area: ['450px', '350px'],
                fix: true, //不固定
                resize: false,
                maxmin: false,
                content: "${path}/wContactsMana/importWContactsPage.shtml?type="+type
            });
        });
    });

    // 编辑
    function updata(id) {
        layer.open({
            type: 2,
            title: '编辑信用白名单',
            area: ['900px', '80%'],
            fix: true, //不固定
            resize: false,
            maxmin: false,
            content: "${path}/wContactsMana/editWContactsPage.shtml?id="+id
        });
    }

    function reloadAjax(){
        var table = $("#table_list").DataTable();
        table.ajax.reload(null,false);
    }

</script>
</body>
</html>

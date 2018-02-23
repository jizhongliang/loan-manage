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
		<li class="layui-this">用户列表</li>
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
							<p class="mt10 ml25">
								<label class="f-12" style="margin-left: 3px;">注册客户端：</label>
								<select class="select-leg" id="registerClient" name="registerClient">
									<option value="">全部</option>
									<option value="android">安卓</option>
									<option value="ios">IOS</option>
									<option value="wx">微信
									</option>
								</select>
								<label class="ml15 f-12">注册渠道：</label>
								<select class="select-leg" id="channelId" name="channelId">
									<option value="">全部</option>
									<option value="android">安卓</option>
									<option value="ios">IOS</option>
									<option value="h5">H5页面</option>
								</select>
								<label class="ml15 f-12">用户类型：</label>
								<select class="select-leg" id="cat" name="cat" disabled>
									<option value="">全部</option>
									<option value="10" <c:if test="${param.type == null || param.type == '10'}">selected</c:if>>信用分期</option>
									<option value="20" <c:if test="${param.type == '20'}">selected</c:if>>车位分期</option>
								</select>
							</p>
							<p class="mt10 ml40">
								<label class="f-12">注册时间：</label>
								<input type="text" name="showTime" id="showTime" class="input-leg key-order-text" placeholder="开始日期 ~ 结束日期" readonly>
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
				<div style="position: relative; border-radius: 6px 6px 0 0;">
					<div class="h-table-processing" id="processing" style="display: none;"></div>
					<div>
						<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
							<thead class="h-table-head">
							<tr>
								<th>手机号码</th>
								<th>真实姓名</th>
								<th>身份证号码</th>
								<th>注册时间</th>
								<th>推广渠道</th>
								<th>注册客户端</th>
								<th>注册渠道</th>
								<th>状态</th>
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
                "url": "${path}/userMana/searchUserList.shtml"
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
                { "data": "loginName" },
                { "data": "realName" },
                { "data": "idNo" },
                { "data": "createTime" },
                { "data": "changed" },
                { "data": "registerClient" },
                { "data": "changed" },
                { "data": "state" },
                { "data": "changed" }
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
                    '<a href="javascript:;" onclick="userInfo('+aData.id+');">查看</a> | <a href="javascript:;" onclick="addBlacklist('+aData.id+');">加入黑名单</a>'
                }
                var b = {
                    'editTable':
                    '<a href="javascript:;" onclick="userInfo('+aData.id+');">查看</a> | <a href="javascript:;" onclick="relieveBlacklist('+aData.id+');">解除黑名单</a> '
                }

                if (aData.state =='10'){
                    $('td:eq(7)', nRow).html('<span class="font-gray">黑名单</span>');
                    $('td:eq(8)', nRow).html(b.editTable);
                }else if (aData.state =='20'){
                    $('td:eq(7)', nRow).html('正常');
                    $('td:eq(8)', nRow).html(a.editTable);
                }else {
                    $('td:eq(7)', nRow).html('<span class="font-red">骗贷</span>');
                    $('td:eq(8)', nRow).html(b.editTable);
                }
                if (aData.registerClient =='android'){
                    $('td:eq(5)', nRow).html('安卓');
                }else if (aData.registerClient =='ios'){
                    $('td:eq(5)', nRow).html('IOS');
                }else if (aData.registerClient =='wx'){
                    $('td:eq(5)', nRow).html('微信');
                }else {
                    $('td:eq(5)', nRow).html('H5页面');
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

    // 编辑
    function userInfo(id) {
        layer.open({
            type: 2,
            title: '用户详情',
            area: ['80%', '80%'],
            fix: true, //不固定
            resize: false,
            maxmin: false,
            content: "${path}/userMana/searchUserInfoPage.shtml?id="+id
        });
    }

    // 编辑
    function userInfoMsg(id) {
        layer.open({
            type: 2,
            title: '查看详情',
            area: ['900px', '80%'],
            fix: true, //不固定
            resize: false,
            maxmin: false,
            content: "${path}/userMana/searchUserInfoMsgPage.shtml?id="+id
        });
    }

    function addBlacklist(id){
        layer.confirm('您确认将该用户移入黑名单？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            $.post("${path}/userMana/addBlacklist.shtml",{id:id},function(result){
                if(result.success == true){
                    reloadAjax();
                    layer.msg("操作成功!");
                }else{
                    layer.msg("操作失败! "+result.message);
                }
            });
        }, function(){

        });
    }

    function relieveBlacklist(id){
        layer.confirm('您确认将该用户解除黑名单？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            $.post("${path}/userMana/relieveBlacklist.shtml",{id:id},function(result){
                if(result.success == true){
                    reloadAjax();
                    layer.msg("操作成功!");
                }else{
                    layer.msg("操作失败! "+result.message);
                }
            });
        }, function(){

        });
    }

    function reloadAjax(){
        var table = $("#table_list").DataTable();
        table.ajax.reload(null,false);
    }
</script>
</body>
</html>

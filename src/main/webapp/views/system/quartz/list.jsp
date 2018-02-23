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
		<li class="layui-this">定时列表</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="js-list-filter-region clearfix ui-box" style="position: relative; margin-bottom: 15px;">
						<div class="widget-list-filter">
							<a class="btn btn-small btn-green" id="add" onclick="edit('');">新增定时</a>
						</div>
					</div>
					<div style="position: relative;">
						<div class="h-table-processing" id="processing" style="display: none;"></div>
						<div>
							<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
								<thead>
								<tr>
									<th>定时名称</th>
									<th>定时code</th>
									<th>cron配置</th>
									<th>成功次数</th>
									<th>失败次数</th>
									<th>定时状态</th>
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
                "url": "${path}/quartzMana/quartzManaList.shtml"
            },
            "fnServerParams": function ( requestData ) {
            	
            },
            "columns": [
                { "data": "name" },
                { "data": "code" },
                { "data": "cycle" },
                { "data": "succeed" },
                { "data": "fail" },
                { "data": "stateStr" },
                { "sClass":"txt-right","data": "id" }
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            	
            	var editState='<span> - </span>';
            	if(aData.state=="10"){
            		editState+='<a href="javascript:;" onclick="disable('+ aData.id+');">禁用</a>';
            	}else{
            		editState+='<a href="javascript:;" onclick="enable('+ aData.id+');">启用</a>';
            	}
            	
            	var runState='';
            	if(aData.state=="20"){
            		runState='<span> - </span><a href="javascript:;" onclick="run('+ aData.id+');">立即运行</a>';
            	}
                var a = {
                    'editTable':
                    '<a href="javascript:;" onclick="edit('+ aData.id+');">编辑</a>'+editState+runState
                    +'<span> - </span><a href="javascript:;" onclick="listLog('+ aData.id+');">执行日志</a>'
                }
                $('td:eq(6)', nRow).html(a.editTable);
            },
            'language': {
                'search': ''
            }
        });

        // 搜索
        $("#search").click(function(){
            searchtable.fnDraw();
        });
		
		layui.use('layer', function(){
            var layer = layui.layer;
        });
	})
	// 编辑
	function edit(id) {
	    layer.open({
	        type: 2,
	        title: id?'编辑定时':'新建定时',
	        area: ['400px', '400px'],
	        fix: true, //不固定
			resize: false,
	        maxmin: false,
	        content: "${path}/quartzMana/editQuartzPage.shtml?id="+id
	    });
	}
	
	
	function run(id){
		$.ajax({
            type: "POST",
            data:{id:id},
            url:"${path}/quartzMana/runQuartz.shtml",
            error: function(request) {
                parent.layer.msg("网络异常，操作失败");
            },
            success: function(ret) {
                if(ret.success==true){
                    parent.layer.msg("操作成功!");
                }else{
                    parent.layer.msg("操作失败! "+ret.message);
                }
            }
        });
	}
	
	function disable(id){
		$.ajax({
            type: "POST",
            data:{id:id},
            url:"${path}/quartzMana/disableQuartz.shtml",
            error: function(request) {
                layer.msg("网络异常，操作失败");
            },
            success: function(ret) {
                if(ret.success==true){
                	reloadAjax();
                    layer.msg("操作成功!");
                }else{
                    layer.msg("操作失败! "+ret.message);
                }
            }
        });
	}
	function enable(id){
		$.ajax({
            type: "POST",
            data:{id:id},
            url:"${path}/quartzMana/enableQuartz.shtml",
            error: function(request) {
                parent.layer.msg("网络异常，操作失败");
            },
            success: function(ret) {
                if(ret.success==true){
                	reloadAjax();
                    layer.msg("操作成功!");
                }else{
                    layer.msg("操作失败! "+ret.message);
                }
            }
        });
	}
	
	 function reloadAjax(){
         var table = $("#table_list").DataTable();
         table.ajax.reload(null,false);
     }
	
	
	 function listLog(id){
		 url="${path}/quartzMana/quartzLogManaListPage.shtml?id="+id,
		 window.location.href=url;
	 }
	 
</script>

</body>
</html>

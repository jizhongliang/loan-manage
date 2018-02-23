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
		<li class="layui-this">定时日志列表</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="js-list-filter-region clearfix ui-box" style="position: relative; margin-bottom: 15px;">
						
					</div>
					<div style="position: relative;">
						<div class="h-table-processing" id="processing" style="display: none;"></div>
						<div>
							<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
								<thead>
								<tr>
									<th>ID</th>
									<th>定时名称</th>
									<th>开始执行时间</th>
									<th>任务用时(毫秒)</th>
									<th>执行状态</th>
									<th>结果备注</th>
								</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="id" id="id" value="${id}">
</div>

<script type="text/javascript">

	$(function(){
		
		var id=$("#id").val();
		searchtable =  $('#table_list').dataTable({
            "bSort":false,
            "searching": false,
            "processing": true,
            "serverSide": true,
            "bFilter": true,
            "bLengthChange": false,
            "iDisplayLength":10,
            "ajax": {
                "url": "${path}/quartzMana/quartzLogManaList.shtml"
            },
            "fnServerParams": function ( requestData ) {
            	 requestData.id=id;
            },
            "columns": [
                { "data": "id" },
                { "data": "name" },
                { "data": "startTime" },
                { "data": "time" },
                { "data": "result" },
                { "data": "remark" }
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            	
            	if(aData.result=="10"){
            		 $('td:eq(4)', nRow).html("成功");
            	}else{
            		 $('td:eq(4)', nRow).html("<span style='color:#FF0000'>失败</span>");
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
		
		layui.use('layer', function(){
            var layer = layui.layer;
        });
	})
	
	
	 function reloadAjax(){
         var table = $("#table_list").DataTable();
         table.ajax.reload(null,false);
     }
	
	
</script>

</body>
</html>

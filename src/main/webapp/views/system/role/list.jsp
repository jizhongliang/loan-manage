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
		<li class="layui-this">角色列表</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="js-list-filter-region clearfix ui-box" style="position: relative; margin-bottom: 15px;">
						<div class="widget-list-filter">
							<a class="btn btn-small btn-green" id="add" onclick="edit('');">新增角色</a>
							<%--<div class="mr10" style="float: right;">--%>
								<%--<input type="text" class="input-normal" name="name" id="name" placeholder="请输入角色">--%>
								<%--<a class="btn btn-small btn-green" id="search">搜索</a>--%>
							<%--</div>--%>
						</div>
					</div>
					<div style="position: relative;">
						<div class="h-table-processing" id="processing" style="display: none;"></div>
						<div>
							<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
								<thead>
								<tr>
									<th>id</th>
									<th>角色</th>
									<th>标识</th>
									<th>排序</th>
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
                    "url": "${path}/roleMana/searchRoleList.shtml"
                },
                "fnServerParams": function ( requestData ) {
                    requestData.name=$("#name").val();
                },
                "columns": [
                    { "data": "id" },
                    { "data": "name" },
                    { "data": "tips" },
                    { "data": "num" },
                    { "sClass":"txt-right","data": "" }
                ],
                "aoColumnDefs": [
                    {
                        sDefaultContent: '',
                        aTargets: [ '_all' ]
                    }
                ],
                "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                    if(aData.tips!='ADMIN'){
                        var a = {
                            'editTable':
                            '<a href="javascript:;" onclick="edit('+ aData.id+');">编辑</a></li>'+
                            '<span> - </span>'+
                            '<a href="javascript:;" onclick="delCat('+ aData.id+');">删除</a></li>'+
                            '<span> - </span>'+
                            '<a href="javascript:;" onclick="dept('+ aData.id+');">管理权限</a></li>'
                        }
                        $('td:eq(4)', nRow).html(a.editTable);
					}else {
                        var a = {
                            'editTable':
                            '<a href="javascript:;" onclick="dept('+ aData.id+');">管理权限</a></li>'
                        }
                        $('td:eq(4)', nRow).html(a.editTable);
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

        });

        // 编辑
        function edit(id) {
            layer.open({
                type: 2,
                title: id?'编辑角色':'新建角色',
                area: ['360px', '330px'],
                fix: true, //不固定
                resize: false,
                maxmin: false,
                content: "${path}/roleMana/editRolePage.shtml?id="+id
            });
        }

        // 权限
        function dept(id) {
            layer.open({
                type: 2,
                title: '分配权限',
                area: ['400px', '55%'],
//                area: ['60%', '55%'],
                fix: true, //不固定
                resize: false,
                maxmin: false,
                content: "${path}/roleMana/searchDeptListPage.shtml?id="+id
            });
        }

		function delCat(id){
            layer.confirm('您确认要删除该角色？', {
                btn: ['确认','取消'] //按钮
            }, function(){
                $.post("${path}/roleMana/deleteOneRole.shtml",{id:id},function(result){
                    if(FsUtils.isEmpty(result.errorCode)){
                        reloadAjax();
                        layer.msg("删除成功!");
                    }else{
                        layer.msg("删除失败!"+result.msg);
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

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
            background: #eee;
		}
		.layui-table td, .layui-table th{
			padding: 16px 8px;
			word-break: break-all;
		}
		.layui-table tbody tr:hover, .layui-table-hover{
			background-color: #eaf8fe!important;
		}
		.layui-table[lay-skin=line] {
            margin: 0px 0px;
			border: 0px solid #e2e2e2;
		}
		.layui-table[lay-skin=line] tr {
			border-radius: 6px 6px 0 0;
		}
		.hwc-nav{width: 100%;border-bottom: solid 1px #e4eaec;}
		.hwc-con{padding: 0}
		.hwc-nav li{background:#f9f9f9;line-height: 40px;color: #999;padding: 0px 15px!important;font-size: 12px;border: solid 1px #d9d9d9;margin-right: 5px;border-top-left-radius: 5px;border-top-right-radius: 5px}
		.hwc-nav li:hover{color: #2db7f5;}
		.hwc-nav li.layui-this{background:#fff;color: #2db7f5!important; }
		.hwc-nav li.layui-this:after{border: none!important;}
	</style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<ul class="layui-tab-title hwc-nav-ul">
		<li class="layui-this">系统参数</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="js-list-filter-region clearfix ui-box" style="position: relative; margin-bottom: 15px;">
						<div class="widget-list-filter">
							<a class="btn btn-small btn-green" id="add" onclick="edit('','');">新增参数</a>
						</div>
					</div>
				</div>
				<div class="app-init-container">
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title hwc-nav">

						</ul>
						<div class="layui-tab-content hwc-con">

						</div>
					</div>
					<div style="position: relative;">
						<div class="h-table-processing" id="processing" style="display: none;"></div>
						<div>
							<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
								<thead>
								<tr>
									<th>编号</th>
									<th>参数名</th>
									<th>参数值</th>
									<th>参数类型</th>
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
</div>
	<script type="text/javascript">
        var searchtable;
        $(function(){

            var code = [],descript = [];
            $.ajax({
                type: "POST",
                url:"${path}/baseCodeMana/searchBaseCodeList.shtml",
                data:{cat:"sys_catalog",length:10000},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret.success == "true"){
                        var type = $(".hwc-nav");
                        $.each(ret.data, function(i,e) {
                            var html = "<li lay-id='" + e.code +"'>" + e.descript + "</li>";
                            var option = $(html);
                            type.append(option);
                            $(".hwc-con").append('<div class="layui-tab-item"></div>');
                            code.push(e.code);
                            descript.push(e.descript);
                        });
                        $(".hwc-nav li").eq(0).attr("class","layui-this");
                        $(".hwc-con>div").eq(0).addClass("layui-show");
                    }else{
                        parent.layer.msg("获取失败");
                    }
                }
            });

            searchtable =  $('#table_list').dataTable({
                "bSort":false,
                "searching": false,
                "processing": true,
                "serverSide": true,
                "bFilter": true,
                "bLengthChange": false,
                "iDisplayLength":10,
                "ajax": {
                    "url": "${path}/configMana/searchConfigList.shtml"
                },
                "fnServerParams": function ( requestData ) {
                    requestData.type=$(".hwc-nav").find(".layui-this").attr("lay-id");
                },
                "columns": [
                    { "data": "code" },
                    { "data": "name" },
                    { "data": "value" },
                    { "data": "type" },
                    { "data": "state" },
                    { "data": "remark" },
                    { "data": "" }
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
                        '<a href="javascript:;" onclick=edit(\"'+aData.code+'\",\"'+aData.type+'\",\"'+aData.id+'\");>编辑</a></li>'+
                        '<span> - </span>'+
                        '<a href="javascript:;" onclick=delCode(\"'+aData.id+'\");>删除</a></li>'
                    }

                    for (var i=0; i<code.length;i++){
                        if (aData.type == code[i]){
                            $('td:eq(3)', nRow).html(descript[i]);
                        }
                    }

                    $('td:eq(6)', nRow).html(a.editTable);
                    if (aData.state == "1"){
                        $('td:eq(4)', nRow).html("启用");
                    }else {
                        $('td:eq(4)', nRow).html("<span class='font-red'>停用</span>");
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
            $(".hwc-nav li").click(function(){
                setTimeout(function () {
                    searchtable.fnDraw();
                },50);
            });

            layui.use(['layer','element'], function(){
                var layer = layui.layer;
                var element = layui.element;
            });

        });

        // 编辑
        function edit(code,type,id) {
            layer.open({
                type: 2,
                title: id?'编辑参数':'新增参数',
                area: ['380px', '420px'],
                fix: true, //不固定
				resize: false,
                maxmin: false,
                content: "${path}/configMana/editConfigPage.shtml?code="+code+"&type="+type+"&id="+id
            });
        }

		function delCode(id){
            layer.confirm('您确认要删除该参数？', {
                btn: ['确认','取消'] //按钮
            }, function(){
                $.post("${path}/configMana/delOneConfig.shtml",{id:id},function(result){
                    if(result.success == true){
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

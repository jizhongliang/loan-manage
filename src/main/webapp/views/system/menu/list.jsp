<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@include file="/common/common.jspf"%>
	<!-- page scripts & css -->
	<script src="${path}/common/plugins/zTree/js/jquery.ztree.all.min.js"></script>
	<link rel="stylesheet" href="${path}/common/plugins/zTree/css/zTreeStyle/zTreeStyle.css">

	<style>
		body{min-width: 1000px; font-size: 12px; line-height: 1.5em; background-color: #f2f2f2; }
		.bg{background: #eaf8fe!important}
		/*ztree表格*/
		.ztree {padding: 0; border: 0;  }
		.ztree li a {vertical-align: middle;height: 40px; }
		.ztree li a:hover{background: #eaf8fe}
		.ztree li > a {width: 100%;}
		.ztree li > a, .ztree li a.curSelectedNode {padding-top: 0px;height: auto;cursor: pointer;opacity: 1;background: none;border-top: none;border-bottom: 1px solid #f2f2f2;border-left:none;border-right:none; }
		.ztree li ul { padding-left: 0px }
		.ztree div.diy span {line-height: 30px; vertical-align: middle;}
		.ztree div.diy {height: 100%;width: 20%;line-height: 40px;text-align: center;display: inline-block;box-sizing: border-box;color: #333;overflow: hidden;}
		.ztree div.diy:first-child { text-align: left; padding-left: 10px; text-indent: 10px; border-left: none;}
		.ztree .head { background: #eee; color: #666; }
		.ztree .head div.diy { border-radius: 5px; color: #666; font-family: "Microsoft YaHei"; font-size: 14px; }
		input[type=checkbox]{z-index: 10}
	</style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<ul class="layui-tab-title hwc-nav-ul">
		<li class="layui-this">菜单管理</li>
	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="hwc-inner">
				<div class="app-init-container">
					<div class="js-list-filter-region clearfix ui-box" style="position: relative; margin-bottom: 15px;">
						<div class="widget-list-filter">
							<span class="btn btn-small btn-green-w" onclick="expandAll(true);">展开全部</span>
							<span class="btn btn-small btn-green-w" onclick="expandAll(false);">收缩所有</span>
							<a class="btn btn-small btn-green" onclick="edit('');">新建菜单</a>
							<a class="btn btn-small btn-green" id="edit">编辑菜单</a>
							<a class="btn btn-small btn-red" id="del">删除菜单</a>
						</div>
					</div>
					<div style="position: relative;">
						<div class="h-table-processing" id="processing" style="display: none;"></div>
						<form>
							<div class="layer">
								<div id="tableMain">
									<ul id="dataTree" class="ztree">

									</ul>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
        var zTreeNodes;
        var setting = {
            view: {
                showLine: false,
                showIcon: false,
                addDiyDom: addDiyDom
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "code",
                    pIdKey: "pcode",
                    rootPId: null
                }
            }
        };
        /**
         * 自定义DOM节点
         */
        function addDiyDom(treeId, treeNode) {
            var spaceWidth = 15;
            var liObj = $("#" + treeNode.tId);
            var aObj = $("#" + treeNode.tId + "_a");
            var switchObj = $("#" + treeNode.tId + "_switch");
            var icoObj = $("#" + treeNode.tId + "_ico");
            var spanObj = $("#" + treeNode.tId + "_span");
            aObj.attr('title', '');
            aObj.removeAttr('href');
            aObj.append('<div class="diy swich"></div>');
            var div = $(liObj).find('div').eq(0);
            switchObj.remove();
            spanObj.remove();
            icoObj.remove();
            div.append(switchObj);
            div.append(spanObj);
            div.prepend('<input type="checkbox" name="checkbox" value="' + treeNode.id + '" >');
            var spaceStr = "<span style='height:1px;display: inline-block;width:" + (spaceWidth * treeNode.levels) + "px'></span>";
            switchObj.before(spaceStr);
            var editStr = '';
            editStr += '<div class="diy">' + (treeNode.icon == undefined? '&nbsp;' : (treeNode.icon == "" ? '&nbsp;' : treeNode.icon)) + '</div>';
            editStr += '<div class="diy">' + (treeNode.tips == undefined? '&nbsp;' : (treeNode.tips == "" ? '&nbsp;' : treeNode.tips)) + '</div>';
            editStr += '<div class="diy">' + (treeNode.status == '' ? '&nbsp;' : treeNode.status ) + '</div>';
            editStr += '<div class="diy">' + (treeNode.ismenu == 0 ? '否' : '是' ) + '</div>';
            aObj.append(editStr);
        }
        /**
         * 查询数据
         */
        function query() {
            $.ajax({
                type: "POST",
                url:"${path}/menuMana/searchMenuList.shtml",
                data:{},
                async: false,
                error: function(request) {
                    layer.msg("网络异常，操作失败 ");
                },
                success: function(ret) {
                    if(ret){
                        $.each(ret.data,function (i,e) {
							e.open = true;
                        });
                        zTreeNodes = ret.data;
                        //初始化树
						$.fn.zTree.init($("#dataTree"), setting, zTreeNodes);
						// 添加表头
						var li_head = ' <li class="head"><div class="diy"><input class="mr10" type="checkbox" disabled>&nbsp;菜单名称</div><div class="diy">图标</div><div class="diy">备注</div><div class="diy">排序</div><div class="diy">是否菜单</div></li>';
						var rows = $("#dataTree").find('li');
						if (rows.length > 0) {
						    rows.eq(0).before(li_head)
						} else {
						    $("#dataTree").append(li_head);
						    $("#dataTree").append('<li><div style="text-align: center;line-height: 30px;" >无符合条件数据</div></li>');
						}
                    }else{
                        parent.layer.msg("获取失败, "+ret.message);
                    }
                }
            });
		}

        function expandAll(ad) {
            var zTree = $.fn.zTree.getZTreeObj("dataTree");
            zTree.expandAll(ad);
        }

        $(function () {
            //初始化数据
            query();

            layui.use('layer', function(){
                var layer = layui.layer;
            });

            $(document).on('click','li a',function () {
                var ele = $(this);
                if (ele.find("input").prop("checked")){
                    $("[type='checkbox']").removeAttr("checked");
                    ele.removeClass("bg");
				}else{
                    $("[type='checkbox']").removeAttr("checked");
                    ele.find("input").prop("checked",true);
                    $("li").find("a").removeClass("bg");
                    ele.addClass("bg");
				}
            });

            $(document).on('click','input[name="checkbox"]',function () {
                var ele = $(this);
                if (ele.prop("checked")){
                    $("[type='checkbox']").removeAttr("checked");
                    ele.parent().parent().removeClass("bg");
                }else{
                    $("[type='checkbox']").removeAttr("checked");
                    ele.prop("checked",true);
                    $("li").find("a").removeClass("bg");
                    ele.parent().parent().addClass("bg");
                }
            });

			//编辑判断
			$("#edit").on("click",function () {
                var standard = $('input[name="checkbox"]:checked').val();
                if (standard == undefined){
                    layer.msg("请选择菜单");
                }else {
                    edit(standard);
                }
            });

			//删除判断
            $("#del").on("click",function () {
                var standard = $('input[name="checkbox"]:checked').val();
                if (standard == undefined){
                    layer.msg("请选择菜单");
                }else {
                    del(standard);
                }
            });

        });

        //新建
        function edit(id) {
            layer.open({
                type: 2,
                title: id?'编辑菜单':'新建菜单',
                area: ['420px', '500px'],
                fix: true, //不固定
                resize: false,
                maxmin: false,
                content: "${path}/menuMana/editMenuPage.shtml?id="+id
            });
        }

		function del(id){
            layer.confirm('您确认要删除该菜单？', {
                btn: ['确认','取消'] //按钮
            }, function(){
                $.post("${path}/menuMana/deleteOneMenu.shtml",{id:id},function(result){
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
            query();
        }
	</script>
</body>
</html>

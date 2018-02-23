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
		body{font-size: 14px!important; min-width:350px; background-color: #fff;padding: 1em}
		/*ztree表格*/
		.ztree {padding:0 2em; border: 0;}
		.ztree li a {vertical-align: middle;height: 26px;}
		.ztree li > a {width: 100%;}
		.ztree li > a, .ztree li a.curSelectedNode {padding-top: 0px;background: none;height: auto;border: none;cursor: pointer;}
		.ztree li ul { padding-left: 0px }
		.ztree div.diy span {font-size: 14px; vertical-align: middle;  color: #666;}
		.ztree div.diy {height: 100%;line-height: 26px;text-align: center;display: inline-block;box-sizing: border-box;color: #333;overflow: hidden;}
		.ztree div.diy:first-child { text-align: left;border-left: none;}
	</style>
</head>
<body>
<div>

	<div style="text-align:left;position:fixed;top:0;width:100%;z-index:20;padding:10px 0;background:#fff;border-bottom:solid 1px #f2f2f2;">
		<span class="btn btn-small btn-green-w" onclick="checkAllNodes(true);">全选</span>
		<span class="btn btn-small btn-green-w" onclick="checkAllNodes(false);">全不选</span>
		<span class="btn btn-small btn-green-w" onclick="expandAll(true);">展开全部</span>
		<span class="btn btn-small btn-green-w" onclick="expandAll(false);">收缩所有</span>
	</div>

	<div style="position: relative;margin: 40px 0">

		<form>
			<input type="hidden" name="id" id="id" value="${id}">
			<ul id="dataTree" class="ztree">

			</ul>
		</form>
	</div>

	<div style="text-align:center;position:fixed;bottom:0;width:100%;z-index:10;line-height:40px;height:40px;background:#fff;border-top:solid 1px #f2f2f2;">
		<input class="btn btn-small btn-blue btn-submit" id="submitbtn" type="button" style=" font-size: 13px" data-loading-text="正在保存..." value=" 保 存  ">
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
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "code",
                pIdKey: "pcode",
                rootPId: null
            }
        },
        callback:{
            onClick: function (e, treeId, treeNode, clickFlag) {
                var zTree = $.fn.zTree.getZTreeObj("dataTree");
                zTree.checkNode(treeNode, !treeNode.checked, true);
            }
        }
    };
    /**
     * 自定义DOM节点
     */
    function addDiyDom(treeId, treeNode) {
        var spaceWidth = 10;
        var liObj = $("#" + treeNode.tId);
        var aObj = $("#" + treeNode.tId + "_a");
        var switchObj = $("#" + treeNode.tId + "_switch");
        var icoObj = $("#" + treeNode.tId + "_ico");
        var spanObj = $("#" + treeNode.tId + "_span");
        aObj.removeAttr('href');
        aObj.append('<div class="diy swich"></div>');
        var div = $(liObj).find('div').eq(0);
        switchObj.remove();
        spanObj.remove();
        icoObj.remove();
        div.append(switchObj);
        div.append(spanObj);
        var spaceStr = "<span style='height:1px;display:inline-block;width:" + (spaceWidth *(treeNode.levels-1) ) + "px'></span>";
        switchObj.before(spaceStr);
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
    function checkAllNodes(ad) {
        var zTree = $.fn.zTree.getZTreeObj("dataTree");
        zTree.checkAllNodes(ad);
    }
    $(function () {
        var index = parent.layer.getFrameIndex(window.name);
        //初始化数据
        query();

        layui.use('layer', function(){
            var layer = layui.layer;
        });

        var id = $("#id").val();
        //获取权限
        if(!FsUtils.isEmpty(id)){
            $.ajax({
                type: "POST",
                url:"${path}/roleMana/getRoleDept.shtml",
                data:{id:id},
                async: false,
                error: function(request) {
                    parent.layer.msg("网络异常，操作失败");
                },
                success: function(ret) {
                    if(ret.success==true){
                        var ids = [];
                        $.each(ret.data.items,function (i,e) {
                            ids.push(e.id);
                        });
                        for(var i = 0 ; i < ids.length ; i ++ ) {
                            var zTree = $.fn.zTree.getZTreeObj("dataTree");
                            zTree.checkNode( zTree.getNodeByParam( "id",ids[i] ), true);
                        }
                    }else{
                        parent.layer.msg("获取失败, "+ret.message);
                    }
                }
            });
        }

        //保存
        $("#submitbtn").click(function () {
            var ele = $(this);
            var treeObj = $.fn.zTree.getZTreeObj("dataTree");
			var nodes = treeObj.getCheckedNodes(true);
			var ids = [];
			$.each(nodes,function (i,e) {
				 ids.push(e.id);
			});
            if (!FsUtils.isEmpty(id)) {
                change_Btn_submit(ele);
                $.ajax({
                    type: "POST",
                    data:{id:id,ids:''+ids+''},
                    url:"${path}/roleMana/editRoleDept.shtml",
                    async: false,
                    error: function(request) {
                        parent.layer.msg("网络异常，操作失败");
                        restore_Btn_submit(ele);
                    },
                    success: function(ret) {
                        if(ret.success==true){
                            parent.reloadAjax();
                            parent.layer.msg("操作成功!");
                            parent.layer.close(index);
                        }else{
                            parent.layer.msg("操作失败! "+ret.message);
                            restore_Btn_submit(ele);
                        }
                    }
                });
            } else {
                parent.layer.msg("请输入用户账号");
            }
        });

    });

    function change_Btn_submit(_index) {
        _index.attr('disabled', true);
        var _loading = _index.attr('data-loading-text');
        _index.val(_loading);
    }
    function restore_Btn_submit(_index) {
        _index.attr('disabled', false);
        _index.val(' 保 存 ');
    }
</script>
</body>
</html>

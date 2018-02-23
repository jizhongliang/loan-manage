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
		body{font-size: 12px; line-height: 1.5em; background-color: #FFFFFF; min-width:100%;}
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
<input type="hidden" id="userId" value="${id}">
<div class="layui-tab-content">
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
		<ul class="layui-tab-title tab_user_info">
			<li class="layui-this">基本信息</li>
			<li>通讯录</li>
			<li>短信数据</li>
			<li>借款记录</li>
			<li>人行征信</li>
			<li>运营商报告</li>
		</ul>

		<div class="layui-tab-content">

			<div class="layui-tab-item layui-show" style="margin-top: 20px;">
				<div class="loan-user-box" style="width: 100%; padding-left: 20px;">
					<div class="img">
						<span>人脸照片</span>
						<a id="livingImg_href" href="" target="_blank"><img id="livingImg" src=""></a>
					</div>
					<div class="img">
						<span>身份证正面</span>
						<a id="frontImg_href" href="" target="_blank"><img id="frontImg" src=""></a>
					</div>
					<div class="img">
						<span>身份证背面</span>
						<a id="backImg_href" href="" target="_blank"><img id="backImg" src=""></a>
					</div>
				</div>
				<blockquote class="h-elem-quote">基本信息</blockquote>
				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right"><em class="required" aria-required="true">*</em>真实姓名：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="realName" name="realName"></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">性别：</label>
						<div class="col-xs-7">
							<span><input type="text" id="sex" class="input-leg" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">年龄：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="age" disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">身份证号码：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="idNo" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">银行卡号：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="cardNo" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">所属银行：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="bank" disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">银行预留号码：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="bankPhone" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">联系电话：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="phone" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">注册时间：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="registTime"  disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-12 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">居住地址：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-xxl" id="liveAddr"  disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-8 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">注册所在地：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-xxl" id="registerAddr"  disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label">注册地经纬度：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="registerCoordinate"  disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">注册客户端：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="registerClient" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">注册渠道：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">推广渠道：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">用户贷款类型：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="cat" disabled></span>
						</div>
					</div>
					<div class="col-xs-8 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">微信账号：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="unionid" disabled></span>
						</div>
					</div>
				</div>

				<%--<br>--%>
				<%--<blockquote class="h-elem-quote">工作信息</blockquote>--%>
				<%--<div class="row">--%>
					<%--<div class="col-xs-4 user-info-group">--%>
						<%--<label class="col-xs-4 control-label" style="text-align:right">单位名称：</label>--%>
						<%--<div class="col-xs-7">--%>
							<%--<span><input type="text" class="input-leg" disabled></span>--%>
						<%--</div>--%>
					<%--</div>--%>
					<%--<div class="col-xs-8 user-info-group">--%>
						<%--<label class="col-xs-4 control-label" style="text-align:right">收入：</label>--%>
						<%--<div class="col-xs-7">--%>
							<%--<span><input type="text" class="input-leg" disabled></span>--%>
						<%--</div>--%>
					<%--</div>--%>
				<%--</div>--%>
				<%--<div class="row">--%>
					<%--<div class="col-xs-12 user-info-group">--%>
						<%--<label class="col-xs-4 control-label" style="text-align:right">单位地址：</label>--%>
						<%--<div class="col-xs-7">--%>
							<%--<span><input type="text" class="input-xxl" disabled></span>--%>
						<%--</div>--%>
					<%--</div>--%>
				<%--</div>--%>

				<br>
				<blockquote class="h-elem-quote">联系人信息</blockquote>
				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">紧急联系人姓名：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="name_10" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">(紧急) 联系方式：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="phone_10" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">(紧急) 关系：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="relation_10" disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">其他联系人姓名：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="name_20"  disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">(其他) 联系方式：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="phone_20" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">(其他) 关系：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="relation_20" disabled></span>
						</div>
					</div>
				</div>

				<br>
				<blockquote class="h-elem-quote">认证状态</blockquote>
				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">银行卡状态：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="bankCardState" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">紧急联系人状态：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="contactState" disabled></span>
						</div>
					</div>
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label"  style="text-align:right">身份证状态：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="idState" disabled></span>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-xs-4 user-info-group">
						<label class="col-xs-4 control-label" style="text-align:right">人行征信状态：</label>
						<div class="col-xs-7">
							<span><input type="text" class="input-leg" id="creditState" disabled></span>
						</div>
					</div>
					<div class="col-xs-8 user-info-group">
					<label class="col-xs-4 control-label" style="text-align:right">运营商认证状态：</label>
					<div class="col-xs-7">
					<span><input type="text" class="input-leg" id="phoneState" disabled></span>
					</div>
					</div>
					<%--<div class="col-xs-8 user-info-group">--%>
						<%--<label class="col-xs-4 control-label" style="text-align:right">工作认证状态：</label>--%>
						<%--<div class="col-xs-7">--%>
							<%--<span><input type="text" class="input-leg" id="workInfoState" disabled></span>--%>
						<%--</div>--%>
					<%--</div>--%>
				</div>
				<br>
			</div>

			<div class="layui-tab-item">
				<div style="position: relative;">
					<div class="h-table-processing" id="processing" style="display: none;"></div>
					<div>
						<table id="table_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
							<thead class="layui-table-head">
							<tr>
								<th>姓名</th>
								<th>手机号码</th>
							</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>

			<div class="layui-tab-item">
				<div class="h-table-processing" id="processing_01" style="display: none;"></div>
				<div>
					<table id="table_message_list" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
						<thead class="layui-table-head">
						<tr>
							<th>对方姓名</th>
							<th>手机号码</th>
							<th>收发时间</th>
							<th>收发类型</th>
						</tr>
						</thead>
					</table>
				</div>
			</div>

			<div class="layui-tab-item">
				<div style="position: relative;">
					<div>
						<table id="table_list_2" class="layui-table" role="grid" aria-describedby="order-table_info" lay-skin="line">
							<thead class="layui-table-head">
							<tr>
								<th>姓名</th>
								<th>手机号码</th>
							</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>


			<div class="layui-tab-item">
				<div>
					<iframe src="" id="zhengxinReport" frameborder="no" style="height: 100%; width: 100%; position: absolute;" allowtransparency="true"></iframe>
				</div>
			</div>

			<div class="layui-tab-item">
				<iframe src="" id="phoneReport" frameborder="no" style="height: 100%; width: 100%; position: absolute;" allowtransparency="true"></iframe>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
    var searchtable,userMessageTable;
    $(function(){

        layui.use(['laydate', 'layer', 'element'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;
            var element = layui.element;

            //日期范围
            laydate.render({
                elem: '#showTime',
                range: "~"
            });

            //监听Tab切换
            element.on('tab(docDemoTabBrief)', function(data){
                var index = data.index;
                console.log(index);
                if (index == 1 && FsUtils.isEmpty(searchtable)){
                    load_table_list();
                }
                if (index == 2 && FsUtils.isEmpty(userMessageTable)){
                    load_table_message_list();
                }
            });
            var id = $("#userId").val();
            if(!FsUtils.isEmpty(id)){
                $.ajax({
                    type: "POST",
                    url:"${path}/userMana/getUserDetail.shtml",
                    data:{id:id},
                    error: function(request) {
                        layer.msg("网络异常，操作失败 ");
                    },
                    success: function(ret) {
                        if(ret.success == true){
                            var user = ret.data;
                            var userbase = user.userbase;
                            if (!FsUtils.isEmpty(userbase)){
                                $("#livingImg").attr("src",userbase.livingImg);
                                $("#livingImg_href").attr("href",userbase.livingImg);

                                $("#frontImg").attr("src",userbase.frontImg);
                                $("#frontImg_href").attr("href",userbase.frontImg);

                                $("#backImg").attr("src",userbase.backImg);
                                $("#backImg_href").attr("href",userbase.backImg);

                                allPrpos(userbase);
                            }
                            var userOtherInfo = user.userOtherInfo;
                            if (!FsUtils.isEmpty(userOtherInfo)){
                                allPrpos(userOtherInfo);
                            }
                            var userEmerList = user.userEmerList;
                            if (!FsUtils.isEmpty(userEmerList)){
                                for (var i=0; i < userEmerList.length; i++){
                                    var emer = userEmerList[i];
                                    $("#name_" + emer.type).val(emer.name);
                                    $("#phone_" + emer.type).val(emer.phone);
                                    $("#relation_" + emer.type).val(emer.relation);
                                }
                            }
                            var userAuth = user.userAuth;
                            if (!FsUtils.isEmpty(userAuth)){
                                allPrpos(userAuth,1);
                            }
                            var userOtherInfo = user.userOtherInfo;
                            if (!FsUtils.isEmpty(userOtherInfo)){
                                $("#cat").val(userOtherInfo.cat);
                            }

                            var userAuthData = user.userAuthData;
                            if (!FsUtils.isEmpty(userAuthData)){
                                if (!FsUtils.isEmpty(userAuthData.zhengxinReport)){
                                    $("#zhengxinReport").attr("src",userAuthData.zhengxinReport)
								}
                                if (!FsUtils.isEmpty(userAuthData.phoneReport)){
                                    $("#phoneReport").attr("src",userAuthData.phoneReport)
                                }
							}

                        }else{
                            layer.msg("获取失败, "+ret.message);
                        }
                    }
                });
            }
        });
    });

    function allPrpos(obj,type) {
        // 用来保存所有的属性名称和值
        var props = "";
        // 开始遍历
        for(var p in obj){
            // 方法
            if(typeof(obj[p])=="function"){
                obj[p]();
            }else{
                var _value = obj[p];
                if (type == 1){
                    if (_value=='10'){
                        $("#"+p).val('未认证');
                    }else if (_value=='20'){
                        $("#"+p).val('认证中');
                    }else if (_value=='30'){
                        $("#"+p).val('已认证');
                    }
                }else {
                    $("#"+p).val(_value);
                }
            }
        }
    }

    function load_table_list() {
        searchtable =  $('#table_list').dataTable({
            "bSort":false,
            "searching": false,
            "processing": true,
            "serverSide": true,
            "bFilter": true,
            "bLengthChange": false,
            "iDisplayLength":10,
            "ajax": {
                "url": "${path}/userMana/searchUserContactsList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.userId=$("#userId").val();
            },
            "columns": [
                { "data": "name" },
                { "data": "phone" }
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {

            },
            'language': {
                'search': ''
            }
        });
    }

    function load_table_message_list() {
        userMessageTable =  $('#table_message_list').dataTable({
            "bSort":false,
            "searching": false,
            "processing": true,
            "serverSide": true,
            "bFilter": true,
            "bLengthChange": false,
            "iDisplayLength":10,
            "ajax": {
                "url": "${path}/userMana/searchUserMessageList.shtml"
            },
            "fnServerParams": function ( requestData ) {
                requestData.userId=$("#userId").val();
            },
            "columns": [
                { "data": "name" },
                { "data": "phone" },
                { "data": "time" },
                { "data": "type" }
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                }
            ],
            "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {

            },
            'language': {
                'search': ''
            }
        });
    }

    function reloadAjax(){
        var table = $("#table_list").DataTable();
        table.ajax.reload(null,false);
    }
</script>
</body>
</html>

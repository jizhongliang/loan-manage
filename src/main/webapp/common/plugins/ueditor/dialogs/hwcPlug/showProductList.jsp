<%@ page trimDirectiveWhitespaces="true" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="<%=basePath %>huistyle/lib/layer/2.1/skin/layer.css" rel="stylesheet" type="text/css" /> 
	<link href="<%=basePath %>huistyle/css/H-ui.admin.css" rel="stylesheet" type="text/css" /> 
	<link href="<%=basePath %>huistyle/lib/Hui-iconfont/1.0.6/iconfont.css" rel="stylesheet" type="text/css" /> 
	<link href="<%=basePath %>huistyle/lib/jquery.dataTables.min.css" rel="stylesheet" type="text/css" /> 
	<link href="<%=basePath %>huistyle/css/H-ui.minForDatatables.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>huistyle/lib/layer/2.1/skin/layer.ext.css" rel="stylesheet" type="text/css" />  
	<link href="<%=basePath %>huistyle/lib/laypage/1.2/skin/laypage.css" rel="stylesheet" type="text/css" />  
	<script type="text/javascript" src="<%=basePath %>huistyle/lib/jquery/1.9.1/jquery.min.js"></script> 
	<script type="text/javascript" src="<%=basePath %>huistyle/lib/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>huistyle/js/H-ui.js"></script>
	<script type="text/javascript" src="<%=basePath %>huistyle/js/H-ui.admin.js"></script>
	<script type="text/javascript" src="<%=basePath %>/huistyle/lib/layer/2.1/layer.js"></script> 
    <script type="text/javascript" src="<%=basePath %>/huistyle/lib/layer/2.1/extend/layer.ext.js"></script> 
	<script type="text/javascript" src="<%=basePath %>js/fsutils.js"></script>
	<!--页面中一定要引入internal.js为了能直接使用当前打开dialog的实例变量-->
	<script type="text/javascript" src="<%=basePath %>ueditor/dialogs/internal.js"></script>
	<style type="text/css">
		.txt{padding: 4px;  font-size: 14px; border: 1px solid #D5D5D5 }
		.td{text-align: center; line-height: 35px;}
	</style>
</head>
<body style="font-family: 'Helvetica Neue',Helvetica,sans-serif; font-size: 14px;">
	<input type="hidden" name="shopId" id="shopId" value="${param.shop_id }">
	<div class="content">
		<div class="searchShop" style="height: 40px; margin-top: 10px;">
			<table>
				<tr>
					<td width="90%" class="td" style="text-align: center; line-height: 30px;">
					商品名称&nbsp;&nbsp;<input type="text" name="name" id="name" class="txt">&nbsp;&nbsp;
						<button class="btn btn-primary radius" id="search" name="search" style="padding: 4px 12px;  font-size: 12px;  height: 30px">
							搜索商品
						</button>
					</td>
				</tr>
			</table>
		</div>
		<div class="searchList">
			<table id="table_list" class="table table-border">
				<thead>
	            <tr>
	                <th>商品名称</th>
	            </tr>
	       	 </thead>
			</table>
    	</div>
    	<div class="next" style="height: 30px; margin-top: 10px;">
    		<table>
				<tr>
					<td width="100%" class="td" style="text-align: center; line-height: 30px;">
    				<button class="btn btn-success radius" id="callBack" name="callBack" style="padding: 4px 12px;  font-size: 12px;  height: 30px">
						返回上一步
					</button>
				</td>
				</tr>
			</table>
    	</div>
	</div>
    <input type="hidden" name="href" id="href" value="javascript:void(0);">
     <input type="hidden" name="findShopId" id="findShopId" value="${param.shop_id}">
	<script type="text/javascript">
  	var searchtable;
		$(function(){
			searchtable =  $('#table_list').dataTable( {
				   "bSort":false,
				   "searching": false,
		           "processing": true,
		           "serverSide": true,
		           "bFilter": true,
		           "bLengthChange": false,
		           "iDisplayLength":5,
				    "ajax": {
			            "url": "<%=basePath %>shopProduct/getShopProductByDatatables.shtml"
			        },  
			        "fnServerParams": function ( requestData ) {
			        	requestData.shop_id=$("#shopId").val();
			            requestData.name=$("#name").val();
			        },  
		           "columns": [
	                       { "data": "name" }
		           ],
		           "aoColumnDefs": [
						 {
							 sDefaultContent: '',
							 aTargets: [ '_all' ]
						  }
					],
					"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
						$('td:eq(0)', nRow).html( '<input type="radio" name="pid" value="'+aData.pid+'">&nbsp;&nbsp;'+aData.name);
					},
				    
		     });
			//搜索
			$("#search").click(function(){
				searchtable.fnDraw();
			});
		});
	</script>
	
	<script type="text/javascript">
		var range = editor.selection.getRange(),
        	link = range.collapsed ? editor.queryCommandValue( "link" ) : editor.selection.getStart(),
        	newLink = link,
        	rangeLink = domUtils.findParentByTagName(range.getCommonAncestor(),'a',true),
        	orgText;
    	link = domUtils.findParentByTagName( link, "a", true );
    	function handleDialogOk(){
    		var href = $("#href").val();
    		var checkPid = $("input[name='pid']:checked").val();
    		var shopId = $("#findShopId").val();
    		var obj = {
        		'href' : href,
        		'onclick' : "showProduct(\'"+shopId+"\',\'"+checkPid+"\')"
         	};
    		if(!FsUtils.isEmpty(checkPid) && !FsUtils.isEmpty(newLink)){
    			editor.execCommand('link',utils.clearEmptyAttrs(obj));
    		}
        	dialog.close(); 
    	}
    	dialog.onok = handleDialogOk;
	</script>
	
	<script type="text/javascript">
		$("#callBack").click(function(){
			location.href="<%=basePath %>ueditor/dialogs/hwcPlug/showShopList.jsp";
		});
	</script>
</body>
</html>
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
	<script type="text/javascript" src="<%=basePath %>js/fsutils.js"></script>
	<!--页面中一定要引入internal.js为了能直接使用当前打开dialog的实例变量-->
	<script type="text/javascript" src="<%=basePath %>ueditor/dialogs/internal.js"></script>
	
	<style type="text/css">
		.txt{padding: 4px;  font-size: 14px; border: 1px solid #D5D5D5 }
		.td{text-align: center; line-height: 35px;}
	</style>
</head>
<body style="font-family: 'Helvetica Neue',Helvetica,sans-serif; font-size: 14px;">
	<div class="content">
		<div class="searchShop" style="height: 40px; margin-top: 10px;">
			<table>
				<tr>
					<td width="90%" class="td" style="text-align: center; line-height: 30px;">
					店铺名称&nbsp;&nbsp;<input type="text" name="shop_name" id="shop_name" class="txt">&nbsp;&nbsp;
						<button class="btn btn-primary radius" id="search" name="search" style="padding: 4px 12px;  font-size: 12px;  height: 30px">
							搜索店铺
						</button>
					</td>
				</tr>
			</table>
		</div>
		<div class="searchList">
			<table id="table_list" class="table table-border">
				<thead>
	            <tr>
	                <th>店名</th>
	                <th>手机</th>
	            </tr>
	       	 </thead>
			</table>
    	</div>
    	<input type="hidden" name="checkShopId" id="checkShopId" >
    	<input type="hidden" name="href" id="href" value="javascript:void(0);">
	</div>
	
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
			            "url": "<%=basePath %>shopMana/searchShopsList.shtml"
			        },  
			        "fnServerParams": function ( requestData ) {
			            requestData.shop_name=$("#shop_name").val();
			        },  
		           "columns": [
	                       { "data": "nick" },
	                       { "sWidth": "50px","data": "mobile" }
		           ],
		           "aoColumnDefs": [
						 {
							 sDefaultContent: '',
							 aTargets: [ '_all' ]
						  }
					],
					"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
						$('td:eq(0)', nRow).html( '<input type="radio" name="shopId" value="'+aData.sid+'">&nbsp;&nbsp;'+aData.nick);
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
    	var checkShopId = $("input[name='shopId']:checked").val();
    	var obj = {
        	'href' : href,
        	'onclick' : "showShop(\'"+checkShopId+"\')"
         };
    	if(!FsUtils.isEmpty(checkShopId) && !FsUtils.isEmpty(newLink)){
    		editor.execCommand('link',utils.clearEmptyAttrs(obj));
    	}
        dialog.close(); 
    }
    dialog.onok = handleDialogOk;
</script>
</body>
</html>
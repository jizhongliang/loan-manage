<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@include file="/common/common.jspf"%>
	<script type="text/javascript" src="${path}/common/plugins/jquery-form.js"></script>
	<style type="text/css">
		body {background-color: #fff; min-width:350px; font-size: 13px;}
		.table td { text-align: left;}
		.table > thead > tr > th,
		.table > tbody > tr > th,
		.table > tfoot > tr > th,
		.table > thead > tr > td,
		.table > tbody > tr > td,
		.table > tfoot > tr > td {
			padding: 8px;
			border-top: none;
			line-height: 30px;
		}

		.webuploader-element-invisible {
			position: absolute !important;
			clip: rect(1px 1px 1px 1px);
			clip: rect(1px,1px,1px,1px);
		}

		.file-list li span, .upload-dialog .file-list li i {
			float: left;
		}
		.file-name {
			width: 300px;
			margin-left: 15px;
			font-size: 14px;
		}
		.pre-ellipsis {
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: pre;
		}
		.file-size {
			width: 60px;
		}
		.icon-remove {
			float: right;
			margin-top: 15px;
			color: #cccccc;
		}
		.icon-remove:hover {
			color: red;
		}
		.file_ul li{
			margin: 16px 20px; height: 50px; line-height: 50px;
		}
		.file_ul li .icon-type{
			color: #508B37;font-size: 32px; margin-top: 10px; float: left;
		}
	</style>
</head>
<body style="background-color: #f8f8f8">
<div style="padding: 1em;">
	<form class="form form-horizontal" name="form-add" id="form-add" method="post" autocomplete="off" enctype="mutltipart/form-data" onkeydown="if(event.keyCode==13){return false;}">
		<input type="hidden" name="type" id="type" value="${param.type}">
		<table class="table" style="text-align: center; width: 100%">
			<tr>
				<td colspan="2" style="text-align: center; padding: 0!important;">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="height: 90px; width: 100%; background-color: #FFFFFF; border-top: 1px dotted #d2d2d2; border-bottom: 1px dotted #d2d2d2; overflow-y: auto;">
						<div class="file-list droppable">
							<ul class="file_ul">
								<li id="file_in" style="display: none">
									<i class="fa fa-file-excel-o icon-type" aria-hidden="true"></i>
									<span id="file-name" class="file-name pre-ellipsis">您还未选择文件</span>
								</li>
								<li id="file_none">
									<span style="text-align: center; width: 100%">您还未选择文件</span>
								</li>
							</ul>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="2">
					<p class="font-gray" style="font-size: 12px; margin-bottom: 10px;">(提醒：文件中名单不能超过2万条)</p>
					<div style="width: 45%; float: left; text-align: right;">
						<input type="file" id="file" class="webuploader-element-invisible inputfile" name="userFile" id="userFile" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" >
						<label class="btn btn-small btn-green-w" for="file" style=" font-size: 13px" > + 请添加文件</label>
					</div>
					<div style="width: 45%; float: right; text-align: left;">
						<input class="btn btn-small btn-blue btn-submit" id="importBtn" type="button" style=" font-size: 13px" data-loading-text="正在导入..." value=" 导 入 名 单 ">
					</div>
				</td>
			</tr>
		</table>
		<%--<p>最大支持单个文件20000条数据</p>--%>
	</form>
</div>
<script type="text/javascript">
    $(function(){
        $( '.inputfile' ).each( function() {
            var $input = $( this ),
                $label = $input.next( 'label' ),
                labelVal = $label.html();
            $input.on( 'change', function( e ) {
                var fileName = '';
                var target_value = e.target.value;
                if( this.files && this.files.length > 1 ){
                    fileName = ( this.getAttribute( 'data-multiple-caption' ) || '' ).replace( '{count}', this.files.length );
                }
                else if( target_value ){
                    var fileExt = target_value.substr(target_value.lastIndexOf(".")).toLowerCase();
                    if (!checkFileExt(fileExt)) {
                        parent.layer.msg("名单文件类型不对!");
                        $("#file_in").hide();
                        $("#file_none").show();
                        return;
                    }
                    fileName = e.target.value.split( '\\' ).pop();
				}
                if( fileName ){
                    $("#file-name").html( fileName );
                    $("#file_in").show();
                    $("#file_none").hide();
				}
				else{
                    $("#file-name").html( fileName );
                    $("#file_in").hide();
                    $("#file_none").show();
				}
            });
            // Firefox bug fix
//            input.addEventListener( 'focus', function(){ input.classList.add( 'has-focus' ); });
//            input.addEventListener( 'blur', function(){ input.classList.remove( 'has-focus' ); });
        });

        var index = parent.layer.getFrameIndex(window.name);
        $("#importBtn").click(function(){
//            console.log($("#userFile"));
            var userFile = $("#userFile").val();
//            if (!FsUtils.isEmpty(userFile)){
            var layerUploadImage = parent.layer.msg('请勿关闭页面，名单正在导入中...', {
                icon: 16,
                time: 60*1000*60,
                shade:0.2,
                success: function(){
                }
            });

            var ele = $(this);
                var form = $('#form-add');
                form.ajaxSubmit({
                    type:'post',
                    url:"${path}/wContactsMana/importWContacts.shtml",
                    error: function(request) {
                        parent.layer.msg("网络异常，操作失败 ");
                    },
                    success:function(data){
                        if(data.success == true){
                            parent.layer.close(layerUploadImage);
                            parent.layer.close(index);
                            parent.reloadAjax();
                            parent.layer.msg(data.message);
                        }else{
                            parent.layer.msg('导入失败, '+ data.message);
                        }
                    }
                })
//            }else {
//                parent.layer.msg("请选择要导入的名单文件!");
//            }

        });
    });

    function checkFileExt(ext) {
        if (!ext.match(/.xls|.xlsx/i)) {
            return false;
        }
        return true;
    }

</script>
</body>
</html>
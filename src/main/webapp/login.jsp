<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<META content="IE=11.0000" http-equiv="X-UA-Compatible">
	<META name="viewport" content="width=device-width, initial-scale=1.0">
	<META name="renderer" content="webkit">
	<META http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<TITLE>财位管理中心</TITLE>
	<link href="${path}/images/ioc/favicon.ico" rel="Shortcut Icon">
	<script type="text/javascript" src="${path}/static/jquery.min.js"></script>
	<%--<script type="text/javascript" src="${path}/static/cookie.js"></script>--%>
	<style type="text/css">
		body{
			background: #ebebeb;
			font-family: "Helvetica Neue","Hiragino Sans GB","Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
			color: #222;
			font-size: 12px;
		}
		*{
			padding: 0px;
			margin: 0px;
		}
		.top_div{
			background: #09C;
			width: 100%;
			height: 300px;
		}
		.ipt{
			border: 1px solid #d3d3d3;
			padding: 10px 10px;
			width: 220px;
			border-radius: 4px;
			padding-left: 35px;
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			-webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
			-o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
		}
		.ipt:focus{
			border-color: #66afe9;
			outline: 0;
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
			box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
		}
		.u_logo{
			background: url("static/username.png") no-repeat;
			padding: 10px 10px;
			position: absolute;
			top: 43px;
			left: 60px;

		}
		.p_logo{
			background: url("static/password.png") no-repeat;
			padding: 10px 10px;
			position: absolute;
			top: 12px;
			left: 60px;
		}
		a{
			text-decoration: none;
		}
		.tou{
			background: url("static/cw_logo.png") no-repeat;
			width: 150px;
			height: 92px;
			position: absolute;
			top: -120px;
			left: 110px;
		}
		.msg {
			color: #f96;
			text-align: center;
			height: 35px;
			line-height: 35px;
		}

		.common_footer {
			color: #eee;
			bottom: 0px;
			text-align: center;
			width: 100%;
			background: #444;
			background: rgba(0, 0, 0, 0.3);
			padding: 10px;
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
			box-sizing: border-box;
			position:fixed;
		}
		a {
			text-decoration: none;
			color: #adf;
			font-weight: 800;
		}
		.button1{
			background: #09C; padding: 5px 12px; border-radius: 4px; border: 1px solid rgb(50, 145, 182); border-image: none; color: rgb(255, 255, 255); cursor:pointer; width: 95px;
		}
		input:disabled{
			border: 1px solid #DDD;
			background-color: #F5F5F5;
			color:#ACA899;
		}
	</style>
</HEAD>
<BODY>
<%--<div class="wrapper">--%>
<DIV class="top_div"></DIV>
<DIV style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 320px;text-align: center; border-radius:5px;">
	<DIV style="width: 165px; height: 96px; position: absolute;">
		<DIV class="tou"></DIV>
	</DIV>
	<form method="post" action="" autocomplete="off" name="loginForm" id="loginForm">
		<P style="padding: 30px 0px 0px; position: relative; font-size: 18px">
			<SPAN style="font-weight: 700">财位资产后台管理系统</SPAN>
		</P>
		<P style="padding: 30px 0px 10px; position: relative;">
			<SPAN class="u_logo"></SPAN>
			<INPUT class="ipt" type="text" placeholder="请输入帐号" value="xljin" name="lmUserName" id="lmUserName">
		</P>
		<P style="position: relative;">
			<SPAN class="p_logo"></SPAN>
			<INPUT class="ipt" id="lmUserPassword" type="password" placeholder="请输入密码" value="123456" name="lmUserPassword">
		</P>
		<div class="msg"></div>
		<div style="clear:both;"></div>
		<DIV style="height: 50px; line-height: 50px;  border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
			<P style="margin: 0px 35px 20px 45px;">
				<SPAN style="float: left; "><input type="checkbox" style="vertical-align:middle;"> <span style="vertical-align:middle; color: #666666;">记住密码</span></SPAN>
				<SPAN style="float: right; margin-top:10px;">
					<input id="submit" type="button" class="button1" data-loading-text="正在登录 ..." value=" 登 录 ">
           		</SPAN>
			</P>
		</DIV>
	</form>
</DIV>
<div style="text-align:center;"></div>
<div class="common_footer">财位资产 V1.00 | Copyright © <a href="http://www.51caiwei.com" target="_blank">www.51caiwei.com</a> All rights reserved.</div>
<script type="text/javascript" >
    $(function(){
        $(document).keydown(function(event){
            if(event.keyCode ==13){
                $("#submit").trigger("click");
            }
        });

        $("#submit").click(function(){
            var msgError = "提示：";
            var isValid = true;
            if (!isValid){
            }else if($("#lmUserName").val().length == 0){
                $(".msg").html(msgError+"账号或密码不能为空");
                $("#lmUserName").focus();
                isValid = false;
            }else if($("#lmUserPassword").val().length == 0){
                $(".msg").html(msgError+"账号或密码不能为空");
                $("#lmUserName").focus();
                isValid = false;
            }

            if(isValid==true){
                var ele = $(this);
                change_Btn_submit(ele);
                $.ajax({
                    type: "post",
                    url:"${path}/login.shtml",
                    data:$('#loginForm').serialize(),
                    dataType:"json",
                    success: function(data) {
                        if(data.success == true){
                            window.location.href="${path}/main.shtml";
                        }else{
                            restore_Btn_submit(ele);
                            $(".msg").html(msgError+data.message);
                        }
                    },
                    error: function(request) {
                        restore_Btn_submit(ele);
                        console.log("网络异常，操作失败 ");
                    }
                });
            }
        });
    });


    function change_Btn_submit(_index){
        _index.attr('disabled',true);
        var _loading = _index.attr('data-loading-text');
        _index.val(_loading);
    }
    function restore_Btn_submit(_index){
        _index.attr('disabled',false);
        _index.val(' 登 录 ');
    }

</script>


</BODY>
</HTML>
	

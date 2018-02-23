<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/shopTag.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="/common/common.jspf"%>
		<style>
			.system{margin-top: 50px;}
		</style>
	</head>
	<body>
	<aside id="hwc-sidebar">
		<div id="hwc-first-sidebar">
			<div style="display: block; width: 90px; overflow: hidden;">
				<div class="ribbon ribbon-badge ribbon-warning">
					<span class="ribbon-inner" id="tips">信用分期</span>
				</div>
				<div style="margin: 15px 15px; color:#FFFFFF;">
					<img src="${path}/static/cw_logo.png" width="60px"/>
				</div>
			</div>
			<nav id="menu">
				<ul class="clearfix">
					<c:forEach items="${session_menu }" var="menu" varStatus="status">
						<c:set var="count" value="0" ></c:set>
						<c:if test="${menu.levels==1}">
							<li class="${menu.tips}  ${menu.code == 'user' ? 'active' : '' }"  style="display: ${menu.tips !='MORTGAGE' ?'block':'none'}" id="${menu.code}_first">
								<a href="javascript:;" class="${menu.code}">
									<span style="width: 16px"><i class="menu-icon fa ${menu.icon} fa-fw" aria-hidden="true"></i></span>&nbsp; ${menu.name}
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</nav>
			<div class="user-name">
				<span>${session_user.nick}</span>
				<div class="user-shop-oper">
					<ul>
						<a href="javascript:;"><li class="switch active" data-value="CREDIT" data-text="信用分期">信用分期</li></a>
						<a href="javascript:;"><li class="switch" data-value="MORTGAGE" data-text="车位分期">车位分期</li></a>
						<a href="${path}/loginOut.shtml"><li>退出</li></a>
					</ul>
					<div class="arrow"></div>
				</div>
			</div>
		</div>
		<c:forEach items="${session_menu }" var="menu">
			<c:if test="${menu.levels==1}">
				<div id="${menu.code}" class="hwc-second-sidebar ${menu.code != 'user' ? 'hide' : '' }" >
					<div class="second-sidebar-title">${menu.name}管理</div>
					<nav>
						<ul calss="nav-ul">
							<c:set var="count" value="0" ></c:set>
							<c:forEach items="${session_menu }" var="secondMenu">
								<c:if test="${secondMenu.levels == 2 && secondMenu.pcode == menu.code }">
									<li class="${secondMenu.tips} nav-li ${count==0?'active':''}" style="display: ${secondMenu.tips !='MORTGAGE' ?'block':'none'} " data-tips="${secondMenu.tips}">
										<a href="javascript:;" data-href="${path}${secondMenu.url}" target="right">${secondMenu.name}</a>
									</li>
									<c:set var="count" value="${count+1 }" ></c:set>
								</c:if>
							</c:forEach>
						</ul>
					</nav>
				</div>
			</c:if>
		</c:forEach>
	</aside>
	<script>
        $(function(){
            $("body").attr('class',"without-second-sidebar");
            var li = $("#menu").find('li');
            var li2 = $(".hwc-second-sidebar").find('li');

            var li_switch = $(".switch");

            var tips = "10";

            var elements = $(document).find('.hwc-second-sidebar');
            $("#menu li").on("click","a", function() {
                li.each(function(_j){
                    var ele = li.eq(_j);
                    ele.removeClass("active");
                });
                elements.each(function(_i){
                    var ele = elements.eq(_i);
                    ele.addClass("hide");
                });
                $(this).parent().addClass("active");
                var _id = $(this).attr('class');
                $("body").removeClass("without-second-sidebar");
                $("#"+_id).removeClass("hide");
                var child = $("#"+_id).find("nav").find("ul").children(":visible:eq(0)");
                var href = child.find("a").attr("data-href") + "?type="+tips;
                $("#rightMain").attr("src",href);
                li2.each(function(_j){
                    var ele = li2.eq(_j);
                    ele.removeClass("active");
                });
                child.addClass("active");
            });
            $(".nav-li").on("click","a", function() {
                li2.each(function(_j){
                    var ele = li2.eq(_j);
                    ele.removeClass("active");
                });
                $(this).parent().addClass("active");

                var data_href = $(this).attr("data-href");
                var _tips = $(this).parent().attr("data-tips");
                if (_tips=="ALL"){
                    data_href = data_href +"?type="+tips;
				}
                $("#rightMain").attr("src",data_href);
            });

            // 切换
            layui.use(['layer'], function(){
                var layer = layui.layer;

                $(".switch").on("click", function() {
                    var switch_this = $(this);
                    if (switch_this.hasClass("active")){
                        return;
                    }
                    var this_text = $(this).attr("data-text");
                    var this_value = $(this).attr("data-value");
                    var index = layer.confirm('系统即将切换, 您只能看到关于<'+this_text+'>的内容', {
                        title:"提示",
                        btn: ['好的，知道了','不切换'] //按钮
                    }, function(){
                        $("#tips").html(this_text);

                        // 菜单恢复到初始
                        li.each(function(_j){
                            var ele = li.eq(_j);
                            ele.removeClass("active");
                        });
						$("#user_first").addClass("active");

                        elements.each(function(_i){
                            var ele = elements.eq(_i);
                            ele.addClass("hide");
                        });
                        $("#user").show();

                        li2.each(function(_j){
                            var ele = li2.eq(_j);
                            var tips = ele.attr("data-tips");
                            ele.removeClass("active");
                        });

						// 切换

                        if (this_value=='CREDIT'){
                            $("#tips").parent().removeClass("ribbon-danger");
                            $("#tips").parent().addClass("ribbon-warning");

                            $(".MORTGAGE").hide();
                            $(".CREDIT").show();

                            tips = "10";

                        }else if (this_value=='MORTGAGE'){
                            $("#tips").parent().removeClass("ribbon-warning");
                            $("#tips").parent().addClass("ribbon-danger");

                            $(".CREDIT").hide();
                            $(".MORTGAGE").show();

                            tips = "20";
                        }

                        var child = $("#user").find("nav").find("ul").children(":first");
                        var href = child.find("a").attr("data-href")+"?type="+tips;
                        $("#rightMain").attr("src",href);
                        child.addClass("active");

                        li_switch.each(function(_j){
                            var ele = li_switch.eq(_j);
                            ele.removeClass("active");
                        });

                        switch_this.addClass("active");
                        layer.close(index);
                    }, function(){

                    });
                });
            });
        });
	</script>
	<div id="hwc-container">
		<iframe name="right" id="rightMain" src="${path}/userMana/searchUserListPage.shtml" frameborder="no" style="height: 100%; width: 100%; position: absolute;" allowtransparency="true"/>
	</div>
	</body>
</html>
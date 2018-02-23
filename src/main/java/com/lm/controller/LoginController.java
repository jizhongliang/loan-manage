package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.base.sdk.core.ResponseBase;
import com.hwc.loan.sdk.admin.domain.DMenuDomain;
import com.hwc.loan.sdk.admin.domain.SysUserLoginDomain;
import com.hwc.loan.sdk.admin.request.MenuListByRoleRequest;
import com.hwc.loan.sdk.admin.request.SysUserLoginRequest;
import com.hwc.loan.sdk.admin.response.MenuListByRoleResponse;
import com.hwc.loan.sdk.admin.response.SysUserLoginResponse;
import com.lm.client.ProjectClient;
import com.lm.common.ProjectConstant;
import com.lm.model.UserBean;
import com.lm.utils.SessionUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * LoginController.java  
 */
@Controller
public class LoginController {

	/**
	 * 使用帐号密码登录
	 * @param request
	 */
	@ResponseBody
	@PostMapping("/login")
	public ResponseBase userLogin(
			@RequestParam(value="lmUserName", required=true) String username,
			@RequestParam(value="lmUserPassword", required=true) String userPws,
			HttpServletRequest request){
		ResponseBase rb = new ResponseBase();
		try {
			if(FsUtils.strsEmpty(username) || FsUtils.strsEmpty(userPws)){
				rb.setCode(400);
				rb.setMessage("帐号或密码不能为空");
				rb.setSuccess(false);
			} else {
				SysUserLoginRequest userLogin = new SysUserLoginRequest();
				userLogin.setAccount(username);
				userLogin.setPassword(DigestUtils.md5Hex(userPws));
				SysUserLoginResponse response = ProjectClient.getResult(userLogin);
				SysUserLoginDomain data = response.getData();
				if (data !=null){
					UserBean userBean = new UserBean();
					userBean.setId(data.getId());
					userBean.setAccount(data.getAccount());
					userBean.setRoleId(data.getRoleid());
					userBean.setNick(data.getName());
					SessionUtils.setUser(request,userBean);
					// 将token记录下来，用于后面的请求使用
//					System.out.println(data.getToken());
					SessionUtils.setAttr(request, "token", data.getToken());

				}
				return response;
			}
		} catch (com.hwc.base.sdk.ServerException e){
			rb.setCode(500);
			rb.setMessage("服务器链接失败");
			rb.setSuccess(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rb;
	}

	/**
	 * 使用帐号密码登录
	 * @param request
	 * @param response
	 */
	@GetMapping("/main")
	public String main(HttpServletRequest request,HttpServletResponse response){
		try {
			UserBean userBean = SessionUtils.getUser(request);
			MenuListByRoleRequest menuListByRoleRequest = new MenuListByRoleRequest();
			menuListByRoleRequest.setId(FsUtils.i(userBean.getRoleId()));
			MenuListByRoleResponse sysUserLoginResponse = sysUserLoginResponse = ProjectClient.getResult(menuListByRoleRequest);
			if (sysUserLoginResponse.getSuccess()){
				ItemData<DMenuDomain> itemData =  sysUserLoginResponse.getData();
				List<DMenuDomain> list = itemData.getItems();
//				System.out.println(JSONObject.toJSONString(list));
				SessionUtils.setSessionMenu(request,list);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/main";
	}


	/**
	 * 退出系统
	 */
	@GetMapping("/loginOut")
	public String loginout(HttpServletRequest request,HttpServletResponse response){
		SessionUtils.removeAttr(request, "session_user");//退出时清空user信息
		return "redirect:/login.jsp";
	}

}



package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.admin.domain.DSysUserDomain;
import com.hwc.loan.sdk.admin.request.SysUserDeleteOneRequest;
import com.hwc.loan.sdk.admin.request.SysUserGetOneRequest;
import com.hwc.loan.sdk.admin.request.SysUserListPageRequest;
import com.hwc.loan.sdk.admin.request.SysUserUpdateOneRequest;
import com.hwc.loan.sdk.admin.response.SysUserDeleteOneResponse;
import com.hwc.loan.sdk.admin.response.SysUserGetOneResponse;
import com.hwc.loan.sdk.admin.response.SysUserListPageResponse;
import com.hwc.loan.sdk.admin.response.SysUserUpdateOneResponse;
import com.lm.client.ProjectClient;
import com.lm.utils.CommonUtil;
import com.lm.utils.PageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/sysUserMana")
@Controller
public class SysUserController {

    @RequestMapping("/searchUserListPage")
    public String searchUserListPage(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "/system/user/list";
    }

    @RequestMapping("/searchUserList")
    @ResponseBody
    public JSONObject searchUserList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DSysUserDomain> data = new ItemData<DSysUserDomain>();
            SysUserListPageRequest sysUserListPageRequest = new SysUserListPageRequest();
            sysUserListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            SysUserListPageResponse sysUserListPageResponse =  ProjectClient.getResult(sysUserListPageRequest);
            if (sysUserListPageResponse.getSuccess()){
                data = sysUserListPageResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    //编辑用户页面
    @RequestMapping("/editUserPage")
    public String editUserPage(HttpServletRequest request,HttpServletResponse response,Model model){
        model.addAttribute("id",request.getParameter("id"));
        return "/system/user/edit";
    }

    //新建或编辑用户
    @PostMapping("/editUser")
    @ResponseBody
    public SysUserUpdateOneResponse editUser(HttpServletRequest request, HttpServletResponse response, Model model){
        SysUserUpdateOneResponse sysUserUpdateOneResponse = new  SysUserUpdateOneResponse();
        try {
            SysUserUpdateOneRequest sysUserUpdateOneRequest = new SysUserUpdateOneRequest();
            sysUserUpdateOneRequest.setId(FsUtils.i(request.getParameter("id")));
            sysUserUpdateOneRequest.setRoleid(request.getParameter("roleid"));
            sysUserUpdateOneRequest.setName(request.getParameter("name"));
            sysUserUpdateOneRequest.setAccount(request.getParameter("account"));
            sysUserUpdateOneRequest.setStatus(FsUtils.i(request.getParameter("status")));
//            System.out.println(JSONObject.toJSONString(sysUserUpdateOneRequest));
            sysUserUpdateOneResponse = ProjectClient.getResult(sysUserUpdateOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sysUserUpdateOneResponse;
    }

    //获取一个用户信息
    @PostMapping("/getOneUser")
    @ResponseBody
    public SysUserGetOneResponse getOneUser(HttpServletRequest request, HttpServletResponse response, Model model){
        SysUserGetOneResponse sysUserGetOneResponse = new  SysUserGetOneResponse();
        try {
            SysUserGetOneRequest sysUserGetOneRequest = new SysUserGetOneRequest();
            sysUserGetOneRequest.setId(FsUtils.i(request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(sysUserGetOneRequest));
            sysUserGetOneResponse = ProjectClient.getResult(sysUserGetOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sysUserGetOneResponse;
    }

    //删除用户
    @PostMapping("/deleteOneUser")
    @ResponseBody
    public SysUserDeleteOneResponse deleteOneUser(HttpServletRequest request, HttpServletResponse response, Model model){
        SysUserDeleteOneResponse sysUserDeleteOneResponse = new  SysUserDeleteOneResponse();
        try {
            SysUserDeleteOneRequest sysUserDeleteOneRequest = new SysUserDeleteOneRequest();
            sysUserDeleteOneRequest.setId(FsUtils.i(request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(sysUserDeleteOneRequest));
            sysUserDeleteOneResponse = ProjectClient.getResult(sysUserDeleteOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sysUserDeleteOneResponse;
    }

}

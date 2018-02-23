package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.user.domain.DCloanUserDomain;
import com.hwc.loan.sdk.user.domain.DUserAuthModelDomain;
import com.hwc.loan.sdk.user.domain.DUserContactsDomain;
import com.hwc.loan.sdk.user.domain.DUserMessageDomain;
import com.hwc.loan.sdk.user.request.*;
import com.hwc.loan.sdk.user.response.*;
import com.lm.client.ProjectClient;
import com.lm.utils.CommonUtil;
import com.lm.utils.PageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/userMana")
@Controller
public class UserController {
    @GetMapping("/searchUserListPage")
    public String searchMemberListPage(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "/user/list";
    }

    @RequestMapping("/searchUserList")
    @ResponseBody
    public JSONObject searchMemberList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DCloanUserDomain> data = new ItemData<DCloanUserDomain>();
            UserListPageRequest userListPageRequest = new UserListPageRequest();
            userListPageRequest.setIdNo(request.getParameter("idNo"));
            userListPageRequest.setPhone(request.getParameter("phone"));
            userListPageRequest.setRealName(request.getParameter("realName"));
//            userListPageRequest.setCat(request.getParameter("cat"));
            userListPageRequest.setRegisterClient(request.getParameter("registerClient"));
            userListPageRequest.setChannelId(FsUtils.l(request.getParameter("channelId")));
            String type = request.getParameter("type");
            if (FsUtils.strsEmpty(type)){
                userListPageRequest.setCat("10");
            }else {
                userListPageRequest.setCat(type);
            }
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    userListPageRequest.setBeginTime(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    userListPageRequest.setEndTime(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            userListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            UserListPageResponse userListResponse =  ProjectClient.getResult(userListPageRequest);
            if (userListResponse.getSuccess()){
                data = userListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    @GetMapping("/searchUserAuthListPage")
    public String searchUserAuthListPage(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "/user/auth";
    }

    @RequestMapping("/searchUserAuthList")
    @ResponseBody
    public JSONObject searchUserAuthList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DUserAuthModelDomain> data = new ItemData<DUserAuthModelDomain>();
            UserAuthListPageRequest userAuthListPageRequest = new UserAuthListPageRequest();
            userAuthListPageRequest.setIdNo(request.getParameter("idNo"));
            userAuthListPageRequest.setPhone(request.getParameter("phone"));
            userAuthListPageRequest.setRealName(request.getParameter("realName"));
            userAuthListPageRequest.setBankCardState(request.getParameter("bankCardState"));
            userAuthListPageRequest.setContactState(request.getParameter("contactState"));
            userAuthListPageRequest.setWorkInfoState(request.getParameter("workInfoState"));
            userAuthListPageRequest.setCreditState(request.getParameter("creditState"));
//            System.out.println(JSONObject.toJSONString(userAuthListPageRequest));
            userAuthListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            String type = request.getParameter("type");
            if (FsUtils.strsEmpty(type)){
                userAuthListPageRequest.setCat("10");
            }else {
                userAuthListPageRequest.setCat(type);
            }
            UserAuthListPageResponse userListResponse = ProjectClient.getResult(userAuthListPageRequest);

            if (userListResponse.getSuccess()) {
                data = userListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 加入黑名单
    @PostMapping("/addBlacklist")
    @ResponseBody
    public UserUpdateStateResponse addBlacklist(HttpServletRequest request, HttpServletResponse response){
        UserUpdateStateResponse userUpdateStateResponse = new  UserUpdateStateResponse();
        try {
            UserUpdateStateRequest userUpdateStateRequest = new UserUpdateStateRequest();
            userUpdateStateRequest.setId(FsUtils.l(request.getParameter("id")));
            userUpdateStateRequest.setState("10");
            userUpdateStateResponse = ProjectClient.getResult(userUpdateStateRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userUpdateStateResponse;
    }

    // 解除黑名单
    @PostMapping("/relieveBlacklist")
    @ResponseBody
    public UserUpdateStateResponse relieveBlacklist(HttpServletRequest request, HttpServletResponse response){
        UserUpdateStateResponse userUpdateStateResponse = new  UserUpdateStateResponse();
        try {
            UserUpdateStateRequest userUpdateStateRequest = new UserUpdateStateRequest();
            userUpdateStateRequest.setId(FsUtils.l(request.getParameter("id")));
            userUpdateStateRequest.setState("20");
            userUpdateStateResponse = ProjectClient.getResult(userUpdateStateRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userUpdateStateResponse;
    }

    @GetMapping("/searchUserInfoPage")
    public String searchUserInfoPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/user/info";
    }

    // 用户详情
    @PostMapping("/getUserDetail")
    @ResponseBody
    public UserGetOneDetailsResponse getUserDetail(HttpServletRequest request, HttpServletResponse response){
        UserGetOneDetailsResponse userGetOneDetailsResponse = new  UserGetOneDetailsResponse();
        try {
            UserGetOneDetailsRequest userGetOneDetailsRequest = new UserGetOneDetailsRequest();
            userGetOneDetailsRequest.setId(FsUtils.l(request.getParameter("id")));
            userGetOneDetailsResponse = ProjectClient.getResult(userGetOneDetailsRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userGetOneDetailsResponse;
    }

    @RequestMapping("/searchUserContactsList")
    @ResponseBody
    public JSONObject searchUserContactsList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DUserContactsDomain> data = new ItemData<DUserContactsDomain>();
            UserContactsListPageRequest userListPageRequest = new UserContactsListPageRequest();
            userListPageRequest.setUserId(FsUtils.l(request.getParameter("userId")));
            userListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            userListPageRequest.setPageSize(10);
            UserContactsListPageResponse userContactsListPageResponse =  ProjectClient.getResult(userListPageRequest);
            if (userContactsListPageResponse.getSuccess()){
                data = userContactsListPageResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    @RequestMapping("/searchUserMessageList")
    @ResponseBody
    public JSONObject searchUserMessageList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DUserMessageDomain> data = new ItemData<DUserMessageDomain>();
            UserMessageListPageRequest userMessageListPageRequest = new UserMessageListPageRequest();
            userMessageListPageRequest.setUserId(FsUtils.l(request.getParameter("userId")));
            userMessageListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            userMessageListPageRequest.setPageSize(10);
            UserMessageListPageResponse userMessageListPageResponse =  ProjectClient.getResult(userMessageListPageRequest);
            if (userMessageListPageResponse.getSuccess()){
                data = userMessageListPageResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
            }
//            System.out.println(JSONObject.toJSONString(ret));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

}

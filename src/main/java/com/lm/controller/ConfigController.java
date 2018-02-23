package com.lm.controller;


import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.borrow.domain.ManageSysListDomain;
import com.hwc.loan.sdk.borrow.request.*;
import com.hwc.loan.sdk.borrow.response.*;
import com.lm.client.ProjectClient;
import com.lm.utils.CommonUtil;
import com.lm.utils.PageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/configMana")
@Controller
public class ConfigController {
    @RequestMapping("/searchConfigListPage")
    public String searchConfigListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/system/config/list";
    }

    @RequestMapping("/searchConfigList")
    @ResponseBody
    public JSONObject searchConfigList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageSysListDomain> data = new ItemData<ManageSysListDomain>();
            ManageSysListRequest manageSysListRequest = new ManageSysListRequest();
            manageSysListRequest.setCode(request.getParameter("code"));
            manageSysListRequest.setType(request.getParameter("type"));
            String length = request.getParameter("length");
            manageSysListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageSysListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageSysListRequest));
            ManageSysListResponse manageSysListResponse =  ProjectClient.getResult(manageSysListRequest);
            if (manageSysListResponse.getSuccess()){
                data = manageSysListResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
                ret.put("success","true");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    @RequestMapping("/editConfigPage")
    public String editConfigPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("type",request.getParameter("type"));
        model.addAttribute("code",request.getParameter("code"));
        model.addAttribute("id",request.getParameter("id"));
        return "/system/config/edit";
    }

    @RequestMapping("/updateConfig")
    @ResponseBody
    public ManageSysUpdateResponse updateConfig(HttpServletRequest request, HttpServletResponse response) {
        ManageSysUpdateRequest manageSysUpdateRequest = new ManageSysUpdateRequest();
        ManageSysUpdateResponse manageSysUpdateResponse = new ManageSysUpdateResponse();
        try{
            manageSysUpdateRequest.setId(FsUtils.l(request.getParameter("id")));
            manageSysUpdateRequest.setCode(request.getParameter("code"));
            manageSysUpdateRequest.setName(request.getParameter("name"));
            manageSysUpdateRequest.setRemark(request.getParameter("remark"));
            manageSysUpdateRequest.setValue(request.getParameter("value"));
            manageSysUpdateRequest.setState(request.getParameter("state"));
            manageSysUpdateRequest.setType(request.getParameter("type"));
//            System.out.println(JSONObject.toJSONString(manageSysUpdateRequest));
            manageSysUpdateResponse = ProjectClient.getResult(manageSysUpdateRequest);
        }catch (Exception e){
            e.printStackTrace();
        }
        return manageSysUpdateResponse;
    }

    @RequestMapping("/addConfig")
    @ResponseBody
    public ManageSysAddResponse addConfig(HttpServletRequest request, HttpServletResponse response) {
        ManageSysAddRequest manageSysAddRequest = new ManageSysAddRequest();
        ManageSysAddResponse manageSysAddResponse = new ManageSysAddResponse();
        try{
            manageSysAddRequest.setCode(request.getParameter("code"));
            manageSysAddRequest.setName(request.getParameter("name"));
            manageSysAddRequest.setRemark(request.getParameter("remark"));
            manageSysAddRequest.setValue(request.getParameter("value"));
            manageSysAddRequest.setState(request.getParameter("state"));
            manageSysAddRequest.setType(request.getParameter("type"));
//            System.out.println(JSONObject.toJSONString(manageSysAddRequest));
            manageSysAddResponse = ProjectClient.getResult(manageSysAddRequest);
        }catch (Exception e){
            e.printStackTrace();
        }
        return manageSysAddResponse;
    }

    //删除字典
    @RequestMapping("/delOneConfig")
    @ResponseBody
    public ManageSysDelResponse delOneConfig(HttpServletRequest request, HttpServletResponse response) {
        ManageSysDelRequest manageSysDelRequest = new ManageSysDelRequest();
        ManageSysDelResponse manageSysDelResponse = new ManageSysDelResponse();
        String id = request.getParameter("id");
        try{
            if (FsUtils.strsEmpty(id)){
                manageSysDelResponse.setCode(400);
                manageSysDelResponse.setMessage("缺少必要参数");
                manageSysDelResponse.setSuccess(false);
                return manageSysDelResponse;
            }else {
                manageSysDelRequest.setId(FsUtils.l(id));
//                System.out.println(JSONObject.toJSONString(manageSysBasecodeDelRequest));
                manageSysDelResponse = ProjectClient.getResult(manageSysDelRequest);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return manageSysDelResponse;
    }

}

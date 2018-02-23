package com.lm.controller;


import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.borrow.domain.ManageSysBasecodeListDomain;
import com.hwc.loan.sdk.borrow.request.ManageSysBasecodeListRequest;
import com.hwc.loan.sdk.borrow.response.ManageSysBasecodeListResponse;
import com.hwc.loan.sdk.core.request.ManageSysBasecodeAddRequest;
import com.hwc.loan.sdk.core.request.ManageSysBasecodeDelRequest;
import com.hwc.loan.sdk.core.request.ManageSysBasecodeUpdateRequest;
import com.hwc.loan.sdk.core.response.ManageSysBasecodeAddResponse;
import com.hwc.loan.sdk.core.response.ManageSysBasecodeDelResponse;
import com.hwc.loan.sdk.core.response.ManageSysBasecodeUpdateResponse;
import com.lm.client.ProjectClient;
import com.lm.utils.CommonUtil;
import com.lm.utils.PageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/baseCodeMana")
@Controller
public class BaseCodeController {
    @RequestMapping("/searchBaseCodeListPage")
    public String searchBaseCodeListPage(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "/system/baseCode/list";
    }

    @RequestMapping("/searchBaseCodeList")
    @ResponseBody
    public JSONObject searchBaseCodeList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageSysBasecodeListDomain> data = new ItemData<ManageSysBasecodeListDomain>();
            ManageSysBasecodeListRequest manageSysBasecodeListRequest = new ManageSysBasecodeListRequest();
            manageSysBasecodeListRequest.setCat(request.getParameter("cat"));
            manageSysBasecodeListRequest.setCode(request.getParameter("code"));
            String length = request.getParameter("length");
            manageSysBasecodeListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageSysBasecodeListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageSysBasecodeListRequest));
            ManageSysBasecodeListResponse manageSysBasecodeListResponse =  ProjectClient.getResult(manageSysBasecodeListRequest);
            if (manageSysBasecodeListResponse.getSuccess()){
                data = manageSysBasecodeListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
                ret.put("success","true");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    @RequestMapping("/editBaseCodePage")
    public String editBaseCodePage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("cat",request.getParameter("cat"));
        model.addAttribute("code",request.getParameter("code"));
        return "/system/baseCode/edit";
    }

    @RequestMapping("/updateBaseCode")
    @ResponseBody
    public ManageSysBasecodeUpdateResponse updateBaseCode(HttpServletRequest request, HttpServletResponse response) {
        ManageSysBasecodeUpdateRequest manageSysBasecodeUpdateRequest = new ManageSysBasecodeUpdateRequest();
        ManageSysBasecodeUpdateResponse manageSysBasecodeUpdateResponse = new ManageSysBasecodeUpdateResponse();
        try{
            manageSysBasecodeUpdateRequest.setCat(request.getParameter("cat"));
            manageSysBasecodeUpdateRequest.setCode(request.getParameter("code"));
            manageSysBasecodeUpdateRequest.setDescript(request.getParameter("descript"));
            manageSysBasecodeUpdateRequest.setHalt(request.getParameter("halt"));
            manageSysBasecodeUpdateRequest.setSys(request.getParameter("sys"));
            manageSysBasecodeUpdateRequest.setSeq(FsUtils.i(request.getParameter("seq")));
//            System.out.println(JSONObject.toJSONString(manageSysBasecodeUpdateRequest));
            manageSysBasecodeUpdateResponse = ProjectClient.getResult(manageSysBasecodeUpdateRequest);
        }catch (Exception e){
            e.printStackTrace();
        }
        return manageSysBasecodeUpdateResponse;
    }

    @RequestMapping("/addBaseCode")
    @ResponseBody
    public ManageSysBasecodeAddResponse addBaseCode(HttpServletRequest request, HttpServletResponse response) {
        ManageSysBasecodeAddRequest manageSysBasecodeAddRequest = new ManageSysBasecodeAddRequest();
        ManageSysBasecodeAddResponse manageSysBasecodeAddResponse = new ManageSysBasecodeAddResponse();
        try{
            manageSysBasecodeAddRequest.setCat(request.getParameter("cat"));
            manageSysBasecodeAddRequest.setCode(request.getParameter("code"));
            manageSysBasecodeAddRequest.setDescript(request.getParameter("descript"));
            manageSysBasecodeAddRequest.setHalt(request.getParameter("halt"));
            manageSysBasecodeAddRequest.setSys(request.getParameter("sys"));
            manageSysBasecodeAddRequest.setSeq(FsUtils.i(request.getParameter("seq")));
//            System.out.println(JSONObject.toJSONString(manageSysBasecodeAddRequest));
            manageSysBasecodeAddResponse = ProjectClient.getResult(manageSysBasecodeAddRequest);
        }catch (Exception e){
            e.printStackTrace();
        }
        return manageSysBasecodeAddResponse;
    }

    //删除字典
    @RequestMapping("/delOneBaseCode")
    @ResponseBody
    public ManageSysBasecodeDelResponse delOneBaseCode(HttpServletRequest request, HttpServletResponse response) {
        ManageSysBasecodeDelRequest manageSysBasecodeDelRequest = new ManageSysBasecodeDelRequest();
        ManageSysBasecodeDelResponse manageSysBasecodeDelResponse = new ManageSysBasecodeDelResponse();
        String code = request.getParameter("code");
        try{
            if (FsUtils.strsEmpty(code)){
                manageSysBasecodeDelResponse.setCode(400);
                manageSysBasecodeDelResponse.setMessage("缺少必要参数");
                manageSysBasecodeDelResponse.setSuccess(false);
                return manageSysBasecodeDelResponse;
            }else {
                manageSysBasecodeDelRequest.setCat(request.getParameter("cat"));
                manageSysBasecodeDelRequest.setCode(code);
//                System.out.println(JSONObject.toJSONString(manageSysBasecodeDelRequest));
                manageSysBasecodeDelResponse = ProjectClient.getResult(manageSysBasecodeDelRequest);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return manageSysBasecodeDelResponse;
    }

}

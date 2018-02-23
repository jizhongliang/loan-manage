package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.admin.request.SysUserDeleteOneRequest;
import com.hwc.loan.sdk.admin.response.SysUserDeleteOneResponse;
import com.hwc.loan.sdk.borrow.domain.ManagePayCreditListDomain;
import com.hwc.loan.sdk.borrow.domain.ManagePayMorrgageListDomain;
import com.hwc.loan.sdk.borrow.request.ManagePayCreditListRequest;
import com.hwc.loan.sdk.borrow.request.ManagePayMorrgageListRequest;
import com.hwc.loan.sdk.borrow.request.ManagePayRePayRequest;
import com.hwc.loan.sdk.borrow.response.ManagePayCreditListResponse;
import com.hwc.loan.sdk.borrow.response.ManagePayMorrgageListResponse;
import com.hwc.loan.sdk.borrow.response.ManagePayRePayResponse;
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

@RequestMapping("/payMana")
@Controller
public class PayController {

    // 信用支付
    @RequestMapping("/creditListPage")
    public String creditListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/pay/credit_list";
    }

    @RequestMapping("/creditlogList")
    @ResponseBody
    public JSONObject creditlogList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManagePayCreditListDomain> data = new ItemData<ManagePayCreditListDomain>();
            ManagePayCreditListRequest managePayCreditListRequest = new ManagePayCreditListRequest();
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    managePayCreditListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    managePayCreditListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            managePayCreditListRequest.setScenes(request.getParameter("scenes"));
            managePayCreditListRequest.setMobile(request.getParameter("mobile"));
            managePayCreditListRequest.setOrder_no(request.getParameter("orderNo"));
            managePayCreditListRequest.setState(request.getParameter("state"));
            String length = request.getParameter("length");
            managePayCreditListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            managePayCreditListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(managePayCreditListRequest));
            ManagePayCreditListResponse managePayCreditListResponse =  ProjectClient.getResult(managePayCreditListRequest);
            if (managePayCreditListResponse.getSuccess()){
                data = managePayCreditListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 车位支付
    @RequestMapping("/morgageListPage")
    public String morgageListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/pay/mortgage_list";
    }

    @RequestMapping("/morgageList")
    @ResponseBody
    public JSONObject morgageList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManagePayMorrgageListDomain> data = new ItemData<ManagePayMorrgageListDomain>();
            ManagePayMorrgageListRequest managePayMorrgageListRequest = new ManagePayMorrgageListRequest();
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    managePayMorrgageListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    managePayMorrgageListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            managePayMorrgageListRequest.setScenes(request.getParameter("scenes"));
            managePayMorrgageListRequest.setMobile(request.getParameter("mobile"));
            managePayMorrgageListRequest.setOrder_no(request.getParameter("orderNo"));
            managePayMorrgageListRequest.setState(request.getParameter("state"));
            String length = request.getParameter("length");
            managePayMorrgageListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            managePayMorrgageListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(managePayMorrgageListRequest));
            ManagePayMorrgageListResponse managePayMorrgageListResponse =  ProjectClient.getResult(managePayMorrgageListRequest);
            if (managePayMorrgageListResponse.getSuccess()){
                data = managePayMorrgageListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    //重新支付
    @PostMapping("/payAgain")
    @ResponseBody
    public ManagePayRePayResponse payAgain(HttpServletRequest request, HttpServletResponse response, Model model){
        ManagePayRePayResponse managePayRePayResponse = new  ManagePayRePayResponse();
        try {
            ManagePayRePayRequest managePayRePayRequest = new ManagePayRePayRequest();
            managePayRePayRequest.setId(FsUtils.l( request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(managePayRePayRequest));
            managePayRePayResponse = ProjectClient.getResult(managePayRePayRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return managePayRePayResponse;
    }


}

package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.borrow.domain.*;
import com.hwc.loan.sdk.borrow.request.*;
import com.hwc.loan.sdk.borrow.response.*;
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

@RequestMapping("/repayMana")
@Controller
public class RepayController {

    // 信用还款计划
    @RequestMapping("/repayCreditListPage")
    public String repayCreditListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/repay/credit_list";
    }

    @RequestMapping("/repayCreditList")
    @ResponseBody
    public JSONObject repayCreditList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageRepaymentCreditListDomain> data = new ItemData<ManageRepaymentCreditListDomain>();
            ManageRepaymentCreditListRequest manageRepaymentCreditListRequest = new ManageRepaymentCreditListRequest();
            manageRepaymentCreditListRequest.setMobile(request.getParameter("mobile"));
            manageRepaymentCreditListRequest.setOrderNo(request.getParameter("orderNo"));
            manageRepaymentCreditListRequest.setState(request.getParameter("state"));
            String length = request.getParameter("length");
            manageRepaymentCreditListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageRepaymentCreditListRequest.setPageSize(Integer.parseInt(length));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageRepaymentCreditListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageRepaymentCreditListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
//            System.out.println(JSONObject.toJSONString(manageRepaymentCreditListRequest));
            ManageRepaymentCreditListResponse manageRepaymentCreditListResponse =  ProjectClient.getResult(manageRepaymentCreditListRequest);
            if (manageRepaymentCreditListResponse.getSuccess()){
                data = manageRepaymentCreditListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 信用还款记录
    @RequestMapping("/repayCreditLogListPage")
    public String repayCreditLogListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/repay/credit_log_list";
    }

    // 信用代扣记录
    @RequestMapping("/withholdCreditListPage")
    public String withholdCreditListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/repay/credit_withhold_list";
    }

    @RequestMapping("/withholdCreditList")
    @ResponseBody
    public JSONObject withholdCreditList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageRepaylogCreditListDomain> data = new ItemData<ManageRepaylogCreditListDomain>();
            ManageRepaylogCreditListRequest manageRepaylogCreditListRequest = new ManageRepaylogCreditListRequest();
            manageRepaylogCreditListRequest.setMobile(request.getParameter("mobile"));
            manageRepaylogCreditListRequest.setOrderNo(request.getParameter("orderNo"));
            manageRepaylogCreditListRequest.setRepayWay(request.getParameter("repayWay"));
            String length = request.getParameter("length");
            manageRepaylogCreditListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageRepaylogCreditListRequest.setPageSize(Integer.parseInt(length));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageRepaylogCreditListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageRepaylogCreditListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
//            System.out.println(JSONObject.toJSONString(manageRepaylogCreditListRequest));
            ManageRepaylogCreditListResponse manageRepaylogCreditListResponse =  ProjectClient.getResult(manageRepaylogCreditListRequest);
            if (manageRepaylogCreditListResponse.getSuccess()){
                data = manageRepaylogCreditListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 车位还款计划
    @RequestMapping("/repayMortgageListPage")
    public String repayMortgageListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/repay/mortgage_list";
    }

    @RequestMapping("/repayMortgageList")
    @ResponseBody
    public JSONObject repayMortgageList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageRepaymentMortgageListDomain> data = new ItemData<ManageRepaymentMortgageListDomain>();
            ManageRepaymentMortgageListRequest manageRepaymentMortgageListRequest = new ManageRepaymentMortgageListRequest();
            manageRepaymentMortgageListRequest.setMobile(request.getParameter("mobile"));
            manageRepaymentMortgageListRequest.setOrderNo(request.getParameter("orderNo"));
            manageRepaymentMortgageListRequest.setState(request.getParameter("state"));
            String length = request.getParameter("length");
            manageRepaymentMortgageListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageRepaymentMortgageListRequest.setPageSize(Integer.parseInt(length));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageRepaymentMortgageListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageRepaymentMortgageListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            ManageRepaymentMortgageListResponse manageRepaymentMortgageListResponse =  ProjectClient.getResult(manageRepaymentMortgageListRequest);
            if (manageRepaymentMortgageListResponse.getSuccess()){
                data = manageRepaymentMortgageListResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 车位还款记录
    @RequestMapping("/repayMortgageLogListPage")
    public String repayMortgageLogListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/repay/mortgage_log_list";
    }

    // 车位代扣记录
    @RequestMapping("/withholdMortgageListPage")
    public String withholdMortgageListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/repay/mortgage_withhold_list";
    }

    @RequestMapping("/withholdMortgageList")
    @ResponseBody
    public JSONObject withholdMortgageList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageRepaylogMortgageListDomain> data = new ItemData<ManageRepaylogMortgageListDomain>();
            ManageRepaylogMortgageListRequest manageRepaylogMortgageListRequest = new ManageRepaylogMortgageListRequest();
            manageRepaylogMortgageListRequest.setMobile(request.getParameter("mobile"));
            manageRepaylogMortgageListRequest.setOrderNo(request.getParameter("orderNo"));
            manageRepaylogMortgageListRequest.setRepayWay(request.getParameter("repayWay"));
            String length = request.getParameter("length");
            manageRepaylogMortgageListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageRepaylogMortgageListRequest.setPageSize(Integer.parseInt(length));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageRepaylogMortgageListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageRepaylogMortgageListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
//            System.out.println(JSONObject.toJSONString(manageRepaylogMortgageListRequest));
            ManageRepaylogMortgageListResponse manageRepaylogMortgageListResponse =  ProjectClient.getResult(manageRepaylogMortgageListRequest);
            if (manageRepaylogMortgageListResponse.getSuccess()){
                data = manageRepaylogMortgageListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    //手工代扣
    @PostMapping("/manualRepay")
    @ResponseBody
    public ManageRepaymentManualRepayResponse manualRepay(HttpServletRequest request, HttpServletResponse response, Model model){
        ManageRepaymentManualRepayResponse manageRepaymentManualRepayResponse = new  ManageRepaymentManualRepayResponse();
        try {
            ManageRepaymentManualRepayRequest manageRepaymentManualRepayRequest = new ManageRepaymentManualRepayRequest();
            manageRepaymentManualRepayRequest.setId(FsUtils.l( request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(manageRepaymentManualRepayRequest));
            manageRepaymentManualRepayResponse = ProjectClient.getResult(manageRepaymentManualRepayRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageRepaymentManualRepayResponse;
    }

    // 查看明细
    @RequestMapping("/repaymentDetailPage")
    public String repaymentDetailPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/borrow/repay/repay_detail";
    }

    @PostMapping("/repaymentDetail")
    @ResponseBody
    public ManageRepaymentDetailResponse repaymentDetail(HttpServletRequest request, HttpServletResponse response, Model model){
        ManageRepaymentDetailResponse manageRepaymentDetailResponse = new  ManageRepaymentDetailResponse();
        try {
            ManageRepaymentDetailRequest manageRepaymentDetailRequest = new ManageRepaymentDetailRequest();
            manageRepaymentDetailRequest.setId(FsUtils.l( request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(manageRepaymentDetailRequest));
            manageRepaymentDetailResponse = ProjectClient.getResult(manageRepaymentDetailRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageRepaymentDetailResponse;
    }

}

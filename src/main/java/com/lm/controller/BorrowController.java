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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/borrowMana")
@Controller
public class BorrowController {

    // 车位借款订单
    @RequestMapping("/borrowMortgageListPage")
    public String borrowMortgageListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/mortgage_borrow_list";
    }

    @RequestMapping("/borrowMortgageList")
    @ResponseBody
    public JSONObject borrowMortgageList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageMortgageBorrowListDomain> data = new ItemData<ManageMortgageBorrowListDomain>();
            ManageMortgageBorrowListRequest manageMortgageBorrowListRequest = new ManageMortgageBorrowListRequest();
            manageMortgageBorrowListRequest.setState(request.getParameter("state"));
            manageMortgageBorrowListRequest.setMobile(request.getParameter("mobile"));
            manageMortgageBorrowListRequest.setOrderNo(request.getParameter("orderNo"));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageMortgageBorrowListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageMortgageBorrowListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            String length = request.getParameter("length");
            manageMortgageBorrowListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageMortgageBorrowListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageMortgageBorrowListRequest));
            ManageMortgageBorrowListResponse manageMortgageBorrowListResponse =  ProjectClient.getResult(manageMortgageBorrowListRequest);
            if (manageMortgageBorrowListResponse.getSuccess()){
                data = manageMortgageBorrowListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 车位放款订单
    @RequestMapping("/repayMortgageListPage")
    public String repayMortgageListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/mortgage_repay_list";
    }

    @RequestMapping("/repayMortgageList")
    @ResponseBody
    public JSONObject repayMortgageList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageMortgageBorrowLoanlistDomain> data = new ItemData<ManageMortgageBorrowLoanlistDomain>();
            ManageMortgageBorrowLoanlistRequest manageMortgageBorrowLoanlistRequest = new ManageMortgageBorrowLoanlistRequest();
            manageMortgageBorrowLoanlistRequest.setState(request.getParameter("state"));
            manageMortgageBorrowLoanlistRequest.setMobile(request.getParameter("mobile"));
            manageMortgageBorrowLoanlistRequest.setOrderNo(request.getParameter("orderNo"));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageMortgageBorrowLoanlistRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageMortgageBorrowLoanlistRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            String length = request.getParameter("length");
            manageMortgageBorrowLoanlistRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageMortgageBorrowLoanlistRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageMortgageBorrowLoanlistRequest));
            ManageMortgageBorrowLoanlistResponse manageMortgageBorrowLoanlistResponse =  ProjectClient.getResult(manageMortgageBorrowLoanlistRequest);
            if (manageMortgageBorrowLoanlistResponse.getSuccess()){
                data = manageMortgageBorrowLoanlistResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 信用借款订单
    @RequestMapping("/borrowCreditListPage")
    public String borrowCreditListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/credit_borrow_list";
    }

    @RequestMapping("/borrowCreditList")
    @ResponseBody
    public JSONObject borrowCreditList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageCreditBorrowListDomain> data = new ItemData<ManageCreditBorrowListDomain>();
            ManageCreditBorrowListRequest manageCreditBorrowListRequest = new ManageCreditBorrowListRequest();
            manageCreditBorrowListRequest.setState(request.getParameter("state"));
            manageCreditBorrowListRequest.setMobile(request.getParameter("mobile"));
            manageCreditBorrowListRequest.setOrderNo(request.getParameter("orderNo"));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageCreditBorrowListRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageCreditBorrowListRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            String length = request.getParameter("length");
            manageCreditBorrowListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageCreditBorrowListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageCreditBorrowListRequest));
            ManageCreditBorrowListResponse manageCreditBorrowListResponse =  ProjectClient.getResult(manageCreditBorrowListRequest);
            if (manageCreditBorrowListResponse.getSuccess()){
                data = manageCreditBorrowListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 信用放款订单
    @RequestMapping("/repayCreditListPage")
    public String repayCreditListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/credit_repay_list";
    }

    @RequestMapping("/repayCreditList")
    @ResponseBody
    public JSONObject repayCreditList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageCreditBorrowLoanlistDomain> data = new ItemData<ManageCreditBorrowLoanlistDomain>();
            ManageCreditBorrowLoanlistRequest manageCreditBorrowLoanlistRequest = new ManageCreditBorrowLoanlistRequest();
            manageCreditBorrowLoanlistRequest.setState(request.getParameter("state"));
            manageCreditBorrowLoanlistRequest.setMobile(request.getParameter("mobile"));
            manageCreditBorrowLoanlistRequest.setOrderNo(request.getParameter("orderNo"));
            String showTime = request.getParameter("showTime");
            if (!FsUtils.strsEmpty(showTime)) {
                String[] time = request.getParameter("showTime").split("~");
                if (!FsUtils.strsEmpty(time)) {
                    manageCreditBorrowLoanlistRequest.setStart(FsUtils.parseDateTime(time[0], "yyyy-MM-dd"));
                    manageCreditBorrowLoanlistRequest.setEnd(FsUtils.parseDateTime(time[1], "yyyy-MM-dd"));
                }
            }
            String length = request.getParameter("length");
            manageCreditBorrowLoanlistRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageCreditBorrowLoanlistRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageCreditBorrowLoanlistRequest));
            ManageCreditBorrowLoanlistResponse manageCreditBorrowLoanlistResponse =  ProjectClient.getResult(manageCreditBorrowLoanlistRequest);
            if (manageCreditBorrowLoanlistResponse.getSuccess()){
                data = manageCreditBorrowLoanlistResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 信用信息
    @RequestMapping("/creditBorrowInfoPage")
    public String creditBorrowInfoPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/borrow/credit_info";
    }
}

package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.borrow.domain.ManageCreditBorrowRepayListDomain;
import com.hwc.loan.sdk.borrow.domain.ManageMortgageBorrowRepayListDomain;
import com.hwc.loan.sdk.borrow.domain.ManagePayCreditListDomain;
import com.hwc.loan.sdk.borrow.domain.ManagePayMorrgageListDomain;
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

@RequestMapping("/loanMana")
@Controller
public class LoanController {

    // 信用已还款
    @RequestMapping("/creditRepayListPage")
    public String creditRepayListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/loan/credit_repay_list";
    }

    // 信用已逾期
    @RequestMapping("/creditOverdueListPage")
    public String creditOverdueListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/loan/credit_overdue_list";
    }

    @RequestMapping("/creditRepayList")
    @ResponseBody
    public JSONObject creditRepayList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageCreditBorrowRepayListDomain> data = new ItemData<ManageCreditBorrowRepayListDomain>();
            ManageCreditBorrowRepayListRequest manageCreditBorrowRepayListRequest = new ManageCreditBorrowRepayListRequest();
            manageCreditBorrowRepayListRequest.setMobile(request.getParameter("mobile"));
            manageCreditBorrowRepayListRequest.setOrderNo(request.getParameter("orderNo"));
            manageCreditBorrowRepayListRequest.setState(request.getParameter("state"));
            String length = request.getParameter("length");
            manageCreditBorrowRepayListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageCreditBorrowRepayListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(managePayCreditListRequest));
            ManageCreditBorrowRepayListResponse manageCreditBorrowRepayListResponse =  ProjectClient.getResult(manageCreditBorrowRepayListRequest);
            if (manageCreditBorrowRepayListResponse.getSuccess()){
                data = manageCreditBorrowRepayListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 抵押已还款
    @RequestMapping("/morgageRepayListPage")
    public String morgageRepayListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/loan/mortgage_repay_list";
    }

    // 抵押逾期
    @RequestMapping("/morgageOverdueListPage")
    public String morgageOverdueListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/borrow/loan/mortgage_overdue_list";
    }

    @RequestMapping("/morgageRepayList")
    @ResponseBody
    public JSONObject morgageRepayList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageMortgageBorrowRepayListDomain> data = new ItemData<ManageMortgageBorrowRepayListDomain>();
            ManageMortgageBorrowRepayListRequest manageMortgageBorrowRepayListRequest = new ManageMortgageBorrowRepayListRequest();
            manageMortgageBorrowRepayListRequest.setMobile(request.getParameter("mobile"));
            manageMortgageBorrowRepayListRequest.setOrderNo(request.getParameter("orderNo"));
            manageMortgageBorrowRepayListRequest.setState(request.getParameter("state"));
            String length = request.getParameter("length");
            manageMortgageBorrowRepayListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageMortgageBorrowRepayListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(managePayMorrgageListRequest));
            ManageMortgageBorrowRepayListResponse manageMortgageBorrowRepayListResponse =  ProjectClient.getResult(manageMortgageBorrowRepayListRequest);
            if (manageMortgageBorrowRepayListResponse.getSuccess()){
                data = manageMortgageBorrowRepayListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

}

package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.borrow.domain.ManageCreditBorrowReviewlistDomain;
import com.hwc.loan.sdk.borrow.domain.ManageMortgageListDomain;
import com.hwc.loan.sdk.borrow.request.*;
import com.hwc.loan.sdk.borrow.response.*;
import com.lm.client.ProjectClient;
import com.lm.common.ProjectConstant;
import com.lm.utils.CommonUtil;
import com.lm.utils.PageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static com.alibaba.fastjson.JSONObject.*;

@RequestMapping("/riskMana")
@Controller
public class RiskController {
    // 抵押分期
    @RequestMapping("/mortgageListPage")
    public String mortgageListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/risk/mortgage_list";
    }

    // 用户信息页面
    @RequestMapping("/mortgageUserPage")
    public String mortgageUserPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/risk/mortgage_usermsg";
    }

    // 审核页面
    @RequestMapping("/mortgageAuditPage")
    public String mortgageAuditPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        model.addAttribute("status",request.getParameter("status"));
        return "/risk/mortgage_audit";
    }

    //用户信息
    @PostMapping("/mortgageUser")
    @ResponseBody
    public ManageMortgageDetailResponse mortgageUser(HttpServletRequest request, HttpServletResponse response){
        ManageMortgageDetailResponse manageMortgageDetailResponse = new  ManageMortgageDetailResponse();
        try {
            ManageMortgageDetailRequest manageMortgageDetailRequest = new ManageMortgageDetailRequest();
            manageMortgageDetailRequest.setId(FsUtils.l(request.getParameter("id")));
            manageMortgageDetailResponse = ProjectClient.getResult(manageMortgageDetailRequest);
//            System.out.println(JSONObject.toJSONString(manageMortgageDetailResponse));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageMortgageDetailResponse;
    }

        // 抵押初审
    @RequestMapping("/mortgageTrialListPage")
    public String mortgageTrialListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/risk/mortgage_trial_list";
    }

    @RequestMapping("/mortgageTrialList")
    @ResponseBody
    public JSONObject mortgageTrialList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageMortgageListDomain> data = new ItemData<ManageMortgageListDomain>();
            ManageMortgageListRequest manageMortgageListRequest = new ManageMortgageListRequest();
            manageMortgageListRequest.setState(request.getParameter("status"));
            manageMortgageListRequest.setMobile(request.getParameter("mobile"));
            manageMortgageListRequest.setOrderNo(request.getParameter("orderNo"));
            String length = request.getParameter("length");
            manageMortgageListRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageMortgageListRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageMortgageListRequest));
            ManageMortgageListResponse manageMortgageListResponse =  ProjectClient.getResult(manageMortgageListRequest);
            if (manageMortgageListResponse.getSuccess()){
                data = manageMortgageListResponse.getData();
//                System.out.println(JSONObject.toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    //初审审核
    @PostMapping("/mortgageTrial")
    @ResponseBody
    public ManageMortgageTrialResponse mortgageTrial(HttpServletRequest request, HttpServletResponse response){
        ManageMortgageTrialResponse manageMortgageTrialResponse = new  ManageMortgageTrialResponse();
        try {
            ManageMortgageTrialRequest manageMortgageTrialRequest = new ManageMortgageTrialRequest();
            manageMortgageTrialRequest.setId(FsUtils.l(request.getParameter("id")));
            manageMortgageTrialRequest.setState(request.getParameter("status"));
            manageMortgageTrialRequest.setRemark(request.getParameter("remark"));
//            System.out.println(JSONObject.toJSONString(manageMortgageTrialRequest));
            manageMortgageTrialResponse = ProjectClient.getResult(manageMortgageTrialRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageMortgageTrialResponse;
    }

    // 抵押复审
    @RequestMapping("/mortgageReviewListPage")
    public String mortgageReviewListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/risk/mortgage_review_list";
    }

    // 抵押复审
    @PostMapping("/mortgageReviewList")
    @ResponseBody
    public ManageMortgageReviewAuthResponse mortgageReviewList(HttpServletRequest request, HttpServletResponse response){
        ManageMortgageReviewAuthResponse manageMortgageReviewAuthResponse = new  ManageMortgageReviewAuthResponse();
        try {
            ManageMortgageReviewAuthRequest manageMortgageReviewAuthRequest = new ManageMortgageReviewAuthRequest();
            manageMortgageReviewAuthRequest.setId(FsUtils.l(request.getParameter("id")));
            manageMortgageReviewAuthRequest.setState(request.getParameter("status"));
            manageMortgageReviewAuthRequest.setRemark(request.getParameter("remark"));
//            System.out.println(JSONObject.toJSONString(manageMortgageReviewAuthRequest));
            manageMortgageReviewAuthResponse = ProjectClient.getResult(manageMortgageReviewAuthRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageMortgageReviewAuthResponse;
    }

    // 设置额度页面
    @RequestMapping("/mortgageReviewEditPage")
    public String mortgageReviewEditPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/risk/mortgage_review_edit";
    }

    // 设置额度
    @PostMapping("/mortgageReviewEdit")
    @ResponseBody
    public ManageMortgageSetQuotaResponse mortgageReviewEdit(HttpServletRequest request, HttpServletResponse response){
        ManageMortgageSetQuotaResponse manageMortgageSetQuotaResponse = new  ManageMortgageSetQuotaResponse();
        try {
            ManageMortgageSetQuotaRequest manageMortgageSetQuotaRequest = new ManageMortgageSetQuotaRequest();
            manageMortgageSetQuotaRequest.setId(FsUtils.l(request.getParameter("id")));
            manageMortgageSetQuotaRequest.setRealQuota(FsUtils.d(request.getParameter("realQuota")));
            manageMortgageSetQuotaRequest.setRealRate(FsUtils.d(request.getParameter("realRate")));
//            System.out.println(JSONObject.toJSONString(manageMortgageSetQuotaRequest));
            manageMortgageSetQuotaResponse = ProjectClient.getResult(manageMortgageSetQuotaRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageMortgageSetQuotaResponse;
    }

    // 抵押过户
    @RequestMapping("/mortgageFinalListPage")
    public String mortgageFinalListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/risk/mortgage_final_list";
    }

    //终审审核
    @PostMapping("/mortgageFinalList")
    @ResponseBody
    public ManageMortgageFinalAuthResponse mortgageFinalList(HttpServletRequest request, HttpServletResponse response){
        ManageMortgageFinalAuthResponse manageMortgageFinalAuthResponse = new  ManageMortgageFinalAuthResponse();
        try {
            ManageMortgageFinalAuthRequest manageMortgageFinalAuthRequest = new ManageMortgageFinalAuthRequest();
            manageMortgageFinalAuthRequest.setId(FsUtils.l(request.getParameter("id")));
            manageMortgageFinalAuthRequest.setState(request.getParameter("status"));
            manageMortgageFinalAuthRequest.setRemark(request.getParameter("remark"));
//            System.out.println(JSONObject.toJSONString(manageMortgageFinalAuthRequest));
            manageMortgageFinalAuthResponse = ProjectClient.getResult(manageMortgageFinalAuthRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageMortgageFinalAuthResponse;
    }

    // 信用复审
    @RequestMapping("/creditReviewListPage")
    public String creditReviewListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/risk/credit_borrow_list";
    }

    @RequestMapping("/creditReviewList")
    @ResponseBody
    public JSONObject creditReviewList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<ManageCreditBorrowReviewlistDomain> data = new ItemData<ManageCreditBorrowReviewlistDomain>();
            ManageCreditBorrowReviewlistRequest manageCreditBorrowReviewlistRequest = new ManageCreditBorrowReviewlistRequest();
            manageCreditBorrowReviewlistRequest.setState(request.getParameter("state"));
            manageCreditBorrowReviewlistRequest.setMobile(request.getParameter("mobile"));
            manageCreditBorrowReviewlistRequest.setOrderNo(request.getParameter("orderNo"));
            String length = request.getParameter("length");
            manageCreditBorrowReviewlistRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), length));
            manageCreditBorrowReviewlistRequest.setPageSize(Integer.parseInt(length));
//            System.out.println(JSONObject.toJSONString(manageCreditBorrowReviewlistRequest));
            ManageCreditBorrowReviewlistResponse manageCreditBorrowReviewlistResponse =  ProjectClient.getResult(manageCreditBorrowReviewlistRequest);
            if (manageCreditBorrowReviewlistResponse.getSuccess()){
                data = manageCreditBorrowReviewlistResponse.getData();
//                System.out.println(toJSONString(data));
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    // 信用复审
    @RequestMapping("/creditBorrowAuditPage")
    public String creditBorrowAuditPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/risk/credit_audit";
    }

    //信用信息
    @PostMapping("/creditBorrowDetail")
    @ResponseBody
    public ManageCreditBorrowDetailResponse creditBorrowDetail(HttpServletRequest request, HttpServletResponse response){
        ManageCreditBorrowDetailResponse manageCreditBorrowDetailResponse = new  ManageCreditBorrowDetailResponse();
        try {
            ManageCreditBorrowDetailRequest manageCreditBorrowDetailRequest = new ManageCreditBorrowDetailRequest();
            manageCreditBorrowDetailRequest.setId(FsUtils.l(request.getParameter("id")));
            manageCreditBorrowDetailResponse = ProjectClient.getResult(manageCreditBorrowDetailRequest);
//            System.out.println(JSONObject.toJSONString(manageCreditBorrowDetailRequest));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageCreditBorrowDetailResponse;
    }

    //信用审核
    @PostMapping("/creditBorrowAudit")
    @ResponseBody
    public ManageCreditBorrowAuditResponse creditBorrowAudit(HttpServletRequest request, HttpServletResponse response){
        ManageCreditBorrowAuditResponse manageCreditBorrowAuditResponse = new  ManageCreditBorrowAuditResponse();
        try {
            ManageCreditBorrowAuditRequest manageCreditBorrowAuditRequest = new ManageCreditBorrowAuditRequest();
            manageCreditBorrowAuditRequest.setId(FsUtils.l(request.getParameter("id")));
            manageCreditBorrowAuditRequest.setState(request.getParameter("status"));
            manageCreditBorrowAuditRequest.setRemark(request.getParameter("remark"));
//            System.out.println(JSONObject.toJSONString(manageCreditBorrowAuditRequest));
            manageCreditBorrowAuditResponse = ProjectClient.getResult(manageCreditBorrowAuditRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageCreditBorrowAuditResponse;
    }

    // 上传图片
    @RequestMapping("/mortgageUpImagepage")
    public String mortgageUpImagepage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        model.addAttribute("userId",request.getParameter("userId"));
        model.addAttribute("cat",request.getParameter("cat"));
        return "/risk/mortgage_upImage";
    }

    //上传图片
    @PostMapping("/mortgageUpImage")
    @ResponseBody
    public ManageMortgageUpImageResponse mortgageUpImage(HttpServletRequest request, HttpServletResponse response){
        JSONObject ret = new JSONObject();
        ManageMortgageUpImageResponse manageMortgageUpImageResponse = new  ManageMortgageUpImageResponse();
        try {
            ManageMortgageUpImageRequest manageMortgageUpImageRequest = new ManageMortgageUpImageRequest();
            manageMortgageUpImageRequest.setMid(FsUtils.l(request.getParameter("id")));
            manageMortgageUpImageRequest.setUserId(FsUtils.l(request.getParameter("userId")));
            manageMortgageUpImageRequest.setCat(request.getParameter("cat"));
            String img_list = request.getParameter("picUrl");
            String[] list = img_list.split(",");
            if (!FsUtils.strsEmpty(list) && list.length>0){
                List<String> imagePathList = Arrays.asList(list);
                List<String> newPath = new ArrayList<String>();
                for (int i = 0; i<imagePathList.size(); i++){
                    String imagePath =  imagePathList.get(i);
                    String path = ProjectConstant.NEW_IMAGE_NAME_LOCAL+"/";
                    newPath.add(imagePath.replace(path,""));
                }
                manageMortgageUpImageRequest.setUrl(newPath);
            }else {
                ret.put("success",false);
                ret.put("message","至少要上传一张图片");
            }

            System.out.println(JSONObject.toJSONString(manageMortgageUpImageRequest));
            manageMortgageUpImageResponse = ProjectClient.getResult(manageMortgageUpImageRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manageMortgageUpImageResponse;
    }


}

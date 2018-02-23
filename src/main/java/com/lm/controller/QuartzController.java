/**
 * Copyright (c) 2017 All Rights Reserved.
 */
package com.lm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hwc.loan.sdk.quzrtz.request.QuartzAddOneRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzDisabledRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzExecuteRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzListPageRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzLoadRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzLogListPageRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzRunRequest;
import com.hwc.loan.sdk.quzrtz.request.QuartzUpdateRequest;
import com.hwc.loan.sdk.quzrtz.response.QuartzAddOneResponse;
import com.hwc.loan.sdk.quzrtz.response.QuartzDisabledResponse;
import com.hwc.loan.sdk.quzrtz.response.QuartzExecuteResponse;
import com.hwc.loan.sdk.quzrtz.response.QuartzListPageResponse;
import com.hwc.loan.sdk.quzrtz.response.QuartzLogListPageResponse;
import com.hwc.loan.sdk.quzrtz.response.QuartzUpdateResponse;
import com.lm.client.ProjectClient;
import com.lm.utils.CommonUtil;
import com.lm.utils.PageUtils;

/**
 * 定时配置
 * @author jinlilong
 * @version $Id: QuartzController.java, v 0.1 2017年12月28日 上午9:32:15 jinlilong Exp $
 */
@RequestMapping("/quartzMana")
@Controller
public class QuartzController {

    /**
     * 
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/quartzManaListPage")
    public String quartzManaListPage(HttpServletRequest request, HttpServletResponse response,
                                     Model model) {

        return "/system/quartz/list";
    }

    /**
     * 
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/quartzLogManaListPage")
    public String quartzLogManaListPage(HttpServletRequest request, HttpServletResponse response,
                                        Model model) {
        model.addAttribute("id", request.getParameter("id"));
        return "/system/quartzLog/list";
    }

    /**
     * 
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/editQuartzPage")
    public String editQuartzPage(HttpServletRequest request, HttpServletResponse response,
                                 Model model) {
        model.addAttribute("id", request.getParameter("id"));
        return "/system/quartz/edit";
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/quartzManaList")
    @ResponseBody
    public JSONObject quartzManagerList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            QuartzListPageRequest quartzListPageRequest = new QuartzListPageRequest();
            quartzListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"),
                request.getParameter("length")));
            QuartzListPageResponse quartzListPageResponse = ProjectClient
                .getResult(quartzListPageRequest);
            if (quartzListPageResponse.getSuccess()) {
                ret = CommonUtil.converStringToDataJSON(quartzListPageResponse.getData());
            }

        } catch (Exception e) {
            e.printStackTrace();
            // TODO: handle exception
        }
        return ret;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/quartzLogManaList")
    @ResponseBody
    public JSONObject quartzLogManaList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            QuartzLogListPageRequest quartzLogListPageRequest = new QuartzLogListPageRequest();
            quartzLogListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"),
                request.getParameter("length")));
            quartzLogListPageRequest.setQuartzId(Long.valueOf(request.getParameter("id")));
            QuartzLogListPageResponse quartzLogListPageResponse = ProjectClient
                .getResult(quartzLogListPageRequest);
            if (quartzLogListPageResponse.getSuccess()) {
                ret = CommonUtil.converStringToDataJSON(quartzLogListPageResponse.getData());
            }

        } catch (Exception e) {
            e.printStackTrace();
            // TODO: handle exception
        }
        return ret;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryQuartzById")
    @ResponseBody
    public QuartzExecuteResponse queryQuartzById(HttpServletRequest request,
                                                 HttpServletResponse response) {
        QuartzExecuteResponse quartzExecuteResponse = new QuartzExecuteResponse();
        try {
            QuartzLoadRequest quartzLoadRequest = new QuartzLoadRequest();
            quartzLoadRequest.setId(Long.valueOf(request.getParameter("id")));
            quartzExecuteResponse = ProjectClient.getResult(quartzLoadRequest);
        } catch (Exception e) {
            // TODO: handle exception
        }
        return quartzExecuteResponse;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addQuartz")
    @ResponseBody
    public QuartzAddOneResponse addQuartz(HttpServletRequest request,
                                          HttpServletResponse response) {
        QuartzAddOneResponse quartzAddOneResponse = new QuartzAddOneResponse();
        try {
            QuartzAddOneRequest quartzAddOneRequest = new QuartzAddOneRequest();
            quartzAddOneRequest.setClassName(request.getParameter("className"));
            quartzAddOneRequest.setCode(request.getParameter("code"));
            quartzAddOneRequest.setCycle(request.getParameter("cycle"));
            quartzAddOneRequest.setName(request.getParameter("name"));
            quartzAddOneResponse = ProjectClient.getResult(quartzAddOneRequest);

        } catch (Exception e) {
            e.printStackTrace();
            // TODO: handle exception
        }
        return quartzAddOneResponse;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/editQuartz")
    @ResponseBody
    public QuartzUpdateResponse editQuartz(HttpServletRequest request,
                                           HttpServletResponse response) {
        QuartzUpdateResponse quartzUpdateResponse = new QuartzUpdateResponse();
        try {
            QuartzUpdateRequest quartzUpdateRequest = new QuartzUpdateRequest();
            quartzUpdateRequest.setClassName(request.getParameter("className"));
            quartzUpdateRequest.setCode(request.getParameter("code"));
            quartzUpdateRequest.setCycle(request.getParameter("cycle"));
            quartzUpdateRequest.setName(request.getParameter("name"));
            quartzUpdateRequest.setId(Long.parseLong(request.getParameter("id")));
            quartzUpdateResponse = ProjectClient.getResult(quartzUpdateRequest);

        } catch (Exception e) {
            // TODO: handle exception
        }
        return quartzUpdateResponse;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/runQuartz")
    @ResponseBody
    public QuartzExecuteResponse runQuartz(HttpServletRequest request,
                                           HttpServletResponse response) {
        QuartzExecuteResponse quartzExecuteResponse = new QuartzExecuteResponse();
        try {
            QuartzRunRequest quartzRunRequest = new QuartzRunRequest();
            quartzRunRequest.setId(Long.parseLong(request.getParameter("id")));
            quartzExecuteResponse = ProjectClient.getResult(quartzRunRequest);
        } catch (Exception e) {
            // TODO: handle exception
        }
        return quartzExecuteResponse;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/enableQuartz")
    @ResponseBody
    public QuartzExecuteResponse enableQuartz(HttpServletRequest request,
                                              HttpServletResponse response) {
        QuartzExecuteResponse quartzExecuteResponse = new QuartzExecuteResponse();
        try {
            QuartzExecuteRequest quartzExecuteRequest = new QuartzExecuteRequest();
            quartzExecuteRequest.setId(Long.parseLong(request.getParameter("id")));
            quartzExecuteResponse = ProjectClient.getResult(quartzExecuteRequest);
        } catch (Exception e) {
            // TODO: handle exception
        }
        return quartzExecuteResponse;
    }

    /**
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/disableQuartz")
    @ResponseBody
    public QuartzDisabledResponse disableQuartz(HttpServletRequest request,
                                                HttpServletResponse response) {
        QuartzDisabledResponse quartzDisabledResponse = new QuartzDisabledResponse();
        try {
            QuartzDisabledRequest quartzDisabledRequest = new QuartzDisabledRequest();
            quartzDisabledRequest.setId(Long.parseLong(request.getParameter("id")));
            quartzDisabledResponse = ProjectClient.getResult(quartzDisabledRequest);
        } catch (Exception e) {
            // TODO: handle exception
        }
        return quartzDisabledResponse;
    }

}

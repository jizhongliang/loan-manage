package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.admin.domain.DMenuDomain;
import com.hwc.loan.sdk.admin.domain.DSysRoleDomain;
import com.hwc.loan.sdk.admin.request.*;
import com.hwc.loan.sdk.admin.response.*;
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

@RequestMapping("/roleMana")
@Controller
public class RoleController {

    @RequestMapping("/searchRoleListPage")
    public String searchUserListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "/system/role/list";
    }

    @RequestMapping("/searchRoleList")
    @ResponseBody
    public JSONObject searchUserList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DSysRoleDomain> data = new ItemData<DSysRoleDomain>();
            RoleListPageRequest roleListPageRequest = new RoleListPageRequest();
            roleListPageRequest.setName(request.getParameter("name"));
            roleListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            RoleListPageResponse roleListPageResponse = ProjectClient.getResult(roleListPageRequest);
            if (roleListPageResponse.getSuccess()){
                data = roleListPageResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    //编辑角色页面
    @RequestMapping("/editRolePage")
    public String editRolePage(HttpServletRequest request,HttpServletResponse response,Model model){
        model.addAttribute("id",request.getParameter("id"));
        return "/system/role/edit";
    }

    //新建或编辑角色
    @PostMapping("/editRole")
    @ResponseBody
    public RoleUpdateOneResponse editRole(HttpServletRequest request, HttpServletResponse response, Model model){
        RoleUpdateOneResponse roleUpdateOneResponse = new  RoleUpdateOneResponse();
        String id = request.getParameter("id");
        try {
            if (!id.equals("1")){
                RoleUpdateOneRequest roleUpdateOneRequest = new RoleUpdateOneRequest();
                roleUpdateOneRequest.setId(FsUtils.i(id));
                roleUpdateOneRequest.setName(request.getParameter("name"));
                roleUpdateOneRequest.setTips(request.getParameter("tips"));
                roleUpdateOneRequest.setNum(FsUtils.i(request.getParameter("num")));
                roleUpdateOneResponse = ProjectClient.getResult(roleUpdateOneRequest);
            }else {
                roleUpdateOneResponse.setCode(400);
                roleUpdateOneResponse.setSuccess(false);
                roleUpdateOneResponse.setMessage("不允许修改超级管理员");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleUpdateOneResponse;
    }

    //获取一个角色信息
    @PostMapping("/getOneRole")
    @ResponseBody
    public RoleGetOneResponse getOneRole(HttpServletRequest request, HttpServletResponse response, Model model){
        RoleGetOneResponse roleGetOneResponse = new  RoleGetOneResponse();
        try {
            RoleGetOneRequest roleGetOneRequest = new RoleGetOneRequest();
            roleGetOneRequest.setId(FsUtils.i(request.getParameter("id")));
            roleGetOneResponse = ProjectClient.getResult(roleGetOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleGetOneResponse;
    }

    //删除角色
    @PostMapping("/deleteOneRole")
    @ResponseBody
    public RoleDeleteOneResponse deleteOneRole(HttpServletRequest request, HttpServletResponse response, Model model){
        RoleDeleteOneResponse roleDeleteOneResponse = new  RoleDeleteOneResponse();
        String id = request.getParameter("id");
        try {
            if (!id.equals("1")){
                RoleDeleteOneRequest roleDeleteOneRequest = new RoleDeleteOneRequest();
                roleDeleteOneRequest.setId(FsUtils.i(id));
                roleDeleteOneResponse = ProjectClient.getResult(roleDeleteOneRequest);
            }else {
                roleDeleteOneResponse.setCode(400);
                roleDeleteOneResponse.setSuccess(false);
                roleDeleteOneResponse.setMessage("不允许删除超级管理员");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleDeleteOneResponse;
    }


    @RequestMapping("/searchDeptListPage")
    public String searchDeptListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/system/role/dept";
    }

    @RequestMapping("/searchDeptList")
    @ResponseBody
    public JSONObject searchDeptList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DMenuDomain> data = new ItemData<DMenuDomain>();
            MenuListRequest menuListRequest = new MenuListRequest();
            MenuListResponse menuListResponse =  ProjectClient.getResult(menuListRequest);
            if (menuListResponse.getSuccess()){
                data = menuListResponse.getData();
                // 按插件格式输出
                JSONObject input= JSON.parseObject(JSONObject.toJSONString(data));
                ret.put("data", input.get("items"));
                ret.put("recordsTotal",input.get("total"));
                ret.put("recordsFiltered",input.get("total"));
                ret.put("draw", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }


    //编辑权限
    @PostMapping("/editRoleDept")
    @ResponseBody
    public RoleSetAuthorityResponse editRoleDept(HttpServletRequest request,HttpServletResponse response,Model model){
        RoleSetAuthorityResponse roleSetAuthorityResponse = new  RoleSetAuthorityResponse();
        try {
            RoleSetAuthorityRequest roleSetAuthorityRequest = new RoleSetAuthorityRequest();
            roleSetAuthorityRequest.setIds(request.getParameter("ids"));
            roleSetAuthorityRequest.setRoleId(FsUtils.i(request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(roleSetAuthorityRequest));
            roleSetAuthorityResponse = ProjectClient.getResult(roleSetAuthorityRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleSetAuthorityResponse;
    }

    //获取权限
    @PostMapping("/getRoleDept")
    @ResponseBody
    public MenuListByRoleResponse getRoleDept(HttpServletRequest request,HttpServletResponse response,Model model){
        MenuListByRoleResponse menuListByRoleResponse = new  MenuListByRoleResponse();
        try {
            MenuListByRoleRequest menuListByRoleRequest = new MenuListByRoleRequest();
            menuListByRoleRequest.setId(FsUtils.i(request.getParameter("id")));
            menuListByRoleResponse = ProjectClient.getResult(menuListByRoleRequest);
//            System.out.println(JSONObject.toJSONString(menuListByRoleResponse));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menuListByRoleResponse;
    }

}

package com.lm.controller;

import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.admin.domain.DMenuDomain;
import com.hwc.loan.sdk.admin.domain.DNewsDomian;
import com.hwc.loan.sdk.admin.request.*;
import com.hwc.loan.sdk.admin.response.*;
import com.lm.client.ProjectClient;
import com.lm.utils.PageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/menuMana")
@Controller
public class MenuController {

    @RequestMapping("/searchMenuListPage")
    public String searchMenuListPage(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "/system/menu/list";
    }

    @RequestMapping("/searchMenuList")
    @ResponseBody
    public JSONObject searchMenuList(HttpServletRequest request, HttpServletResponse response) {
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


    @RequestMapping("/editMenuPage")
    public String editMenuPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("id",request.getParameter("id"));
        return "/system/menu/edit";
    }

    //新建
    @RequestMapping("/addMenu")
    @ResponseBody
    public MenuAddOneResponse addMenu(HttpServletRequest request, HttpServletResponse response, DNewsDomian newsDomian) {
        MenuAddOneResponse menuAddOneResponse = new MenuAddOneResponse();
        try{
            MenuAddOneRequest menuAddOneRequest = new MenuAddOneRequest();
            menuAddOneRequest.setName(request.getParameter("name"));
            menuAddOneRequest.setIcon(request.getParameter("icon"));
            menuAddOneRequest.setTips(request.getParameter("tips"));
            menuAddOneRequest.setPcode(request.getParameter("pcode"));
            menuAddOneRequest.setCode(request.getParameter("code"));
            menuAddOneRequest.setUrl(request.getParameter("url"));
            menuAddOneRequest.setIsmenu(FsUtils.i(request.getParameter("ismenu")));
            menuAddOneRequest.setStatus(FsUtils.i(request.getParameter("status")));
//            System.out.println(JSONObject.toJSONString(menuAddOneRequest));
            menuAddOneResponse = ProjectClient.getResult(menuAddOneRequest);
        }catch (Exception e){
            e.printStackTrace();
        }
        return menuAddOneResponse;
    }

    //编辑
    @RequestMapping("/editMenu")
    @ResponseBody
    public MenuUpdateOneResponse editMenu(HttpServletRequest request, HttpServletResponse response, DNewsDomian newsDomian) {
        MenuUpdateOneResponse menuUpdateOneResponse = new MenuUpdateOneResponse();
        try{
            MenuUpdateOneRequest menuUpdateOneRequest = new MenuUpdateOneRequest();
            menuUpdateOneRequest.setId(FsUtils.i(request.getParameter("id")));
            menuUpdateOneRequest.setName(request.getParameter("name"));
            menuUpdateOneRequest.setIcon(request.getParameter("icon"));
            menuUpdateOneRequest.setTips(request.getParameter("tips"));
            menuUpdateOneRequest.setUrl(request.getParameter("url"));
            menuUpdateOneRequest.setPcode(request.getParameter("pcode"));
            menuUpdateOneRequest.setCode(request.getParameter("code"));
            menuUpdateOneRequest.setIsmenu(FsUtils.i(request.getParameter("ismenu")));
            menuUpdateOneRequest.setStatus(FsUtils.i(request.getParameter("status")));
//            System.out.println(JSONObject.toJSONString(menuUpdateOneRequest));
            menuUpdateOneResponse = ProjectClient.getResult(menuUpdateOneRequest);
        }catch (Exception e){
            e.printStackTrace();
        }
        return menuUpdateOneResponse;
    }

    //获取一个菜单信息
    @PostMapping("/getOneMenu")
    @ResponseBody
    public MenuGetOneResponse getOneMenu(HttpServletRequest request, HttpServletResponse response, Model model){
        MenuGetOneResponse menuGetOneResponse = new  MenuGetOneResponse();
        try {
            MenuGetOneRequest menuGetOneRequest = new MenuGetOneRequest();
            menuGetOneRequest.setId(FsUtils.i(request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(menuGetOneRequest));
            menuGetOneResponse = ProjectClient.getResult(menuGetOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menuGetOneResponse;
    }

    //删除菜单
    @PostMapping("/deleteOneMenu")
    @ResponseBody
    public MenuDeleteOneResponse deleteOneMenu(HttpServletRequest request, HttpServletResponse response, Model model){
        MenuDeleteOneResponse menuDeleteOneResponse = new  MenuDeleteOneResponse();
        try {
            MenuDeleteOneRequest menuDeleteOneRequest = new MenuDeleteOneRequest();
            menuDeleteOneRequest.setId(FsUtils.i(request.getParameter("id")));
//            System.out.println(JSONObject.toJSONString(menuDeleteOneRequest));
            menuDeleteOneResponse = ProjectClient.getResult(menuDeleteOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menuDeleteOneResponse;
    }
}

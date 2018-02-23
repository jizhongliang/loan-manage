package com.lm.controller;

import cn.freesoft.FsParameters;
import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSONObject;
import com.hwc.base.sdk.core.ItemData;
import com.hwc.loan.sdk.user.domain.DWContactsDomain;
import com.hwc.loan.sdk.user.domain.DWContactsImportDomain;
import com.hwc.loan.sdk.user.request.ImportWContactsListRequest;
import com.hwc.loan.sdk.user.request.WContactsGetOneDetailsRequest;
import com.hwc.loan.sdk.user.request.WContactsListPageRequest;
import com.hwc.loan.sdk.user.request.WContactsUpdateOneRequest;
import com.hwc.loan.sdk.user.response.ImportWContactsListResponse;
import com.hwc.loan.sdk.user.response.WContactsGetOneDetailsResponse;
import com.hwc.loan.sdk.user.response.WContactsListPageResponse;
import com.hwc.loan.sdk.user.response.WContactsUpdateOneResponse;
import com.lm.client.ProjectClient;
import com.lm.utils.CommonUtil;
import com.lm.utils.ListPagination;
import com.lm.utils.LoanHttpClient;
import com.lm.utils.PageUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/wContactsMana")
@Controller
public class WContactsController {

    @RequestMapping("/searchWContactsListPage")
    public String searchAppListPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        String type = request.getParameter("type");
        if (FsUtils.strsEmpty(type) || type.equals("10")){
            return "/user/wContacts/xy_list";
        }else {
            return "/user/wContacts/dy_list";
        }
    }

    @RequestMapping("/searchWContactsList")
    @ResponseBody
    public JSONObject searchWContactsList(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            ItemData<DWContactsDomain> data = new ItemData<DWContactsDomain>();
            WContactsListPageRequest wContactsListPageRequest = new WContactsListPageRequest();
            wContactsListPageRequest.setPage(PageUtils.getcurrPage(request.getParameter("start"), request.getParameter("length")));
            String type = request.getParameter("type");
            if (FsUtils.strsEmpty(type)){
                wContactsListPageRequest.setCat("10");
            }else {
                wContactsListPageRequest.setCat(type);
            }
            wContactsListPageRequest.setRealName(request.getParameter("realName"));
            wContactsListPageRequest.setPhone(request.getParameter("phone"));
            wContactsListPageRequest.setIdNo(request.getParameter("idNo"));
            WContactsListPageResponse newsListPageResponse =  ProjectClient.getResult(wContactsListPageRequest);
            if (!FsUtils.strsEmpty(newsListPageResponse) && newsListPageResponse.getSuccess()){
                data = newsListPageResponse.getData();
                ret = CommonUtil.converStringToDataJSON(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    @RequestMapping("/importWContactsPage")
    public String importWContactsPage(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "/user/wContacts/import";
    }

    @RequestMapping("/importWContacts")
    @ResponseBody
    public JSONObject importWContacts(HttpServletRequest request, HttpServletResponse response) {
        JSONObject ret = new JSONObject();
        try {
            FsParameters formdatas = LoanHttpClient.getUploadFile(request);
            String extension = formdatas.getString("userFile_extension");
            String result = formdatas.getString("result");
            String type = formdatas.getString("type");
            if (result.equals("true")){
                if (!extension.equalsIgnoreCase("xlsx") && !extension.equalsIgnoreCase("xls")){
                    ret.put("success",false);
                    ret.put("message","不支持该文件类型");
                    return ret;
                }
                byte[] userFiles =  (byte[])formdatas.get("userFile");
                InputStream file = new ByteArrayInputStream(userFiles);
                Workbook xssfWorkbook = WorkbookFactory.create(file);
                int sheetNumber = xssfWorkbook.getNumberOfSheets();

                //
                List<DWContactsDomain> list = new ArrayList();
                for (int numSheet = 0; numSheet < 1; numSheet++) {
                    Sheet sheet = xssfWorkbook.getSheetAt(numSheet);
                    if (sheet == null) {
                        continue;
                    }
                    if (sheet.getLastRowNum() > 20000) {
                        ret.put("success",false);
                        ret.put("message","导入的数据不能大于20000条");
                        return ret;
                    }
                    if (type.equals("10")){ //信用分期
                        for(int i=1; i < sheet.getLastRowNum()+1; i++) {
                            DWContactsDomain dwContactsDomain = new DWContactsDomain();
                            Row row = sheet.getRow(i);
                            String phone = cellValue(row.getCell(1));
                            if (phone.indexOf(".") > 0){
                                phone = phone.substring(0,phone.indexOf("."));
                            }
                            String tipsPhone = cellValue(row.getCell(2));
                            if (tipsPhone.indexOf(".") > 0){
                                tipsPhone = tipsPhone.substring(0,tipsPhone.indexOf("."));
                            }
                            dwContactsDomain.setName(cellValue(row.getCell(0)));
                            dwContactsDomain.setPhone(phone);
                            dwContactsDomain.setTipsPhone(tipsPhone);
                            dwContactsDomain.setEducation(cellValue(row.getCell(3)));
                            dwContactsDomain.setPersonIncome(FsUtils.divNumber(cellValue(row.getCell(4))));
                            dwContactsDomain.setCompanyName(cellValue(row.getCell(5)));
                            dwContactsDomain.setCompanyType(cellValue(row.getCell(6)));
                            dwContactsDomain.setVocation(cellValue(row.getCell(7)));
                            dwContactsDomain.setLiveCommunity(cellValue(row.getCell(8)));
                            dwContactsDomain.setQuotaExpire(FsUtils.i(numberNotNull(cellValue(row.getCell(9)))));
                            dwContactsDomain.setCreditLines(FsUtils.bigdec(cellValue(row.getCell(10))));
                            dwContactsDomain.setMonthRepayBalance(FsUtils.bigdec(cellValue(row.getCell(11))));
                            dwContactsDomain.setUnuseBorrowBalance(FsUtils.bigdec(cellValue(row.getCell(12))));
                            dwContactsDomain.setOldRepayRate(FsUtils.bigdec(cellValue(row.getCell(13))));
                            String riskLevel = cellValue(row.getCell(14));
                            if (riskLevel.indexOf(".") > 0){
                                riskLevel = riskLevel.substring(0,riskLevel.indexOf("."));
                            }
                            dwContactsDomain.setRiskLevel(FsUtils.i(riskLevel));
                            dwContactsDomain.setSrc(cellValue(row.getCell(15)));
                            dwContactsDomain.setBorrowQuota(FsUtils.divNumber(cellValue(row.getCell(16))));
                            dwContactsDomain.setBorrowRate(FsUtils.bigdec(cellValue(row.getCell(17))));
                            dwContactsDomain.setIsCredit("T");
                            dwContactsDomain.setIsDy("F");
                            list.add(dwContactsDomain);
                        }
                    }else if (type.equals("20")){ // 车位分期
                        for(int i=1; i < sheet.getLastRowNum()+1; i++) {
                            DWContactsDomain dwContactsDomain = new DWContactsDomain();
                            Row row = sheet.getRow(i);
                            dwContactsDomain.setName(cellValue(row.getCell(0)));
                            String phone = cellValue(row.getCell(1));
                            if (phone.indexOf(".") > 0){
                                phone = phone.substring(0,phone.indexOf("."));
                            }
                            dwContactsDomain.setPhone(phone);
                            dwContactsDomain.setEducation(cellValue(row.getCell(2)));
                            dwContactsDomain.setPersonIncome(FsUtils.divNumber(cellValue(row.getCell(3))));
                            dwContactsDomain.setLiveAddr(cellValue(row.getCell(4)));
                            dwContactsDomain.setCompanyName(cellValue(row.getCell(5)));
                            dwContactsDomain.setCompanyType(cellValue(row.getCell(6)));
                            dwContactsDomain.setCompanyAddr(cellValue(row.getCell(7)));
                            dwContactsDomain.setDyCity(cellValue(row.getCell(8)));
                            dwContactsDomain.setLiveCommunity(cellValue(row.getCell(9)));
                            dwContactsDomain.setDyValue(FsUtils.bigdec(cellValue(row.getCell(10))));
                            dwContactsDomain.setDyValueDiscount(FsUtils.l(numberNotNull(cellValue(row.getCell(11)))));
                            dwContactsDomain.setBorrowQuota(FsUtils.divNumber(cellValue(row.getCell(12))));
                            dwContactsDomain.setQuotaExpire(FsUtils.i(numberNotNull(cellValue(row.getCell(13)))));
                            dwContactsDomain.setBorrowRate(FsUtils.bigdec(cellValue(row.getCell(14))));
                            dwContactsDomain.setIsCredit("F");
                            dwContactsDomain.setIsDy("T");
                            list.add(dwContactsDomain);
                        }
                    }else {
                        continue;
                    }
                }
                //
                if (!list.isEmpty()){
                    int pageSize = 500,totalRecord = list.size(), successNum = 0, failNum = 0;
                    if (totalRecord > pageSize){
                        int totalPageNum = (totalRecord  +  pageSize  - 1) / pageSize;
                        for (int i = 1; i <= totalPageNum ; i++){
                            List subList = ListPagination.subList(list,i,pageSize,totalPageNum);
                            ImportWContactsListRequest importWContactsListRequest = new ImportWContactsListRequest();
                            importWContactsListRequest.setList(subList);
                            ImportWContactsListResponse importWContactsListResponse =  ProjectClient.getResult(importWContactsListRequest);
                            if (importWContactsListResponse.getSuccess()){
                                successNum = successNum + importWContactsListResponse.getData().getSuccessNum();
                                failNum = failNum + importWContactsListResponse.getData().getFailNum();
                            }else {
                                failNum = failNum + pageSize;
                            }
                        }
                    }else {
                        ImportWContactsListRequest importWContactsListRequest = new ImportWContactsListRequest();
                        importWContactsListRequest.setList(list);
                        ImportWContactsListResponse importWContactsListResponse =  ProjectClient.getResult(importWContactsListRequest);
                        if (importWContactsListResponse.getSuccess()){
                            successNum = successNum + importWContactsListResponse.getData().getSuccessNum();
                            failNum = failNum + importWContactsListResponse.getData().getFailNum();
                        }else {
                            failNum = failNum + pageSize;
                        }
                    }
                    ret.put("success",true);
                    ret.put("message","共导入数据 "+totalRecord+" 条，成功 "+successNum+" 条，失败 "+failNum+"条");
                    return ret;
                }else {
                    ret.put("success",false);
                    ret.put("message","导入的数据不能为空");
                    return ret;
                }
            }else {
                ret.put("success",false);
                ret.put("message","导入的文件不存在");
                return ret;
            }

        }catch (NumberFormatException e) {
            ret.put("success",false);
            ret.put("message","该文件不符合要求");
            return ret;
        } catch (Exception e) {
            ret.put("success",false);
            ret.put("message","文件读取异常");
            return ret;
        }
    }

    private static String cellValue(Cell cell){
        String cellValue = "";
        if (null != cell) {
            // 以下是判断数据的类型
            switch (cell.getCellType()) {
                case HSSFCell.CELL_TYPE_NUMERIC: // 数字
                    DecimalFormat df = new  DecimalFormat("######0.00");
                    cellValue = df.format(cell.getNumericCellValue());
                    break;

                case HSSFCell.CELL_TYPE_STRING: // 字符串
                    cellValue = cell.getStringCellValue();
                    break;

                case HSSFCell.CELL_TYPE_BOOLEAN: // Boolean
                    cellValue = cell.getBooleanCellValue() + "";
                    break;

                case HSSFCell.CELL_TYPE_FORMULA: // 公式
                    DecimalFormat decimalFormat = new  DecimalFormat("######0.00");
                    cellValue = decimalFormat.format(cell.getNumericCellValue()); // 特殊处理， 否则用 getCellFormulacellValue = cell.getCellFormula() + "";
                    break;

                case HSSFCell.CELL_TYPE_BLANK: // 空值
                    cellValue = "";
                    break;

                case HSSFCell.CELL_TYPE_ERROR: // 故障
                    cellValue = "非法字符";
                    break;

                default:
                    cellValue = "未知类型";
                    break;
            }
        }
        return cellValue;
    }


    private static String numberNotNull(String str){
        if (str.indexOf(".") > 0){
            str = str.substring(0,str.indexOf("."));
        }
        return str;
    }


    public static boolean isIntegerForDouble(double obj) {
        double eps = 1e-10;  // 精度范围
        return obj-Math.floor(obj) < eps;
    }


    @RequestMapping("/editWContactsPage")
    public String editWContactsPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        if (!FsUtils.strsEmpty(request.getParameter("id"))){
            model.addAttribute("id",request.getParameter("id"));
        }
        return "/user/wContacts/xy_edit";
    }

    @RequestMapping("/editDyWContactsPage")
    public String editDyWContactsPage(HttpServletRequest request, HttpServletResponse response, Model model) {
        if (!FsUtils.strsEmpty(request.getParameter("id"))){
            model.addAttribute("id",request.getParameter("id"));
        }
        return "/user/wContacts/dy_edit";
    }

    @RequestMapping("/getOneWContacts")
    @ResponseBody
    public WContactsGetOneDetailsResponse getOneWContacts(HttpServletRequest request, HttpServletResponse response, Model model){
        WContactsGetOneDetailsResponse wContactsGetOneDetailsResponse = new  WContactsGetOneDetailsResponse();
        try {
            WContactsGetOneDetailsRequest wContactsGetOneDetailsRequest = new WContactsGetOneDetailsRequest();
            wContactsGetOneDetailsRequest.setId(FsUtils.l(request.getParameter("id")));
            wContactsGetOneDetailsResponse = ProjectClient.getResult(wContactsGetOneDetailsRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wContactsGetOneDetailsResponse;
    }

    @RequestMapping("/editWContacts")
    @ResponseBody
    public WContactsUpdateOneResponse editWContacts(HttpServletRequest request, HttpServletResponse response) {
        WContactsUpdateOneResponse wContactsUpdateOneResponse = new WContactsUpdateOneResponse();
        try {
            WContactsUpdateOneRequest wContactsUpdateOneRequest = new WContactsUpdateOneRequest();
            wContactsUpdateOneRequest.setId(FsUtils.l(request.getParameter("id")));
            wContactsUpdateOneRequest.setName(request.getParameter("name"));
            wContactsUpdateOneRequest.setPhone(request.getParameter("phone"));
            wContactsUpdateOneRequest.setTipsPhone(request.getParameter("tipsPhone"));

            wContactsUpdateOneRequest.setEducation(request.getParameter("education"));
            wContactsUpdateOneRequest.setPersonIncome(FsUtils.bigdec(request.getParameter("personIncome")));
            wContactsUpdateOneRequest.setCompanyName(request.getParameter("companyName"));
            wContactsUpdateOneRequest.setCompanyType(request.getParameter("companyType"));
            wContactsUpdateOneRequest.setVocation(request.getParameter("vocation"));

            wContactsUpdateOneRequest.setCompanyAddr(request.getParameter("companyAddr"));
            wContactsUpdateOneRequest.setLiveAddr(request.getParameter("liveAddr"));

            wContactsUpdateOneRequest.setDyCity(request.getParameter("dyCity"));
            wContactsUpdateOneRequest.setDyValue(FsUtils.bigdec(request.getParameter("dyValue")));
            wContactsUpdateOneRequest.setLiveCommunity(request.getParameter("liveCommunity"));
            wContactsUpdateOneRequest.setDyValueDiscount(FsUtils.l(request.getParameter("dyValueDiscount")));
            wContactsUpdateOneRequest.setQuotaExpire(FsUtils.i(request.getParameter("quotaExpire")));

            wContactsUpdateOneRequest.setCreditLines(FsUtils.bigdec(request.getParameter("creditLines")));
            wContactsUpdateOneRequest.setMonthRepayBalance(FsUtils.bigdec(request.getParameter("monthRepayBalance")));
            wContactsUpdateOneRequest.setUnuseBorrowBalance(FsUtils.bigdec(request.getParameter("unuseBorrowBalance")));
            wContactsUpdateOneRequest.setOldRepayRate(FsUtils.bigdec(request.getParameter("oldRepayRate")));
            wContactsUpdateOneRequest.setSrc(request.getParameter("src"));
            wContactsUpdateOneRequest.setRiskLevel(FsUtils.i(request.getParameter("riskLevel")));

            wContactsUpdateOneRequest.setBorrowQuota(FsUtils.bigdec(request.getParameter("borrowQuota")));
            wContactsUpdateOneRequest.setBorrowRate(FsUtils.bigdec(request.getParameter("borrowRate")));
//            System.out.println(JSONObject.toJSONString(wContactsUpdateOneRequest));
            wContactsUpdateOneResponse = ProjectClient.getResult(wContactsUpdateOneRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wContactsUpdateOneResponse;
    }


}

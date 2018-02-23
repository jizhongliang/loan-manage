package com.lm.controller;

import cn.freesoft.FsParameters;
import com.alibaba.fastjson.JSONObject;
import com.lm.utils.CommonUtil;
import com.lm.utils.UploadOssUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.InputStream;

@RequestMapping("/uploadMana")
@Controller
public class UploadController {

    @RequestMapping("/uploadIconImage")
    @ResponseBody
    public JSONObject uploadShowImage(HttpServletRequest request){
        JSONObject json = new JSONObject();
        try {
            FsParameters formdatas = CommonUtil.getUploadFile(request);
            InputStream is = new ByteArrayInputStream((byte[])formdatas.get("file"));
            BufferedImage buff = ImageIO.read(is);
            int imageWidth = buff.getWidth();
            int imageHeight = buff.getHeight();
            if(imageWidth >0 && imageHeight>0 && (imageWidth == imageHeight)){
                json = UploadOssUtil.uploadImage(imageWidth,imageHeight,"temp/",formdatas);
            }else {
                json.put("state",false);
                json.put("msg","图片尺寸不对");
            }
        } catch (Exception e) {
            json.put("state",false);
            json.put("msg","上传异常");
            e.printStackTrace();
        }
        return json;
    }

    @RequestMapping("/uploadNewsImage")
    @ResponseBody
    public JSONObject uploadNewsImage(HttpServletRequest request){
        JSONObject json = new JSONObject();
        try {
            FsParameters formdatas = CommonUtil.getUploadFile(request);
            InputStream is =new ByteArrayInputStream((byte[])formdatas.get("file"));
            BufferedImage buff = ImageIO.read(is);
            int imageWidth = buff.getWidth();
            int imageHeight = buff.getHeight();
            if(imageWidth >0 && imageHeight>0){
                double div = (double) imageHeight/imageWidth;
                if(String.valueOf(div).equals("0.75")){
                    json = UploadOssUtil.uploadImage(imageWidth,imageHeight,"temp/",formdatas);
                }else {
                    json.put("state",false);
                    json.put("msg","图片尺寸不对");
                }
            }else {
                json.put("state",false);
                json.put("msg","非图片类型");
            }
        } catch (Exception e) {
            json.put("state",false);
            json.put("msg","上传异常");
            e.printStackTrace();
        }
        return json;
    }


    @RequestMapping("/uploadBannerImage")
    @ResponseBody
    public JSONObject uploadBannerImage(HttpServletRequest request){
        JSONObject json = new JSONObject();
        try {
            FsParameters formdatas = CommonUtil.getUploadFile(request);
            InputStream is = new ByteArrayInputStream((byte[])formdatas.get("file"));
            BufferedImage buff = ImageIO.read(is);
            int imageWidth = buff.getWidth();
            int imageHeight = buff.getHeight();
            if(imageWidth >0 && imageHeight>0){
               if (imageWidth == 710 && imageHeight==320){
                   json = UploadOssUtil.uploadImage(imageWidth,imageHeight,"temp/",formdatas);
                }else {
                    json.put("state",false);
                    json.put("msg","图片尺寸不对");
                }
            }else {
                json.put("state",false);
                json.put("msg","非图片类型");
            }
        } catch (Exception e) {
            json.put("state",false);
            json.put("msg","上传异常");
            e.printStackTrace();
        }
        return json;
    }

    @RequestMapping("/uploadMortgageImage")
    @ResponseBody
    public JSONObject uploadMortgageImage(HttpServletRequest request){
        JSONObject json = new JSONObject();
        try {
            FsParameters formdatas = CommonUtil.getUploadFile(request);
            InputStream is = new ByteArrayInputStream((byte[])formdatas.get("file"));
            BufferedImage buff = ImageIO.read(is);
            int imageWidth = buff.getWidth();
            int imageHeight = buff.getHeight();
            if(imageWidth >0 && imageHeight>0){
                json = UploadOssUtil.uploadImage(imageWidth,imageHeight,"temp/",formdatas);
            }else {
                json.put("state",false);
                json.put("msg","非图片类型");
            }
        } catch (Exception e) {
            json.put("state",false);
            json.put("msg","上传异常");
            e.printStackTrace();
        }
        return json;
    }
}

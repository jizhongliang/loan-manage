package com.lm.utils;

import cn.freesoft.FsParameters;
import cn.freesoft.utils.FsUtils;
import cn.freesoft.utils.FsVelocityUtils;
import com.alibaba.fastjson.JSONObject;
import com.lm.common.ProjectConstant;

import java.util.Date;
import java.util.UUID;

public class UploadOssUtil {

    private static UploadOssUtil uploadOssUtil = null;

    public static UploadOssUtil getInstance() {
        if (uploadOssUtil == null) {
            uploadOssUtil = new UploadOssUtil();
        }
        return uploadOssUtil;
    }

    public static FsParameters init(){
        FsParameters input = new FsParameters();
        input.set(OSSHelper.KEY_ACCESSKEYID, ProjectConstant.ACCESS_KEY_ID);
        input.set(OSSHelper.KEY_ACCESSKEYSECRET, ProjectConstant.ACCESS_KEY_SECRET);
        input.set(OSSHelper.KEY_ENDPOINT, ProjectConstant.END_POINT);
        input.set(OSSHelper.KEY_BUCKETNAME, ProjectConstant.BUCKET_NAME);
        return input;
    }

    public static JSONObject uploadImage (Integer imageWidth, Integer imageHeight, String folderPath, FsParameters formdatas){
        JSONObject json = new JSONObject();
        FsParameters input = init();
        input.set("bytes", formdatas.get("file"));
        input.set("folder", folderPath);
        StringBuffer file_name= new StringBuffer();
        file_name.append(UUID.randomUUID().toString());
        file_name.append(".jpg");
        input.set("filename",file_name);
        String url = OSSHelper.upload_simple2 (input);
        json.put("width", imageWidth);
        json.put("height", imageHeight);
        json.put("url", url);
        json.put("state", true);
        return json;
    }

    public static String uploadHtml (String title, String share_title, String content, String author, Date date, String folderPath, String htmlPath){
        try {
            FsVelocityUtils fvu = new FsVelocityUtils();
            fvu.addContext("title", title);
            fvu.addContext("share_title",share_title);
            fvu.addContext("content", content);
            fvu.addContext("author",author);
            fvu.addContext("date", FsUtils.formatDate(date));
            String vmHtml5 = vmHtml5 = fvu.createString("/createHtmlForNews.vm");
            if(!FsUtils.strsEmpty(vmHtml5)){
                FsParameters input = init();
                input.set("bytes",vmHtml5.getBytes("utf-8"));
                input.set("contentType", "text/html");
                input.set("folder", folderPath);
                if(FsUtils.strsNotEmpty(htmlPath) && htmlPath.indexOf(ProjectConstant.NEW_IMAGE_NAME_LOCAL) > 0){
                    String filename = htmlPath.substring( htmlPath.lastIndexOf("/")+1, htmlPath.lastIndexOf(".html"));
                    input.set("filename", filename+".html");//OSS上面HTML文件命名规则.
                }else{
                    input.set("filename", getFileName()+".html");//OSS上面HTML文件命名规则.
                }
                String path = OSSHelper.upload_simple2(input);
                return path;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public static long getFileName(){
        Date date = new Date();
        Long time = date.getTime();
        String fileName = time.toString()+FsUtils.randomNumeric(6);
        return date.getTime();
    }
}

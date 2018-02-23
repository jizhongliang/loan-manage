package com.lm.utils;

import cn.freesoft.FsParameters;
import cn.freesoft.utils.FsUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class LoanHttpClient {

    private static LoanHttpClient inst;
    private FsParameters params;

    private LoanHttpClient(String configpath) throws Exception {
        File file = new File(configpath);
        FileInputStream ins = FileUtils.openInputStream(file);
        params = new FsParameters();
        params.load(ins);
        inst = this;
    }

    /**
     * 上传文件
     *
     * @param request
     *            服务器应用
     * @return
     * @throws Exception
     */
    public static FsParameters getUploadFile(HttpServletRequest request) throws Exception {
        FsParameters retValue = new FsParameters();
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            retValue.put("result", false);
            return retValue;
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(request);
        for (FileItem item : items) {
            String name = item.getFieldName();
            InputStream stream = item.getInputStream();
            if (item.isFormField()) {
                if (retValue.containsKey(name)) {
                    if (retValue.get(name) instanceof String) {
                        List<String> vals = new ArrayList<String>();
                        vals.add(retValue.getString(name));
                        vals.add(item.getString());
                        retValue.put(name, vals);
                    } else if (retValue.get(name) instanceof List) {
                        List<String> vals = (List<String>) retValue.get(name);
                        vals.add(item.getString("UTF-8"));
                    }
                } else {
                    retValue.put(name, item.getString("UTF-8"));
                }
            } else {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                int byteData = -1;
                while ((byteData = stream.read()) >= 0) {
                    baos.write(byteData);
                }
                if (baos.size() == 0) {
                    continue;
                }
                retValue.put(item.getFieldName(), baos.toByteArray());
                retValue.put(item.getFieldName() + "_filename", item.getName());
                retValue.put(item.getFieldName() + "_extension",
                        item.getName().substring(item.getName().lastIndexOf(".") + 1, item.getName().length()));
            }
        }
        for (Object key : retValue.keySet()) {
            if (retValue.get(key) instanceof List) {
                List<String> vals = (List<String>) retValue.get(key);
                retValue.set(key.toString(), FsUtils.toArraysString(vals));
            }
        }
        retValue.put("result", true);
        return retValue;
    }
}

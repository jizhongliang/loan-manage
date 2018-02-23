package com.lm.utils;

import cn.freesoft.FsParameters;
import cn.freesoft.utils.FsUtils;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.common.utils.BinaryUtil;
import com.aliyun.oss.model.CopyObjectResult;
import com.aliyun.oss.model.DeleteObjectsRequest;
import com.aliyun.oss.model.DeleteObjectsResult;
import com.aliyun.oss.model.MatchMode;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PolicyConditions;
import org.apache.commons.io.IOUtils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Date;
import java.util.*;

public class OSSHelper {
    public static final String KEY_ACCESSKEYID = "accesskeyid";
    public static final String KEY_ACCESSKEYSECRET = "accesskeysecret";
    public static final String KEY_ENDPOINT = "endpoint";
    public static final String KEY_BUCKETNAME = "bucketname";
    public static final String KEY_FOLDER = "folder";
    public static final String KEY_EXPIRETIME = "expiretime";
    public static final long KEY_EXPIRETIME_DEFLAUT = 60000L;
    public static final String PIC_PATH = "filename";
    public static final int FILE_SIZE_MAX_DEFAULT = 104857600;
    private static String HTTP_HEAD = "http://";
    public static final String NEW_PIC_PATH = "new_pic_path";

    public OSSHelper() {
    }

    public static String upload_simple(FsParameters input) {
        OSSClient client = createClient(input);
        return upload(client, input);
    }

    public static String upload_simple2(FsParameters input) {
        OSSClient client = createClient2(input);
        return upload(client, input);
    }

    private static String upload(OSSClient client, FsParameters input) {
        String bucketName = input.getString("bucketname");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        byte[] content = (byte[])((byte[])input.get("bytes"));
        ObjectMetadata meta = new ObjectMetadata();
        meta.setContentLength((long)content.length);
        if (input.getString("contentType") != null) {
            meta.setContentType(input.getString("contentType"));
        }

        String key = folder == null ? filename : folder + filename;
        client.putObject(bucketName, key, new ByteArrayInputStream(content), meta);
        return buildUrl(input);
    }

    public static void copyObject(FsParameters input) {
        String bucketName = input.getString("bucketname");
        String fromFilename = input.getString("fromFilename");
        String fromFolder = input.getString("fromFolder");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        OSSClient client = createClient(input);
        String fromKey = fromFolder == null ? fromFilename : fromFolder + fromFilename;
        String key = folder == null ? filename : folder + filename;
        CopyObjectResult result = client.copyObject(bucketName, fromKey, bucketName, key);
        FsUtils.log_debug("ETag: " + result.getETag() + " LastModified: " + result.getLastModified());
    }

    public static String copyObject2(FsParameters input) {
        String bucketName = input.getString("bucketname");
        String fromFilename = input.getString("fromFilename");
        String fromFolder = input.getString("fromFolder");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        OSSClient client = createClient2(input);
        String fromKey = fromFolder == null ? fromFilename : fromFolder + fromFilename;
        String key = folder == null ? filename : folder + filename;
        client.copyObject(bucketName, fromKey, bucketName, key);
        return buildUrl(input);
    }

    public static String cutObject(FsParameters input) {
        String bucketName = input.getString("bucketname");
        String fromFilename = input.getString("fromFilename");
        String fromFolder = input.getString("fromFolder");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        OSSClient client = createClient(input);
        String fromKey = fromFolder == null ? fromFilename : fromFolder + fromFilename;
        String key = folder == null ? filename : folder + filename;
        client.copyObject(bucketName, fromKey, bucketName, key);
        delete_simple(FsParameters.initWithKeyAndValue(new Object[]{"bucketname", bucketName, "filename", fromFilename, "folder", fromFolder}));
        return buildUrl(input);
    }

    public static String cutObject2(FsParameters input) {
        String bucketName = input.getString("bucketname");
        String fromFilename = input.getString("fromFilename");
        String fromFolder = input.getString("fromFolder");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        OSSClient client = createClient2(input);
        String fromKey = fromFolder == null ? fromFilename : fromFolder + fromFilename;
        String key = folder == null ? filename : folder + filename;
        client.copyObject(bucketName, fromKey, bucketName, key);
        delete_simple(FsParameters.initWithKeyAndValue(new Object[]{"bucketname", bucketName, "filename", fromFilename, "folder", fromFolder}));
        return buildUrl(input);
    }

    public static byte[] getObject(FsParameters input) throws Exception {
        byte[] ret = null;
        String bucketName = input.getString("bucketname");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        OSSClient client = createClient(input);
        String key = folder == null ? filename : folder + filename;
        OSSObject object = client.getObject(bucketName, key);
        ObjectMetadata meta = object.getObjectMetadata();
        InputStream objectContent = object.getObjectContent();
        ret = IOUtils.toByteArray(objectContent);
        objectContent.close();
        if (ret == null) {
            ret = new byte[0];
        }

        return ret;
    }

    public static void delete_simple(FsParameters input) {
        String bucketName = input.getString("bucketname");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        String key = folder == null ? filename : folder + filename;
        OSSClient client = createClient(input);
        client.deleteObject(bucketName, key);
    }

    public static void delete_url(FsParameters input) {
        if (!FsUtils.strsEmpty(new Object[]{input.getString("url")})) {
            String bucketName = input.getString("bucketname");
            String filename = input.getString("filename");
            String folder = input.getString("folder");
            String url = input.getString("url");
            url = url.replace(HTTP_HEAD, "");
            String key = url.substring(url.indexOf("/") + 1, url.length());
            OSSClient client = createClient(input);
            client.deleteObject(bucketName, key);
        }
    }

    public static void delete_urls(FsParameters input, List<String> urls) {
        List<String> keys = new ArrayList();
        if (urls != null && urls.size() != 0) {
            Iterator var3 = urls.iterator();

            while(var3.hasNext()) {
                String url = (String)var3.next();
                url = url.replace(HTTP_HEAD, "");
                String key = url.substring(url.indexOf("/") + 1, url.length());
                keys.add(key);
            }

            String bucketName = input.getString("bucketname");
            OSSClient ossClient = createClient(input);
            DeleteObjectsRequest req = new DeleteObjectsRequest(bucketName);
            req.setKeys(keys);
            DeleteObjectsResult deleteObjectsResult = ossClient.deleteObjects(req);
            List<String> deletedObjects = deleteObjectsResult.getDeletedObjects();
            ossClient.shutdown();
        }
    }

    public static void delete_keys(FsParameters input, List<String> keys) {
        String bucketName = input.getString("bucketname");
        OSSClient ossClient = createClient(input);
        DeleteObjectsRequest req = new DeleteObjectsRequest(bucketName);
        req.setKeys(keys);
        DeleteObjectsResult deleteObjectsResult = ossClient.deleteObjects(req);
        List<String> deletedObjects = deleteObjectsResult.getDeletedObjects();
        ossClient.shutdown();
    }

    public static FsParameters splitUrl(String url) {
        FsParameters output = new FsParameters();
        if (url.indexOf(HTTP_HEAD) == 0) {
            url = url.substring(HTTP_HEAD.length(), url.length());
        }

        String bucketName = url.substring(0, url.indexOf("."));
        output.set("bucketname", bucketName);
        String endpoint = HTTP_HEAD + url.substring(url.indexOf(".") + 1, url.indexOf("/"));
        output.set("endpoint", endpoint);
        String filename = url.substring(url.lastIndexOf("/") + 1, url.length());
        output.set("filename", filename);
        if (url.indexOf("/") < url.lastIndexOf("/")) {
            String folder = url.substring(url.indexOf("/") + 1, url.lastIndexOf("/") + 1);
            output.set("folder", folder);
        }

        return output;
    }

    public static String buildUrl(FsParameters input) {
        String endpoint = input.getString("endpoint");
        String bucketName = input.getString("bucketname");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        String key = folder == null ? filename : folder + filename;
        StringBuffer sb = new StringBuffer();
        sb.append(HTTP_HEAD);
        sb.append(bucketName + ".");
        if (endpoint.indexOf(HTTP_HEAD) == 0) {
            sb.append(endpoint.substring(HTTP_HEAD.length(), endpoint.length()));
        } else {
            sb.append(endpoint);
        }

        sb.append("/" + key);
        return sb.toString();
    }

    public static OSSClient createClient(FsParameters input) {
        String accessKeyId = input.getString("accesskeyid");
        String accessKeySecret = input.getString("accesskeysecret");
        String endpoint = input.getString("endpoint");
        String bucketName = input.getString("bucketname");
        StringBuffer sb = new StringBuffer();
        sb.append(HTTP_HEAD);
        sb.append(bucketName + ".");
        if (endpoint.indexOf(HTTP_HEAD) == 0) {
            sb.append(endpoint.substring(HTTP_HEAD.length(), endpoint.length()));
        } else {
            sb.append(endpoint);
        }

        OSSClient client = new OSSClient(sb.toString(), accessKeyId, accessKeySecret);
        return client;
    }

    public static OSSClient createClient2(FsParameters input) {
        String accessKeyId = input.getString("accesskeyid");
        String accessKeySecret = input.getString("accesskeysecret");
        String endpoint = input.getString("endpoint");
        String bucketName = input.getString("bucketname");
        StringBuffer sb = new StringBuffer();
        sb.append(HTTP_HEAD);
        OSSClient client = new OSSClient(endpoint, accessKeyId, accessKeySecret);
        return client;
    }

    public static String upFile(FsParameters input) {
        OSSClient ossClient = createClient2(input);

        try {
            String bucketName = input.getString("bucketname");
            InputStream inputStream = (new URL(input.getString("filename"))).openStream();
            ossClient.putObject(bucketName, input.getString("new_pic_path"), inputStream);
            String endpoint = input.getString("endpoint");
            String prefix = HTTP_HEAD + bucketName;
            String url;
            if (endpoint.indexOf(HTTP_HEAD) == 0) {
                url = prefix + "." + endpoint.substring(HTTP_HEAD.length(), endpoint.length());
            } else {
                url = prefix + "." + endpoint;
            }

            String newpath = url + "/" + input.getString("new_pic_path");
            return newpath;
        } catch (MalformedURLException var8) {
            FsUtils.log_error(var8);
        } catch (IOException var9) {
            FsUtils.log_error(var9);
        }

        return "";
    }

    public static Map<String, String> getPostPolicy(FsParameters input) {
        try {
            String sExpireTime = input.getString("expiretime");
            String folder = input.getString("folder");
            if (FsUtils.strsEmpty(new Object[]{folder})) {
                folder = "/";
            }

            OSSClient client = createClient2(input);
            long expireTime = sExpireTime != null ? Long.parseLong(sExpireTime) : 60000L;
            long expireEndTime = System.currentTimeMillis() + expireTime;
            Date expiration = new Date(expireEndTime);
            PolicyConditions policyConds = new PolicyConditions();
            policyConds.addConditionItem("content-length-range", 0L, 104857600L);
            policyConds.addConditionItem(MatchMode.StartWith, "key", folder);
            String postPolicy = client.generatePostPolicy(expiration, policyConds);
            byte[] binaryData = postPolicy.getBytes("utf-8");
            String encodedPolicy = BinaryUtil.toBase64String(binaryData);
            String postSignature = client.calculatePostSignature(postPolicy);
            Map<String, String> respMap = new LinkedHashMap();
            respMap.put("accessid", input.getString("accesskeyid"));
            respMap.put("policy", encodedPolicy);
            respMap.put("signature", postSignature);
            respMap.put("dir", folder);
            respMap.put("host", "");
            respMap.put("expire", String.valueOf(expireEndTime / 1000L));
            return respMap;
        } catch (Exception var15) {
            var15.printStackTrace();
            return null;
        }
    }

    public static boolean hasObject(FsParameters input) throws Exception {
        String bucketName = input.getString("bucketname");
        String filename = input.getString("filename");
        String folder = input.getString("folder");
        OSSClient client = createClient2(input);
        String key = folder == null ? filename : folder + filename;
        boolean ret = client.doesObjectExist(bucketName, key);
        return ret;
    }


}

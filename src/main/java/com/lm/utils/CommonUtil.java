package com.lm.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.freesoft.FsParameters;
import cn.freesoft.utils.FsUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.http.HttpServletRequest;

public class CommonUtil {

	//根据传入的值获取时间
	public static Date getDayForNum(Date date, String num){
		Date endDate = date;
		if(!FsUtils.strsEmpty(num)){
			int days = Integer.parseInt(num);
			if(days != 1){
				endDate = FsUtils.addDate(date, -days);
			}
		}
		return endDate;
	}
	
	//
	public static String getStuctName(String sign){
		String signName = "未知";
		if(sign.equals("carousel")){
			signName ="轮播图";
		}else{
			signName ="小喇叭";
		}
		return signName;
		
	}

	/**
	 * 获取GetTime()
	 * @param
	 * @return Date
	 */
	public static long getFileName(){
		Date date = new Date();
		Long time = date.getTime();
		String fileName = time.toString()+FsUtils.randomNumeric(6);
		return date.getTime();
	}


	/**
	 * 格式当前化日期。
	 * @return 日期
	 * @throws ParseException
	 */
	public static String getCurrentDate() throws ParseException {
		return FsUtils.formatDateTime(new Date(), "yyyy-MM-dd");
	}

	/**
	 * 提取文章内容。
	 * @param HtmlUrl 文章地址
	 * @return 日期
	 * @throws ParseException
	 */
	public static String subHtml(String HtmlUrl){
		String conStr = "";
		System.out.println(HtmlUrl);
		if(!FsUtils.strsEmpty(HtmlUrl)){
			try {
				Document doc=  Jsoup.connect(HtmlUrl).get();
				Elements h_editor = doc.getElementsByClass("h_editor");
				if(FsUtils.strsEmpty(h_editor)){
					Element html = doc.select("section").last();
					conStr = html.getElementsByTag("p").toString();
				}else{
					Element html = doc.select("section").first();
					conStr = html.children().toString();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return conStr;
	}


	/**
	 * 删除连续多余的空格，只留一个
	 * @param str 字符串
	 * @return
	 */
	public static String clearSurplusSpace(String str){
		String result = "";
		if(!FsUtils.strsEmpty(str)){
			result = str.replaceAll("[' ']+"," ");
		}
		return result;
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



	public static JSONObject converStringToDataJSON(Object data)  {
		JSONObject ret = new JSONObject();
		if(!FsUtils.strsEmpty(data)){
			JSONObject input= JSON.parseObject((JSONObject.toJSONString(data, SerializerFeature.WriteDateUseDateFormat)));
			ret.put("data", input.get("items"));
			ret.put("recordsTotal",input.get("total"));
			ret.put("recordsFiltered",input.get("total"));
			ret.put("draw", 0);
		}
		return ret;
	}

}

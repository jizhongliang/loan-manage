package com.lm.utils;

import cn.freesoft.utils.FsUtils;

import java.util.HashMap;
import java.util.Map;

public class SubUrl {
	
	private static String TruncateUrlPage(String strURL)
	{
		String strAllParam=null;
		String[] arrSplit=null;

		strURL=strURL.trim().toLowerCase();

		arrSplit=strURL.split("[?]");
		if(strURL.length()>1)
		{
			if(arrSplit.length>1)
			{
				if(arrSplit[1]!=null)
				{
					strAllParam=arrSplit[1];
				}
			}
		}

		return strAllParam;   
	}
	
	public static Map<String, String> URLRequest(String URL)
	{
		Map<String, String> mapRequest = new HashMap<String, String>();

		String[] arrSplit=null;

		String strUrlParam=TruncateUrlPage(URL);
		if(strUrlParam==null)
		{
			return mapRequest;
		}
		arrSplit=strUrlParam.split("[&]");
		for(String strSplit:arrSplit)
		{
			String[] arrSplitEqual=null;         
			arrSplitEqual= strSplit.split("[=]");
			if(arrSplitEqual.length>1)
			{
				mapRequest.put(arrSplitEqual[0], arrSplitEqual[1]);
			}
			else
			{
				if(arrSplitEqual[0]!="")
				{
					mapRequest.put(arrSplitEqual[0], "");       
				}
			}
		}   
		return mapRequest;   
	}
	
	public static String getJDURLRequest(String jd, String url){
		String getId = "";
		if(!FsUtils.strsEmpty(url) && !FsUtils.strsEmpty(jd)){
			url = url.replace(jd, "");
			getId = url.substring(0, url.indexOf(".html"));
		}
		return getId;
	}
}

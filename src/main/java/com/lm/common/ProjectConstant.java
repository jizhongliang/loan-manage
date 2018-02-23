package com.lm.common;

import java.io.Serializable;


import cn.freesoft.utils.FsUtils;

public final class ProjectConstant extends BasePropConfig implements Serializable {

	//service配置
	public static String URL_ROOT;
	public static Integer TIME_OUT;
	//OSS配置
	public static String ACCESS_KEY_ID;
	public static String ACCESS_KEY_SECRET;
	public static String END_POINT;
	public static String BUCKET_NAME;

	public static String OLD_IMAGE_NAME_LOCAL;
	public static String NEW_IMAGE_NAME_LOCAL;

	//报表服务
	public static String JASPER_SERVER;


	//重写常量（赋值）
	public void parseConfigProperties() {
		URL_ROOT = get("urlroot",EMPTY_STR);
		TIME_OUT = FsUtils.i(get("timeout",EMPTY_STR));
		BUCKET_NAME = get("bucketname",EMPTY_STR);
		ACCESS_KEY_ID = get("accesskeyid",EMPTY_STR);
		ACCESS_KEY_SECRET = get("accesskeysecret",EMPTY_STR);
		END_POINT = get("endpoint",EMPTY_STR);
		OLD_IMAGE_NAME_LOCAL = get("ossEndPoint",EMPTY_STR);
		NEW_IMAGE_NAME_LOCAL = get("ossImgPath",EMPTY_STR);
		JASPER_SERVER = get("jasperserver",EMPTY_STR);
	}
}

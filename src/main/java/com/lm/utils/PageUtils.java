package com.lm.utils;

import cn.freesoft.utils.FsUtils;

public class PageUtils {
	
	public static int getcurrPage(String start, String length){
		int currentPage = 0;
		if(!FsUtils.strsEmpty(start) && !FsUtils.strsEmpty(length))
		if(Integer.valueOf(start)==0){
			currentPage = 1;
		}else{
			Integer page = Integer.valueOf(start)/Integer.valueOf(length);
			currentPage = page+1;
		}
		return currentPage;
	}
}

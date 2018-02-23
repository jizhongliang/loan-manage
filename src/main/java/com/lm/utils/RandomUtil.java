/**  
* @Title: DateConvertUtil.java 
* @Package com.spring.web.util 
* @Description: 随机数
* @author HXJ  
* @date 2013-5-30 上午10:07:03 
* @version V1.0  
*/ 

package com.lm.utils;

import java.util.Random;

/** 
 *  
 */
public final class RandomUtil {
	
	
    
    /**
     * 生成商品编号随机数
    * @return
     */
    public static String NextFive() {
        Random rand = new Random();
        Integer randvalue = rand.nextInt(99999)+1;
        String res = ""+randvalue;
    	int len = 5-res.length();
    	for(int i=0; i<len; i++){
    		res = "0" + res;
    	}
    	return res;
    }
    
    /**
     * 生成商品编号随机数
    * @return
     */
    public static String NextTwo() {
        Random rand = new Random();
        Integer randvalue = rand.nextInt(99)+1;
        return randvalue.toString();
    }
    
    /**
     * 券号密码
    * @return
     */
    public static String NextEight(){
    	Random rand = new Random();
    	Integer randvalue = rand.nextInt(999999)+1;
    	String res = ""+randvalue;
    	int len = 6-res.length();
    	for(int i=0; i<len; i++){
    		res = "0" + res;
    	}
    	return res;
    }
    
    /**
     * 生成6位随机数
    * @return
     */
    
    public static String getRandomNumber(){
    	StringBuffer sb = new StringBuffer();
    	Random random = new Random();
    	for(int i = 0; i < 6; i++){
    		String rand = String.valueOf(random.nextInt(10));
    		sb.append(rand);
    	}
    	return sb.toString();
    }
    
    public static void main(String[] args) {
    	String s = NextTwo();
		//System.out.println(s);
	}
    
}

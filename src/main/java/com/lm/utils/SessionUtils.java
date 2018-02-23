package com.lm.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lm.model.UserBean;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.List;

/**
 * 
 * Session 工具类
 *
 */
public final class SessionUtils {
	
	
	private static final String SESSION_USER = "session_user"; //用户
	
	private static final String SESSION_VALIDATECODE = "session_validatecode";//验证码
	
	private static final String SESSION_MENU = "session_menu"; //菜单
	
	/**
	  * 设置session的值
	  * @param request
	  * @param key
	  * @param value
	  */
	 public static void setAttr(HttpServletRequest request,String key,Object value){
		 request.getSession(true).setAttribute(key, value);
	 }
	 
	 /**
	  * 获取session的值
	  * @param request
	  * @param key
	  */
	 public static Object getAttr(HttpServletRequest request,String key){
		 return request.getSession(true).getAttribute(key);
	 }
	 
	 /**
	  * 删除Session值
	  * @param request
	  * @param key
	  */
	 public static void removeAttr(HttpServletRequest request,String key){
		 request.getSession(true).removeAttribute(key);
	 }
	 
	 /**
	  * 设置值
	  * @param request
	 * @return 
	  * @return SysUser
	  */
	 public static void setUser(HttpServletRequest request,UserBean user){
		  request.getSession(true).setAttribute(SESSION_USER,user);
	 }

	 /**
	  * 从session中获取用户信息
	  * @param request
	  * @return SysUser
	  */
	 public static UserBean getUser(HttpServletRequest request){
		return (UserBean) request.getSession(true).getAttribute(SESSION_USER);
	 }
	 
	 /**
	  * 设置验证码 到session
	  * @param request
	  * @param validateCode
	  */
	 public static void setValidateCode(HttpServletRequest request,String validateCode){
		 request.getSession(true).setAttribute(SESSION_VALIDATECODE, validateCode);
	 }
	 
	 
	 /**
	  * 从session中获取验证码
	  * @param request
	  * @return SysUser
	  */
	 public static String getValidateCode(HttpServletRequest request){
		return (String)request.getSession(true).getAttribute(SESSION_VALIDATECODE);
	 }
	 
	 
	 /**
	  * 从session中获删除验证码
	  * @param request
	  * @return SysUser
	  */
	 public static void removeValidateCode(HttpServletRequest request){
		removeAttr(request, SESSION_VALIDATECODE);
	 }


	/**
	 * 设置值
	 * @param request
	 * @return
	 * @return MENU
	 */
	public static void setSessionMenu(HttpServletRequest request,List list){
		request.getSession(true).setAttribute(SESSION_MENU,list);
	}

	/**
	 * 从session中获取用户信息
	 * @param request
	 * @return SysUser
	 */
	public static List getSessionMenu(HttpServletRequest request){
		return (List) request.getSession(true).getAttribute(SESSION_MENU);
	}
	 
	 /**
	  * 从session中获删除菜单
	  * @param request
	  * @return SysUser
	  */
	 public static void removeSessionMenu(HttpServletRequest request){
		removeAttr(request, SESSION_MENU);
	 }

	 public static HttpSession getSession() {
		 RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
		 if (requestAttributes != null) {
			 HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
			 return request.getSession(true);
		 }
		 return null;
	 }

}
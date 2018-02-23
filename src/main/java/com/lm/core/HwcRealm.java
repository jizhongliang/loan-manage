package com.lm.core;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

public class HwcRealm extends AuthorizingRealm{


	/** 
	 * 授权信息 
	 */  
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {  
		String username = (String) getAvailablePrincipal(principals);
		
		return null;
	}  

	/** 
	 * 认证信息 
	 */  
	protected AuthenticationInfo doGetAuthenticationInfo(  
			AuthenticationToken authcToken ) throws AuthenticationException {  

		return null;  
	}  

}

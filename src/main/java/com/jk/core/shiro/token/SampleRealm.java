package com.jk.core.shiro.token;

import java.util.Date;
import java.util.Iterator;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.jk.common.model.UUser;
import com.jk.common.model.deptuser;
import com.jk.core.shiro.token.manager.TokenManager;
import com.jk.dept.service.DeptPermissionService;
import com.jk.permission.service.PermissionService;
import com.jk.permission.service.RoleService;
import com.jk.user.service.UUserService;


/**
 * @author Mr.KangJonney
 * @date   2017年10月10日
 * @remark shiro 认证 + 授权   重写
 */
public class SampleRealm extends AuthorizingRealm {

	@Autowired
	UUserService userService;
	@Autowired
	PermissionService permissionService;
	@Autowired
	RoleService roleService;
	@Autowired
	@Qualifier("deptPermissionService")
	DeptPermissionService deptPermissionService;
	
	public SampleRealm() {
		super();
	}
	/**
	 *  认证信息，主要针对用户登录， 
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		
		ShiroToken token = (ShiroToken) authcToken;
		UUser user = userService.login(token.getUsername(),token.getPswd());
		if(null == user){
			throw new AccountException("帐号或密码不正确！");
		/**
		 * 如果用户的status为禁用。那么就抛出<code>DisabledAccountException</code>
		 */
		}else if(UUser._0.equals(user.getStatus())){
			throw new DisabledAccountException("帐号已经禁止登录！");
		}else{
			//更新登录时间 last login time
			user.setLastLoginTime(new Date());
			userService.updateByPrimaryKeySelective(user);
		}
		return new SimpleAuthenticationInfo(user,user.getPswd(), getName());
    }

	 /** 
     * 授权 
     */  
    @Override  
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {     	
    	UUser user=TokenManager.getToken();//这里拿到一个user 信息    	
    	deptuser usr=deptPermissionService.initFindDeptid(user.getEmail());//这里处理人员拿到部门信息
		SimpleAuthorizationInfo info =  new SimpleAuthorizationInfo();//new shiroInfo 准备储存权限信息	
		Set<String> roles=roleService.findRoleByUserId(user.getId());//拿取当前人的角色信息
		Set<String> permissions = deptPermissionService.findPermissionByDept(usr.getId());
		//这里根据人员所在部门拿取 部门权限↑
		Set<String> userpermission=userService.selectUserPermissionById(userService.selectIdByEmail(user.getEmail()));
		//这里拿取个人所有权限↑
			//这里就交给shiro管理，在前台控制标签的显示，扔到shiro缓存里↓
		info.setStringPermissions(permissions);	//设置部门权限	
		info.setStringPermissions(userpermission);//设置个人权限
		info.setRoles(roles);//设置该人的角色信息
        return info;  
    }  
    /**
     * 清空当前用户权限信息
     */
	public  void clearCachedAuthorizationInfo() {
		PrincipalCollection principalCollection = SecurityUtils.getSubject().getPrincipals();
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				principalCollection, getName());
		super.clearCachedAuthorizationInfo(principals);
	}
	/**
	 * 指定principalCollection 清除
	 */
	public void clearCachedAuthorizationInfo(PrincipalCollection principalCollection) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				principalCollection, getName());
		super.clearCachedAuthorizationInfo(principals);
	}
}

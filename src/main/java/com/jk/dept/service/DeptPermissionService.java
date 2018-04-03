package com.jk.dept.service;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.jk.common.model.UPermission;
import com.jk.common.model.deptuser;
import com.jk.common.model.permissionMapUtil;

public interface DeptPermissionService {
      List<UPermission> selectAllPermission();//加载所有权限

	int saveOrUpdatePermission(permissionMapUtil map);//添加权限

	Object selectPermissionByDept(int parseInt);//获取权限根据部门id

	int delPermissionDept(String did, String deptid);//单个删除权限
	
	Set<String> initFindDeptByUser(String email);//查询用户的所在部门
	
	Set<String> findPermissionByDept(Long id);//查询部门所存在的权限

	deptuser initFindDeptid(String email);

	String  getuserpermission(int parseInt);//这个方法使用httpClient发送请求，请求demoZtree返回结果集

	int authorizingPermissionUser(permissionMapUtil map);
}

package com.jk.common.dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.jk.common.model.UPermission;
import com.jk.common.model.deptuser;
import com.jk.common.model.permissionMapUtil;

public interface DeptPermissionDao {

	List<UPermission> selectAllPermission();
     
	int permissionSaveOrUpdate(permissionMapUtil map);
	
	void beforeChange(@Param("deptid") int deptid);
	
	List<UPermission>selectDeptPerList(@Param("id") int id);
	
	int delDeptPermission(@Param("id") int id, @Param("deptId") int deptId);
	
	Set<String> initFindDeptByUser(@Param("email") String email);//查询用户的所在部门
	
	Set<String> findPermissionByDept(@Param("id") Long id);//查询部门所存在的权限

	deptuser initFindDeptid(@Param("email") String email);

	void beforeChangeUser(@Param("id") int deptid);//附加人员权限之前，清空权限

	int authorizingPermissionUser(permissionMapUtil map);//添加个人的权限

}

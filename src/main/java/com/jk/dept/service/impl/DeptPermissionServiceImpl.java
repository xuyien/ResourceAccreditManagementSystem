package com.jk.dept.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jk.common.dao.DeptPermissionDao;
import com.jk.common.model.HttpClientUtil;
import com.jk.common.model.UPermission;
import com.jk.common.model.deptuser;
import com.jk.common.model.permissionMapUtil;
import com.jk.dept.service.DeptPermissionService;
@Service("deptPermissionService")
public class DeptPermissionServiceImpl implements DeptPermissionService {

	
	@Autowired
	private DeptPermissionDao permissionDao;
	
	@Override
	public List<UPermission> selectAllPermission() {
		// TODO Auto-generated method stub
		return permissionDao.selectAllPermission();
	}

	@Override
	public int saveOrUpdatePermission(permissionMapUtil map) {
		int count=0;
		permissionDao.beforeChange(map.getMainid());
		List<String> list=map.getPermissionList();
		for(String str:list){
			map.setNumber(Integer.parseInt(str));
			count=permissionDao.permissionSaveOrUpdate(map);
		}		
		return count;
	}

	@Override
	public Object selectPermissionByDept(int parseInt) {
		// TODO Auto-generated method stub
		return permissionDao.selectDeptPerList(parseInt);
	}

	@Override
	public int delPermissionDept(String did,String deptid) {
		// TODO Auto-generated method stub
		return permissionDao.delDeptPermission(Integer.parseInt(did),Integer.parseInt(deptid));
	}

	@Override
	public Set<String> initFindDeptByUser(String email) {
		// TODO Auto-generated method stub
		return permissionDao.initFindDeptByUser(email);
	}

	@Override
	public Set<String> findPermissionByDept(Long id) {
		// TODO Auto-generated method stub
		return permissionDao.findPermissionByDept(id);
	}

	@Override
	public deptuser initFindDeptid(String email) {
		// TODO Auto-generated method stub
		return permissionDao.initFindDeptid(email);
	}

	@Override
	public String getuserpermission(int parseInt) {
		//此处使用httpClicent调取demoTree查询人员权限
		String str=HttpClientUtil.doGet("http://localhost:8080/demoZtree/selectUserPermisson?id="+parseInt);
	    return str;
	}

	@Override
	public int authorizingPermissionUser(permissionMapUtil map) {
		int count=0;
		permissionDao.beforeChangeUser(map.getMainid());
		for(String str :map.getPermissionList()){
			map.setNumber(Integer.parseInt(str));
			count=permissionDao.authorizingPermissionUser(map);
		}
		return count;
	}

}

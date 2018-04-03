package com.jk.dept.service.impl;

import java.util.List;
import java.util.Map;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jk.common.dao.deptDao;
import com.jk.common.model.UUser;
import com.jk.common.model.deptuser;
import com.jk.common.model.usercollect;
import com.jk.dept.service.DeptService;
import com.jk.user.manager.UserManager;

@Service("deptService")
public class DeptServiceImpl implements DeptService {

	@Autowired
	private deptDao dept;
	
	public List<deptuser> basicNode(){
		// TODO Auto-generated method stub
		return dept.basicNode();
	}

	
	public List<UUser> secondaryNode(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return dept.sedcondaryNode(map);
	}

	
	public List<Map<String, Object>> selectDept() {
		// TODO Auto-generated method stub
		return dept.selectDept();
	}

	
	public int addDept(String deptName) {
		// TODO Auto-generated method stub
		return dept.addDept(deptName);
	}

	
	public List<UUser> checkDept(int id) {
		// TODO Auto-generated method stub
		return dept.checkDept(id);
	}

	
	public void deleteDept(int id) {
		// TODO Auto-generated method stub
		dept.deleteDept(id);
	}

	
	public UUser selectdeleteUser(int parseInt) {
		// TODO Auto-generated method stub
		return dept.selectdeleteUser(parseInt);
	}

	
	public int deleteUser(Long id) {
		// TODO Auto-generated method stub
		return dept.deleteUser(id);
	}

	
	public int updatedeptUser(UUser user) {
		user.setPswd(UserManager.md5Pswd(user.getEmail(), user.getPswd()));
		return dept.updatedeptUser(user);
	}

	
	public void deleteUserCollect(Long id) {
		// TODO Auto-generated method stub
		dept.deleteUserCollect(id);
	}

	
	public int addDeptUser(UUser user) {
		String pwd=UserManager.md5Pswd(user.getEmail(), user.getPswd());
		user.setPswd(pwd);
		// TODO Auto-generated method stub
		return  dept.addDeptUser(user);
	}

	
	public void addDeptUserCollect(Long id) {
		// TODO Auto-generated method stub
	 dept.addDeptUserCollect(id);
	}

	
	public UUser selectJustAdd(String email) {
		// TODO Auto-generated method stub
		return  dept.selectJustAdd(email);
	}

	
	public List<Map<String,Object>>  secondDeptNode(int parseInt) {
		// TODO Auto-generated method stub
		return dept.secondDeptNode(parseInt);
	}

	
	public int addingDept(deptuser user) {
		// TODO Auto-generated method stub
		return dept.addingDept(user);
	}


	@Override
	public usercollect checkCollect(int parseInt) {
		// TODO Auto-generated method stub
		return dept.checkCollect(parseInt);
	}


	@Override
	public void changOnUsersDept(int id, int selecter) {
		// TODO Auto-generated method stub
		dept.changOnUsersDept(id,selecter);
	}


	@Override
	public int reNameNode(int parseInt, String name) {
		// TODO Auto-generated method stub
		return dept.reNameNode(parseInt,name);
	}

}

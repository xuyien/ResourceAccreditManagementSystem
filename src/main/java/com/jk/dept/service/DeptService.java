package com.jk.dept.service;

import java.util.List;
import java.util.Map;

import javax.jws.WebService;

import com.jk.common.model.UUser;
import com.jk.common.model.deptuser;
import com.jk.common.model.usercollect;


public interface DeptService {
	List<deptuser> basicNode();
       public List<UUser> secondaryNode(Map<String, Integer> map);
	List<Map<String, Object>> selectDept();
	int addDept(String deptName);
	List<UUser> checkDept(int id);
	void deleteDept(int id);
	UUser selectdeleteUser(int parseInt);
		int deleteUser(Long id);
		int updatedeptUser(UUser user);
		void deleteUserCollect(Long id);
		int addDeptUser(UUser user);
		void addDeptUserCollect(Long id);
		UUser selectJustAdd(String email);
		List<Map<String,Object>>  secondDeptNode(int parseInt);
		int addingDept(deptuser user);
		usercollect checkCollect(int parseInt);
		void changOnUsersDept(int parseInt, int parseInt2);
		int reNameNode(int parseInt, String name);
}

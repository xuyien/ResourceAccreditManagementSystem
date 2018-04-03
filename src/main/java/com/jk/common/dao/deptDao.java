package com.jk.common.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jk.common.model.UUser;
import com.jk.common.model.deptuser;
import com.jk.common.model.usercollect;

public interface deptDao {
     List<deptuser> basicNode();
     List<UUser> sedcondaryNode(Map<String, Integer> map);
     //查询所有部门↓
	List<Map<String, Object>> selectDept();
	int addDept(@Param("deptName") String deptName);
	List<UUser> checkDept(@Param("id") int id);
	void deleteDept(@Param("id") int id);
	UUser selectdeleteUser(@Param("id") int parseInt);
	
	/**
	 * 删除人员同时要干掉部门连接信息
	 * @param id
	 * @return
	 */
	int deleteUser(@Param("id") Long id);//1删除人员
	void deleteUserCollect(@Param("id") Long id);//2删除管理连接
	
	
	int updatedeptUser(UUser user);
	int addDeptUser(UUser user);
	
	/**
	 * 当添加完人员需要关联部门信息
	 * @param id
	 */
	void addDeptUserCollect(@Param("id") Long id);
	UUser selectJustAdd(@Param("email") String email);
	
	/**
	 * 加载部门node信息，部门列表信息
	 * @param parseInt
	 * @return 部门集合
	 */
	List<Map<String,Object>> secondDeptNode(@Param("id") int parseInt);
	//添加部门
	int addingDept(deptuser user);
	
	//更换部门前，查询这个人是否存在部门
	usercollect checkCollect(@Param("id") int id);
	//更换部门
	void changOnUsersDept(@Param("id") int id, @Param("selecter") int selecter);
	int reNameNode(@Param("id") int parseInt, @Param("name") String name);
	
}

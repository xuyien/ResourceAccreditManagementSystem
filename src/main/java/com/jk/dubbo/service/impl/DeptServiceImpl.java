package com.jk.dubbo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.jk.common.dao.deptDao;
import com.jk.common.model.deptuser;
import com.jk.dubbo.service.DeptService;

public class DeptServiceImpl implements DeptService{

	@Autowired
	private deptDao dept;
	
	@Override
	public List<deptuser> basicNode() {
		// TODO Auto-generated method stub
		return dept.basicNode();
	}

}

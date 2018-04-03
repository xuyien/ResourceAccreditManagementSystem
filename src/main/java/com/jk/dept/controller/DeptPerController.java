package com.jk.dept.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jk.common.model.permissionMapUtil;
import com.jk.dept.service.DeptPermissionService;

@Controller
@RequestMapping("per")
public class DeptPerController {
	
	@Autowired
	@Qualifier("deptPermissionService")
	private DeptPermissionService deptPermission;
	
      @RequestMapping("gorolDept.shtml")
      public String gorolDept(){
    	  return "ManagementAuthorizing";
      }
      
      @RequestMapping("selectAllPermission.shtml")
      @ResponseBody
      public Object selectAllPermission(){
    	 return deptPermission.selectAllPermission();
      }
      
      
      @RequestMapping("authorizingPermissionDept.shtml")
      @ResponseBody
      public String authorizingPermissionDept(@RequestParam("permissionList")String permissionList,
    		  @RequestParam("deptid")String deptid
    		  ){
    	  List<String> list=Arrays.asList(permissionList.split(","));
    	  permissionMapUtil map=new permissionMapUtil();
    	  map.setPermissionList(list);
    	  map.setMainid(Integer.parseInt(deptid));    	 
    	  if(deptPermission.saveOrUpdatePermission(map)>0){
    		  return "succ";  
    	  }else{
    		  return "fail";
    	  }    	 
      }
      
      @RequestMapping("selectPermissionByDept.shtml")
      @ResponseBody
      public Object selectPermissionByDept(@RequestParam(value="id")String id
    		  ){
    	  return deptPermission.selectPermissionByDept(Integer.parseInt(id));    	   	 
      }
      
      
      @RequestMapping("delPermissionDept.shtml")
      @ResponseBody
      public String delPermissionDept(@RequestParam("did")String did,
    		  @RequestParam("deptid")String deptid
    		  ){
    	  if(deptPermission.delPermissionDept(did,deptid)>0){
    		  return "succ";  
    	  }else{
    		  return "fail";
    	  }
      }
      
    
      @RequestMapping("getuserpermission.shtml")
      @ResponseBody
      public String  getuserpermission(@RequestParam("id")String id
    		  ){
    	return  deptPermission.getuserpermission(Integer.parseInt(id));    	
      }
   
      @RequestMapping("authorizingPermissionUser.shtml")
      @ResponseBody
      public String authorizingPermissionUser(@RequestParam("permissionList")String permissionList,
    		  @RequestParam("uid")String uid
    		  ){
    	  List<String> list=Arrays.asList(permissionList.split(","));
    	  permissionMapUtil map=new permissionMapUtil();
    	  map.setPermissionList(list);
    	 map.setMainid(Integer.parseInt(uid));    	 
    	  if(deptPermission.authorizingPermissionUser(map)>0){
    		  return "succ";  
    	  }else{
    		  return "fail";
    	  }
    	 
      }
     
      
}

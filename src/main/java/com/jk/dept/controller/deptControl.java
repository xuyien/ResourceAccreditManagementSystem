package com.jk.dept.controller;

import com.jk.common.model.UUser;
import com.jk.common.model.deptuser;
import com.jk.common.model.usercollect;
import com.jk.dept.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dept")
public class deptControl {
    
	@Autowired
	@Qualifier("deptService")
	private DeptService dept;
	
	@RequestMapping("/managementuser.shtml")
	public String goDept(){
		return "dept";
	}
	
	@RequestMapping("/managementuserbasic.shtml")
	@ResponseBody
	public Object loadBasic(){
		List<deptuser> info=dept.basicNode();
		return info;
	}
	
	@RequestMapping("/managementusersecond.shtml")
	@ResponseBody
	public Object intoSencond(@RequestParam("treeId")String treeId){
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("number", Integer.parseInt(treeId));
		List<UUser> info=dept.secondaryNode(map);
		return info;
	}
	
	@RequestMapping("/gosetDept.shtml")
	public String gosetDept(){
		return "magDept";
	}
	
	@RequestMapping("/magDept.shtml")
	@ResponseBody
	public Object loadingdept(){
		List<Map<String,Object>>list=dept.selectDept();
		return list;
	}
	
	@RequestMapping("addDept.shtml")
	@ResponseBody
	public String addDept(@RequestParam("deptName")String deptName){
		if(dept.addDept(deptName)>1){
			return "succ";
		}else{
			return "fail";
		}
		
	}
	
	@RequestMapping("deleteDept.shtml")
	public String  deleteDept(@RequestParam("id")String id,
			HttpServletRequest request
			){
		List<UUser> user=dept.checkDept(Integer.parseInt(id));
		if(user.size()<1){
			dept.deleteDept(Integer.parseInt(id));
			return "redirect:/dept/gosetDept.shtml";
		}else{
			request.setAttribute("hint", "该部门存在人员,请开除所有,即可删除该部门");
			return "404Error";
		}
	}
	
	@RequestMapping("deleteDept2.shtml")
	@ResponseBody
	public String  deleteDept2(@RequestParam("id")String id){
		List<UUser> user=dept.checkDept(Integer.parseInt(id));
		if(user.size()<1){
			dept.deleteDept(Integer.parseInt(id));
			return "succ";
		}else{
			return "fail";
		}
	}
	
	@RequestMapping(value="deleteUsr.shtml")
	public String  deleteUser(@RequestParam("id")String id,
			HttpServletRequest request
			){
		UUser user=dept.selectdeleteUser(Integer.parseInt(id));
		if(user!=null){
			if(dept.deleteUser(user.getId())>0){
				dept.deleteUserCollect(user.getId());
			}
			request.setAttribute("hint", "删除成功");
			return "redirect:/dept/managementuser.shtml";
		}else{
			request.setAttribute("hint", "删除失败,请刷新检查人员是否存在");
			return "redirect:/dept/managementuser.shtml";
		}
	}
	
	@RequestMapping("usrUpdate.shtml")
	public String  usrUpdate(@RequestParam("id")String id,
			Model model
			){
		UUser user=dept.selectdeleteUser(Integer.parseInt(id));
		if(user!=null){
			model.addAttribute("user",user);
			return "updatedeptUser";
		}else{
			return "404Error";
		}
	}
	
	@RequestMapping("updateDeptUser.shtml")
	public String updatedeptUser(UUser user,
			HttpServletRequest request){
		if(dept.updatedeptUser(user)>0){
			return "redirect:/dept/managementuser.shtml";
		}else{
			request.setAttribute("hint", "修改失败，请检查格式是否正确");
			return "redirect:/dept/usrUpdate.shtml";
		}	
	}
	
	@RequestMapping("goaddDeptUser.shtml")
    public String goaddDeptUser(){
		return "newDeptUser";
	}
	
	@RequestMapping("addDeptUser.shtml")
	public String addDeptUser(UUser user,
			HttpServletRequest request
			){
		if(dept.addDeptUser(user)>0){
			UUser sr=dept.selectJustAdd(user.getEmail());
			 Long id=sr.getId();
			 dept.addDeptUserCollect(id);
			return "redirect:/dept/managementuser.shtml";
		}else{
			request.setAttribute("hint", "添加失败,请检查信息是否填写正确");
			return "404Error";
		}		
	}
	
	@RequestMapping("deptManagement.shtml")
	@ResponseBody
	public Object secondDeptNode(@RequestParam("treeId")String treeId){
		return dept.secondDeptNode(Integer.parseInt(treeId));
	}
	
	@RequestMapping("addingDept.shtml")
	public String addingDept(deptuser user,
			HttpServletRequest request
			){
		if(dept.addingDept(user)>0){
			return "redirect:/dept/gosetDept.shtml";
		}else{
			request.setAttribute("hint", "添加方法出错");
			return "404Error";
		}
		
	}
	
	@RequestMapping("loadselecter.shtml")
	@ResponseBody
	public Object loadselecter(){
		List<Map<String,Object>>list=dept.selectDept();
		return list;
	}
	
	@RequestMapping("changingDeptOnUser.shtml")
	public String changingDept(@RequestParam("deptSelecter")String deptSelecter,
			@RequestParam("uid")String uid,
			HttpServletRequest request
			){
		usercollect col=dept.checkCollect(Integer.parseInt(uid));
		if(col!=null){
			dept.changOnUsersDept(Integer.parseInt(uid),Integer.parseInt(deptSelecter));
		      return "redirect:/dept/managementuser.shtml";
		}
		else{
			request.setAttribute("hint","修改失败,检察人员是否存在");
		    return "404Error";
		}
	}
	
	@RequestMapping("reNameNode.shtml")
	@ResponseBody
	public String reNameNode(@RequestParam("treeId")String treeId,
			@RequestParam("Name")String Name
			){
		if(dept.reNameNode(Integer.parseInt(treeId),Name)>0){
			return "succ";
		}else{
			return "fail";
		}	
	}
	
}

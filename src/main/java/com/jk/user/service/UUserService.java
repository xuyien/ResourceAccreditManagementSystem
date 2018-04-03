package com.jk.user.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.ui.ModelMap;

import com.jk.common.model.UUser;
import com.jk.core.mybatis.page.Pagination;
import com.jk.permission.bo.URoleBo;
import com.jk.permission.bo.UserRoleAllocationBo;

public interface UUserService {

	int deleteByPrimaryKey(Long id);

	UUser insert(UUser record);

    UUser insertSelective(UUser record);

    UUser selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(UUser record);

    int updateByPrimaryKey(UUser record);
    
    UUser login(String email, String pswd);

	UUser findUserByEmail(String email);

	Pagination<UUser> findByPage(Map<String, Object> resultMap, Integer pageNo,
								 Integer pageSize);

	Map<String, Object> deleteUserById(String ids);

	Map<String, Object> updateForbidUserById(Long id, Long status);

	Pagination<UserRoleAllocationBo> findUserAndRole(ModelMap modelMap,
													 Integer pageNo, Integer pageSize);

	List<URoleBo> selectRoleByUserId(Long id);

	Map<String, Object> addRole2User(Long userId, String ids);

	Map<String, Object> deleteRoleByUserIds(String userIds);
	
	
	/**
	 *  根据当前账户查到当前id 可供查询userPermission时传入的id 
	 */
	int selectIdByEmail(String email);
	/**
	 *  查询当前user的所有权限
	     返回shiro 所需要的set<String>类型的集合
	 */
	Set<String> selectUserPermissionById(int id);
}

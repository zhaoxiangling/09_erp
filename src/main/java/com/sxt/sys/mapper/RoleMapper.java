package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    
    List<Role> queryAllRole(Role role);
    
    //根据角色ID删除角色和权限之间的关系
	void deleteRolePermissionByRoleId(Integer rid);
	
	//保存角色和权限之间的关系
	void saveRolePermission(Integer rid, Integer pid);
	//根据用户ID查询用户拥有的角色
	List<Role> queryRolesByUserId(Integer userId, Integer available);
}
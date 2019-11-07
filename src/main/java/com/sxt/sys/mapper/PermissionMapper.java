package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.Permission;

public interface PermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Permission record);

    int insertSelective(Permission record);

    Permission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Permission record);

    int updateByPrimaryKey(Permission record);
    
    List<Permission> queryAllPermission(Permission permission);
    //查询最大的菜单排序
	int queryMaxOrderNun();
	//根据角色ID查询权限
	List<Permission> queryPermissionByRoleId(Integer available, Integer roleId);
	//根据用户ID查询权限
	List<Permission> queryAllPermissionByUserId(Integer userid, Integer available, String type);
}
package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.Permission;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.PermissionVo;

public interface PermissionService {
	
	//查询菜单
	List<Permission> queryAllPermissionForList(PermissionVo permissionVo);
	
	List<Permission> queryPermissionByUserIdForList(PermissionVo permissionVo,Integer userid);
	
	//查询菜单返回DataGridView
	DataGridView queryAllPermission(PermissionVo permissionVo);
	//查询最大的排序码
	int queryMaxOrderNun();
	//添加菜单和权限
	void addPermission(PermissionVo permissionVo);
	//根据ID查询菜单和权限
	Permission queryPermissionById(Integer id);
	//修改菜单和权限
	void updatePermission(PermissionVo permissionVo);
	//删除菜单和权限
	void deletePermission(Integer id);

	//根据角色ID查询权限
	List<Permission> queryPermissionByRoleIdForList(PermissionVo permissionVo, Integer id);
	

}

package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.Role;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.RoleVo;

public interface RoleService {
	
	
	/**
	 * 查询所有角色返回DataGridView
	 */
	public DataGridView queryAllRoles(RoleVo roleVo);

	/**
	 * 添加角色
	 * @param roleVo
	 */
	public void addRole(RoleVo roleVo);

	/**
	 * 根据ID查询角色
	 * @param id
	 * @return
	 */
	public Role queryRoleById(Integer id);

	/**
	 * 修改角色信息
	 * @param roleVo
	 */
	public void updateRole(RoleVo roleVo);

	/**
	 * 删除
	 * @param roleVo
	 */
	public void deleteRole(Integer id);

	/**
	 * 保存角色和权限之间的关系
	 */
	public void saveRolePermission(RoleVo roleVo);

	
	public List<Role> queryAllRolesForList(RoleVo roleVo);
	/**
	 * 2查询当前用户拥有的角色
	 * @param userId
	 * @return
	 */
	public List<Role> queryRolesByUserId(Integer userId);
	
}

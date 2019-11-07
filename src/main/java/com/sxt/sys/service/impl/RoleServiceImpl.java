package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Role;
import com.sxt.sys.mapper.RoleMapper;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.RoleVo;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleMapper roleMapper;
	

	@Override
	public DataGridView queryAllRoles(RoleVo roleVo) {
		Page<Object> page=PageHelper.startPage(roleVo.getPage(), roleVo.getLimit());
		List<Role> data=this.roleMapper.queryAllRole(roleVo);
		DataGridView view=new DataGridView(page.getTotal(), data);
		return view;
	}

	/**
	 * 添加角色
	 */
	@Override
	public void addRole(RoleVo roleVo) {
		this.roleMapper.insert(roleVo);
	}

	@Override
	public Role queryRoleById(Integer id) {
		return this.roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateRole(RoleVo roleVo) {
		this.roleMapper.updateByPrimaryKeySelective(roleVo);
	}

	@Override
	public void deleteRole(Integer id) {
		this.roleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void saveRolePermission(RoleVo roleVo) {
		Integer rid=roleVo.getId();
		Integer[] pids=roleVo.getIds();
		//根据角色ID删除sys_role_permission的数据
		this.roleMapper.deleteRolePermissionByRoleId(rid);
		//保存
		if(pids!=null&&pids.length>0) {
			for (Integer pid : pids) {
				this.roleMapper.saveRolePermission(rid,pid);
			}
		}
	}

	@Override
	public List<Role> queryAllRolesForList(RoleVo roleVo) {
		return this.roleMapper.queryAllRole(roleVo);
	}

	@Override
	public List<Role> queryRolesByUserId(Integer userId) {
		Integer available=SYSConstast.SYS_AVAILABLE_TRUE;
		return this.roleMapper.queryRolesByUserId(userId,available);
	}
}

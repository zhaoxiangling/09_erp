package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.Permission;
import com.sxt.sys.mapper.PermissionMapper;
import com.sxt.sys.service.PermissionService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.PermissionVo;

@Service
public class PermissionServiceImpl implements PermissionService{
	
	@Autowired
	private PermissionMapper permissionMapper;

	@Override
	public List<Permission> queryAllPermissionForList(PermissionVo permissionVo) {
		return permissionMapper.queryAllPermission(permissionVo);
	}

	@Override
	public List<Permission> queryPermissionByUserIdForList(PermissionVo permissionVo, Integer userid) {
		 return permissionMapper.queryAllPermissionByUserId(userid,permissionVo.getAvailable(),permissionVo.getType());
	}

	@Override
	public DataGridView queryAllPermission(PermissionVo permissionVo) {
		Page<Object> page=PageHelper.startPage(permissionVo.getPage(), permissionVo.getLimit());
		List<Permission> data = this.permissionMapper.queryAllPermission(permissionVo);
		return new DataGridView(page.getTotal(), data);
	}

	@Override
	public int queryMaxOrderNun() {
		return this.permissionMapper.queryMaxOrderNun();
	}

	@Override
	public void addPermission(PermissionVo permissionVo) {
		this.permissionMapper.insertSelective(permissionVo);
	}

	@Override
	public Permission queryPermissionById(Integer id) {
		return this.permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updatePermission(PermissionVo permissionVo) {
		this.permissionMapper.updateByPrimaryKeySelective(permissionVo);
	}

	@Override
	public void deletePermission(Integer id) {
		this.permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Permission> queryPermissionByRoleIdForList(PermissionVo permissionVo, Integer id) {
		Integer available = permissionVo.getAvailable();
		return this.permissionMapper.queryPermissionByRoleId(available,id);
	}

}

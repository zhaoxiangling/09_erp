package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Permission;
import com.sxt.sys.domain.Role;
import com.sxt.sys.service.PermissionService;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.TreeNode;
import com.sxt.sys.vo.PermissionVo;
import com.sxt.sys.vo.RoleVo;

@Controller
@RequestMapping("role")
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@Autowired
	private PermissionService permissionService;

	/**
	 * 跳转到roleManager.jsp
	 */
	@RequestMapping("toRoleManager")
	public String toRoleManager() {
		return "sys/role/roleManager";
	}

	/**
	 * 加载角色列表
	 */
	@RequestMapping("loadAllRoles")
	@ResponseBody
	public DataGridView loadAllRoles(RoleVo roleVo) {
		return this.roleService.queryAllRoles(roleVo);
	}

	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddRole")
	public String toAddRole() {
		return "sys/role/roleAdd";
	}

	/**
	 * 添加
	 */
	@RequestMapping("addRole")
	@ResponseBody
	public Map<String, Object> addRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "添加成功";
		try {
			this.roleService.addRole(roleVo);
		} catch (Exception e) {
			msg = "添加失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 跳转到修改页面
	 */
	@RequestMapping("toUpdateRole")
	public String toUpdateRole(RoleVo roleVo, Model model) {
		Role role = this.roleService.queryRoleById(roleVo.getId());
		BeanUtils.copyProperties(role, roleVo);
		return "sys/role/roleUpdate";
	}

	/**
	 * 修改
	 */
	@RequestMapping("updateRole")
	@ResponseBody
	public Map<String, Object> updateRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "修改成功";
		try {
			// 做修改
			this.roleService.updateRole(roleVo);
		} catch (Exception e) {
			msg = "修改失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 删除
	 */
	@RequestMapping("deleteRole")
	@ResponseBody
	public Map<String, Object> deleteRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			// 做删除
			this.roleService.deleteRole(roleVo.getId());
		} catch (Exception e) {
			msg = "删除失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 批量删除
	 */
	@RequestMapping("batchDeleteRole")
	@ResponseBody
	public Map<String, Object> batchDeleteRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			// 做删除
			Integer[] ids = roleVo.getIds();
			if (null != ids && ids.length > 0) {
				for (Integer integer : ids) {
					this.roleService.deleteRole(integer);
				}
			}
		} catch (Exception e) {
			msg = "删除失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 跳转到分配权限的页面
	 */              
	@RequestMapping("toSelectPermission")
	public String toSelectPermission(RoleVo roleVo) {
		return "sys/role/roleSelectPermission";
	}
	
	/**
	 * 加载权限的树并选择之前的分配的权限
	 */
	@RequestMapping("loadRolePermission")
	@ResponseBody
	public List<TreeNode> loadRolePermission(RoleVo roleVo){
		//1,查询所有可用的权限
		PermissionVo permissionVo=new PermissionVo();
		permissionVo.setAvailable(SYSConstast.SYS_AVAILABLE_TRUE);//只查可用的
		List<Permission> allPermision = this.permissionService.queryAllPermissionForList(permissionVo);
		//2,查询当前roleid已经拥有的权限
		List<Permission> rolePermission=this.permissionService.queryPermissionByRoleIdForList(permissionVo, roleVo.getId());
		List<TreeNode> treeNodes=new ArrayList<>();
		for (Permission p1 : allPermision) {
			Boolean checked=false;
			for (Permission p2 : rolePermission) {
				if(p1.getId()==p2.getId()) {
					checked=true;
					break;
				}
			}
			Boolean open=p1.getOpen()==SYSConstast.SYS_OPEN_TRUE?true:false;
			Boolean isParent=p1.getParent()==SYSConstast.SYS_PARENT_TRUE?true:false;
			if(p1.getType().equals(SYSConstast.PERMISSION_TYPE_MEUN)) {
				isParent=true;
			}
			treeNodes.add(new TreeNode(p1.getId(), p1.getPid(), p1.getName(), open, isParent, checked));
		}
		return treeNodes;
	}
	
	
	/**
	 * 保存角色和权限之间的关系
	 */
	@RequestMapping("saveRolePermission")
	@ResponseBody
	public Map<String,Object> saveRolePermission(RoleVo roleVo){
		Map<String,Object> map=new HashMap<>();
		try {
			this.roleService.saveRolePermission(roleVo);
			map.put("msg", "保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "保存失败");
		}
		return map;
	}
	
}

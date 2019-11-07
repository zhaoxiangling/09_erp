package com.sxt.sys.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Permission;
import com.sxt.sys.service.PermissionService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.PermissionVo;

@Controller
@RequestMapping("permission")
public class PermissionController {
	
	@Autowired
	private PermissionService permissionService;
	
	/*****权限管理开始***/

	/**
	 * 跳转到permissionManager.jsp
	 */
	@RequestMapping("toPermissionManager")
	public String toPermissionManager() {
		return "sys/permission/permissionManager";
	}

	/**
	 * 跳转到permissionLeft.jsp
	 */
	@RequestMapping("toPermissionLeft")
	public String toPermissionLeft() {
		return "sys/permission/permissionLeft";
	}

	/**
	 * 跳转到permissionRigth.jsp
	 */
	@RequestMapping("toPermissionRight")
	public String toPermissionRight() {
		return "sys/permission/permissionRight";
	}
	
	/**
	 * 加载权限数据
	 */
	@RequestMapping("loadAllPermission")
	@ResponseBody
	public DataGridView loadAllPermission(PermissionVo permissionVo) {
		//只能查询type=permission
		permissionVo.setType(SYSConstast.PERMISSION_TYPE_PERMISSION);
		return this.permissionService.queryAllPermission(permissionVo);
	}
	
	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddPermission")
	public String toAddPermission(PermissionVo permissionVo) {
		int maxOrderNum=this.permissionService.queryMaxOrderNun();
		permissionVo.setOrdernum(maxOrderNum+1);
		return "sys/permission/permissionAdd";
	}
	
	/**
	 * 添加权限
	 */
	@RequestMapping("addPermission")
	@ResponseBody
	public Map<String,Object> addPermission(PermissionVo permissionVo){
		Map<String, Object> map=new HashMap<>();
		String msg="添加成功";
		try {
			//权限
			permissionVo.setType(SYSConstast.PERMISSION_TYPE_PERMISSION);
			this.permissionService.addPermission(permissionVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg="添加失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 跳转到修改页面
	 */
	@RequestMapping("toUpdatePermission")
	public String toUpdatePermission(PermissionVo permissionVo) {
		Permission permission=this.permissionService.queryPermissionById(permissionVo.getId());
		//把permission里面的属性值copy到permissionVo里面  
		/**
		 * 参数1数据源对象
		 * 参数2目标对象
		 */
		BeanUtils.copyProperties(permission, permissionVo);
		return "sys/permission/permissionUpdate";
	}
	
	/**
	 * 修改权限
	 */
	@RequestMapping("updatePermission")
	@ResponseBody
	public Map<String,Object> updatePermission(PermissionVo permissionVo){
		Map<String, Object> map=new HashMap<>();
		String msg="修改成功";
		try {
			this.permissionService.updatePermission(permissionVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg="修改失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 删除权限
	 */
	@RequestMapping("deletePermission")
	@ResponseBody
	public Map<String,Object> deletePermission(PermissionVo permissionVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			this.permissionService.deletePermission(permissionVo.getId());
		} catch (Exception e) {
			e.printStackTrace();
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 批量删除权限
	 */
	@RequestMapping("deletePermissionBatch")
	@ResponseBody
	public Map<String,Object> deletePermissionBatch(PermissionVo permissionVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			Integer [] ids=permissionVo.getIds();
			for (Integer id : ids) {
				this.permissionService.deletePermission(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/*****权限管理结束***/
	

}

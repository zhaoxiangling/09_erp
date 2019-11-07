package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Permission;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.PermissionService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.TreeNode;
import com.sxt.sys.utils.TreeNodeBuilder;
import com.sxt.sys.vo.PermissionVo;

@Controller
@RequestMapping("menu")
public class MenuController {
	
	@Autowired
	private PermissionService permissionService;
	
	/**
	 * 加载index页面左边的菜单树
	 */
	@RequestMapping("loadIndexLeftTree")
	@ResponseBody
	public List<TreeNode> loadIndexLeftTree(PermissionVo permissionVo,HttpSession session){
		List<Permission> list=null;
		//取出用户
		User user=(User)session.getAttribute("user");
		permissionVo.setAvailable(SYSConstast.SYS_AVAILABLE_TRUE);//只查可用的菜单
		permissionVo.setType(SYSConstast.PERMISSION_TYPE_MEUN);//只查菜单
		if(user.getType()==SYSConstast.USER_TYPE_SUPER) {
			list=this.permissionService.queryAllPermissionForList(permissionVo);
		}else {
			list=this.permissionService.queryPermissionByUserIdForList(permissionVo, user.getId());
		}
		List<TreeNode>  treeNodes=new ArrayList<>();
		for (Permission p : list) {
			Boolean spread=p.getOpen()==SYSConstast.SYS_OPEN_TRUE?true:false;
			treeNodes.add(new TreeNode(p.getId(), p.getPid(), p.getName(), p.getIcon(), p.getHref(), spread));
		}
		
		Integer topId=1;
		List<TreeNode> nodes=TreeNodeBuilder.builder(treeNodes,topId);
		return nodes;
	}
	
	
	/*****菜单管理开始***/

	/**
	 * 跳转到menuManager.jsp
	 */
	@RequestMapping("toMenuManager")
	public String toMenuManager() {
		return "sys/menu/menuManager";
	}

	/**
	 * 跳转到menuLeft.jsp
	 */
	@RequestMapping("toMenuLeft")
	public String toMenuLeft() {
		return "sys/menu/menuLeft";
	}

	/**
	 * 跳转到menuRigth.jsp
	 */
	@RequestMapping("toMenuRight")
	public String toMenuRight() {
		return "sys/menu/menuRight";
	}
	
	/**
	 * 加载菜单数据
	 */
	@RequestMapping("loadAllMenu")
	@ResponseBody
	public DataGridView loadAllMenu(PermissionVo permissionVo) {
		//只能查询type=menu
		permissionVo.setType(SYSConstast.PERMISSION_TYPE_MEUN);
		return this.permissionService.queryAllPermission(permissionVo);
	}
	
	/**
	 * 加载菜单管理左边的菜单树
	 */
	@RequestMapping("loadMenuLeftTree")
	@ResponseBody	
	public List<TreeNode> loadMenuLeftTree(PermissionVo permissionVo){
		//只能查询type=menu
		permissionVo.setType(SYSConstast.PERMISSION_TYPE_MEUN);
		List<Permission> allMenu=this.permissionService.queryAllPermissionForList(permissionVo);
		List<TreeNode> treeNodes=new ArrayList<>();
		for (Permission menu : allMenu) {
			Boolean open=menu.getOpen()==SYSConstast.SYS_OPEN_TRUE?true:false;
			Boolean isParent=menu.getParent()==SYSConstast.SYS_PARENT_TRUE?true:false;
			treeNodes.add(new TreeNode(menu.getId(), menu.getPid(), menu.getName(), open, isParent));
		}
		return treeNodes;
	}
	
	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddMenu")
	public String toAddMenu(PermissionVo permissionVo) {
		int maxOrderNum=this.permissionService.queryMaxOrderNun();
		permissionVo.setOrdernum(maxOrderNum+1);
		return "sys/menu/menuAdd";
	}
	
	/**
	 * 添加菜单
	 */
	@RequestMapping("addMenu")
	@ResponseBody
	public Map<String,Object> addMenu(PermissionVo permissionVo){
		Map<String, Object> map=new HashMap<>();
		String msg="添加成功";
		try {
			//菜单
			permissionVo.setType(SYSConstast.PERMISSION_TYPE_MEUN);
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
	@RequestMapping("toUpdateMenu")
	public String toUpdateMenu(PermissionVo permissionVo) {
		Permission menu=this.permissionService.queryPermissionById(permissionVo.getId());
		//把nemu里面的icon里面的&换成&amp;
		menu.setIcon(menu.getIcon().replace("&", "&amp;"));
		//把menu里面的属性值copy到menuVo里面  
		/**
		 * 参数1数据源对象
		 * 参数2目标对象
		 */
		BeanUtils.copyProperties(menu, permissionVo);
		return "sys/menu/menuUpdate";
	}
	
	/**
	 * 修改菜单
	 */
	@RequestMapping("updateMenu")
	@ResponseBody
	public Map<String,Object> updateMenu(PermissionVo permissionVo){
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
	 * 删除菜单
	 */
	@RequestMapping("deleteMenu")
	@ResponseBody
	public Map<String,Object> deleteMenu(PermissionVo permissionVo){
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
	 * 批量删除菜单
	 */
	@RequestMapping("deleteMenuBatch")
	@ResponseBody
	public Map<String,Object> deleteMenuBatch(PermissionVo permissionVo){
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
	/*****菜单管理结束***/
	

}

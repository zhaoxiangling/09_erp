package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Dept;
import com.sxt.sys.service.DeptService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.TreeNode;
import com.sxt.sys.vo.DeptVo;

@Controller
@RequestMapping("dept")
public class DeptController {

	@Autowired
	private DeptService deptService;

	/**
	 * 跳转到deptManager.jsp
	 */
	@RequestMapping("toDeptManager")
	public String toDeptManager() {
		return "sys/dept/deptManager";
	}

	/**
	 * 跳转到deptLeft.jsp
	 */
	@RequestMapping("toDeptLeft")
	public String toDeptLeft() {
		return "sys/dept/deptLeft";
	}

	/**
	 * 跳转到deptRigth.jsp
	 */
	@RequestMapping("toDeptRight")
	public String toDeptRight() {
		return "sys/dept/deptRight";
	}
	
	/**
	 * 加载部门数据
	 */
	@RequestMapping("loadAllDept")
	@ResponseBody
	public DataGridView loadAllDept(DeptVo deptVo) {
		return this.deptService.queryAllDept(deptVo);
	}
	
	/**
	 * 加载部门管理左边的部门树
	 */
	@RequestMapping("loadDeptLeftTree")
	@ResponseBody	
	public List<TreeNode> loadDeptLeftTree(DeptVo deptVo){
		List<Dept> allDept=this.deptService.queryAllDeptForList(deptVo);
		List<TreeNode> treeNodes=new ArrayList<>();
		for (Dept dept : allDept) {
			Boolean open=dept.getOpen()==SYSConstast.SYS_OPEN_TRUE?true:false;
			Boolean isParent=dept.getParent()==SYSConstast.SYS_PARENT_TRUE?true:false;
			treeNodes.add(new TreeNode(dept.getId(), dept.getPid(), dept.getName(), open, isParent));
		}
		return treeNodes;
	}
	
	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddDept")
	public String toAddDept(DeptVo deptVo) {
		int maxOrderNum=this.deptService.queryMaxOrderNun();
		deptVo.setOrdernum(maxOrderNum+1);
		return "sys/dept/deptAdd";
	}
	
	/**
	 * 添加部门
	 */
	@RequestMapping("addDept")
	@ResponseBody
	public Map<String,Object> addDept(DeptVo deptVo){
		Map<String, Object> map=new HashMap<>();
		String msg="添加成功";
		try {
			this.deptService.addDept(deptVo);
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
	@RequestMapping("toUpdateDept")
	public String toUpdateDept(DeptVo deptVo) {
		Dept dept=this.deptService.queryDeptById(deptVo.getId());
		//把dept里面的属性值copy到deptVo里面  
		/**
		 * 参数1数据源对象
		 * 参数2目标对象
		 */
		BeanUtils.copyProperties(dept, deptVo);
		return "sys/dept/deptUpdate";
	}
	
	/**
	 * 修改部门
	 */
	@RequestMapping("updateDept")
	@ResponseBody
	public Map<String,Object> updateDept(DeptVo deptVo){
		Map<String, Object> map=new HashMap<>();
		String msg="修改成功";
		try {
			this.deptService.updateDept(deptVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg="修改失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 删除部门
	 */
	@RequestMapping("deleteDept")
	@ResponseBody
	public Map<String,Object> deleteDept(DeptVo deptVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			this.deptService.deleteDept(deptVo.getId());
		} catch (Exception e) {
			e.printStackTrace();
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 批量删除部门
	 */
	@RequestMapping("deleteDeptBatch")
	@ResponseBody
	public Map<String,Object> deleteDeptBatch(DeptVo deptVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			Integer [] ids=deptVo.getIds();
			for (Integer id : ids) {
				this.deptService.deleteDept(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
}

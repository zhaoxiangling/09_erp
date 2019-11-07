package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.Dept;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.DeptVo;

public interface DeptService {
	
	//查询部门
	DataGridView queryAllDept(DeptVo deptVo);
	//查询所有部门返回集合
	List<Dept> queryAllDeptForList(DeptVo deptVo);
	//查询部门最大的排序码
	Integer queryMaxOrderNun();
	//添加部门
	void addDept(DeptVo deptVo);
	//根据ID查询部门
	Dept queryDeptById(Integer id);
	//修改
	void updateDept(DeptVo deptVo);
	//删除
	void deleteDept(Integer id);
	
}

package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.Dept;
import com.sxt.sys.mapper.DeptMapper;
import com.sxt.sys.service.DeptService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.DeptVo;

@Service
public class DeptServiceImpl implements DeptService {
	
	@Autowired
	private DeptMapper deptMapper;

	@Override
	public DataGridView queryAllDept(DeptVo deptVo) {
		Page<Object> page=PageHelper.startPage(deptVo.getPage(), deptVo.getLimit());
		List<Dept> data = this.deptMapper.queryAllDept(deptVo);
		return new DataGridView(page.getTotal(), data);
	}

	@Override
	public List<Dept> queryAllDeptForList(DeptVo deptVo) {
		return this.deptMapper.queryAllDept(deptVo);
	}

	@Override
	public Integer queryMaxOrderNun() {
		return this.deptMapper.queryMaxOrderNun();
	}

	@Override
	public void addDept(DeptVo deptVo) {
		this.deptMapper.insert(deptVo);
	}

	@Override
	public Dept queryDeptById(Integer id) {
		return this.deptMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateDept(DeptVo deptVo) {
		this.deptMapper.updateByPrimaryKeySelective(deptVo);
	}

	@Override
	public void deleteDept(Integer id) {
		this.deptMapper.deleteByPrimaryKey(id);
	}

}

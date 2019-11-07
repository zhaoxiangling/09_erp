package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.LeaveBill;
import com.sxt.sys.mapper.LeaveBillMapper;
import com.sxt.sys.service.LeaveBillService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LeaveBillVo;

@Service
public class LeaveBillServiceImpl implements LeaveBillService {

	@Autowired
	private LeaveBillMapper leaveBillMapper;
	

	@Override
	public DataGridView queryAllLeaveBills(LeaveBillVo leaveBillVo) {
		Page<Object> page=PageHelper.startPage(leaveBillVo.getPage(), leaveBillVo.getLimit());
		List<LeaveBill> data=this.leaveBillMapper.queryAllLeaveBill(leaveBillVo);
		DataGridView view=new DataGridView(page.getTotal(), data);
		return view;
	}

	/**
	 * 添加请假单
	 */
	@Override
	public void addLeaveBill(LeaveBillVo leaveBillVo) {
		this.leaveBillMapper.insert(leaveBillVo);
	}

	@Override
	public LeaveBill queryLeaveBillById(Integer id) {
		
		return this.leaveBillMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateLeaveBill(LeaveBillVo leaveBillVo) {
		this.leaveBillMapper.updateByPrimaryKey(leaveBillVo);
	}

	@Override
	public void deleteLeaveBill(Integer id) {
		this.leaveBillMapper.deleteByPrimaryKey(id);
	}
}

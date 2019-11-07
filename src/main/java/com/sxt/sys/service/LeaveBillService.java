package com.sxt.sys.service;

import com.sxt.sys.domain.LeaveBill;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LeaveBillVo;

public interface LeaveBillService {
	
	/**
	 * 查询所有请假单返回DataGridView
	 */
	public DataGridView queryAllLeaveBills(LeaveBillVo leaveBillVo);

	/**
	 * 添加请假单
	 * @param leaveBillVo
	 */
	public void addLeaveBill(LeaveBillVo leaveBillVo);

	/**
	 * 根据ID查询请假单
	 * @param id
	 * @return
	 */
	public LeaveBill queryLeaveBillById(Integer id);

	/**
	 * 修改请假单信息
	 * @param leaveBillVo
	 */
	public void updateLeaveBill(LeaveBillVo leaveBillVo);

	/**
	 * 删除
	 * @param leaveBillVo
	 */
	public void deleteLeaveBill(Integer id);
	
}

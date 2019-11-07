package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Provider;
import com.sxt.bus.mapper.ProviderMapper;
import com.sxt.bus.service.ProviderService;
import com.sxt.bus.vo.ProviderVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class ProviderServiceImpl implements ProviderService {

	@Autowired
	private ProviderMapper providerMapper;

	/**
	 * 查询有效客户
	 */
	@Override
	public List<Provider> queryAllProvider(ProviderVo providerVo) {
		return providerMapper.queryAllProviders(providerVo);
	}
	@Override
	public DataGridView loadProviders(ProviderVo providerVo) {
		Page<Provider> page=PageHelper.startPage(providerVo.getPage(), providerVo.getLimit());
		List<Provider> list=providerMapper.queryAllProviders(providerVo);
		DataGridView view=new DataGridView();
		view.setCount(page.getTotal());
		view.setData(list);
		return view;
	}
	@Override
	public void addProvider(ProviderVo providerVo) {
		this.providerMapper.insert(providerVo);
	}
	@Override
	public Provider queryProviderById(Integer id) {
		return this.providerMapper.selectByPrimaryKey(id);
	}
	@Override
	public void updateProvider(ProviderVo providerVo) {
		this.providerMapper.updateByPrimaryKey(providerVo);
	}
	@Override
	public void deleteProvider(ProviderVo providerVo) {
		this.providerMapper.deleteByPrimaryKey(providerVo.getId());
	}
	
}

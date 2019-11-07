package com.sxt.bus.service;

import java.util.List;

import com.sxt.bus.domain.Provider;
import com.sxt.bus.vo.ProviderVo;
import com.sxt.sys.utils.DataGridView;

public interface ProviderService {
	List<Provider> queryAllProvider(ProviderVo providerVo);

	DataGridView loadProviders(ProviderVo providerVo);

	void addProvider(ProviderVo providerVo);

	Provider queryProviderById(Integer id);

	void updateProvider(ProviderVo providerVo);

	void deleteProvider(ProviderVo providerVo);

}

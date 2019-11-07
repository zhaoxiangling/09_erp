package com.sxt.bus.vo;

import com.sxt.bus.domain.Provider;

public class ProviderVo extends Provider{
	
	private Integer[] ids;
	/**
	 * 定义分页的参数  和layui的分页参数保持一至
	 */
	private Integer page;//当前第几页
	private Integer limit;//每页显示多少条
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public Integer[] getIds() {
		return ids;
	}
	public void setIds(Integer[] ids) {
		this.ids = ids;
	}
	
}

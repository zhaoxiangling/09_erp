package com.sxt.sys.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.sxt.sys.domain.Role;

public class RoleVo extends Role {

	// 批量删除使用
	private Integer[] ids;

	private Integer page;
	private Integer limit;
	@JsonProperty("LAY_CHECKED")
	private Boolean checked;
	
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

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	

}

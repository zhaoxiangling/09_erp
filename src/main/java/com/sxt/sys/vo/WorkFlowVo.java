package com.sxt.sys.vo;

public class WorkFlowVo{
	
	//批量删除使用
	private Integer[] ids;
	
	private Integer page;
	private Integer limit;
	
	
	//流程部署名称
	private String deploymentName;
	
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
	public String getDeploymentName() {
		return deploymentName;
	}
	public void setDeploymentName(String deploymentName) {
		this.deploymentName = deploymentName;
	}
	
	
}

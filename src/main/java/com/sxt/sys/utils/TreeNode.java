package com.sxt.sys.utils;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 树节点类
 * @author LJH
 *
 */
public class TreeNode {
	
	private Integer id;
	@JsonProperty("pId")//在生成json字符串的key时把pid -->pId
	private Integer pid;
	private String name;
	private String icon;
	private String href;
	private Boolean spread;//是否展开
	
	private List<TreeNode> children=new ArrayList<>();
	
	
	//zTree扩展
	private Boolean open;
	private Boolean isParent;
	
	//zTree的checkbox的属性
	private Boolean checked;
	
	
	/**
	 * zTree的复选树使用的构造方法	
	 * @param id
	 * @param pid
	 * @param name
	 * @param open
	 * @param isParent
	 * @param checked
	 */
	public TreeNode(Integer id, Integer pid, String name, Boolean open, Boolean isParent, Boolean checked) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.open = open;
		this.isParent = isParent;
		this.checked = checked;
	}
	/**
	 * zTree使用的构造方法	
	 * @param id
	 * @param pid
	 * @param name
	 * @param open
	 * @param isParent
	 */
	public TreeNode(Integer id, Integer pid, String name, Boolean open, Boolean isParent) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.open = open;
		this.isParent = isParent;
	}
	/**
	 * 系统主页面左边的导航菜单树使用
	 * @param id
	 * @param pid
	 * @param name
	 * @param icon
	 * @param href
	 * @param spread
	 */
	public TreeNode(Integer id, Integer pid, String name, String icon, String href, Boolean spread) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.icon = icon;
		this.href = href;
		this.spread = spread;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public Boolean getSpread() {
		return spread;
	}
	public void setSpread(Boolean spread) {
		this.spread = spread;
	}
	public List<TreeNode> getChildren() {
		return children;
	}
	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}
	public Boolean getOpen() {
		return open;
	}
	public void setOpen(Boolean open) {
		this.open = open;
	}
	public Boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	
	
}

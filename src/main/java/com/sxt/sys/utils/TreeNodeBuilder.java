package com.sxt.sys.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 构造标准json对象的类
 * @author LJH
 *
 */
public class TreeNodeBuilder {

	/**
	 * 构造在层级关系的json
	 * @param treeNodes
	 * @param topId
	 * @return
	 */
	public static List<TreeNode> builder(List<TreeNode> treeNodes, Integer topId) {
		List<TreeNode> nodes=new ArrayList<>();
		for (TreeNode n1 : treeNodes) {
			if(n1.getPid()==topId){//说明是根节点
				nodes.add(n1);
			}
			//再次循环判断treeNodes里面的哪些节点的pid和n1和id一样
			for (TreeNode n2 : treeNodes) {
				if(n2.getPid()==n1.getId()){
					n1.getChildren().add(n2);
				}
			}
		}
		return nodes;
	}

}

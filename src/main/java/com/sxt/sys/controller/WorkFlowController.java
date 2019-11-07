package com.sxt.sys.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.service.WorkFlowService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.WorkFlowVo;

/**
 * 工作流的控制器
 * @author LJH
 *
 */
@Controller
@RequestMapping("workFlow")
public class WorkFlowController {

	@Autowired
	private WorkFlowService workFlowService;
	
	
	
	/**
	 * 跳转到流程管理的页面
	 */
	@RequestMapping("toWorkFlowManager")
	public String toWorkFlowManager() {
		return "sys/workFlow/workFlowManager";
	}
	
	/**
	 * 加载部署信息数据
	 */
	@RequestMapping("loadAllDeployment")
	@ResponseBody
	public DataGridView  loadAllDeployment(WorkFlowVo workFlowVo) {
		return this.workFlowService.queryProcessDeploy(workFlowVo);
	}
	
	/**
	 * 加载流程定义信息数据
	 */
	@RequestMapping("loadAllProcessDefinition")
	@ResponseBody
	public DataGridView  loadAllProcessDefinition(WorkFlowVo workFlowVo) {
		return this.workFlowService.queryAllProcessDefinition(workFlowVo);
	}
}

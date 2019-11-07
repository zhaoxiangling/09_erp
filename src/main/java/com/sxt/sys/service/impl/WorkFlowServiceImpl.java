package com.sxt.sys.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sxt.sys.service.WorkFlowService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.WorkFlowVo;
import com.sxt.sys.vo.act.ActDeploymentEntity;
import com.sxt.sys.vo.act.ActProcessDefinitionEntity;

@Service
public class WorkFlowServiceImpl implements WorkFlowService{
	
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private HistoryService historyService;
	@Autowired
	private IdentityService identityService;
	@Autowired
	private FormService formService;
	@Autowired
	private ManagementService managementService;
	
	
	/**
	 * 查询流程部署信息
	 */
	public DataGridView queryProcessDeploy(WorkFlowVo workFlowVo) {
		if(workFlowVo.getDeploymentName()==null) {
			workFlowVo.setDeploymentName("");
		}
		String name=workFlowVo.getDeploymentName();
		//查询总条数
		long count = repositoryService.createDeploymentQuery().deploymentNameLike("%"+name+"%").count();
		//查询
		int firstResult=(workFlowVo.getPage()-1)*workFlowVo.getLimit();
		int maxResults=workFlowVo.getLimit();
		List<Deployment> list = repositoryService.createDeploymentQuery().deploymentNameLike("%"+name+"%").listPage(firstResult, maxResults);
		List<ActDeploymentEntity> data=new ArrayList<ActDeploymentEntity>();
		for (Deployment deployment : list) {
			ActDeploymentEntity entity=new ActDeploymentEntity();
			//copy
			BeanUtils.copyProperties(deployment, entity);
			data.add(entity);
		}
		return new DataGridView(count, data);
	}

	/**
	 * 查询流程定义
	 */
	@Override
	public DataGridView queryAllProcessDefinition(WorkFlowVo workFlowVo) {
		if(workFlowVo.getDeploymentName()==null) {
			workFlowVo.setDeploymentName("");
		}
		String name=workFlowVo.getDeploymentName();
		//先根据部署的的名称模糊查询出所有的部署的ID
		List<Deployment> dlist = repositoryService.createDeploymentQuery().deploymentNameLike("%"+name+"%").list();
		Set<String> deploymentIds=new HashSet<>();
		for (Deployment deployment : dlist) {
			deploymentIds.add(deployment.getId());
		}
		long count=0;
		List<ActProcessDefinitionEntity> data=new ArrayList<>();
		if(deploymentIds.size()>0) {
			 count = this.repositoryService.createProcessDefinitionQuery().deploymentIds(deploymentIds).count();
			//查询流程部署信息
				int firstResult=(workFlowVo.getPage()-1)*workFlowVo.getLimit();
				int maxResults=workFlowVo.getLimit();
				List<ProcessDefinition> list = this.repositoryService.createProcessDefinitionQuery().deploymentIds(deploymentIds).listPage(firstResult, maxResults);
				for (ProcessDefinition pd : list) {
					ActProcessDefinitionEntity entity=new ActProcessDefinitionEntity();
					BeanUtils.copyProperties(pd, entity);
					data.add(entity);
				}
		}
		return new DataGridView(count, data);
	}
	
	
	
	
	

}

package com.sxt.sys.controller;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sxt.sys.domain.LeaveBill;
import com.sxt.sys.service.LeaveBillService;
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
	
	@Autowired
	private LeaveBillService leaveBillService;
	
	
	
	
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
	
	
	/**
	 * 跳转到部署流程的页面
	 */
	@RequestMapping("toAddWorkFlow")
	public String toAddWorkFlow() {
		return "sys/workFlow/workFlowAdd";
	}
	
	
	/**
	 * 添加流程部署
	 */
	@RequestMapping("addWorkFlow")
	@ResponseBody
	public Map<String,Object> addWorkFlow(MultipartFile mf,WorkFlowVo workFlowVo){
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			this.workFlowService.addWorkFlow(mf.getInputStream(),workFlowVo.getDeploymentName());
			map.put("msg", "部署成功");
		} catch (Exception e) {
			map.put("msg", "部署失败");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 删除流程部署
	 */
	@RequestMapping("deleteWorkFlow")
	@ResponseBody
	public Map<String,Object> deleteWorkFlow(WorkFlowVo workFlowVo){
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			this.workFlowService.deleteWorkFlow(workFlowVo.getDeploymentId());
			map.put("msg", "删除成功");
		} catch (Exception e) {
			map.put("msg", "删除失败");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 批量删除流程部署
	 */
	@RequestMapping("batchDeleteWorkFlow")
	@ResponseBody
	public Map<String,Object> batchDeleteWorkFlow(WorkFlowVo workFlowVo){
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			String[] deploymentIds=workFlowVo.getIds();
			for (String deploymentId : deploymentIds) {
				this.workFlowService.deleteWorkFlow(deploymentId);
			}
			map.put("msg", "删除成功");
		} catch (Exception e) {
			map.put("msg", "删除失败");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 流程管理里面跳转到查看流程图的页面
	 */
	@RequestMapping("toViewProcessImage")
	public String toViewProcessImage(WorkFlowVo workFlowVo) {
		return "sys/workFlow/viewProcessImage";
	}
	
	/**
	 * 查看流程图
	 */
	@RequestMapping("viewProcessImage")
	public void viewProcessImage(WorkFlowVo workFlowVo,HttpServletResponse response) {
		InputStream stream=this.workFlowService.queryProcessDeploymentImage(workFlowVo.getDeploymentId());
		try {
			BufferedImage image=ImageIO.read(stream);
			ServletOutputStream outputStream = response.getOutputStream();
			ImageIO.write(image, "JPEG", outputStream);
			stream.close();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 启动流程
	 */
	@RequestMapping("startProcess")
	@ResponseBody
	public Map<String,Object> startProcess(WorkFlowVo workFlowVo){
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			Integer leaveBillId=workFlowVo.getId();
			this.workFlowService.startProcess(leaveBillId);
			map.put("msg", "启动成功");
		} catch (Exception e) {
			map.put("msg", "启动失败");
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 跳转到待办任务的页面
	 */
	@RequestMapping("toTaskManager")
	public String toTaskManager() {
		return "sys/workFlow/taskManager";
	}
	
	/**
	 * 查询当前登陆人的代办任务
	 */
	@RequestMapping("loadCurrentUserTask")
	@ResponseBody
	public DataGridView loadCurrentUserTask(WorkFlowVo workFlowVo) {
		return this.workFlowService.queryCurrentUserTask(workFlowVo);
	}
	
	
	/**
	 * 跳转到办理任务的页面
	 */
	@RequestMapping("toDoTask")
	public String toDoTask(WorkFlowVo workFlowVo,Model model) {
		//1,根据任务ID查询请假单的信息
		LeaveBill leaveBill=this.workFlowService.queryLeaveBillByTaskId(workFlowVo.getTaskId());
		model.addAttribute("leaveBill", leaveBill);
		//2,根据任务ID查询连线信息
		List<String> outcomeName=this.workFlowService.queryOutComeByTaskId(workFlowVo.getTaskId());
		model.addAttribute("outcomes", outcomeName);
		return "sys/workFlow/doTaskManager";
	}
	/**
	 * 根据任务ID查询批注信息
	 */
	@RequestMapping("loadAllCommentByTaskId")
	@ResponseBody
	public DataGridView loadAllCommentByTaskId(WorkFlowVo workFlowVo) {
		return this.workFlowService.queryCommentByTaskId(workFlowVo.getTaskId());
	}
	
	/**
	 * 完成任务
	 */
	@RequestMapping("doTask")
	@ResponseBody
	public Map<String,Object> doTask(WorkFlowVo workFlowVo){
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			this.workFlowService.completeTask(workFlowVo);
			map.put("msg", "任务完成成功");
		} catch (Exception e) {
			map.put("msg", "任务完成失败");
			e.printStackTrace();
		}
		return map;
	}
	
	
	/**
	 * 根据任务ID查看流程进度图
	 */
	@RequestMapping("toViewProcessByTaskId")
	public String toViewProcessByTaskId(WorkFlowVo workFlowVo,Model model) {
		ProcessDefinition processDefinition=this.workFlowService.queryProcessDefinitionByTaskId(workFlowVo.getTaskId());
		//取出流程部署ID
		String deploymentId = processDefinition.getDeploymentId();
		workFlowVo.setDeploymentId(deploymentId);
		//根据任务ID查询节点坐标
		Map<String,Object> coordinate=this.workFlowService.queryTaskCoordinateByTaskId(workFlowVo.getTaskId());
		model.addAttribute("c", coordinate);
		return "sys/workFlow/viewProcessImage";
	}
	
	
	/**
	 * 根据请假单ID查询审批批注信息和请假单的信息
	 */
	@RequestMapping("viewSpProcess")
	public String viewSpProcess(WorkFlowVo workFlowVo,Model model) {
		//查询请假单的信息
		LeaveBill leaveBill = leaveBillService.queryLeaveBillById(workFlowVo.getId());
		model.addAttribute("leaveBill", leaveBill);
		return "sys/workFlow/spProcessView";
	}
	
	/**
	 * 根据请假单的ID查询批注信息
	 */
	@RequestMapping("loadCommentByLeaveBillId")
	@ResponseBody
	public DataGridView loadCommentByLeaveBillId(WorkFlowVo workFlowVo) {
		return this.workFlowService.querydCommentByLeaveBillId(workFlowVo.getId());
	}
}

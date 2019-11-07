package com.sxt.sys.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.service.LogInfoService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LogInfoVo;

/**
 * 日志管理控制器
 * @author LJH
 *
 */
@Controller
@RequestMapping("logInfo")
//@RestController//==@RequestMapping +@ResponseBody
public class LogInfoController {
	@Autowired
	private LogInfoService logInfoService;
	/**
	 * 跳转到日志管理的页面
	 */
	@RequestMapping("toLogInfoManager")
	public String toLogInfoManager() {
		return "sys/logInfo/logInfoManager";
	}
	/**
	 * 查询日志
	 */
	@RequestMapping("loadAllLogInfo")
	@ResponseBody
	public DataGridView loadAllLogInfo(LogInfoVo logInfoVo) {
		return this.logInfoService.queryAllLogInfo(logInfoVo);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping("deleteLogInfo")
	@ResponseBody
	public Map<String,Object> deleteLogInfo(LogInfoVo infoVo){
		Map<String,Object> map=new HashMap<>();
		try {
			this.logInfoService.deleteLogInfo(infoVo);
			map.put("msg", "删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "删除失败");
		}
		return map;
	}
	
	
	/**
	 * 批量删除
	 */
	@RequestMapping("deleteBatchLogInfo")
	@ResponseBody
	public Map<String,Object> deleteBatchLogInfo(LogInfoVo infoVo){
		Map<String,Object> map=new HashMap<>();
		try {
			Integer[] ids = infoVo.getIds();
			for (Integer id : ids) {
				infoVo.setId(id);
				this.logInfoService.deleteLogInfo(infoVo);
			}
			map.put("msg", "删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "删除失败");
		}
		return map;
	}
	
	
}

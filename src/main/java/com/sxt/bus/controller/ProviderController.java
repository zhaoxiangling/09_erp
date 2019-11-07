package com.sxt.bus.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.domain.Provider;
import com.sxt.bus.service.ProviderService;
import com.sxt.bus.vo.ProviderVo;
import com.sxt.sys.utils.DataGridView;

@Controller
@RequestMapping("provider")
public class ProviderController {
	
	@Autowired
	private ProviderService providerService;
	
	/**
	 * 跳转到供应商管理页面
	 */
	@RequestMapping("toProviderManager")
	public String toProviderManager() {
		return "bus/provider/providerManager";
	}
	
	/**
	 * 加载供应商数据
	 */
	@RequestMapping("loadProviders")
	@ResponseBody
	public DataGridView loadProviders(ProviderVo providerVo) {
		return providerService.loadProviders(providerVo);
	}
	
	
	/**
	 * 跳转到添加供应商页面
	 */
	@RequestMapping("toAddProvider")
	public String toAddProvider() {
		return "bus/provider/providerAdd";
	}
	
	/**
	 * 添加供应商
	 */
	@RequestMapping("addProvider")
	@ResponseBody
	public Map<String, Object> addProvider(ProviderVo providerVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "添加成功";
		try {
			providerService.addProvider(providerVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
	
	/**
	 * 跳转到修改供应商页面
	 */
	@RequestMapping("toUpdateProvider")
	public String toUpdateProvider(ProviderVo providerVo,Model model) {
		//根据供应商ID查询所有供应商信息
		Provider provider=this.providerService.queryProviderById(providerVo.getId());
		model.addAttribute("provider", provider);
		return "bus/provider/providerUpdate";
	}
	
	/**
	 * 修改供应商
	 */
	@RequestMapping("updateProvider")
	@ResponseBody
	public Map<String, Object> updateProvider(ProviderVo providerVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "修改成功";
		try {
			providerService.updateProvider(providerVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "修改失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 删除供应商
	 */
	@RequestMapping("deleteProvider")
	@ResponseBody
	public Map<String, Object> deleteProvider(ProviderVo providerVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "删除成功";
		try {
			providerService.deleteProvider(providerVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping("batchDeleteProvider")
	@ResponseBody
	public Map<String, Object> batchDeleteProvider(ProviderVo providerVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "删除成功";
		try {
			Integer [] ids=providerVo.getIds();
			for (Integer id : ids) {
				providerVo.setId(id);
				providerService.deleteProvider(providerVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}

}

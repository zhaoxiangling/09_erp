package com.sxt.bus.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.domain.Customer;
import com.sxt.bus.service.CustomerService;
import com.sxt.bus.vo.CustomerVo;
import com.sxt.sys.utils.DataGridView;

@Controller
@RequestMapping("customer")
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	/**
	 * 跳转到客户管理页面
	 */
	@RequestMapping("toCustomerManager")
	public String toCustomerManager() {
		return "bus/customer/customerManager";
	}
	
	/**
	 * 加载客户数据
	 */
	@RequestMapping("loadCustomers")
	@ResponseBody
	public DataGridView loadCustomers(CustomerVo customerVo) {
		return customerService.loadCustomers(customerVo);
	}
	
	
	/**
	 * 跳转到添加客户页面
	 */
	@RequestMapping("toAddCustomer")
	public String toAddCustomer() {
		return "bus/customer/customerAdd";
	}
	
	/**
	 * 添加客户
	 */
	@RequestMapping("addCustomer")
	@ResponseBody
	public Map<String, Object> addCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "添加成功";
		try {
			customerService.addCustomer(customerVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "添加失败";
		}
		map.put("msg", msg);
		return map;
	}
	
	
	/**
	 * 跳转到修改客户页面
	 */
	@RequestMapping("toUpdateCustomer")
	public String toUpdateCustomer(CustomerVo customerVo,Model model) {
		//根据客户ID查询所有客户信息
		Customer customer=this.customerService.queryCustomerById(customerVo.getId());
		model.addAttribute("customer", customer);
		return "bus/customer/customerUpdate";
	}
	
	/**
	 * 修改客户
	 */
	@RequestMapping("updateCustomer")
	@ResponseBody
	public Map<String, Object> updateCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "修改成功";
		try {
			customerService.updateCustomer(customerVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "修改失败";
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 删除客户
	 */
	@RequestMapping("deleteCustomer")
	@ResponseBody
	public Map<String, Object> deleteCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			customerService.deleteCustomer(customerVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败";
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping("batchDeleteCustomer")
	@ResponseBody
	public Map<String, Object> batchDeleteCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			Integer [] ids=customerVo.getIds();
			for (Integer id : ids) {
				customerVo.setId(id);
				customerService.deleteCustomer(customerVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败";
		}
		map.put("msg", msg);
		return map;
	}

}

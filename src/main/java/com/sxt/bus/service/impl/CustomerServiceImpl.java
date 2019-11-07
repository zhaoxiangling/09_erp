package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Customer;
import com.sxt.bus.mapper.CustomerMapper;
import com.sxt.bus.service.CustomerService;
import com.sxt.bus.vo.CustomerVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerMapper customerMapper;

	/**
	 * 查询有效客户
	 */
	@Override
	public List<Customer> queryAllCustomer(CustomerVo customerVo) {
		return customerMapper.queryAllCustomers(customerVo);
	}
	@Override
	public DataGridView loadCustomers(CustomerVo customerVo) {
		Page<Customer> page=PageHelper.startPage(customerVo.getPage(), customerVo.getLimit());
		List<Customer> list=customerMapper.queryAllCustomers(customerVo);
		DataGridView view=new DataGridView();
		view.setCount(page.getTotal());
		view.setData(list);
		return view;
	}
	@Override
	public void addCustomer(CustomerVo customerVo) {
		this.customerMapper.insert(customerVo);
	}
	@Override
	public Customer queryCustomerById(Integer id) {
		return this.customerMapper.selectByPrimaryKey(id);
	}
	@Override
	public void updateCustomer(CustomerVo customerVo) {
		this.customerMapper.updateByPrimaryKey(customerVo);
	}
	@Override
	public void deleteCustomer(CustomerVo customerVo) {
		this.customerMapper.deleteByPrimaryKey(customerVo.getId());
	}
	
}

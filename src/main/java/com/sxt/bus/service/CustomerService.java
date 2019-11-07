package com.sxt.bus.service;

import java.util.List;

import com.sxt.bus.domain.Customer;
import com.sxt.bus.vo.CustomerVo;
import com.sxt.sys.utils.DataGridView;

public interface CustomerService {
	List<Customer> queryAllCustomer(CustomerVo customerVo);

	DataGridView loadCustomers(CustomerVo customerVo);

	void addCustomer(CustomerVo customerVo);

	Customer queryCustomerById(Integer id);

	void updateCustomer(CustomerVo customerVo);

	void deleteCustomer(CustomerVo customerVo);

}

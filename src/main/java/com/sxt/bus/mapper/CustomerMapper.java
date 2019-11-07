package com.sxt.bus.mapper;

import java.util.List;

import com.sxt.bus.domain.Customer;

public interface CustomerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
    
    /**
     * 全查询+模糊
     */
    List<Customer> queryAllCustomers(Customer customer);
}
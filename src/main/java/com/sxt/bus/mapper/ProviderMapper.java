package com.sxt.bus.mapper;

import java.util.List;

import com.sxt.bus.domain.Provider;

public interface ProviderMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Provider record);

    int insertSelective(Provider record);

    Provider selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Provider record);

    int updateByPrimaryKey(Provider record);
    
    List<Provider> queryAllProviders(Provider record);
}
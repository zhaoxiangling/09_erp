package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.User;
import com.sxt.sys.vo.UserVo;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    //根据登陆名查询用户
    User queryUserByLoginName(String loginname);
    //查询用户
	List<User> queryAllUser(UserVo userVo);
	//查询最大的排序码
	int queryMaxOrderNun();
	//根据部门ID查询用户
	List<User> queryUserByDeptId(Integer deptid);
	//根据用户ID删除用户和角色之间的关系数据
	void deleteUserRoleByUserId(Integer id);
	//保存用户和角色之间的关系
	void saveUserRole(Integer uid, Integer rid);
}
package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.User;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.UserVo;

public interface UserService {

	
	//根据登陆名查询用户
	User queryUserByLoginName(String loginname);
	//查询用户
	DataGridView queryAllUser(UserVo userVo);
	//查询最大的排序码
	int queryMaxOrderNun();
	//添加用户
	void addUser(UserVo userVo);
	//根据部门ID查询用户
	List<User> queryUserByDeptId(Integer deptid);
	//根据用户ID查询用户
	User queryUserById(Integer id);
	//修改用户
	void updateUser(UserVo userVo);
	//删除用户
	void deleteUser(Integer id);
	//重置密码
	void resetPwd(Integer id);
	//保存用户和角色之间的关系
	void saveUserRole(UserVo userVo);
}

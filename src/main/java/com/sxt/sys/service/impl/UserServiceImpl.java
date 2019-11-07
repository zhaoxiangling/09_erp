package com.sxt.sys.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.User;
import com.sxt.sys.mapper.UserMapper;
import com.sxt.sys.service.UserService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.MD5Utils;
import com.sxt.sys.vo.UserVo;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public User queryUserByLoginName(String loginname) {
		return userMapper.queryUserByLoginName(loginname);
	}

	@Override
	public DataGridView queryAllUser(UserVo userVo) {
		Page<Object> page = PageHelper.startPage(userVo.getPage(), userVo.getLimit());
		List<User> data = this.userMapper.queryAllUser(userVo);
		return new DataGridView(page.getTotal(), data);
	}

	@Override
	public int queryMaxOrderNun() {
		return this.userMapper.queryMaxOrderNun();
	}

	@Override
	public void addUser(UserVo userVo) {
		this.userMapper.insertSelective(userVo);
	}

	@Override
	public List<User> queryUserByDeptId(Integer deptid) {
		return this.userMapper.queryUserByDeptId(deptid);
	}

	@Override
	public User queryUserById(Integer id) {
		return this.userMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateUser(UserVo userVo) {
		this.userMapper.updateByPrimaryKeySelective(userVo);
	}

	@Override
	public void deleteUser(Integer id) {
		// 1,删除用户和角色之间的关系数据
		this.userMapper.deleteUserRoleByUserId(id);
		// 2,删除用户
		this.userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void resetPwd(Integer id) {
		User user = this.userMapper.selectByPrimaryKey(id);
		String salt = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
		user.setSalt(salt);
		if (user != null) {
			user.setPwd(MD5Utils.md5(SYSConstast.USER_PWD_DEFAULT, user.getSalt(), 2));
			;
		}
		this.userMapper.updateByPrimaryKeySelective(user);

	}

	@Override
	public void saveUserRole(UserVo userVo) {
		Integer uid=userVo.getId();
		Integer [] rids=userVo.getIds();
		// 1,删除用户和角色之间的关系数据
		this.userMapper.deleteUserRoleByUserId(uid);
		//2,保存
		if(rids!=null&&rids.length>0) {
			for (Integer rid : rids) {
				this.userMapper.saveUserRole(uid,rid);
			}
		}
	}

}

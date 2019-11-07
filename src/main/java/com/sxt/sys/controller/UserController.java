package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Role;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.service.UserService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.MD5Utils;
import com.sxt.sys.utils.PinyinUtils;
import com.sxt.sys.vo.RoleVo;
import com.sxt.sys.vo.UserVo;

@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	/**
	 * 跳转到userManager.jsp
	 */
	@RequestMapping("toUserManager")
	public String toUserManager() {
		return "sys/user/userManager";
	}

	/**
	 * 跳转到userLeft.jsp
	 */
	@RequestMapping("toUserLeft")
	public String toUserLeft() {
		return "sys/user/userLeft";
	}

	/**
	 * 跳转到userRigth.jsp
	 */
	@RequestMapping("toUserRight")
	public String toUserRight() {
		return "sys/user/userRight";
	}

	/**
	 * 加载用户数据
	 */
	@RequestMapping("loadAllUser")
	@ResponseBody
	public DataGridView loadAllUser(UserVo userVo) {
		return this.userService.queryAllUser(userVo);
	}

	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddUser")
	public String toAddUser(UserVo userVo) {
		int maxOrderNum = this.userService.queryMaxOrderNun();
		userVo.setOrdernum(maxOrderNum + 1);
		return "sys/user/userAdd";
	}

	/**
	 * 添加用户
	 */
	@RequestMapping("addUser")
	@ResponseBody
	public Map<String, Object> addUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "添加成功";
		try {
			String salt = UUID.randomUUID().toString().replace("-", "").toUpperCase();
			String pwd = MD5Utils.md5(SYSConstast.USER_PWD_DEFAULT, salt, 2);
			String imgpath = SYSConstast.USER_DEFALUT_IMGTITLE;
			userVo.setSalt(salt);
			userVo.setPwd(pwd);
			userVo.setType(SYSConstast.USER_TYPE_NORMAL);
			userVo.setImgpath(imgpath);
			this.userService.addUser(userVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "添加失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 根据部门ID查询部门下面的员工
	 */
	@RequestMapping("loadUserByDeptId")
	@ResponseBody
	public List<User> loadUserByDeptId(UserVo userVo) {
		return this.userService.queryUserByDeptId(userVo.getDeptid());
	}

	/**
	 * 把用户名中文改成拼音 并验证登陆名是否唯一
	 */
	@RequestMapping(value = "changeUserNameToPinyin", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String changeUserNameToPinyin(UserVo userVo) {
		String py = PinyinUtils.toPinyin(userVo.getName());
		User user = this.userService.queryUserByLoginName(py);
		if (user != null) {
			py += "01";
		}
		return py;
	}

	/**
	 * 跳转到修改页面
	 */
	@RequestMapping("toUpdateUser")
	public String toUpdateUser(UserVo userVo) {
		User user = this.userService.queryUserById(userVo.getId());
		// 把user里面的属性值copy到userVo里面
		/**
		 * 参数1数据源对象 参数2目标对象
		 */
		BeanUtils.copyProperties(user, userVo);
		return "sys/user/userUpdate";
	}

	/**
	 * 根据用户ID查询用户
	 * 
	 */
	@RequestMapping("loadUserById")
	@ResponseBody
	public User loadUserById(UserVo userVo) {
		return this.userService.queryUserById(userVo.getId());
	}

	/**
	 * 修改用户
	 */
	@RequestMapping("updateUser")
	@ResponseBody
	public Map<String, Object> updateUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "修改成功";
		try {
			this.userService.updateUser(userVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "修改失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 删除用户
	 */
	@RequestMapping("deleteUser")
	@ResponseBody
	public Map<String, Object> deleteUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			this.userService.deleteUser(userVo.getId());
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 批量删除用户
	 */
	@RequestMapping("deleteUserBatch")
	@ResponseBody
	public Map<String, Object> deleteUserBatch(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			Integer[] ids = userVo.getIds();
			for (Integer id : ids) {
				this.userService.deleteUser(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 重置密码
	 */
	@RequestMapping("resetPwd")
	@ResponseBody
	public Map<String, Object> resetPwd(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "重置成功";
		try {
			// 重置
			this.userService.resetPwd(userVo.getId());
		} catch (Exception e) {
			e.printStackTrace();
			msg = "重置失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 跳转到分配角色的页面
	 */
	@RequestMapping("toUserSelectRole")
	public String toUserSelectRole(UserVo userVo) {
		return "sys/user/selectUserRole";
	}

	/**
	 * 加载角色的列表 不用分页 要加入一个LAY_CHECKED
	 */
	@RequestMapping("loadUserRoleList")
	@ResponseBody
	public DataGridView loadUserRoleList(UserVo userVo) {
		// 1,查询所有可用的角色
		RoleVo roleVo = new RoleVo();
		roleVo.setAvailable(SYSConstast.SYS_AVAILABLE_TRUE);
		List<Role> allRoles = this.roleService.queryAllRolesForList(roleVo);
		// 2查询当前用户拥有的角色
		Integer userId = userVo.getId();
		List<Role> currUserRoles = this.roleService.queryRolesByUserId(userId);
		List<RoleVo> roles = new ArrayList<>();
		for (Role r1 : allRoles) {
			Boolean LAY_CHECKED = false;
			for (Role r2 : currUserRoles) {
				if (r1.getId() == r2.getId()) {
					LAY_CHECKED = true;
					break;
				}
			}
			RoleVo vo = new RoleVo();
			BeanUtils.copyProperties(r1, vo);
			vo.setChecked(LAY_CHECKED);
			roles.add(vo);
		}
		return new DataGridView(Long.valueOf(roles.size()), roles);
	}

	/**
	 * 保存用户和角色之间的关系数据
	 */
	@RequestMapping("saveUserRole")
	@ResponseBody
	public Map<String, Object> saveUserRole(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "分配成功";
		try {
			// 重置
			this.userService.saveUserRole(userVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "分配失败" + e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}

}

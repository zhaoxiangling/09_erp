package com.sxt.sys.realm;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.Permission;
import com.sxt.sys.domain.Role;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.PermissionService;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.service.UserService;
import com.sxt.sys.utils.ActiverUser;
import com.sxt.sys.vo.PermissionVo;

/**
 * 用户登陆的自定义realm
 * @author LJH
 *
 */
public class UserRealm extends AuthorizingRealm {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private PermissionService permissionService;

	@Override
	public String getName() {
		return this.getClass().getSimpleName();
	}
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		//得到登陆名
		String loginname = token.getPrincipal().toString();
		//2根据登陆名去查询用户
		User user = userService.queryUserByLoginName(loginname);
		if(null!=user) {
			
			//查询当前用户的角色
			List<Role> currRoles=this.roleService.queryRolesByUserId(user.getId());
			List<String> currRoleStrs=new ArrayList<String>();
			for (Role role : currRoles) {
				currRoleStrs.add(role.getName());
			}
			
			//查询当前用户的权限
			PermissionVo permissionVo=new PermissionVo();
			permissionVo.setAvailable(SYSConstast.SYS_AVAILABLE_TRUE);
			permissionVo.setType(SYSConstast.PERMISSION_TYPE_PERMISSION);
			List<Permission> currPermissions=this.permissionService.queryPermissionByUserIdForList(permissionVo, user.getId());
			List<String> currPermissionStrs=new ArrayList<>();
			for (Permission permission : currPermissions) {
				currPermissionStrs.add(permission.getPercode());
			}
			// 根据角色和权限
			ActiverUser activerUser=new ActiverUser();
			activerUser.setUser(user);
			activerUser.setRoles(currRoleStrs);
			activerUser.setPermissions(currPermissionStrs);
			ByteSource salt=ByteSource.Util.bytes(user.getSalt());
			SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(activerUser, user.getPwd(), salt, getName());
			return info;
		}
		return null;
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection collection) {
		ActiverUser activerUser=(ActiverUser) collection.getPrimaryPrincipal();
		SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();
		if(activerUser.getUser().getType()==SYSConstast.USER_TYPE_SUPER) {
			info.addStringPermission("*:*");
		}else {
			if(activerUser.getRoles()!=null&&activerUser.getRoles().size()>0) {
				info.addRoles(activerUser.getRoles());
			}
			if(activerUser.getPermissions()!=null&&activerUser.getPermissions().size()>0) {
				info.addStringPermissions(activerUser.getPermissions());
			}
		}
		return info;
	}

}

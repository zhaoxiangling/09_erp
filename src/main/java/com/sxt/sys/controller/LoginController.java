package com.sxt.sys.controller;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sxt.sys.service.LogInfoService;
import com.sxt.sys.utils.ActiverUser;
import com.sxt.sys.vo.LogInfoVo;
import com.sxt.sys.vo.UserVo;

@Controller
@RequestMapping("login")
public class LoginController {
	
	@Autowired
	private LogInfoService logInfoService;
	
	/**
	 * 跳转到登陆页面
	 */
	@RequestMapping("toLogin")
	public String toLogin() {
		return "sys/main/login";
	}
	
	/**
	 * 登陆
	 */
	@RequestMapping("login")
	public String login(UserVo userVo,Model model,HttpServletRequest request) {
		//1,创建Token
		UsernamePasswordToken token=new UsernamePasswordToken(userVo.getLoginname(), userVo.getPwd());
		//2,得到sbuject
		Subject subject=SecurityUtils.getSubject();
		try {
			subject.login(token);
			System.out.println("登陆成功");
			ActiverUser activerUser=(ActiverUser) subject.getPrincipal();
			request.getSession().setAttribute("user", activerUser.getUser());
			LogInfoVo infoVo=new LogInfoVo();
			infoVo.setLoginname(activerUser.getUser().getName()+"-"+activerUser.getUser().getLoginname());
			infoVo.setLoginip(request.getRemoteAddr());
			infoVo.setLogintime(new Date());
			//添加登陆日志
			logInfoService.addLogInfo(infoVo);
			return "sys/main/index";
		} catch (IncorrectCredentialsException e) {
			System.err.println("密码不正确");
			model.addAttribute("error", "密码不正确");
		} catch (UnknownAccountException e) {
			System.err.println("用户名不存在");
			model.addAttribute("error", "用户名不存在");
		}
		return "sys/main/login";
	}

}

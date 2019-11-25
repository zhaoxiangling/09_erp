package com.sxt.sys.listener;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.sxt.sys.domain.User;
import com.sxt.sys.service.UserService;
import com.sxt.sys.utils.SessionUtils;

public class TaskListenerImpl implements TaskListener{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void notify(DelegateTask delegateTask) {
		//得到当前用户
		User currentUser = SessionUtils.getCurrentUser();
		//取出领导ID
		Integer mgr=currentUser.getMgr();
		//取出IOC容器
		HttpServletRequest request=SessionUtils.getCurrentServletRequest();
		ApplicationContext applicationContext = WebApplicationContextUtils
                  .getWebApplicationContext(request.getServletContext());
		//从IOC容器里面取出UserService
		UserService userService=applicationContext.getBean(UserService.class);
		//3查询领导信息
		User leaderUser = userService.queryUserById(mgr);
		//4,设置办理人
		delegateTask.setAssignee(leaderUser.getName());
	}

}

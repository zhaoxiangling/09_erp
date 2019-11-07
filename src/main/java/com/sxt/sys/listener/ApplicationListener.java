package com.sxt.sys.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class ApplicationListener implements ServletContextListener{

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		context.setAttribute("ctx", context.getContextPath());
		System.out.println("---------------ServletContext初始化成功  ctx被加入到作用域--------");
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
	
	}
}

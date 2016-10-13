package com.newvery.servlet.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


/**
 * 获取系统所有参数
 */
public class SystemParameterListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent sce) {
	}

	public void contextInitialized(ServletContextEvent event) {
//		try {
//			
//			//参数缓存
//			List<SystemParameter> parameters = BeanFactory.getBasicDao().findAllParams();
//			for (SystemParameter p : parameters) {
//				SystemParameterFactory.PARAMETERS.put(p.getParamKey(), p.getParamValue());
//			 }
//			
//			List<CategoryRecord> categoryList = BeanFactory.getCategoryDao().listAllCategory();
//			for (CategoryRecord c : categoryList) {
//				CategoryCache.putCategory(c);
//			}
//			
//			
//		} catch (ServiceException e) {
//			e.printStackTrace();
//		}
	}

}

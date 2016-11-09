package com.newvery.bean;

import org.apache.log4j.PropertyConfigurator;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.newvery.ErrorCode;
import com.newvery.config.ConfigManager;
import com.newvery.dal.dao.annotate.IAnnotateDao;
import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.dal.dao.comment.ICommentDao;
import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.pdf.IPDFFileDao;
import com.newvery.dal.dao.permission.IPermissionDao;
import com.newvery.dal.dao.queryChart.IQueryChartDao;
import com.newvery.dal.dao.queryCondition.IQueryConditionDao;
import com.newvery.dal.dao.tag.ITagDao;
import com.newvery.dal.dao.user.IUserDao;
import com.newvery.exception.ServiceException;
import com.newvery.task.ISecurityExecutor;

public class BeanFactory {
	static private String[] configPath = new String[] { 
		"applicationContext.xml",
		"SpringExecutor.xml"
	};
	
	//配置Log4j
	static {
		PropertyConfigurator.configure(ConfigManager.getInstance().getLog4jConfigFilePath());
		//DOMConfigurator.configure(ConfigManager.getInstance().getLog4jConfigFilePath());
	}
	
	//org.apache.log4j.config.

	/**
	 * SpringContext的实例，使用加锁双检查（Double-checked locking）的SingleTon实现
	 * 参见：http://www.ibm.com/developerworks/java/library/j-dcl.html
	 */
	static private ConfigurableApplicationContext beanContext = null;

	static public ApplicationContext getBeanContext() {
		if (beanContext == null) {
			synchronized(BeanFactory.class) {
				if (beanContext == null) {
					beanContext =  new FileSystemXmlApplicationContext(getConfigPath());
				}
			}
		}
		
		return beanContext;
	}

	static public void setBeanContext(ConfigurableApplicationContext context) {
		beanContext = context;
	}

	public static String[] getConfigPath() {
		String[] fullConfigPath = new String[configPath.length];
		for (int i = 0; i < configPath.length; i++) {
			fullConfigPath[i] = "classpath:" + ConfigManager.getInstance().getSpringConfigPath() + "/" + configPath[i];
		}

		return fullConfigPath;
	}

	static public Object getBean(String beanName) throws ServiceException {
		ApplicationContext ctx = getBeanContext();

		if (ctx != null) {
			return getBeanContext().getBean(beanName);
		} else {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}
	}

	static public void destroyAllBeans() {
		ApplicationContext ctx = getBeanContext();
		if (ctx != null) {
			((ConfigurableApplicationContext) getBeanContext()).close();
			setBeanContext(null);
		}
	}
	
	static public ISecurityExecutor getSecurityExecutor() throws ServiceException {
		ISecurityExecutor executor = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		executor = (ISecurityExecutor) getBeanContext().getBean("securityExecutor");
		if (executor == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得SecurityExecutor");
		}

		return executor;
	}
	
	static public IUserDao getUserDao() throws ServiceException {
		IUserDao userDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		userDao = (IUserDao) getBeanContext().getBean("userDao");
		if (userDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得userDao");
		}

		return userDao;
	}
	
	static public IPermissionDao getPermissionDao() throws ServiceException {
		IPermissionDao permissionDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		permissionDao = (IPermissionDao) getBeanContext().getBean("permissionDao");
		if (permissionDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得permissionDao");
		}

		return permissionDao;
	}
	
	static public ITagDao getTagDao() throws ServiceException {
		ITagDao tagDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		tagDao = (ITagDao) getBeanContext().getBean("tagDao");
		if (tagDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得tagDao");
		}

		return tagDao;
	}
	
	static public ICategoryDao getCategoryDao() throws ServiceException {
		ICategoryDao categoryDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		categoryDao = (ICategoryDao) getBeanContext().getBean("categoryDao");
		if (categoryDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得categoryDao");
		}

		return categoryDao;
	}
	
	static public IArticleDao getArticleDao() throws ServiceException {
		IArticleDao articleDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		articleDao = (IArticleDao) getBeanContext().getBean("articleDao");
		if (articleDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得articleDao");
		}

		return articleDao;
	}
	
	static public IFavoriteDao getFavoriteDao() throws ServiceException {
		IFavoriteDao favoriteDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		favoriteDao = (IFavoriteDao) getBeanContext().getBean("favoriteDao");
		if (favoriteDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得favoriteDao");
		}

		return favoriteDao;
	}
	
	static public ICommentDao getCommentDao() throws ServiceException {
		ICommentDao commentDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		commentDao = (ICommentDao) getBeanContext().getBean("commentDao");
		if (commentDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得commentDao");
		}

		return commentDao;
	}
	
	static public IAnnotateDao getAnnotateDao() throws ServiceException {
		IAnnotateDao annotateDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		annotateDao = (IAnnotateDao) getBeanContext().getBean("annotateDao");
		if (annotateDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得annotateDao");
		}

		return annotateDao;
	}
	
	static public IQueryConditionDao getQueryConditionDao() throws ServiceException {
		IQueryConditionDao queryConditionDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		queryConditionDao = (IQueryConditionDao) getBeanContext().getBean("queryConditionDao");
		if (queryConditionDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得queryConditionDao");
		}

		return queryConditionDao;
	}
	
	static public IQueryChartDao getQueryChartDao() throws ServiceException {
		IQueryChartDao queryChartDao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		queryChartDao = (IQueryChartDao) getBeanContext().getBean("queryChartDao");
		if (queryChartDao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得queryChartDao");
		}

		return queryChartDao;
	}
	
	static public IPDFFileDao getPDFFileDao() throws ServiceException {
		IPDFFileDao dao = null;
		ApplicationContext ctx = getBeanContext();

		if (ctx == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得ApplicationContext");
		}

		dao = (IPDFFileDao) getBeanContext().getBean("pdfFileDao");
		if (dao == null) {
			throw new ServiceException(ErrorCode.NULL_INPUT, "无法获得userInterstDao");
		}
		return dao;
	}
}

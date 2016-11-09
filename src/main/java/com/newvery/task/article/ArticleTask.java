package com.newvery.task.article;

import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.dal.dao.user.IUserDao;
import com.newvery.dal.dao.user.impl.UserDaoImpl;
import com.newvery.record.ArticleRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class ArticleTask implements SecurityTask {
	private ArticleRecord article;
	private String operatorIP;
	private IDaoManagerFactory daoManagerFactory;

	public String getOperatorIP() {
		return operatorIP;
	}

	public void setOperatorIP(String operatorIP) {
		this.operatorIP = operatorIP;
	}

	public IDaoManagerFactory getDaoManagerFactory() {
		return daoManagerFactory;
	}

	public void setDaoManagerFactory(IDaoManagerFactory daoManagerFactory) {
		this.daoManagerFactory = daoManagerFactory;
	}

	public IArticleDao getArticleDao() {
		return (IArticleDao)getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}
	
	public IUserDao getUserDao() {
		return (IUserDao) getDaoManagerFactory().getManagerImpl(UserDaoImpl.class);
	}

	public ArticleRecord getArticle() {
		return article;
	}

	public void setArticle(ArticleRecord article) {
		this.article = article;
	}
}

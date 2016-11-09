package com.newvery.task.annotate;

import com.newvery.dal.dao.annotate.IAnnotateDao;
import com.newvery.dal.dao.annotate.impl.AnnotateDaoImpl;
import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.record.AnnotateRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class AnnotateTask implements SecurityTask {
	private AnnotateRecord annotate;
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

	public IAnnotateDao getAnnotateDao() {
		return (IAnnotateDao)getDaoManagerFactory().getManagerImpl(AnnotateDaoImpl.class);
	}
	
	public IArticleDao getArticleDao() {
		return (IArticleDao)getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}

	public AnnotateRecord getAnnotate() {
		return annotate;
	}

	public void setAnnotate(AnnotateRecord annotate) {
		this.annotate = annotate;
	}
}

package com.newvery.task.comment;

import com.newvery.dal.dao.comment.ICommentDao;
import com.newvery.dal.dao.comment.impl.CommentDaoImpl;
import com.newvery.record.CommentRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class CommentTask implements SecurityTask {
	private CommentRecord comment;
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

	public ICommentDao getCommentDao() {
		return (ICommentDao)getDaoManagerFactory().getManagerImpl(CommentDaoImpl.class);
	}

	public CommentRecord getComment() {
		return comment;
	}

	public void setComment(CommentRecord comment) {
		this.comment = comment;
	}
}

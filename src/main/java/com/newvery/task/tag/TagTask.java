package com.newvery.task.tag;

import com.newvery.dal.dao.tag.ITagDao;
import com.newvery.dal.dao.tag.impl.TagDaoImpl;
import com.newvery.record.TagRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class TagTask implements SecurityTask {
	private TagRecord tag;
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

	public ITagDao getTagDao() {
		return (ITagDao)getDaoManagerFactory().getManagerImpl(TagDaoImpl.class);
	}

	public TagRecord getTag() {
		return tag;
	}

	public void setTag(TagRecord tag) {
		this.tag = tag;
	}
}

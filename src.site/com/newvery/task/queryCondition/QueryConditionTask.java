package com.newvery.task.queryCondition;

import com.newvery.dal.dao.queryCondition.IQueryConditionDao;
import com.newvery.dal.dao.queryCondition.impl.QueryConditionDaoImpl;
import com.newvery.record.QueryConditionRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class QueryConditionTask implements SecurityTask {
	private QueryConditionRecord queryCondition;
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

	public IQueryConditionDao getQueryConditionDao() {
		return (IQueryConditionDao)getDaoManagerFactory().getManagerImpl(QueryConditionDaoImpl.class);
	}

	public QueryConditionRecord getQueryCondition() {
		return queryCondition;
	}

	public void setQueryCondition(QueryConditionRecord queryCondition) {
		this.queryCondition = queryCondition;
	}
}

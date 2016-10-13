package com.newvery.dal.dao.queryCondition.impl;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.task.queryCondition.QueryConditionTask;

public class QueryConditionInsertTask extends QueryConditionTask {

	@Override
	public Object exec() throws ServiceException {
		getQueryCondition().setDeleted(false);
		getQueryCondition().setCreateTime(new Date());
		
		setQueryCondition(getQueryConditionDao().insertQueryCondition(getQueryCondition()));
		
		return getQueryCondition();
	}

}

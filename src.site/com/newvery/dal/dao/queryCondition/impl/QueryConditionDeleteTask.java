package com.newvery.dal.dao.queryCondition.impl;

import com.newvery.exception.ServiceException;
import com.newvery.task.queryCondition.QueryConditionTask;

public class QueryConditionDeleteTask extends QueryConditionTask {

	@Override
	public Object exec() throws ServiceException {
		getQueryConditionDao().deleteQueryConditionById(getQueryCondition().getId());
		return null;
	}

}

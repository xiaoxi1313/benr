package com.newvery.dal.dao.queryCondition;

import java.util.List;

import com.newvery.exception.ServiceException;
import com.newvery.record.QueryConditionRecord;

public interface IQueryConditionDao {
	public QueryConditionRecord insertQueryCondition(QueryConditionRecord queryCondition)throws ServiceException;

	public void deleteQueryConditionById(long id) throws ServiceException;

	public List<QueryConditionRecord> findQueryCondition(long userId, int type)throws ServiceException;
}

package com.newvery.dal.dao.queryCondition.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.queryCondition.IQueryConditionDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.QueryConditionRecord;

public class QueryConditionDaoImpl extends BaseDao implements IQueryConditionDao {

	@Override
	public QueryConditionRecord insertQueryCondition(QueryConditionRecord queryCondition) throws ServiceException {
		getSqlTemplate().insert("insertQueryCondition", queryCondition);
		return queryCondition;
	}

	@Override
	public void deleteQueryConditionById(long id) throws ServiceException {
		getSqlTemplate().update("deleteQueryConditionById", id);
	}

	@Override
	public List<QueryConditionRecord> findQueryCondition(long userId, int type) throws ServiceException {
		Map query = new HashMap();
		query.put("userId", userId);
		query.put("type", type);
		
		return getSqlTemplate().selectList("findQueryCondition", query);
	}

}

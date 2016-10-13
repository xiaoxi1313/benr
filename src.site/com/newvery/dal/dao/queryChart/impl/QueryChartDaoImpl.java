package com.newvery.dal.dao.queryChart.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.queryChart.IQueryChartDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.QueryChartRecord;

public class QueryChartDaoImpl extends BaseDao implements IQueryChartDao {

	@Override
	public  QueryChartRecord insertQueryChart(QueryChartRecord queryChart) throws ServiceException {
		getSqlTemplate().insert("insertQueryChart", queryChart);
		return queryChart;
	}

	@Override
	public void deleteQueryChartById(long id) throws ServiceException {
		getSqlTemplate().update("deleteQueryChartById", id);
	}

	@Override
	public  List<QueryChartRecord> findQueryChart(long userId, int type) throws ServiceException {
		Map query = new HashMap();
		query.put("userId", userId);
		query.put("type", type);
		
		return getSqlTemplate().selectList("findQueryChart", query);
	}

	@Override
	public QueryChartRecord findQueryChartByPK(long id)
			throws ServiceException {
		return  getSqlTemplate().selectOne("findQueryChartByPK", id);
	}

}

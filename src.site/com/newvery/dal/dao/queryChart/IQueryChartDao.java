package com.newvery.dal.dao.queryChart;

import java.util.List;

import com.newvery.exception.ServiceException;
import com.newvery.record.QueryChartRecord;

public interface IQueryChartDao {
	public QueryChartRecord insertQueryChart(QueryChartRecord queryChart)throws ServiceException;

	public void deleteQueryChartById(long id) throws ServiceException;

	public List<QueryChartRecord> findQueryChart(long userId, int type)throws ServiceException;
	
	public QueryChartRecord findQueryChartByPK(long id) throws ServiceException;
}

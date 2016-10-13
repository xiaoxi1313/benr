package com.newvery.task.queryChart;

import com.newvery.exception.ServiceException;

public class QueryChartInsertTask extends QueryChartTask {

	@Override
	public Object exec() throws ServiceException {
		
		return getQueryChartDao().insertQueryChart(getQueryChart());
	}

}

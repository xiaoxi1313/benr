package com.newvery.task.queryChart;

import com.newvery.exception.ServiceException;

public class QueryChartDeleteTask extends QueryChartTask {

	@Override
	public Object exec() throws ServiceException {
		getQueryChartDao().deleteQueryChartById(getQueryChart().getId());
		return null;
	}

}

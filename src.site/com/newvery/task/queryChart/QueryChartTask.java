package com.newvery.task.queryChart;

import com.newvery.dal.dao.queryChart.IQueryChartDao;
import com.newvery.dal.dao.queryChart.impl.QueryChartDaoImpl;
import com.newvery.record.QueryChartRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class QueryChartTask implements SecurityTask {
	private QueryChartRecord queryChart;
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

	public IQueryChartDao getQueryChartDao() {
		return (IQueryChartDao)getDaoManagerFactory().getManagerImpl(QueryChartDaoImpl.class);
	}

	public QueryChartRecord getQueryChart() {
		return queryChart;
	}

	public void setQueryChart(QueryChartRecord queryChart) {
		this.queryChart = queryChart;
	}
}

package com.newvery.web.response;

import java.util.ArrayList;
import java.util.List;

import com.newvery.record.QueryChartRecord;

public class QueryChartResponse {
	
	private QueryChartRecord queryChart;
	private List<QueryChartBean> queryChartBeanList = new ArrayList<QueryChartBean>();
	public QueryChartRecord getQueryChart() {
		return queryChart;
	}
	public void setQueryChart(QueryChartRecord queryChart) {
		this.queryChart = queryChart;
	}
	public List<QueryChartBean> getQueryChartBeanList() {
		return queryChartBeanList;
	}
	public void setQueryChartBeanList(List<QueryChartBean> queryChartBeanList) {
		this.queryChartBeanList = queryChartBeanList;
	}
}

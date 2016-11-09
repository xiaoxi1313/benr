package com.newvery.web.response;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.ChartTagRecord;
import com.newvery.web.servlet.BaseResponse;

/**
 * 图表
 * @author mi_xb
 *
 */
public class ChartTagResponse extends BaseResponse {
	@Expose
	private List<ChartTagRecord> chartTagList;

	public List<ChartTagRecord> getChartTagList() {
		return chartTagList;
	}

	public void setChartTagList(List<ChartTagRecord> chartTagList) {
		this.chartTagList = chartTagList;
	}
	
}

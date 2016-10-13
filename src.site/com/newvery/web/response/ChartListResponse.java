package com.newvery.web.response;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.web.servlet.BaseResponse;

/**
 * 图表
 * @author mi_xb
 *
 */
public class ChartListResponse extends BaseResponse {
	@Expose
	private List<ChartResponse> chartResList = new ArrayList<ChartResponse>();

	public List<ChartResponse> getChartResList() {
		return chartResList;
	}

	public void setChartResList(List<ChartResponse> chartResList) {
		this.chartResList = chartResList;
	}

}

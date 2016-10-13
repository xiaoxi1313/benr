package com.newvery.web.response;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.TagCategoryRecord;
import com.newvery.web.servlet.BaseResponse;

public class PieChartResponse extends BaseResponse {

	@Expose
	private List<PieChartBean> data;

	@Expose
	List<TagCategoryRecord> tagCategoryList;
	
	public List<PieChartBean> getData() {
		return data;
	}

	public void setData(List<PieChartBean> data) {
		this.data = data;
	}

	public List<TagCategoryRecord> getTagCategoryList() {
		return tagCategoryList;
	}

	public void setTagCategoryList(List<TagCategoryRecord> tagCategoryList) {
		this.tagCategoryList = tagCategoryList;
	}
	
}

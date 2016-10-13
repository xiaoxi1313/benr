package com.newvery.web.response;

import com.google.gson.annotations.Expose;

public class QueryChartBean {
	@Expose
	private String beginDate;
	@Expose
	private String endDate;
	@Expose
	private String tagName;
	@Expose
	private long parentFavoriteId;
	@Expose
	private long[] childenFavoriteIds;
	
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public long getParentFavoriteId() {
		return parentFavoriteId;
	}
	public void setParentFavoriteId(long parentFavoriteId) {
		this.parentFavoriteId = parentFavoriteId;
	}
	public long[] getChildenFavoriteIds() {
		return childenFavoriteIds;
	}
	public void setChildenFavoriteIds(long[] childenFavoriteIds) {
		this.childenFavoriteIds = childenFavoriteIds;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
}

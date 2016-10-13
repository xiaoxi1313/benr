package com.newvery.web.response;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.ArticleRecord;
import com.newvery.record.ChartDistributionRecord;
import com.newvery.record.ChartRecord;
import com.newvery.web.servlet.BaseResponse;

/**
 * 图表
 * @author mi_xb
 *
 */
public class ChartResponse extends BaseResponse {
	@Expose
	private String tagName;
	@Expose
	private List<ChartRecord> chartList;
	@Expose
	private List<ArticleRecord> articleList;
	@Expose
	private long totalNum;
	@Expose
	private long maxNum;
	@Expose
	List<ChartDistributionRecord> chartDistributionList;
	@Expose
	private String parentFavoriteId;
	@Expose
	private String childFavoriteIds;
	
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public List<ChartRecord> getChartList() {
		return chartList;
	}
	public void setChartList(List<ChartRecord> chartList) {
		this.chartList = chartList;
	}
	public List<ArticleRecord> getArticleList() {
		return articleList;
	}
	public void setArticleList(List<ArticleRecord> articleList) {
		this.articleList = articleList;
	}
	public List<ChartDistributionRecord> getChartDistributionList() {
		return chartDistributionList;
	}
	public void setChartDistributionList(
			List<ChartDistributionRecord> chartDistributionList) {
		this.chartDistributionList = chartDistributionList;
	}
	public long getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(long totalNum) {
		this.totalNum = totalNum;
	}
	public long getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(long maxNum) {
		this.maxNum = maxNum;
	}
	public String getParentFavoriteId() {
		return parentFavoriteId;
	}
	public void setParentFavoriteId(String parentFavoriteId) {
		this.parentFavoriteId = parentFavoriteId;
	}
	public String getChildFavoriteIds() {
		return childFavoriteIds;
	}
	public void setChildFavoriteIds(String childFavoriteIds) {
		this.childFavoriteIds = childFavoriteIds;
	}
}

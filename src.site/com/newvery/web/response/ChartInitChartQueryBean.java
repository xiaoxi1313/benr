package com.newvery.web.response;

/**
 * 热点发现查询结果数据json对象
 * @author beimukaibin
 *
 */
public class ChartInitChartQueryBean {

	private int optionsRadio;
	private long[] yid;
	private long[] fid;
	private long[] cid;
	private String beginDate;
	private String endDate;
	private long tagCategoryId;
	
	private String tagName;
	
	public int getOptionsRadio() {
		return optionsRadio;
	}
	public void setOptionsRadio(int optionsRadio) {
		this.optionsRadio = optionsRadio;
	}
	public long[] getYid() {
		return yid;
	}
	public void setYid(long[] yid) {
		this.yid = yid;
	}
	public long[] getFid() {
		return fid;
	}
	public void setFid(long[] fid) {
		this.fid = fid;
	}
	public long[] getCid() {
		return cid;
	}
	public void setCid(long[] cid) {
		this.cid = cid;
	}
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
	public long getTagCategoryId() {
		return tagCategoryId;
	}
	public void setTagCategoryId(long tagCategoryId) {
		this.tagCategoryId = tagCategoryId;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	
	
	
}

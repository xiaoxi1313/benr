package com.newvery.record;

import com.google.gson.annotations.Expose;

public class ChartDistributionRecord {
	@Expose
	private int num;			// 总数
	@Expose
	private String tagName;		// 标签名
	
	private long tagId;
	
	private long categoryId;	//标签分类id
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public long getTagId() {
		return tagId;
	}
	public void setTagId(long tagId) {
		this.tagId = tagId;
	}
	public long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}
}

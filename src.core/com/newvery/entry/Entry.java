package com.newvery.entry;

import java.util.Date;

import com.google.gson.annotations.Expose;

public class Entry implements IEntry {

	private String locale;
	
	private Date createTime = new Date();
	
	private Date modifyTime = new Date();

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	
}

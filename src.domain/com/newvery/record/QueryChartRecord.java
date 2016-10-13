package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 报表查询条件
 * @author mi_xb
 *
 */
public class QueryChartRecord extends Entry implements IEntry {
	private long id;
	private String title;
	private long userId;				//创建者
	private int type;
	private String content;
	private boolean deleted;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
}

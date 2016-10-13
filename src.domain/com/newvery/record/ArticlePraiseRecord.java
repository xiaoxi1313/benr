package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

public class ArticlePraiseRecord extends Entry implements IEntry {
	private long id;
	private long articleId;
	private long userId;
	private int type;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getArticleId() {
		return articleId;
	}
	public void setArticleId(long articleId) {
		this.articleId = articleId;
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
}

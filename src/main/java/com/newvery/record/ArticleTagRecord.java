package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 文章、标签对应表
 * @author mi_xb
 *
 */
public class ArticleTagRecord extends Entry implements IEntry {
	private long id;
	private long articleId;
	private long userId;
	private long tagId;
	private boolean deleted;
	
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
	public long getTagId() {
		return tagId;
	}
	public void setTagId(long tagId) {
		this.tagId = tagId;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
}

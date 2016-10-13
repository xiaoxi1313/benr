package com.newvery.record;

import com.google.gson.annotations.Expose;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 文章批注
 * @author mi_xb
 *
 */
public class AnnotateRecord extends Entry implements IEntry {
	@Expose
	private long id;
	@Expose
	private long articleId;
	private long userId;
	private boolean deleted;
	@Expose
	private String content;
	private int type;	//1：批注 	2: 热门标签	3：趋势标签
	private boolean saved;		// 批注时是否点了保存按钮
	
	private UserRecord user;
	
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
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public UserRecord getUser() {
		return user;
	}
	public void setUser(UserRecord user) {
		this.user = user;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public boolean isSaved() {
		return saved;
	}
	public void setSaved(boolean saved) {
		this.saved = saved;
	}
}

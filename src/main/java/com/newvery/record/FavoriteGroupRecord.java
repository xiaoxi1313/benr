package com.newvery.record;

import java.util.List;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 用户耳机收藏夹下的分组
 * @author mi_xb
 *
 */
public class FavoriteGroupRecord extends Entry implements IEntry {
	private long id;
	private String name;
	private long userId;
	private long favoriteId;
	private boolean deleted;
	
	private List<ArticleRecord> articleList;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getFavoriteId() {
		return favoriteId;
	}
	public void setFavoriteId(long favoriteId) {
		this.favoriteId = favoriteId;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public List<ArticleRecord> getArticleList() {
		return articleList;
	}
	public void setArticleList(List<ArticleRecord> articleList) {
		this.articleList = articleList;
	}
}

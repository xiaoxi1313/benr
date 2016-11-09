package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 文章、收藏夹分组对应关系
 * @author mi_xb
 *
 */
public class ArticleFavoriteGroupRecord extends Entry implements IEntry {
	private long id;
	private long articleId;
	private long favoriteGroupId;
	
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
	public long getFavoriteGroupId() {
		return favoriteGroupId;
	}
	public void setFavoriteGroupId(long favoriteGroupId) {
		this.favoriteGroupId = favoriteGroupId;
	}
}

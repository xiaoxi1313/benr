package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 收藏夹、文章对应关系
 * @author mi_xb
 *
 */
public class ArticleFavoriteRecord extends Entry implements IEntry {

	private long id;
	private long articleId;
	private long parentFavoriteId;
	private long childFavoriteId;
	private long userId;
	private boolean deleted;
	private int position;
	
	private FavoriteRecord childFavorite;
	private FavoriteRecord parentFavorite;
	
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
	public long getParentFavoriteId() {
		return parentFavoriteId;
	}
	public void setParentFavoriteId(long parentFavoriteId) {
		this.parentFavoriteId = parentFavoriteId;
	}
	public long getChildFavoriteId() {
		return childFavoriteId;
	}
	public void setChildFavoriteId(long childFavoriteId) {
		this.childFavoriteId = childFavoriteId;
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
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
	}
	public FavoriteRecord getChildFavorite() {
		return childFavorite;
	}
	public void setChildFavorite(FavoriteRecord childFavorite) {
		this.childFavorite = childFavorite;
	}
	public FavoriteRecord getParentFavorite() {
		return parentFavorite;
	}
	public void setParentFavorite(FavoriteRecord parentFavorite) {
		this.parentFavorite = parentFavorite;
	}
}

package com.newvery.record;

import com.google.gson.annotations.Expose;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 用户、收藏夹关系(只用于普通用户)
 * @author mi_xb
 *
 */
public class UserShareFavoriteRecord extends Entry implements IEntry {
	@Expose
	private long id;
	@Expose
	private long userId;
	
	@Expose
	private long shareUserId;
	
	@Expose
	private long parentFavoriteId;
	@Expose
	private long childFavoriteId;
	private boolean deleted;
	
	@Expose
	private FavoriteRecord parentFavorite;
	
	@Expose
	private FavoriteRecord childFavorite;
	
	private long userGroupId;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
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
	public FavoriteRecord getParentFavorite() {
		return parentFavorite;
	}
	public void setParentFavorite(FavoriteRecord parentFavorite) {
		this.parentFavorite = parentFavorite;
	}
	public FavoriteRecord getChildFavorite() {
		return childFavorite;
	}
	public void setChildFavorite(FavoriteRecord childFavorite) {
		this.childFavorite = childFavorite;
	}
	public long getUserGroupId() {
		return userGroupId;
	}
	public void setUserGroupId(long userGroupId) {
		this.userGroupId = userGroupId;
	}
	public long getShareUserId() {
		return shareUserId;
	}
	public void setShareUserId(long shareUserId) {
		this.shareUserId = shareUserId;
	}
}

package com.newvery.record;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 收藏夹
 * @author mi_xb
 *
 */
public class FavoriteRecord extends Entry implements IEntry {
	@Expose
	private long id;
	@Expose
	private String name;
	private long userId;
	private long parentId;
	private boolean deleted;
	private String alias;
	private String img;
	private int position;
	private int articleNum;
	
	private boolean completed;		// 是否完成
	
	private int type;		//类型 1：管理员  2：用户
	
	private List<FavoriteRecord> children;
	private List<FavoriteGroupRecord> favoriteGroupList;
	
	@Override
	public boolean equals(Object obj) {
		try {
			FavoriteRecord f = (FavoriteRecord)obj;
			return f.getId() == id;
		} catch (Exception e) {
			return false;
		}
	}
	
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
	public long getParentId() {
		return parentId;
	}
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
	}
	public int getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
	}
	public boolean isCompleted() {
		return completed;
	}
	public void setCompleted(boolean completed) {
		this.completed = completed;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public List<FavoriteRecord> getChildren() {
		return children;
	}
	public void setChildren(List<FavoriteRecord> children) {
		this.children = children;
	}
	public List<FavoriteGroupRecord> getFavoriteGroupList() {
		return favoriteGroupList;
	}
	public void setFavoriteGroupList(List<FavoriteGroupRecord> favoriteGroupList) {
		this.favoriteGroupList = favoriteGroupList;
	}
}

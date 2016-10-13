package com.newvery.record;

import com.google.gson.annotations.Expose;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 标签分类
 * @author mi_xb
 *
 */
public class TagCategoryRecord extends Entry implements IEntry {

	@Expose
	private long id;
	
	@Expose
	private String name;
	private String description;
	private boolean deleted;
	private String alias;
	private long userId;
	
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
}

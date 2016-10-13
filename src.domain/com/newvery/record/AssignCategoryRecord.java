package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 录入员可以管理的父目录
 * @author beimukaibin
 *
 */
public class AssignCategoryRecord extends Entry implements IEntry {

	private long id;
	
	private long userId;
	
	private CategoryRecord category;
	private long categoryId;

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

	public CategoryRecord getCategory() {
		return category;
	}

	public void setCategory(CategoryRecord category) {
		this.category = category;
	}

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}
	
}

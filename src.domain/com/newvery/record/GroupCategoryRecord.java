package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

public class GroupCategoryRecord extends Entry implements IEntry {

	
	private long id;
	
	private long categoryId;
	
	private CategoryRecord category;
	
	private long userGroupId;
	
	private long parentCategoryId;
	private CategoryRecord parentCategory;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public long getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(long userGroupId) {
		this.userGroupId = userGroupId;
	}

	public long getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}

	public CategoryRecord getCategory() {
		return category;
	}

	public void setCategory(CategoryRecord category) {
		this.category = category;
	}

	public CategoryRecord getParentCategory() {
		return parentCategory;
	}

	public void setParentCategory(CategoryRecord parentCategory) {
		this.parentCategory = parentCategory;
	}
	
	
}

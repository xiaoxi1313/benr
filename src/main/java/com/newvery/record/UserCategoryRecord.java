package com.newvery.record;

import java.util.List;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 用户可以查看的目录
 * @author beimukaibin
 *
 */
public class UserCategoryRecord extends Entry implements IEntry {

	
	private long id;
	
	private long categoryId;
	
	private long userId;
	
	private long parentCategoryId;

	private List<CategoryRecord> allowCategoryList;
	
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

	public long getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public List<CategoryRecord> getAllowCategoryList() {
		return allowCategoryList;
	}

	public void setAllowCategoryList(List<CategoryRecord> allowCategoryList) {
		this.allowCategoryList = allowCategoryList;
	}
	
	
}

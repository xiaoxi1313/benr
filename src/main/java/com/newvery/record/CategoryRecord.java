package com.newvery.record;

import java.io.Serializable;
import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.Constants;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

public class CategoryRecord extends Entry implements IEntry,Serializable {
	@Expose
	private long id;
	@Expose
	private String name;
	
	@Expose
	private String tagName;
	
	private String alias;
	private String description;
	private long parentId;
	private boolean deleted;
	private int articleNum;
	
	@Expose
	private CategoryRecord parentCategory;
	
	private List<CategoryRecord> children;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		if(id == Constants.ALL_CHILDREN_CATEGORY) {
			return "全部";
		}
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public int getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
	}
	public CategoryRecord getParentCategory() {
		return parentCategory;
	}
	public void setParentCategory(CategoryRecord parentCategory) {
		this.parentCategory = parentCategory;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public List<CategoryRecord> getChildren() {
		return children;
	}
	public void setChildren(List<CategoryRecord> children) {
		this.children = children;
	}
}

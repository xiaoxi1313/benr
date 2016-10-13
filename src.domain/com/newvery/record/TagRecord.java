package com.newvery.record;

import java.util.Date;

import com.google.gson.annotations.Expose;
import com.newvery.Constants;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/**
 * 标签
 * @author mi_xb
 *
 */
public class TagRecord extends Entry implements IEntry {
	@Expose
	private long id;
	@Expose
	private String name;
	private String alias;
	private int articleNum;
	private int status;
	private String description;
	private boolean deleted;
	private long categoryId;
	private long userId;
	
	private boolean hot;		//是否热门标签
	
	private String tooltip;
	
	public String getStatusName() {
		switch (status) {
			case Constants.TAG_STATUS_NEW:
				Date now = new Date();
				long dates = 30 - (now.getTime() - getCreateTime().getTime())/(1000*60*60*24);
				return "新增标签 (还剩"+dates+"天变为常规标签)";
			case Constants.TAG_STATUS_NORMAL:
				return "常规标签";
		}
		return "";
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
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public int getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
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

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public boolean isHot() {
		return hot;
	}

	public void setHot(boolean hot) {
		this.hot = hot;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getTooltip() {
		return tooltip;
	}

	public void setTooltip(String tooltip) {
		this.tooltip = tooltip;
	}
}

package com.newvery.record;

import java.util.Date;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;
import com.newvery.utils.TimeUtil;

/**
 * 查询条件
 * @author mi_xb
 *
 */
public class QueryConditionRecord extends Entry implements IEntry {
	private long id;
	private String name;
	private long parentCategoryId;
	private long childCategoryId;
	private Date beginDate;
	private Date endDate;
	private int status;
	private long userId;				//创建者
	private long queryUserId;			//查询条件中的userId
	private int type;
	private boolean deleted;
	
	public String getBeginDateStr() {
		return TimeUtil.format(beginDate, TimeUtil.FORMAT_DATE_ONLY);
	}
	
	public String getEndDateStr() {
		return TimeUtil.format(endDate, TimeUtil.FORMAT_DATE_ONLY);
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
	public long getParentCategoryId() {
		return parentCategoryId;
	}
	public void setParentCategoryId(long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}
	public long getChildCategoryId() {
		return childCategoryId;
	}
	public void setChildCategoryId(long childCategoryId) {
		this.childCategoryId = childCategoryId;
	}
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public long getQueryUserId() {
		return queryUserId;
	}
	public void setQueryUserId(long queryUserId) {
		this.queryUserId = queryUserId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}

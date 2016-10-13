package com.newvery.record;

import com.newvery.Constants;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

public class PDFFileRecord extends Entry implements IEntry {
	private long id;
	private String title;
	private int type;
	private long userId;
	private String thumbnail;		//缩略图
	private String pdf;				//pdf文件
	private boolean deleted;
	
	private UserGroupRecord userGroup;
	
	public String getTypeName() {
		if (type == Constants.PDF_TYPE_TREDN) {
			return "创新趋势";
		}
		else if (type == Constants.PDF_TYPE_INFO) {
			return "创新情报";
		}
		return "";
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getPdf() {
		return pdf;
	}
	public void setPdf(String pdf) {
		this.pdf = pdf;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public UserGroupRecord getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroupRecord userGroup) {
		this.userGroup = userGroup;
	}
}

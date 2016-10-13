package com.newvery.record;

import java.util.ArrayList;
import java.util.List;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;
import com.newvery.utils.TimeUtil;

/**
 * 文章评论
 * @author mi_xb
 *
 */
public class CommentRecord extends Entry implements IEntry {
	private long id;
	private long userId;
	private long articleId;
	private long parentId;
	private String comment;
	private int status;
	private boolean deleted;
	
	private UserRecord user;
	private List<CommentRecord> children = new ArrayList<CommentRecord>();
	
	/**
	 * 展示的时间，刚刚、几分钟前。。。
	 * @return
	 */
	public String getCreateDateShowStr() {
		return TimeUtil.formatDateBefore(getCreateTime());
	}
	
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
	public long getArticleId() {
		return articleId;
	}
	public void setArticleId(long articleId) {
		this.articleId = articleId;
	}
	public long getParentId() {
		return parentId;
	}
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public List<CommentRecord> getChildren() {
		return children;
	}
	public void setChildren(List<CommentRecord> children) {
		this.children = children;
	}
	public UserRecord getUser() {
		return user;
	}
	public void setUser(UserRecord user) {
		this.user = user;
	}
}

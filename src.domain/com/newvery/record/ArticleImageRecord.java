package com.newvery.record;

import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

/** 
 * 文章图片关联
 * @author mi_xb
 *
 */
public class ArticleImageRecord extends Entry implements IEntry {
	private long id;
	private long articleId;
	private String name;		//文件名
	private String image;		//二进制图片内容
	private boolean deleted;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getArticleId() {
		return articleId;
	}
	public void setArticleId(long articleId) {
		this.articleId = articleId;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
}

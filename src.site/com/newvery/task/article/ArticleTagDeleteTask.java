package com.newvery.task.article;

import com.newvery.exception.ServiceException;

public class ArticleTagDeleteTask extends ArticleTask {
	private long articleId;
	private long tagId;
	
	@Override
	public Object exec() throws ServiceException {
		getArticleDao().deleteArticleTagByArticleAndTagId(articleId, tagId);
		return null;
	}

	public long getArticleId() {
		return articleId;
	}

	public void setArticleId(long articleId) {
		this.articleId = articleId;
	}

	public long getTagId() {
		return tagId;
	}

	public void setTagId(long tagId) {
		this.tagId = tagId;
	}
	
}

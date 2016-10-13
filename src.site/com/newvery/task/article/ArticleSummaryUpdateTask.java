package com.newvery.task.article;

import com.newvery.exception.ServiceException;

/**
 * 修改文章状态
 * @author mi_xb
 *
 */
public class ArticleSummaryUpdateTask extends ArticleTask {

	private String summary;
	
	@Override
	public Object exec() throws ServiceException {
		setArticle(getArticleDao().updateArticleSummary(getArticle().getId(),getSummary()));
		return getArticle();
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

}

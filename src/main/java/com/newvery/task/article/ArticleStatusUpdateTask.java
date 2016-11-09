package com.newvery.task.article;

import com.newvery.exception.ServiceException;

/**
 * 修改文章状态
 * @author mi_xb
 *
 */
public class ArticleStatusUpdateTask extends ArticleTask {

	@Override
	public Object exec() throws ServiceException {
		setArticle(getArticleDao().updateArticleStatus(getArticle().getId(), getArticle().getStatus()));
		
		return getArticle();
	}

}
